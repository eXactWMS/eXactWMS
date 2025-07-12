unit uFrmSaidaConsulta;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, DataSet.Serialize,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.DateTimeCtrls, System.JSON,
  Data.Bind.Components, Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures, FMX.ActnList,
  System.Actions, FMX.TabControl, FMX.Edit, FMX.Layouts, FMX.Grid, FMX.ListView,
  FMX.Controls.Presentation, FMX.Objects, ksTypes, ksLoadingIndicator,
  DataSetConverter4D, FMX.DialogService,
  DataSetConverter4D.Impl, FMX.Grid.Style, FMX.ScrollBox, FMX.ListBox,
  FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani;
type
  TFrmSaidaConsulta = class(TFrmBase)
    Label1: TLabel;
    Label2: TLabel;
    EdtPessoaId: TEdit;
    BindSourceDB1: TBindSourceDB;
    FdMemSaidas: TFDMemTable;
    Label3: TLabel;
    EdtDocumentoNr: TEdit;
    LytShowPedido: TLayout;
    LytPedidoVolumes: TLayout;
    Layout5: TLayout;
    Rectangle1: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LytPedidos: TLayout;
    RctTopListaPedido: TRectangle;
    LblTitId: TLabel;
    LblTitDocNr: TLabel;
    LblTitData: TLabel;
    LblTitProc: TLabel;
    LstPedidos: TListView;
    LblTitDest: TLabel;
    LytDetTop: TLayout;
    EdtDtSaida: TEdit;
    BtnSearch: TSpeedButton;
    Path1: TPath;
    FDMemPedidoVolumes: TFDMemTable;
    LstPedidoVolumes: TListView;
    ImgAtendidoPendente: TImage;
    ImgAtendidoTotal: TImage;
    ImgAtendidoParcial: TImage;
    ImgAtendidoCancelado: TImage;
    RctAtendTotal: TRectangle;
    Label10: TLabel;
    RctAtendParcial: TRectangle;
    Label11: TLabel;
    RctAtendCancelado: TRectangle;
    Label12: TLabel;
    Line1: TLine;
    Line2: TLine;
    Line3: TLine;
    ImgLixeira: TImage;
    ImgLixeiraOff: TImage;
    EdtPedidoId: TEdit;
    Line4: TLine;
    FdMemSaidasPedidoId: TIntegerField;
    FdMemSaidasOperacaoTipoId: TIntegerField;
    FdMemSaidasOperacao: TStringField;
    FdMemSaidasPessoaId: TIntegerField;
    FdMemSaidasCodPessoaERP: TIntegerField;
    FdMemSaidasRazao: TStringField;
    FdMemSaidasDocumentoNr: TStringField;
    FdMemSaidasDocumentoData: TStringField;
    FdMemSaidasDtInclusao: TStringField;
    FdMemSaidasHrInclusao: TStringField;
    FdMemSaidasArmazemId: TIntegerField;
    FdMemSaidasStatus: TIntegerField;
    FdMemSaidasRotaId: TIntegerField;
    FdMemSaidasRota: TStringField;
    FdMemSaidasProcessoId: TIntegerField;
    FdMemSaidasEtapa: TStringField;
    FdMemSaidasPicking: TIntegerField;
    FdMemSaidasItens: TIntegerField;
    FdMemSaidasDemanda: TIntegerField;
    FdMemSaidasQtdSuprida: TIntegerField;
    FdMemSaidasRegistroERP: TStringField;
    FdMemSaidasuuid: TStringField;
    FdMemSaidasTVolumes: TIntegerField;
    FdMemSaidasTVolCxaFechada: TIntegerField;
    FdMemSaidasTVolFracionado: TIntegerField;
    FdMemSaidasCancelado: TIntegerField;
    FdMemSaidasPeso: TFloatField;
    FdMemSaidasVolCm3: TFloatField;
    FDMemPedidoVolumesPedidoId: TIntegerField;
    FDMemPedidoVolumesPedidoVolumeId: TIntegerField;
    FDMemPedidoVolumesVolumeTipo: TIntegerField;
    FDMemPedidoVolumesEmbalagem: TStringField;
    FDMemPedidoVolumesDescricao: TStringField;
    FDMemPedidoVolumesIdentificacao: TStringField;
    FDMemPedidoVolumesTara: TIntegerField;
    FDMemPedidoVolumesSequencia: TIntegerField;
    FDMemPedidoVolumesVolumeCaixa: TIntegerField;
    FDMemPedidoVolumesProcessoId: TIntegerField;
    FDMemPedidoVolumesProcesso: TStringField;
    FDMemPedidoVolumesDocumentoData: TStringField;
    FDMemPedidoVolumesPessoaId: TIntegerField;
    FDMemPedidoVolumesRazao: TStringField;
    FDMemPedidoVolumesRotaId: TIntegerField;
    FDMemPedidoVolumesRota: TStringField;
    FDMemPedidoVolumesOrdem: TIntegerField;
    FDMemPedidoVolumesDemanda: TIntegerField;
    FDMemPedidoVolumesQtdSuprida: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure LstPedidosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure LstPedidoVolumesItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure LstPedidosItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure EdtDtSaidaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    Procedure Limpar(tipo : integer = 0);
    Function ApplyMask(aMask, aValue: String): String;
    Procedure AlertaErro(pMensagem : String);
    procedure Pesquisa;
    Procedure PesquisaVolume(pPedidoId : Integer; pPedidoEtapa : Single);
  public
    { Public declarations }
  end;

