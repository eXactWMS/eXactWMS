unit GerarPedidoCaixaFracionada;

interface

uses
  classes,
  FireDAC.Comp.Client,
  Generics.Collections,
  VolumeEmbalagemCtrl,
  PedidoVolumeCtrl,
  System.Json,
  DataSet.Serialize,
  ufuncoes,
  Rest.Types,
  PedidoSaidaCtrl,
  GerarPedido,
  Data.DB,
  System.SysUtils;

type
  TGerarPedidoCaixaFracionada = class
  public
    function Gerar(pPedidoId: Integer; Reprocessado: Boolean): Boolean;
  private
    FDMemVolumeEmbalagem: TFDMemTable;
    JsonArrayVolumeEmbalagem: TjsonArray;
    ObjVolumeEmbalagemCtrl: TVolumeEmbalagemCtrl;
    vCaixaCapacidade: Double;
    vCaixaVolume: Double;
    function ValidarVolumeEmbalagem(pPesoProduto, pVolumeProduto
      : Double): Integer;
    procedure IniciarVolumes;
    procedure FDMemVolumeEmbalagemCalcFields(DataSet: TDataSet);
    procedure AdicionarCamposVolumeEmbalagem(MemTable: TFDMemTable);
    procedure AdicionarCamposCaixaFracionada(MemTable: TFDMemTable);
    procedure Pedido_CancelarCubagem(pedidoId: Integer);
  end;

implementation

{ TGerarPedidoCaixaFracionada }

procedure TGerarPedidoCaixaFracionada.AdicionarCamposVolumeEmbalagem
  (MemTable: TFDMemTable);
