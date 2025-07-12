unit GerarPedidoCaixaFechada;

interface

uses
  classes,
  FireDAC.Comp.Client,
  Generics.Collections,
  System.Json,
  uFrmeXactWMS,
  Rest.Types,
  PedidoSaidaCtrl,
  ufuncoes,
  GerarPedido,

  System.SysUtils;

type
  TGerarPedidoCaixaFechada = class(TGerarPedido)
  public
    QryEstoqueDisponivel_CaixaFechada: TFDMemTable;
    function Gerar(pedidoId: string; Qry: TFDMemTable): boolean;
  private

  end;

implementation

{ TGerarPedido }

function TGerarPedidoCaixaFechada.Gerar(pedidoId: string;
  Qry: TFDMemTable): boolean;

Var
  ObjPedidoCtrl: TPedidoSaidaCtrl;
  ArrayJsonVolume, ArrayJsonRetorno: TjsonArray;
  jsonVolume: TjsonObject;
  vProduto, vSaldo: Integer;
  vQtVolume: Integer;
  vErro, vResultado: String;
begin
  Result := True; // Retorno com Erro
  ArrayJsonVolume := TjsonArray.Create;

  gravalog('        -> geracao caixa fechada do pedido ' + pedidoId);
  try
    Try
      vProduto := 0;
      Qry.First;

      While Not Qry.Eof do
      Begin
        gravalog('        -> processando item ' + Qry.FieldByName('ProdutoId')
          .AsString);
        if (vProduto <> Qry.FieldByName('ProdutoId').AsInteger) Then
        Begin
          vProduto := Qry.FieldByName('ProdutoId').AsInteger;
          vSaldo := (Qry.FieldByName('QtdPedido').AsInteger);

        End;
        While (vSaldo >= Qry.FieldByName('FatorConversao').AsInteger) and
          (Qry.FieldByName('Qtde').AsInteger >=
          Qry.FieldByName('FatorConversao').AsInteger) do
        Begin
          if Qry.FieldByName('Qtde').AsInteger >=
            Qry.FieldByName('FatorConversao').AsInteger then
          Begin
            jsonVolume := TjsonObject.Create();
            jsonVolume.AddPair('pedidoid', pedidoId);
            jsonVolume.AddPair('loteid',
              TJSONNumber.Create(Qry.FieldByName('LoteId').AsInteger));
            jsonVolume.AddPair('enderecoid',
              TJSONNumber.Create(Qry.FieldByName('EnderecoId').AsInteger));
            jsonVolume.AddPair('estoquetipoid',
              TJSONNumber.Create(Qry.FieldByName('EstoqueTipoId').AsInteger));
            if vSaldo >= Qry.FieldByName('Qtde').AsInteger then
              vQtVolume := Qry.FieldByName('Qtde').AsInteger Div Qry.FieldByName
                ('FatorConversao').AsInteger
            Else
              vQtVolume := vSaldo Div Qry.FieldByName('FatorConversao')
                .AsInteger;
            jsonVolume.AddPair('qtvolume', TJSONNumber.Create(vQtVolume));
            jsonVolume.AddPair('quantidade',
              TJSONNumber.Create(Qry.FieldByName('FatorConversao').AsInteger));
            // Qtde Solicitada, Emb.Cxa.Fechada
            jsonVolume.AddPair('embalagempadrao',
              TJSONNumber.Create(Qry.FieldByName('EmbalagemPadrao').AsInteger));
            // Qtde Solicitada, Emb.Cxa.Fechada
            jsonVolume.AddPair('usuarioid',
              TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.
              UsuarioId));
            // Qtde Solicitada, Emb.Cxa.Fechada
            jsonVolume.AddPair('terminal', 'MicroServico');
            // Qtde Solicitada, Emb.Cxa.Fechada
            If Qry.FieldByName('Reprocessado').AsBoolean then
              jsonVolume.AddPair('reprocessado', TJSONNumber.Create(1))
            Else
              jsonVolume.AddPair('reprocessado', TJSONNumber.Create(0));
            Qry.Edit;
            Qry.FieldByName('Qtde').AsInteger := Qry.FieldByName('Qtde')
              .AsInteger - (vQtVolume * Qry.FieldByName('FatorConversao')
              .AsInteger);
            ArrayJsonVolume.AddElement(jsonVolume);
            vSaldo := vSaldo - (vQtVolume * Qry.FieldByName('FatorConversao')
              .AsInteger);
            // Quantidades de Volumes Caixa Fechada
            Qry.ApplyUpdates();
          End
          Else
          Begin
            vSaldo := 0;
          End;
        End;
        Qry.Next;
      End;
      if ArrayJsonVolume.Count > 0 then
      Begin
        ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
        gravalog('           -> Enviando geracao de volumes');
        if DebugHook > 0 then
        begin
          with TStringList.Create do
          begin
            text := ArrayJsonVolume.ToString;
            savetofile(ExtractFilePath(GetModuleName(HInstance)) +
              'jsonvalumescaixafechada.json');
            free;
          end;
        end;
        ArrayJsonRetorno := ObjPedidoCtrl.GerarVolume(ArrayJsonVolume, 'FC');
        gravalog('           -> Geracao de volumes concluida');
        if ArrayJsonRetorno.Count > 0 then
        Begin
          if ArrayJsonRetorno.Items[0].TryGetValue<String>('Erro', vErro) then
          Begin
            gravalog('    Erro ao gerar caixa fechada ' + vErro);
          end;
        End;

      End;
      ArrayJsonVolume.free; // := Nil;
      Result := False;
    Except
      On E: Exception do
      Begin
        gravalog('Erro ao gerar caixa fechada ' + E.Message);
        raise Exception.Create(E.Message);
      End;
    End;
  finally
{$IFDEF MSWINDOWS}
    gravalog(' Free objects caixa fechada...');

    try
      if assigned(ArrayJsonRetorno) then
        ArrayJsonRetorno := nil;
    except

    end;
    try
      // ESTE OBJETO ESTA COM O DESTROY INCORRRETO CAUSANDO ERRO
      if assigned(ObjPedidoCtrl) then
        FreeAndNil(ObjPedidoCtrl);
    except

    end;

{$ENDIF}
  end;
end;

end.