var
  FrmSaidaConsulta: TFrmSaidaConsulta;

implementation

{$R *.fmx}

uses uTSaida, uDmClient, uFrmeXactWMS, Notificacao, PedidoSaidaCtrl, PedidoVolumeCtrl;

procedure TFrmSaidaConsulta.AlertaErro(pMensagem: String);
begin
  TThread.CreateAnonymousThread(procedure begin
    TThread.Synchronize(nil, procedure
    begin
      FrmeXactWMS.PlaySound('notfound.wav');
      TLoading.ToastMessage(FrmeXactWMS, pMensagem, TAlignLayout.Top, CorToastErro);
    End);
  end).Start;
end;

function TFrmSaidaConsulta.ApplyMask(aMask, aValue: String): String;
Var
   M, V  : Integer;
   Texto : String;
begin
  Result := '';
  Texto  := '';
  aMask  := aMask.ToUpper;
  for V := 0 to aValue.Length-1 do
     if aValue.Chars[V] In ['0'..'9'] Then
        Texto := Texto + aValue.Chars[V];
  M := 0;
  V := 0;
  while (V < Texto.Length) And (M < aMask.Length) do Begin
    While aMask.Chars[M] <> '#' Do Begin
      Result := Result + aMask.Chars[M];
      Inc(M);
    End;
    Result := Result + Texto.Chars[V];
    Inc(M);
    Inc(V);
  End;
end;

procedure TFrmSaidaConsulta.BtnAddClick(Sender: TObject);
begin
  FuncaoDesabilitada(Self);
  //inherited;
end;

procedure TFrmSaidaConsulta.BtnSearchClick(Sender: TObject);
begin
  inherited;
  if (EdtPedidoId.Text.IsEmpty) and (EdtDocumentoNr.Text.IsEmpty) and (EdtDtSaida.Text.IsEmpty) and (EdtPessoaId.Text.Isempty) then
     ShowErro('Informe algum parâmetro para pesquisa!')
  Else Begin
    Try
      If Not EdtDtSaida.Text.IsEmpty Then
         StrToDate(EdtDtSaida.Text);
    Except On E: Exception do
      raise Exception.Create('Erro: Data do Pedido inválida!');
    End;
    //MensagemStand('API: '+DmeXactWMS.RestClientWMS.BASEURL);
    Pesquisa;
  End;
end;

procedure TFrmSaidaConsulta.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
     If sender = EdtPedidoId Then DelayedSetFocus(EdtDocumentoNr)
     Else if Sender = EdtDocumentoNr then DelayEdSetFocus(EdtDtSaida)
     Else If Sender = EdtDtSaida then DelayedSetFocus(EdtPessoaId)
     Else If Sender = EdtPessoaId Then DelayEdSetFocus(EdtPedidoid);
end;

procedure TFrmSaidaConsulta.EdtDtSaidaKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then Begin
     DelayedSetFocus(EdtPessoaId);
     Exit;
  End;
  TThread.Queue(Nil,
     Procedure
     begin
     EdtDtSaida.Text := ApplyMask('##/##/####', EdtDtSaida.Text);
     EdtDtSaida.CaretPosition := EdtDtSaida.Text.Length;
     End);
end;

procedure TFrmSaidaConsulta.Pesquisa;
var JsonArrayRetorno : TJSONArray;
    ObjPedidoCtrl    : TPedidoSaidaCtrl;
    vErro            : String;
    vDtInicio        : TDateTime;
