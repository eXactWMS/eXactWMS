unit EstoqueCaixaFechada;

interface

uses
  classes,
  FireDAC.Comp.Client,
  System.SysUtils,
  Generics.Collections,
  System.Json,
  ufuncoes,
  Data.DB,
  Rest.Types,
  PedidoSaidaCtrl;

type
  TEstoqueCaixaFechada = class
  public
    class function Gerar(pedidoId, statusPedido: string;
      Mentable: TFDMemTable): boolean;
  private
    class procedure AdicionarCampos(MemTable: TFDMemTable);
  end;

implementation

{ TEstoqueCaixaFechada }
class procedure TEstoqueCaixaFechada.AdicionarCampos(MemTable: TFDMemTable);
begin
  MemTable.FieldDefs.Clear;

  // Campos inteiros
  MemTable.FieldDefs.Add('Produtoid', ftInteger);
  MemTable.FieldDefs.Add('EmbPrim', ftInteger);
  MemTable.FieldDefs.Add('EmbSec', ftInteger);
  MemTable.FieldDefs.Add('MesSaidaMinima', ftInteger);
  MemTable.FieldDefs.Add('Loteid', ftInteger);
  MemTable.FieldDefs.Add('EnderecoId', ftInteger);
  MemTable.FieldDefs.Add('QtdPedido', ftInteger);
  MemTable.FieldDefs.Add('EmbalagemPadrao', ftInteger);
  MemTable.FieldDefs.Add('Qtde', ftInteger);
  MemTable.FieldDefs.Add('EstoqueTipoId', ftInteger);
  MemTable.FieldDefs.Add('FatorConversao', ftInteger);

  // Campos Data e Hora
  MemTable.FieldDefs.Add('Vencimento', ftDateTime);
  MemTable.FieldDefs.Add('DtEntrada', ftDate);
  MemTable.FieldDefs.Add('HrEntrada', ftTime);

  // Campo Booleano
  MemTable.FieldDefs.Add('Reprocessado', ftBoolean);

  // Criar os campos no dataset
  MemTable.CreateDataSet;
end;

class function TEstoqueCaixaFechada.Gerar(pedidoId, statusPedido: string;
  Mentable: TFDMemTable): boolean;
Var
  ObjPedidoCtrl: TPedidoSaidaCtrl;
  ReturnJsonArray: TJsonArray;
  vLote, vBloqueado: Integer;
  xProdPed: Integer;
  JsonEstoqueCubagem: TJsonObject;
  vErro: String;
begin
  Result := True;
  TEstoqueCaixaFechada.AdicionarCampos(Mentable);
  Mentable.Open;
  ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
  try
    Try
      ReturnJsonArray := ObjPedidoCtrl.PedidoCubagem(StrToIntDef(pedidoId, 0));
      if (ReturnJsonArray.Items[0].TryGetValue('Erro', vErro)) OR
        (ReturnJsonArray.Items[0].TryGetValue('MSG', vErro)) then
      Begin
        gravalog('    - Erro ao buscar estoque caixa fechada - ' + vErro);
        Result := False;
        exit;
      End;
      vLote := 0;
      vBloqueado := 0;
      for xProdPed := 0 to ReturnJsonArray.count - 1 do
      Begin
        JsonEstoqueCubagem := ReturnJsonArray.Items[xProdPed] as TJsonObject;
        if (JsonEstoqueCubagem.TryGetValue('Obs', vErro)) then
        Begin
          gravalog('    - Erro ao retornar estoque caixa fechada ' + vErro);
          Result := False;
          exit;
        End;
        if (JsonEstoqueCubagem.GetValue<Integer>('qtde') >=
          JsonEstoqueCubagem.GetValue<Integer>('embsec')) then
        Begin

          if vLote <> JsonEstoqueCubagem.GetValue<Integer>('loteid') then
          Begin
            vLote := JsonEstoqueCubagem.GetValue<Integer>('loteid');
            vBloqueado := JsonEstoqueCubagem.GetValue<Integer>('bloqueado');
          End;
          Mentable.Append;
          Mentable.FieldByName('ProdutoId').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('produtoid');
          Mentable.FieldByName('EmbPrim').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('embprim');
          Mentable.FieldByName('embsec').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('embsec');
          Mentable.FieldByName('FatorConversao').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('fatorconversao');
          Mentable.FieldByName('MesSaidaMinima').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('messaidaminima');
          Mentable.FieldByName('loteid').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('loteid');

          Mentable.FieldByName('Vencimento').AsDateTime :=
            ParseDataSegura(JsonEstoqueCubagem.GetValue<String>('vencimento'));
          Mentable.FieldByName('EnderecoId').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('enderecoid');
          Mentable.FieldByName('QtdPedido').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('qtdpedido');
          Mentable.FieldByName('EmbalagemPadrao').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('embalagempadrao');
          if (vBloqueado <> 0) and (JsonEstoqueCubagem.GetValue<Integer>('qtde')
            >= vBloqueado) then
          Begin
            Mentable.FieldByName('Qtde').AsInteger :=
              JsonEstoqueCubagem.GetValue<Integer>('qtde') - vBloqueado;
            vBloqueado := 0;
          End
          Else if (vBloqueado <> 0) then
          Begin
            vBloqueado := vBloqueado -
              JsonEstoqueCubagem.GetValue<Integer>('qtde');
            Mentable.FieldByName('Qtde').AsInteger := 0;
          End
          Else
            Mentable.FieldByName('Qtde').AsInteger :=
              JsonEstoqueCubagem.GetValue<Integer>('qtde');
          Mentable.FieldByName('EstoqueTipoId').AsInteger :=
            JsonEstoqueCubagem.GetValue<Integer>('estoquetipoid');
          if (Pos('PROCESSADO', UpperCase(statusPedido)) > 0) or
            (Pos('ETIQUETA', UpperCase(statusPedido)) > 0) or
            (Pos('RE-PROCESSADO', UpperCase(statusPedido)) > 0) then
            Mentable.FieldByName('Reprocessado').AsBoolean := True
          else
            Mentable.FieldByName('Reprocessado').AsBoolean := False;

        End
        else
        begin
          gravalog('    Quantidade cubagem e menor que estoque ');
        end;
      end;
      Result := True;
    Except
      On E: Exception do
      Begin
        gravalog('          Erro ao gerar estoque caixa fechada - ' +
          E.Message);

        raise Exception.Create(E.Message);
      End;
    End;
  finally
{$IFDEF MSWINDOWS}
    gravalog(' Free objects estoque caixa fechada...');

    try
      if assigned(ObjPedidoCtrl) then
        FreeAndNil(ObjPedidoCtrl);
    except

    end;
    try
      If assigned(ReturnJsonArray) then
        ReturnJsonArray := Nil;
    except

    end;
    try
      If assigned(JsonEstoqueCubagem) then
        JsonEstoqueCubagem := Nil;
    except

    end;
{$ENDIF}
  end;

end;

end.