begin
  { MemTable.FieldDefs.Clear;

    // Campos normais
    MemTable.FieldDefs.Add('EmbalagemId', ftInteger);
    MemTable.FieldDefs.Add('Identificacao', ftString, 5);
    MemTable.FieldDefs.Add('Altura', ftFloat);
    MemTable.FieldDefs.Add('Largura', ftFloat);
    MemTable.FieldDefs.Add('Comprimento', ftFloat);
    MemTable.FieldDefs.Add('Aproveitamento', ftInteger);
    MemTable.FieldDefs.Add('Capacidade', ftFloat);

    // Campos calculados (precisam ser adicionados após CreateDataSet) }

  MemTable.Close;
  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'EmbalagemId';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TStringField.Create(MemTable) do
  begin
    FieldName := 'Identificacao';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'Altura';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'Largura';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'Comprimento';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'Aproveitamento';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'Capacidade';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'Volume';
    FieldKind := fkCalculated;
    DataSet := MemTable;
  end;

  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'PesoGr';
    FieldKind := fkCalculated;
    DataSet := MemTable;
  end;
  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'PesoKg';
    FieldKind := fkCalculated;
    DataSet := MemTable;
  end;
  MemTable.CreateDataSet;
  MemTable.Open;
end;

procedure TGerarPedidoCaixaFracionada.AdicionarCamposCaixaFracionada
  (MemTable: TFDMemTable);
begin
  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'ProdutoId';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'EnderecoId';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'EnderecoOrigem';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'EmbalagemPadrao';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'QtdSolicitada';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'LoteId';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'EstoqueTipoId';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'Qtde';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'Ordem';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'Distribuicao';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'RuaId';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'ZonaId';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TIntegerField.Create(MemTable) do
  begin
    FieldName := 'FatorConversao';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'VolumeCm3';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TFloatField.Create(MemTable) do
  begin
    FieldName := 'PesoLiquidoKg';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TDateTimeField.Create(MemTable) do
  begin
    FieldName := 'Vencimento';
    FieldKind := fkData;
    DataSet := MemTable;
  end;
  with TDateTimeField.Create(MemTable) do
  begin
    FieldName := 'DtHrEntrada';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  with TBooleanField.Create(MemTable) do
  begin
    FieldName := 'Reprocessado';
    FieldKind := fkData;
    DataSet := MemTable;
  end;

  MemTable.CreateDataSet;
  MemTable.Open;
end;

procedure TGerarPedidoCaixaFracionada.IniciarVolumes();
begin
  Try
    FDMemVolumeEmbalagem := TFDMemTable.Create(Nil);
    AdicionarCamposVolumeEmbalagem(FDMemVolumeEmbalagem);

    FDMemVolumeEmbalagem.OnCalcFields := FDMemVolumeEmbalagemCalcFields;
    ObjVolumeEmbalagemCtrl := TVolumeEmbalagemCtrl.Create;
    JsonArrayVolumeEmbalagem :=
      ObjVolumeEmbalagemCtrl.GetVolumeEmbalagemMultipla(0, '', 0);

    FDMemVolumeEmbalagem.Close;
    FDMemVolumeEmbalagem.LoadFromJSON(JsonArrayVolumeEmbalagem, False);

    FDMemVolumeEmbalagem.First;
    vCaixaCapacidade := FDMemVolumeEmbalagem.FieldByName('Capacidade').AsFloat;
    // LstVolumeEmbalagem[0].ObjVolumeEmbalagem.Capacidade;//*1000;
    vCaixaVolume := FDMemVolumeEmbalagem.FieldByName('Volume').AsFloat *
      (FDMemVolumeEmbalagem.FieldByName('Aproveitamento').AsFloat / 100);


    JsonArrayVolumeEmbalagem := Nil;
  Finally
    FreeAndNil(ObjVolumeEmbalagemCtrl);
  End;
end;

procedure TGerarPedidoCaixaFracionada.Pedido_CancelarCubagem(pedidoId: Integer);
begin
  with TPedidoSaidaCtrl.Create do
  begin
    Pedido_CancelarCubagem(pedidoId);
    free;
  end;
end;

function TGerarPedidoCaixaFracionada.ValidarVolumeEmbalagem(pPesoProduto,
  pVolumeProduto: Double): Integer;
Var
  xVolumeCaixa: Double;
begin
  FDMemVolumeEmbalagem.First;
  Result := FDMemVolumeEmbalagem.FieldByName('EmbalagemId').AsInteger;
  While Not FDMemVolumeEmbalagem.Eof do
  Begin
    xVolumeCaixa := FDMemVolumeEmbalagem.FieldByName('Volume').AsFloat *
      (FDMemVolumeEmbalagem.FieldByName('Aproveitamento').AsFloat / 100);
    if (pPesoProduto <= FDMemVolumeEmbalagem.FieldByName('EmbalagemId').AsFloat)
      and (pVolumeProduto <= xVolumeCaixa) then
      Result := FDMemVolumeEmbalagem.FieldByName('EmbalagemId').AsInteger;
    FDMemVolumeEmbalagem.Next;
  End;
end;

procedure TGerarPedidoCaixaFracionada.FDMemVolumeEmbalagemCalcFields
  (DataSet: TDataSet);
begin
  inherited;
  FDMemVolumeEmbalagem.FieldByName('Volume').AsFloat :=
    (FDMemVolumeEmbalagem.FieldByName('Altura').AsFloat *
    FDMemVolumeEmbalagem.FieldByName('Largura').AsFloat *
    FDMemVolumeEmbalagem.FieldByName('Comprimento').AsFloat) *
    (FDMemVolumeEmbalagem.FieldByName('Aproveitamento').AsFloat / 100);
  FDMemVolumeEmbalagem.FieldByName('PesoGr').AsFloat :=
    FDMemVolumeEmbalagem.FieldByName('Capacidade').AsFloat;
  FDMemVolumeEmbalagem.FieldByName('PesoKg').AsFloat :=
    FDMemVolumeEmbalagem.FieldByName('Capacidade').AsFloat / 1000;
end;

function TGerarPedidoCaixaFracionada.Gerar(pPedidoId: Integer;
  Reprocessado: Boolean): Boolean;

Var
  ObjPedidoFracCtrl: TPedidoSaidaCtrl;
  ReturnJsonArrayFrac: TjsonArray;
  jsonProdCxaFracionada: TJsonObject;
  vErro: String;
  xRetorno: Integer;
  vProdutoId: Integer;
  vZonaId, vRuaId: Integer;
  vPesoProduto: Double;
  vVolumeProduto: Double;
  vQtdProdKgToCaixa, vQtdProdVlmToCaixa: Integer;
  vSaldoQtdSolicitada, vQtdProd, vQtLoteVolume: Integer;
  vSaldoCaixaVolume, vSaldoCaixaPeso: Double;
  vVolumeOpen: Boolean;
  jsonVolume: TJsonObject;
  jsonVolumeLote: TJsonObject;
  ArrayJsonVolumeLotes, ArrayJsonVolumes, ArrayJsonRetorno: TjsonArray;
  vNumVolume, vLote, vBloqueado: Integer;
  vCaixaCapacidade, vCaixaVolume: Double;
  Mentable: TFDMemTable;
  indeceConsulta: Integer;
begin
  Result := True;
  try
    IniciarVolumes();
    Try
      ReturnJsonArrayFrac :=
        ObjPedidoFracCtrl.PedidoCubagemVolume_CaixaFracionada(pPedidoId);
      if ReturnJsonArrayFrac.Items[0].GetValue<TJsonObject>.TryGetValue('Erro',
        vErro) then
      Begin
        gravalog('    Erro ao retornar json caixa fracionada ' + vErro);
        Result := False;
        exit;
      end
      Else if ReturnJsonArrayFrac.Items[0].GetValue<TJsonObject>.TryGetValue
        ('MSG', vErro) then
      Begin
        gravalog('    Erro ao retornar json2 caixa fracionada  ' + vErro);
        Result := False;
        exit;
      end;
      Mentable := TFDMemTable.Create(Nil);
      AdicionarCamposCaixaFracionada(Mentable);
      Mentable.Open;
      vLote := 0;
      vBloqueado := 0;
      for xRetorno := 0 to Pred(ReturnJsonArrayFrac.Count) do
      Begin
        jsonProdCxaFracionada := ReturnJsonArrayFrac.Items[xRetorno]
          as TJsonObject;
        if jsonProdCxaFracionada.TryGetValue('Erro', vErro) then
        begin
          gravalog('    Erro ao retornar json2 caixa fracionada  ' + vErro);
          Result := False;
          exit;
        end;
        Mentable.Append;
        if vLote <> jsonProdCxaFracionada.GetValue<Integer>('loteid') then
        Begin
          vLote := jsonProdCxaFracionada.GetValue<Integer>('loteid');
          vBloqueado := jsonProdCxaFracionada.GetValue<Integer>('bloqueado');
        End;
        Mentable.FieldByName('ProdutoId').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('produtoid');
        Mentable.FieldByName('EnderecoId').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('enderecoid');
        Mentable.FieldByName('EnderecoOrigem').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('enderecoorigem');
        Mentable.FieldByName('FatorConversao').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('fatorconversao');
        Mentable.FieldByName('EmbalagemPadrao').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('embalagempadrao');
        Mentable.FieldByName('VolumeCm3').AsFloat :=
          jsonProdCxaFracionada.GetValue<Double>('volumecm3');
        Mentable.FieldByName('PesoLiquidoKg').AsFloat :=
          jsonProdCxaFracionada.GetValue<Double>('pesoliquidokg');
        Mentable.FieldByName('QtdSolicitada').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('qtdsolicitada');
        Mentable.FieldByName('LoteId').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('loteid');
        Mentable.FieldByName('EstoqueTipoId').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('estoquetipoid');
        if (vBloqueado <> 0) and
          (jsonProdCxaFracionada.GetValue<Integer>('qtde') >= vBloqueado) then
        Begin
          Mentable.FieldByName('Qtde').AsInteger :=
            jsonProdCxaFracionada.GetValue<Integer>('qtde') - vBloqueado;
          vBloqueado := 0;
        End
        Else if (vBloqueado <> 0) then
        Begin
          vBloqueado := vBloqueado - Mentable.FieldByName('Qtde').AsInteger;
          Mentable.FieldByName('Qtde').AsInteger := 0;
        End
        Else
          Mentable.FieldByName('Qtde').AsInteger :=
            jsonProdCxaFracionada.GetValue<Integer>('qtde');

        Mentable.FieldByName('Vencimento').AsDateTime :=
          ParseDataSegura(jsonProdCxaFracionada.GetValue<String>('vencimento'));
        Mentable.FieldByName('DtHrEntrada').AsDateTime :=
          StrToDateTime(jsonProdCxaFracionada.GetValue<string>('horario'));
        Mentable.FieldByName('Ordem').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('ordem');
        Mentable.FieldByName('Distribuicao').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('distribuicao');
        Mentable.FieldByName('RuaId').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('ruaid');
        Mentable.FieldByName('ZonaId').AsInteger :=
          jsonProdCxaFracionada.GetValue<Integer>('zonaid');

      End;
      if Mentable.IsEmpty then
      begin
        gravalog('    Nehum dado retornado para geracai caixa fracionada');
        exit;
      end;
      vProdutoId := 0;
      vRuaId := 0;
      vZonaId := 0;
      vVolumeOpen := True;
      vVolumeOpen := False;
      vNumVolume := 0;
      vSaldoCaixaVolume := vCaixaVolume; // 44064
      vSaldoCaixaPeso := vCaixaCapacidade; // 25000
      Mentable.First;
      ArrayJsonVolumes := TjsonArray.Create;
      indeceConsulta := 0;
      While Not Mentable.Eof do
      Begin
        inc(indeceConsulta);
        gravalog('        Procesando item caixa fracionada - produto  ' + Mentable.FieldByName
          ('ProdutoId').AsString);
        if vProdutoId <> Mentable.FieldByName('ProdutoId').AsInteger then
        Begin
          vProdutoId := Mentable.FieldByName('ProdutoId').AsInteger;
          vPesoProduto := Mentable.FieldByName('PesoLiquidoKg').AsFloat;
          if vPesoProduto <= 0 then
            vPesoProduto := 0.01;
          vVolumeProduto := Mentable.FieldByName('VolumeCm3').AsFloat;
          If vVolumeProduto <= 0 then
            vVolumeProduto := 512;
          vSaldoQtdSolicitada := Mentable.FieldByName('QtdSolicitada')
            .AsInteger;
        End;
        if (vPesoProduto > vSaldoCaixaPeso) or
          (vVolumeProduto > vSaldoCaixaVolume) or
          (vZonaId <> Mentable.FieldByName('ZonaId').AsInteger) or
          (vRuaId <> Mentable.FieldByName('RuaId').AsInteger) or
          (Not vVolumeOpen) then
        Begin
          If vVolumeOpen then
          Begin
            jsonVolume.AddPair('embalagemid',
              TJSONNumber.Create(ValidarVolumeEmbalagem((vCaixaCapacidade -
              vSaldoCaixaPeso), (vCaixaVolume - vSaldoCaixaVolume))));
            ArrayJsonVolumes.AddElement(jsonVolume);
            vVolumeOpen := False;
          End;
          inc(vNumVolume);
          jsonVolume := TJsonObject.Create;
          jsonVolume.AddPair('pedidoid', TJSONNumber.Create(pPedidoId));
          jsonVolume.AddPair('numvolume', TJSONNumber.Create(vNumVolume));
          jsonVolume.AddPair('terminal', NomeDoComputador);
          jsonVolume.AddPair('usuarioid', TJSONNumber.Create(0));
          If Mentable.FieldByName('Reprocessado').AsBoolean then
            jsonVolume.AddPair('reprocessado', TJSONNumber.Create(1))
          Else
            jsonVolume.AddPair('reprocessado', TJSONNumber.Create(0));
          ArrayJsonVolumeLotes := TjsonArray.Create;
          vVolumeOpen := True;
          vRuaId := Mentable.FieldByName('RuaId').AsInteger;
          vZonaId := Mentable.FieldByName('ZonaId').AsInteger;
          vSaldoCaixaVolume := vCaixaVolume;
          vSaldoCaixaPeso := vCaixaCapacidade;
        End;
        vQtdProdKgToCaixa := Trunc(vSaldoCaixaPeso / vPesoProduto) *
          Mentable.FieldByName('EmbalagemPadrao').AsInteger;
        if vQtdProdKgToCaixa < 1 then
          vQtdProdKgToCaixa := Mentable.FieldByName('EmbalagemPadrao')
            .AsInteger;
        vQtdProdVlmToCaixa := Trunc(vSaldoCaixaVolume / vVolumeProduto) *
          Mentable.FieldByName('EmbalagemPadrao').AsInteger;
        if vQtdProdVlmToCaixa < 1 then
          vQtdProdVlmToCaixa := Mentable.FieldByName('EmbalagemPadrao')
            .AsInteger;
        if (vQtdProdVlmToCaixa > Mentable.FieldByName('EmbalagemPadrao')
          .AsInteger) then
          vQtdProdVlmToCaixa :=
            Trunc(vQtdProdVlmToCaixa / Mentable.FieldByName('EmbalagemPadrao')
            .AsInteger) * Mentable.FieldByName('EmbalagemPadrao').AsInteger;
        if ((vPesoProduto) > vSaldoCaixaPeso) or

          ((vVolumeProduto) > vSaldoCaixaVolume) then
        Begin
          vQtdProdKgToCaixa := Mentable.FieldByName('EmbalagemPadrao')
            .AsInteger;
          vQtdProdVlmToCaixa := Mentable.FieldByName('EmbalagemPadrao')
            .AsInteger;
          // validacaoes wilson
          if vSaldoCaixaVolume > 0 then
            vVolumeProduto := vSaldoCaixaVolume;
          if vSaldoCaixaPeso > 0 then
            vPesoProduto := vSaldoCaixaPeso;
        End;
        if vQtdProdKgToCaixa < vQtdProdVlmToCaixa then
        Begin
          if vQtdProdKgToCaixa > vSaldoQtdSolicitada then
            vQtdProd := vSaldoQtdSolicitada
          Else
            vQtdProd := vQtdProdKgToCaixa;
        End
        Else
        Begin
          if vQtdProdVlmToCaixa > vSaldoQtdSolicitada then
            vQtdProd := vSaldoQtdSolicitada
          Else
            vQtdProd := vQtdProdVlmToCaixa;
        End;
        while (Mentable.FieldByName('ProdutoId').AsInteger = vProdutoId) and
          (vQtdProd > 0) and (Not Mentable.Eof) do
        Begin
          if (vQtdProd >= Mentable.FieldByName('EmbalagemPadrao').AsInteger)
          then
          Begin
            if (Mentable.FieldByName('Qtde').AsInteger < vQtdProd) then

              vQtLoteVolume :=
                ((Mentable.FieldByName('Qtde')
                .AsInteger Div Mentable.FieldByName('EmbalagemPadrao')
                .AsInteger) * Mentable.FieldByName('EmbalagemPadrao').AsInteger)

            Else
              vQtLoteVolume := vQtdProd;
            if vQtLoteVolume > 0 then
            Begin
              vQtdProd := vQtdProd - vQtLoteVolume;
              jsonVolumeLote := TJsonObject.Create;
              jsonVolumeLote.AddPair('loteid',
                TJSONNumber.Create(Mentable.FieldByName('LoteId').AsInteger));
              jsonVolumeLote.AddPair('enderecoid',
                TJSONNumber.Create(Mentable.FieldByName('EnderecoId')
                .AsInteger));
              jsonVolumeLote.AddPair('estoquetipoid',
                TJSONNumber.Create(Mentable.FieldByName('EstoqueTipoId')
                .AsInteger));
              jsonVolumeLote.AddPair('enderecoorigem',
                TJSONNumber.Create(Mentable.FieldByName('EnderecoOrigem')
                .AsInteger));
              jsonVolumeLote.AddPair('quantidade',
                TJSONNumber.Create(vQtLoteVolume));
              jsonVolumeLote.AddPair('embalagempadrao',
                TJSONNumber.Create(Mentable.FieldByName('EmbalagemPadrao')
                .AsInteger));
              jsonVolumeLote.AddPair('qtdsuprida',
                TJSONNumber.Create(vQtLoteVolume));
              ArrayJsonVolumeLotes.AddElement(jsonVolumeLote);

              vSaldoQtdSolicitada := vSaldoQtdSolicitada - vQtLoteVolume;

            end;
            Mentable.Edit;
            if vQtLoteVolume = 0 then
              Mentable.FieldByName('Qtde').AsInteger := 0
            Else
              Mentable.FieldByName('Qtde').AsInteger :=
                Mentable.FieldByName('Qtde').AsInteger - vQtLoteVolume;

            vSaldoCaixaPeso := vSaldoCaixaPeso -
              (vQtLoteVolume * (vPesoProduto / Mentable.FieldByName
              ('EmbalagemPadrao').AsInteger));
            vSaldoCaixaVolume := vSaldoCaixaVolume -
              (vQtLoteVolume * (vVolumeProduto / Mentable.FieldByName
              ('EmbalagemPadrao').AsInteger));
          End;
          jsonVolume.AddPair('lotes', ArrayJsonVolumeLotes);

          if (Mentable.FieldByName('Qtde').AsInteger = 0) or
            ((vSaldoQtdSolicitada < Mentable.FieldByName('EmbalagemPadrao')
            .AsInteger)) then
            Mentable.Next;
        End;
        While (Mentable.FieldByName('ProdutoId').AsInteger = vProdutoId) and
          (vSaldoQtdSolicitada = 0) and (Not Mentable.Eof) do
          Mentable.Next;
      End;
      gravalog('     Concluido calculo de itens fracionados ');
      If vVolumeOpen then
      Begin
        jsonVolume.AddPair('embalagemid',
          TJSONNumber.Create(ValidarVolumeEmbalagem((vCaixaCapacidade -
          vSaldoCaixaPeso), (vCaixaVolume - vSaldoCaixaVolume))));

        ArrayJsonVolumes.AddElement(jsonVolume);
        vVolumeOpen := False;
      End;
      if ArrayJsonVolumes.Count >= 1 then
      Begin
        ArrayJsonRetorno := ObjPedidoFracCtrl.GerarVolume
          (ArrayJsonVolumes, 'FR');
        if ArrayJsonRetorno.Items[0].TryGetValue('Erro', vErro) then
        Begin
          gravalog('    - Erro ao gerar caixa fracionada ' + vErro);
        end
        Else
          Result := False;
      End;
    Except
      On E: Exception do
      Begin
        Pedido_CancelarCubagem(pPedidoId);
        raise Exception.Create(E.Message);
      End;
    End;

  finally
    gravalog('     Procesamento caixa fracionada finalizado pedido ' +
      inttostr(pPedidoId));
{$IFDEF MSWINDOWS}
    gravalog(' Free objects caixa fracionada...');

    if assigned(Mentable) then
      FreeAndNil(Mentable);
    try
      if assigned(ObjPedidoFracCtrl) then
        FreeAndNil(ObjPedidoFracCtrl);
    except
    end;
    try
      if assigned(ReturnJsonArrayFrac) then
        ReturnJsonArrayFrac := Nil;
    except

    end;
    try
      if assigned(FDMemVolumeEmbalagem) then
        FreeAndNil(FDMemVolumeEmbalagem);
    except

    end;
    try
      if assigned(ArrayJsonRetorno) then
        ArrayJsonRetorno := nil;
    except

    end;
{$ENDIF}
  end;
end;

end.