Begin
  inherited;
  Try
    Showloading;
    If EdtDtSaida.Text = '' then
       vDtInicio := 0
    Else vDtInicio :=StrToDate(EdtDtSaida.Text);
    if (FdMemSaidas.Active) then Begin
       FdMemSaidas.EmptyDataSet;
       //FdMemSaidas.FieldDefs.Clear;
       FdMemSaidas.Close;
    End;
    ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
    JsonArrayRetorno := ObjPedidoCtrl.PedidoProcessar(StrToIntDef(EdtPedidoId.Text, 0), 0, StrToIntDef(EdtPessoaId.Text, 0), vDtInicio, vDtInicio,
                                                      '', '', '', 0, 0, 0, 0, 1, 1, 1, False, 2, 0, 0, 0, '', 0, 0);
    if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then
       ShowErro('😢Erro: '+vErro)
    Else Begin
       FdmemSaidas.LoadFromJson(JsonArrayRetorno, False);
       LstPedidos.BeginUpdate;
       LstPedidos.Items.Clear;
       while NOT FdmemSaidas.Eof do begin
         with LstPedidos.Items.Add do Begin
           TListItemText(Objects.FindDrawable('Text3')).Text := FdmemSaidas.FieldByName('PedidoId').AsString;
           TListItemText(Objects.FindDrawable('Text4')).Text := FdmemSaidas.FieldByName('DocumentoNr').AsString;
           TListItemText(Objects.FindDrawable('Text5')).Text := FdmemSaidas.FieldByName('DocumentoData').AsString;
           TListItemText(Objects.FindDrawable('Text6')).Text := FdmemSaidas.FieldByName('etapa').AsString;
           TListItemText(Objects.FindDrawable('Text6')).TagFloat := FdmemSaidas.FieldByName('ProcessoId').AsInteger;
           TListItemText(Objects.FindDrawable('Text7')).Text := FdmemSaidas.FieldByName('Razao').AsString;
//Fundo do ListView de Acordo com a Etapa do Pedido
           if FdmemSaidas.FieldByName('ProcessoId').AsInteger < 12 then
              TListItemImage(Objects.FindDrawable('Image8')).Bitmap := ImgAtendidoPendente.BitMap
           Else if FdmemSaidas.FieldByName('ProcessoId').AsInteger = 15 then
               TListItemImage(Objects.FindDrawable('Image8')).Bitmap := ImgAtendidoCancelado.BitMap
           Else Begin
            if FdmemSaidas.FieldByName('Demanda').AsInteger = FdMemPedidoVolumes.FieldByName('QtdSuprida').AsInteger then
               TListItemImage(Objects.FindDrawable('Image8')).Bitmap := ImgAtendidoTotal.BitMap
            Else if FdmemSaidas.FieldByName('Demanda').AsInteger > FdMemPedidoVolumes.FieldByName('QtdSuprida').AsInteger then
               TListItemImage(Objects.FindDrawable('Image8')).Bitmap := ImgAtendidoParcial.BitMap;
           End;

           if FdmemSaidas.FieldByName('ProcessoId').AsInteger < 13 then Begin
              TListItemImage(Objects.FindDrawable('Image7')).Bitmap := ImgLixeira.BitMap;
              TListItemImage(Objects.FindDrawable('Image7')).TagFloat := 1;
              End
           Else Begin
              TListItemImage(Objects.FindDrawable('Image7')).Bitmap   := ImgLixeiraOff.BitMap;
              TListItemImage(Objects.FindDrawable('Image7')).TagFloat := 0;
           End;
         End;
         FdmemSaidas.Next;
       end;
       LstPedidos.EndUpdate;
       FdMemSaidas.First;
       PesquisaVolume(FdMemSaidas.FieldByName('PedidoId').AsInteger, FdMemSaidas.FieldByName('ProcessoId').AsInteger);
    End;
    JsonArrayRetorno := Nil;
    ObjPedidoCtrl := Nil;
    HideLoading;
  Except
    HideLoading;
  End;
End;

procedure TFrmSaidaConsulta.PesquisaVolume(pPedidoId : Integer; pPedidoEtapa: Single);
Var ReturnJsonArray     : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    vErro               : String;
begin
  if (FdMemPedidoVolumes.Active) then Begin
     FdMemPedidoVolumes.EmptyDataSet;
     //FdMemPedidoVolumes.FieldDefs.Clear;
     FdMemPedidoVolumes.Close;
  End;
  LstPedidoVolumes.Items.Clear;
  ReturnJsonArray := ObjPedidoVolumeCtrl.GetVolume(pPedidoId, 0, 0);
  if ReturnJsonArray.Get(0).tryGetValue<String>('Erro', vErro) then
     ShowErro('😢Erro: '+vErro)
  Else Begin
     FdMemPedidoVolumes.LoadFromJson(ReturnjsonArray, False);
     LstPedidoVolumes.BeginUpdate;
     LstPedidoVolumes.Items.Clear;
     while NOT FdMemPedidoVolumes.Eof do begin
       with LstPedidoVolumes.Items.Add do Begin
         TListItemText(Objects.FindDrawable('Text3')).Text := FdMemPedidoVolumes.FieldByName('PedidoVolumeId').AsString;
         TListItemText(Objects.FindDrawable('Text4')).Text := FdMemPedidoVolumes.FieldByName('Sequencia').AsString;
         TListItemText(Objects.FindDrawable('Text5')).Text := FdMemPedidoVolumes.FieldByName('Embalagem').AsString;
         TListItemText(Objects.FindDrawable('Text6')).Text := FdMemPedidoVolumes.FieldByName('Processo').AsString;
         TListItemText(Objects.FindDrawable('Text7')).Text := '0';
         TListItemText(Objects.FindDrawable('Text8')).Text := '0';
         if FdMemPedidoVolumes.FieldByName('ProcessoId').AsInteger < 12 then
            TListItemImage(Objects.FindDrawable('Image2')).Bitmap := ImgAtendidoPendente.BitMap
         Else if FdMemPedidoVolumes.FieldByName('ProcessoId').AsInteger = 15 then
             TListItemImage(Objects.FindDrawable('Image2')).Bitmap := ImgAtendidoCancelado.BitMap
         Else Begin
          if FdMemPedidoVolumes.FieldByName('Demanda').AsInteger = FdMemPedidoVolumes.FieldByName('QtdSuprida').AsInteger then
             TListItemImage(Objects.FindDrawable('Image2')).Bitmap := ImgAtendidoTotal.BitMap
          Else if FdMemPedidoVolumes.FieldByName('Demanda').AsInteger > FdMemPedidoVolumes.FieldByName('QtdSuprida').AsInteger then
             TListItemImage(Objects.FindDrawable('Image2')).Bitmap := ImgAtendidoParcial.BitMap;
         End;
         if pPedidoEtapa < 13 then Begin
            TListItemImage(Objects.FindDrawable('Image10')).Bitmap := ImgLixeira.BitMap;
            TListItemImage(Objects.FindDrawable('Image10')).TagFloat := 1;
            End
         Else Begin
            TListItemImage(Objects.FindDrawable('Image10')).Bitmap   := ImgLixeiraOff.BitMap;
            TListItemImage(Objects.FindDrawable('Image10')).TagFloat := 0;
         End;


       End;
       FdMemPedidoVolumes.Next;
     end;
     LstPedidoVolumes.EndUpdate;
  End;
  ReturnjsonArray     := Nil;
  ObjPedidoVolumeCtrl := Nil;
end;

procedure TFrmSaidaConsulta.FormCreate(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmSaidaConsulta.Limpar(tipo : integer);
begin
  if Tipo <> 1 then
     EdtPedidoId.Text   := '';
  EdtPessoaId.Text    := '';
  EdtDocumentoNr.Text := '';
  EdtDtSaida.Text     := '';
  LstPedidos.Items.Clear;
  LstPedidoVolumes.Items.Clear;
  if (FdMemSaidas.Active) then Begin
     FdMemSaidas.EmptyDataSet;
     FdMemSaidas.FieldDefs.Clear;
     FdMemSaidas.Close;
  End;
  if Tipo <> 1 then
     DelayedSetFocus(EdtPedidoId);
end;

procedure TFrmSaidaConsulta.LstPedidosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var txt : TListItemText;
begin
  inherited;
  txt := TListItemText(LstPedidos.Items[AItem.Index].Objects.FindDrawable('Text1'));
  PesquisaVolume(Txt.Text.ToInteger(), TListItemText(LstPedidos.Items[AItem.Index].Objects.FindDrawable('Text6')).TagFloat );
end;

procedure TFrmSaidaConsulta.LstPedidosItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var ItemText : TListItemText;
begin
  inherited;
  If ItemObject.Name = 'Image7' then Begin
     ItemText := TListItemText(LstPedidoVolumes.Items[ItemIndex].Objects.FindDrawable('Text6'));
     If ItemText.TagFloat = 1 then
        ShowErro('Cancelar Pedido');
  End;
end;

procedure TFrmSaidaConsulta.LstPedidoVolumesItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var ItemText : TListItemText;
begin
  inherited;
  If ItemObject.Name = 'Image10' then Begin
     ItemText := TListItemText(LstPedidoVolumes.Items[ItemIndex].Objects.FindDrawable('Image10'));
     If ItemText.TagFloat = 1 then Begin
        //Pegar Numero do Volume
        ItemText := TListItemText(LstPedidoVolumes.Items[ItemIndex].Objects.FindDrawable('Text3'));
        TDialogService.MessageDialog('Confirma cancelamento do volume ' +
                                     ItemText.text + ' ?',
                 TMsgDlgType.mtConfirmation,
                 [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
                 TMsgDlgBtn.mbNo,
                 0,
        procedure(const AResult: TModalResult)
        begin
            if AResult = mrYes then
            begin
                // Chamar Evento Cancelar Volume
                //Atualizar a ListView
            end;
        end);
        ShowErro('Volume não cancelado!');
     End;
  End;
end;

end.

