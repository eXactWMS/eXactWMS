Unit uFrmCargaConferencia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, System.Rtti, FMX.Grid.Style, FMX.ListView.Types, System.JSON, REST.Json, Rest.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, System.Generics.Collections,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, DataSet.Serialize,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, FMX.Objects, ksTypes,
  ksLoadingIndicator, FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani,
  FMX.ListView, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.Layouts
  {$IFDEF IOS}
    ,Macapi.Helpers
  {$ENDIF IOS}
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    ,Androidapi.Helpers
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Os
    ,Androidapi.JNI.Telephony //Sms
  {$Endif}
  , CargasCtrl, PedidoVolumeCtrl;
type
  TFrmCargaConferencia = class(TFrmBase)
    LblTit02: TLabel;
    LblTit03: TLabel;
    Label1: TLabel;
    EdtDtCarga: TEdit;
    Line1: TLine;
    Label2: TLabel;
    EdtRota: TEdit;
    Line3: TLine;
    Label3: TLabel;
    QryCargaDestinatario: TFDMemTable;
    QryCargaPedido: TFDMemTable;
    RctPedidos: TRectangle;
    Rectangle1: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LstPedidos: TListView;
    QryCargaPedidoPedidoid: TIntegerField;
    QryCargaPedidoQtdVolumes: TIntegerField;
    QryCargaPedidoItens: TIntegerField;
    QryCargaPedidoConferido: TIntegerField;
    Label10: TLabel;
    QryCargaDestinatarioCargaId: TIntegerField;
    QryCargaDestinatarioPessoaId: TIntegerField;
    QryCargaDestinatarioCodPessoaERP: TIntegerField;
    QryCargaDestinatarioRazao: TStringField;
    QryCargaDestinatarioOrdem: TIntegerField;
    QryCargaDestinatarioConferido: TIntegerField;
    Label12: TLabel;
    QryCargaVolumes: TFDMemTable;
    IntegerField1: TIntegerField;
    QryCargaVolumesPessoaId: TIntegerField;
    QryCargaVolumesPedidoVolumeId: TIntegerField;
    QryCargaVolumesConferido: TIntegerField;
    ImgLstFdoWhite: TImage;
    QryCargaDestinatarioTotPed: TIntegerField;
    EdtVolumeId: TEdit;
    Line4: TLine;
    TabVolumes: TTabItem;
    LytLegendaCargaVolumes: TLayout;
    RctCargaVolumes: TRectangle;
    RctVolumeConferido: TRectangle;
    LblVolumeConferido: TLabel;
    RctVolumePendente: TRectangle;
    LblVolumePendente: TLabel;
    LytVolumes: TLayout;
    LstCargaVolumes: TListView;
    RctLegendaVolumes: TRectangle;
    LblLegVolume: TLabel;
    LblLegConferencia: TLabel;
    LblLegEmbalagem: TLabel;
    LblLegPedido: TLabel;
    ChgTabCargaVolumes: TChangeTabAction;
    FDMemCargaVolumesResumo: TFDMemTable;
    CbDestinatario: TComboBox;
    QryCargaDestinatarioFantasia: TStringField;
    LytRodapeFinalizar: TLayout;
    BtnFinalizarConferencia: TSpeedButton;
    PthFinalizarCheckIn: TPath;
    LblFinalizarCheckIn: TLabel;
    BtnAbortarCheckIn: TSpeedButton;
    PthAbortarCheckIn: TPath;
    LblAbortarCheckIn: TLabel;
    EdtCargaId: TEdit;
    LnCargaId: TLine;
    CircContagem: TCircle;
    LblCircContagem: TLabel;
    ChkDestinatario: TCheckBox;
    ChkPendente: TCheckBox;
    CircVolumes: TCircle;
    LblCircVolumes: TLabel;
    TabVolumeProdutos: TTabItem;
    LytHeaderVolumeProdutos: TLayout;
    RctHeaderVolumeProdutos: TRectangle;
    LytBodyVolumeProdutos: TLayout;
    LstVolumeProdutos: TListView;
    RctLegendaVolumeProdutos: TRectangle;
    LblDescricao: TLabel;
    LblVencimento: TLabel;
    LblLote: TLabel;
    LblCodProduto: TLabel;
    LblVolumeId: TLabel;
    Label8: TLabel;
    LblEndereco: TLabel;
    ChgTabVolumeProdutos: TChangeTabAction;
    FDMemVolumeProdutos: TFDMemTable;
    FDMemVolumeProdutosPedidoVolumeId: TIntegerField;
    FDMemVolumeProdutosLoteId: TIntegerField;
    FDMemVolumeProdutospedidovolumeloteid: TIntegerField;
    FDMemVolumeProdutosDescrLote: TStringField;
    FDMemVolumeProdutosVencimento: TDateField;
    FDMemVolumeProdutosProdutoId: TIntegerField;
    FDMemVolumeProdutosCodProduto: TIntegerField;
    FDMemVolumeProdutosDescricao: TStringField;
    FDMemVolumeProdutosEndereco: TStringField;
    FDMemVolumeProdutosZona: TStringField;
    FDMemVolumeProdutosMascara: TStringField;
    FDMemVolumeProdutosQtdSuprida: TIntegerField;
    QryCargaPedidodocumentodata: TDateField;
    LblVolume: TLabel;
    procedure BtnSearchPesqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstPrincipalItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure EdtCodigoTyping(Sender: TObject);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure CbDestinatarioChange(Sender: TObject);
    procedure EdtVolumeIdEnter(Sender: TObject);
    procedure EdtVolumeIdExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnAbortarCheckInClick(Sender: TObject);
    procedure BtnFinalizarConferenciaClick(Sender: TObject);
    procedure ChkDestinatarioClick(Sender: TObject);
    procedure LstCargaVolumesItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
  private
    ObjCargaCtrl : TCargasCtrl;
    CodConfirmacao : integer;
    Procedure GetCarga(pCargaId : Integer);
    procedure OpenCarga(pCargaId, pRotaId, pProcessoId: Integer);
    procedure ThreadTerminate(Sender: TObject);
    { Private declarations }
    Function GetListaCarga(pCarga, pRotaId, pProcessoid : Integer) : Boolean;
    Procedure CargaDestinatario;
    Procedure MontaCargaDestinatario;
    Procedure CargaPedido;
    Procedure MontaCargaPedido;
    Procedure AtivarDestinatario;
    Procedure AtualizarDestinatario;
    Function AtualizarConferenciaVolume : Boolean;
    procedure CargaVolumes;
    Procedure InserirVolumeSqlLite;
    Procedure InserirPedidoSqlLite;
    Procedure InserirDestinatarioSqlLite;
    Procedure GetCargaVolumes;
    Procedure GetVolumeProdutos(pPedidoVolumeId : Integer);
    Procedure GetVolumeProdutosOLD(pPedidoVolumeId : Integer);
    Procedure FinalizarConferencia;
  public
    { Public declarations }
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Procedure ShowDados; OverRide;
    Procedure ConfirmacaoExecute; OverRide;
    Procedure ConfirmacaoCancel; OverRide;
    Procedure AtivaCampoDefault; OverRide;
  end;

var
  FrmCargaConferencia: TFrmCargaConferencia;

implementation

{$R *.fmx}

uses uFuncoes, uFrmeXactWMS, ProcessoCtrl, uDmClient, System.Threading;

procedure TFrmCargaConferencia.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'EdtCodigo' then Begin
     EdtCodigo.Text := '';
     DelayEdSetFocus(EdtCodigo);
  End
  Else if CampoDefault = 'EdtVolumeId' then Begin
     EdtVolumeId.Text := '';
     DelayEdSetFocus(EdtVolumeId);
  End
  Else if CampoDefault = 'CbDestinatario' then Begin
     CbDestinatario.ItemIndex := -1;
     DelayEdSetFocus(CbDestinatario);
  End
end;

procedure TFrmCargaConferencia.AtivarDestinatario;
begin
  //QryCargaDestinatario.First;
  TThread.Synchronize(TThread.CurrentThread, procedure
    begin
//      EdtDestinatario.Text := QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+' - '+QryCargaDestinatario.FieldByName('Razao').AsString;
      CbDestinatario.ItemIndex := CbDestinatario.Items.IndexOf(QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+' '+
                                  QryCargaDestinatario.FieldByName('Fantasia').AsString);
    End);
end;

Function TFrmCargaConferencia.AtualizarConferenciaVolume : Boolean;
var Th: TThread;
    xRegPedido, xRegDestinatario : Integer;
    JsonVolumeConferencia : TJsonObject;
    vPedidoVolumeId : String;
    vPos1, vPos2 : Integer;
    vPedidoId : Integer;
begin
  Result := False;
  ShowLoading;
//  Th := TThread.CreateAnonymousThread(procedure
//  Var vPos1, vPos2 : Integer;
//  begin
  Try
    vPedidoVolumeid := EdtVolumeId.Text;
    if QryCargaVolumes.Locate('PedidoVolumeId', EdtVolumeId.Text, []) then Begin
       if QryCargaVolumes.FieldByName('PessoaId').AsInteger <> QryCargaDestinatario.FieldByName('PessoaId').AsInteger then Begin
          HideLoading;
          SetCampoDefault('EdtVolumeId');
          ShowErro('Atenção: Volume('+vPedidoVolumeId+') não pertence ao Destinatário da Conferência!');
          Exit;
       End
       Else if QryCargaVolumes.FieldByName('Conferido').AsInteger = 1 then Begin
          HideLoading;
          SetCampoDefault('EdtVolumeId');
          ShowErro('Atenção: Volume('+vPedidoVolumeId+') já conferido"');
          Exit;
       End;
    End
    Else Begin
       HideLoading;
       SetCampoDefault('EdtVolumeId');
       ShowErro('Atenção: Volume('+vPedidoVolumeId+') não pertence a Carga!');
       Exit;
    End;
    QryCargaVolumes.Edit;
    QryCargaVolumes.FieldByName('Conferido').AsInteger := 1;
    vPedidoid := QryCargaVolumes.FieldByName('PedidoId').AsInteger;
    QryCargaVolumes.Post;
    //InserirVolumeSqlLite;
    JsonVolumeConferencia := TJsonObject.Create();
    JsonVolumeConferencia.AddPair('cargaid',  TJsonNumber.Create(ObjCargaCtrl.ObjCargas.CargaId));
    JsonVolumeConferencia.AddPair('pedidovolumeid', TJsonNumber.Create(StrToIntDef(EdtVolumeId.Text, 0)));
    JsonVolumeConferencia.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWms.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    JsonVolumeConferencia.AddPair('terminal', NomeDoComputador);
    JsonVolumeConferencia.AddPair('processo', 'CO');
    ObjCargaCtrl.RegistrarCarregamento(JsonVolumeConferencia);
    JsonVolumeConferencia.Free;
    QryCargaPedido.First;
    QryCargaVolumes.FieldByName('PedidoId').AsInteger;
    if QryCargaPedido.Locate('PedidoId', vPedidoid, []) then Begin
       QryCargaPedido.Edit;
       QryCargaPedido.FieldByName('Conferido').AsInteger := QryCargaPedido.FieldByName('Conferido').AsInteger + 1;
       QryCargaPedido.Post;
       xRegPedido := QryCargaPedido.RecNo;
//       InserirPedidoSqlLite;
       MontaCargaPedido;
//       MontaCargaDestinatario;
       QryCargaPedido.RecNo := xRegPedido;
       if QryCargaPedido.FieldByName('Conferido').AsInteger >= QryCargaPedido.FieldByName('QtdVolume').AsInteger then Begin
          QryCargaDestinatario.Edit;
          QryCargaDestinatario.FieldByName('Conferido').AsInteger := QryCargaDestinatario.FieldByName('Conferido').AsInteger + 1;
          QryCargaDestinatario.Post;
          xRegDestinatario := QryCargaDestinatario.RecNo;
          QryCargaDestinatario.RecNo := xRegDestinatario;
          vPos1 := QryCargaDestinatario.FieldByName('TotPed').AsInteger;
          vPos2 := QryCargaDestinatario.FieldByName('Conferido').AsInteger;
          if QryCargaDestinatario.FieldByName('Conferido').AsInteger >= QryCargaDestinatario.FieldByName('TotPed').AsInteger then Begin
             SetCampoDefault('CbDestinatario');
             CbDestinatario.ItemIndex := -1;
             ShowOk('Conferëncia Loja('+QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+') Concluída', 'ok');
             MontaCargaDestinatario;
             //AtualizarDestinatario;
          End
       End
       Else
          FrmeXactWMS.PlaySound('toast2.wav');
    End;
    Result := True;
//    TThread.Synchronize(TThread.CurrentThread, procedure
//    begin
      EdtVolumeId.Text := '';
      DelayEdSetFocus(EdtVolumeId);
//   End);
//  End);
//  Th.OnTerminate := ThreadTerminate;
//  Th.Start;
    HideLoading;
  Except On E: Exception do Begin
    HideLoading;
    SetCampoDefault('EdtVolumeId');
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

procedure TFrmCargaConferencia.AtualizarDestinatario;
Var pJsonFinalizar : TJsonObject;
begin
  QryCargaDestinatario.Next;
  //Mudar abaixo... Exibir Barra Finalizar
  if (QryCargaDestinatario.Eof) then Begin
     pJsonFinalizar := TJsonObject.Create();
     pJsonFinalizar.AddPair('cargaid', TJsonNumber.Create(StrToIntDef(EdtCargaId.Text, 0)));
     pJsonFinalizar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
     pJsonFinalizar.AddPair('terminal', NomeDoComputador);
     pJsonFinalizar.AddPair('operacao', 'CO');
     ObjCargaCtrl.FinalizarCarregamento(pJsonFinalizar);
     pJsonFinalizar.Free;
     EdtCargaId.Text   := '';
     EdtConteudoPesq.Text := '';
     ShowOk('Conferência Concluída!!!');
     Try
     Limpar;
     Except
     ShowErro('Erro na funcao Limpar');
     End;
     Try
     GetListaLstCadastro;
     Except
     ShowErro('Erro na funcao Limpar');
     End;
     Exit;
  End
  Else
     CargaPedido;
//  EdtDestinatario.Text := QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+' - '+QryCargaDestinatario.FieldByName('Razao').AsString;
  CbDestinatario.Itemindex := CbDestinatario.Items.IndexOf(QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+' '+
                              QryCargaDestinatario.FieldByName('Fantasia').AsString);
  DelayEdSetFocus(EdtVolumeId);
end;

procedure TFrmCargaConferencia.BtnAbortarCheckInClick(Sender: TObject);
begin
  inherited;
  CodConfirmacao := 2;
  LblTituloConfirmacao.Text := 'Abortar Conferência';
  LblTituloFoot.Text        := 'todos volumes serão removidos da conferência.';
  LblMensagem1.Text         := 'Abortar conferência?';
  LblMensagem2.Text         := 'A conferência garante integridade ao carregamento.';
  PgcPrincipal.ActiveTab    := TabConfirmacao;
end;

procedure TFrmCargaConferencia.BtnFinalizarConferenciaClick(Sender: TObject);
begin
  inherited;
  CodConfirmacao := 1;
  LblTituloConfirmacao.Text := 'Finalizar Conferência';
  LblTituloFoot.Text        := 'Finalize a conferência para liberar o carregamento.';
  LblMensagem1.Text         := 'Finalizar a conferência?';
  LblMensagem2.Text         := 'A conferência garante integridade ao carregamento.';
  PgcPrincipal.ActiveTab    := TabConfirmacao;
end;

procedure TFrmCargaConferencia.BtnSearchPesqClick(Sender: TObject);
begin
//  inherited;
  if StrToIntDef(EdtConteudoPesq.Text, 0) <=  0 then Begin
     SetCampoDefault('EdtCargaId');
     ShowErro('Informe um Id de carga válido');
  End
  Else
     OpenCarga(StrToIntDef(EdtConteudoPesq.Text, 0), 0 , 16);
end;

procedure TFrmCargaConferencia.CargaDestinatario;
Var JsonArrayDestinatario : TJsonArray;
    vErro  : String;
    xDest  : Integer;
begin
//  Showloading;
  Try
    JsonArrayDestinatario := ObjCargaCtrl.GetCargaPessoas(ObjCargaCtrl.ObjCargas.cargaid, 'CO' , 0);
    if JsonArrayDestinatario.Items[0].TryGetValue('Erro', vErro) then Begin
       raise Exception.Create(vErro);
       Exit;
    End;
    If QryCargaDestinatario.Active then
       QryCargaDestinatario.EmptyDataSet;
    QryCargaDestinatario.Close;
    QryCargaDestinatario.LoadFromJSON(JsonArrayDestinatario, False);
    QryCargaDestinatario.First;
    CbDestinatario.Items.Clear;
    While Not QryCargaDestinatario.Eof do Begin
       CbDestinatario.Items.Add(QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+' '+
                                QryCargaDestinatario.FieldByName('Fantasia').AsString);
       QryCargaDestinatario.Next;
    End;
    MontaCargaDestinatario;
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
//  JsonArrayDestinatario.Free;
//  HideLoading;
end;

procedure TFrmCargaConferencia.CargaPedido;
Var JsonArrayPedido : TJsonArray;
    vErro  : String;
begin
  Try
    JsonArrayPedido := ObjCargaCtrl.GetCargaPedidos(ObjCargaCtrl.ObjCargas.cargaid,
                       QryCargaDestinatario.FieldByName('PessoaId').AsInteger, 'CO', 0);
    if JsonArrayPedido.Items[0].TryGetValue('Erro', vErro) then Begin
       raise Exception.Create(vErro);
       Exit;
    End;
    If QryCargaPedido.Active then
       QryCargaPedido.EmptyDataSet;
    QryCargaPedido.Close;
    QryCargaPedido.LoadFromJSON(JsonArrayPedido, False);
    //QryCargaDestinatario.IndexFieldNames := 'CodPessoaERP';
    MontaCargaPedido;
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
//  JsonArrayPedido.Free;
end;

procedure TFrmCargaConferencia.CargaVolumes;
Var JsonArrayVolumes : TJsonArray;
    vErro  : String;
begin
  Try
    JsonArrayVolumes := ObjCargaCtrl.GetCargaCarregarVolumes(ObjCargaCtrl.ObjCargas.cargaid,
                        QryCargaDestinatario.FieldByName('PessoaId').AsInteger, 'CO', 0);
    if JsonArrayVolumes.Items[0].TryGetValue('Erro', vErro) then Begin
       raise Exception.Create(vErro);
       Exit;
    End;
    If QryCargaVolumes.Active then
       QryCargaVolumes.EmptyDataSet;
    QryCargaVolumes.Close;
    QryCargaVolumes.LoadFromJSON(JsonArrayVolumes, False);
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
//  JsonArrayPedido.Free;
end;

procedure TFrmCargaConferencia.CbDestinatarioChange(Sender: TObject);
Var vCodPessoaERP : Integer;
begin
  if (CbDestinatario.Items.Count <= 0) or (CbDestinatario.ItemIndex < 0)then Begin
     DelayEdSetFocus(CbDestinatario);
     EdtVolumeId.Text := '';
     Exit;
  End;
  inherited;
  vCodPessoaERP := StrToIntDef(Copy(CbDestinatario.Items[CbDestinatario.ItemIndex], 1,
                               Pos(' ', CbDestinatario.Items[CbDestinatario.ItemIndex])-1), 0);
  If QryCargaDestinatario.Locate('CodPessoaERP', vCodPessoaERP, []) then Begin
     CargaPedido;
     CargaVolumes;
     DelayEdSEtFocus(EdtVolumeId);
  End;
end;

procedure TFrmCargaConferencia.ChkDestinatarioClick(Sender: TObject);
begin
  inherited;
  GetCargaVolumes;
end;

procedure TFrmCargaConferencia.ConfirmacaoCancel;
begin
  inherited;
  case CodConfirmacao Of
    1, 2: Begin
       PgcPrincipal.ActiveTab := TabDetalhes;
    End;
    3: Begin
       PgcPrincipal.ActiveTab := TabLista;
    End;
    Else
       PgcPrincipal.ActiveTab := TabDetalhes;
  end;
end;

procedure TFrmCargaConferencia.ConfirmacaoExecute;
Var vCargaId   : Integer;
    JsonObject : TJsonObject;
    vErro      : String;
begin
  inherited;
 case CodConfirmacao Of
    1: Begin
       FinalizarConferencia;
       PgcPrincipal.ActiveTab := TabDetalhes;
    End;
    2: Begin
       vCargaId := ObjCargaCtrl.ObjCargas.cargaid;
       ObjCargaCtrl.CancelarConferencia(vCargaId);
       PgcPrincipal.ActiveTab := TabLista;
          //GetListaLstCadastro;
    End;
    3: Begin //Reconferência de Cargas
         vCargaId   := ObjCargaCtrl.ObjCargas.cargaid;
         JsonObject := ObjCargaCtrl.CancelarConferencia(vCargaId);
         if Not JsonObject.TryGetValue('Erro', vErro) then Begin
            edtCargaId.Text        := '';
            sleep(20);
            PgcPrincipal.ActiveTab := TabLista;
            EdtConteudoPesq.Text := '';
         End
         Else Begin
           SetCampoDefault('EdtCargaId');
           ShowErro('Erro: '+vErro);
         End;
       End;
    Else
       PgcPrincipal.ActiveTab := TabDetalhes;
  end;
end;

procedure TFrmCargaConferencia.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if EdtCargaId.Text = '' then
     Exit;
  if StrToIntDef(EdtCargaId.Text, 0) <= 0 then Begin
     SetCampoDefault('EdtCargaId');
     ShowErro('Id('+EdtCargaId.Text+') de Carga inválido!');
     Exit;
  End;
  if Key = 13 then
     OpenCarga(StrToIntDef(EdtCargaId.Text, 0), 0, 0);
end;

procedure TFrmCargaConferencia.EdtCodigoTyping(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmCargaConferencia.EdtVolumeIdEnter(Sender: TObject);
begin
  inherited;
  //EdtVolumeId.StyleLookup := 'transparentedit'; // Define o estilo do Edit como transparente
  //EdtVolumeId.StyledSettings := EdtVolumeId.StyledSettings - [TStyledSetting.ssBackground]; // Remove as configurações de estilo de fundo do Edit
//  EdtVolumeId.Font.Fill.Color := TAlphaColors.Red; // Define a cor de fundo do Edit como vermelho
  //EdtVolumeId.TextSettings.FontColor := TAlphaColors.Burlywood;
  //EdtVolumeId.Fill.Color := TAlphaColors.Red;
end;

procedure TFrmCargaConferencia.EdtVolumeIdExit(Sender: TObject);
begin
  inherited;
  //EdtVolumeId.TextSettings.FontColor := TAlphaColors.white; // Define a cor de fundo do Edit como vermelho
end;

procedure TFrmCargaConferencia.EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (EdtVolumeId.Text = '') then Exit;
  If (CbDestinatario.ItemIndex < 0) then Begin
     SetCampoDefault('CbDestinatario');
     ShowErro('Selecione a loja para conferêcia.');
     Exit;
  End;
  if (Key = 13) then Begin
     If Not AtualizarConferenciaVolume then Begin
        EdtVolumeId.Text := '';
        DelayEdSetFocus(EdtVolumeId);
     End;
  End;
end;

procedure TFrmCargaConferencia.FinalizarConferencia;
Var pJsonFinalizar : TJsonObject;
begin
  Try
    pJsonFinalizar := TJsonObject.Create();
    pJsonFinalizar.AddPair('cargaid', TJsonNumber.Create(StrToIntDef(EdtCargaId.Text, 0)));
    pJsonFinalizar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
    {$IfDef Android}
       pJsonFinalizar.AddPair('terminal', IMEI); //IMEI;   //Substituído estacao por terminal em 18/03/2021
    {$else}
       pJsonFinalizar.AddPair('terminal', NomeDoComputador);
    {$Endif}
    pJsonFinalizar.AddPair('terminal', NomeDoComputador);
    pJsonFinalizar.AddPair('operacao', 'CO');
    ObjCargaCtrl.FinalizarCarregamento(pJsonFinalizar);
    pJsonFinalizar.Free;
    EdtCargaId.Text      := '';
    EdtConteudoPesq.Text := '';
    ShowOk('Conferência Concluída!!!');
    Limpar;
    GetListaLstCadastro;
  Except On E: Exception do Begin
    SetCampoDefault('EdtCargaId');
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

procedure TFrmCargaConferencia.FormCreate(Sender: TObject);
begin
  EdtCodigo.Visible := False;
  BtnFinalizarConferencia.Enabled := False;
  ObjCargaCtrl      := TCargasCtrl.Create;
  CircleStatus.Visible := False;
  LblAtivo.Visible     := False;
  inherited;
  PgcPrincipal.ActiveTab := TabLista;
  //GetListaLstCadastro;
end;

procedure TFrmCargaConferencia.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(ObjCargaCtrl) then
     ObjCargaCtrl.Free;
end;

{procedure TFrmCargaConferencia.GetCarga(pCargaId: Integer);
Var
  JsonArrayCarga: TJsonArray;
  vErro: String;
begin
  TTask.Create(
    procedure()
    begin
      JsonArrayCarga := ObjCargaCtrl.GetCargas(pCargaId, 0, 0, '', '', '', 0, '', '', 0);
      TThread.Synchronize(nil,
        procedure()
        begin
          if JsonArrayCarga.Items[0].TryGetValue('Erro', vErro) then
          Begin
            EdtCargaId.Enabled := True;
            DelayEdSetFocus(EdtCargaId);
            raise Exception.Create(vErro);
          End;
          // ObjCargaCtrl.ObjCargas := ObjCargaCtrl.ObjCargas.JsonToClass((JsonArrayCarga.Items[0] as TJsonObject).ToString);
          if (JsonArrayCarga.Items[0].GetValue<Integer>('processoid') = 21) then
          Begin // <> vProcessoId then Begin
            EdtCargaId.Enabled := True;
            DelayEdSetFocus(EdtCargaId);
            raise Exception.Create('Carga cancelada!!!');
            // JsonArrayProcesso.DisposeOf;
            Exit;
          End
          Else if (JsonArrayCarga.Items[0].GetValue<Integer>('processoid') = 16)
            and (JsonArrayCarga.Items[0].GetValue<Integer>('carregando') = 1)
          then
          Begin // <> vProcessoId then Begin
            EdtCargaId.Enabled := True;
            DelayEdSetFocus(EdtCargaId);
            raise Exception.Create('Carga em processo de Carregamento!!!');
            // JsonArrayProcesso.DisposeOf;
            Exit;
          End;
          ObjCargaCtrl.ObjCargas.CargaId := JsonArrayCarga.Items[0]
            .GetValue<Integer>('cargaid');
          ObjCargaCtrl.ObjCargas.rotaid := JsonArrayCarga.Items[0]
            .GetValue<Integer>('rotaid');
          EdtRota.Text := JsonArrayCarga.Items[0].GetValue<String>('rota');
          ObjCargaCtrl.ObjCargas.dtinclusao :=
            StrToDate(JsonArrayCarga.Items[0].GetValue<string>('dtinclusao'));
          ObjCargaCtrl.ObjCargas.transportadora.PessoaId := JsonArrayCarga.Items
            [0].GetValue<Integer>('transportadoraid');
          ObjCargaCtrl.ObjCargas.transportadora.Razao := JsonArrayCarga.Items[0]
            .GetValue<String>('transportadora');
          ObjCargaCtrl.ObjCargas.veiculo.VeiculoId := JsonArrayCarga.Items[0]
            .GetValue<Integer>('veiculoid');
          ObjCargaCtrl.ObjCargas.veiculo.Placa := JsonArrayCarga.Items[0]
            .GetValue<String>('placa');
          ObjCargaCtrl.ObjCargas.veiculo.Modelo := JsonArrayCarga.Items[0]
            .GetValue<String>('modelo');
          ObjCargaCtrl.ObjCargas.motorista.CodPessoa := JsonArrayCarga.Items[0]
            .GetValue<Integer>('motoristaid');
          ObjCargaCtrl.ObjCargas.motorista.Razao := JsonArrayCarga.Items[0]
            .GetValue<String>('motorista');
          ObjCargaCtrl.ObjCargas.ProcessoId := JsonArrayCarga.Items[0]
            .GetValue<Integer>('processoid');
          ShowDados;
        End);
    end);
end;
}
procedure TFrmCargaConferencia.GetCarga(pCargaId : Integer);
Var JsonArrayCarga : TJsonArray;
    vErro          : String;
begin
    JsonArrayCarga := ObjCargaCtrl.GetCargas(pCargaId, 0, 0, '', '', '', '', 0, '', '', 0);
    if JsonArrayCarga.Items[0].TryGetValue('Erro', vErro) then Begin
       EdtCargaId.Enabled := True;
       DelayEdSetFocus(EdtCargaId);
       raise Exception.Create(vErro);
    End;
//    ObjCargaCtrl.ObjCargas := ObjCargaCtrl.ObjCargas.JsonToClass((JsonArrayCarga.Items[0] as TJsonObject).ToString);
    if (JsonArrayCarga.Items[0].GetValue<Integer>('processoid') = 21) then Begin //<> vProcessoId then Begin
       EdtCargaId.Enabled := True;
       DelayEdSetFocus(EdtCargaId);
       raise Exception.Create('Carga cancelada!!!');
       //JsonArrayProcesso.DisposeOf;
       Exit;
    End
    Else if (JsonArrayCarga.Items[0].GetValue<Integer>('processoid') = 16) and
       (JsonArrayCarga.Items[0].GetValue<Integer>('carregando') = 1) then Begin //<> vProcessoId then Begin
       EdtCargaId.Enabled := True;
       DelayEdSetFocus(EdtCargaId);
       raise Exception.Create('Carga em processo de Carregamento!!!');
       //JsonArrayProcesso.DisposeOf;
       Exit;
    End;
    ObjCargaCtrl.ObjCargas.cargaid    := JsonArrayCarga.Items[0].GetValue<Integer>('cargaid');
    ObjCargaCtrl.ObjCargas.rotaid     := JsonArrayCarga.Items[0].GetValue<Integer>('rotaid');
    EdtRota.Text                      := JsonArrayCarga.Items[0].GetValue<String>('rota');
    ObjCargaCtrl.ObjCargas.dtinclusao := StrToDate(JsonArrayCarga.Items[0].GetValue<string>('dtinclusao'));
    ObjCargaCtrl.ObjCargas.transportadora.PessoaId := JsonArrayCarga.Items[0].GetValue<Integer>('transportadoraid');
    ObjCargaCtrl.ObjCargas.transportadora.Razao    := JsonArrayCarga.Items[0].GetValue<String>('transportadora');
    ObjCargaCtrl.ObjCargas.veiculo.VeiculoId       := JsonArrayCarga.Items[0].GetValue<Integer>('veiculoid');
    ObjCargaCtrl.ObjCargas.Veiculo.Placa           := JsonArrayCarga.Items[0].GetValue<String>('placa');
    ObjCargaCtrl.ObjCargas.Veiculo.Modelo          := JsonArrayCarga.Items[0].GetValue<String>('modelo');
    ObjCargaCtrl.ObjCargas.motorista.CodPessoa     := JsonArrayCarga.Items[0].GetValue<Integer>('motoristaid');
    ObjCargaCtrl.ObjCargas.Motorista.Razao         := JsonArrayCarga.Items[0].GetValue<String>('motorista');
    ObjCargaCtrl.ObjCargas.ProcessoId              := JsonArrayCarga.Items[0].GetValue<Integer>('processoid');
    TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      ShowDados;
    End);
end;

procedure TFrmCargaConferencia.GetCargaVolumes;
Var Th : TThread;
begin
  ShowLoading;
  Th := TThread.CreateAnonymousThread(procedure
     Var JsonArrayVolumes : TJsonArray;
         vErro : String;
     begin
       Try
         If FDMemCargaVolumesResumo.Active then
            FDMemCargaVolumesResumo.EmptyDataSet;
         FDMemCargaVolumesResumo.Close;
         LstCargaVolumes.Items.Clear;
         JsonArrayVolumes := ObjCargaCtrl.GetCargaPedidoVolumesConferencia(ObjCargaCtrl.ObjCargas.cargaid, 'CO');
       Except On E: Exception do Begin
          JsonArrayVolumes := Nil;
          raise Exception.Create('Erro: '+E.Message);
         End;
       End;
       if JsonArrayVolumes.Items[0].TryGetValue('Erro', vErro) then Begin
          JsonArrayVolumes := Nil;
          raise Exception.Create('Erro: Carregando volumes!');
       End
       Else Begin
         FDMemCargaVolumesResumo.LoadFromJSON(JsonArrayVolumes, False);

         if (ChkDestinatario.IsChecked) and (ChkPendente.IsChecked) then Begin
            FdMemCargaVolumesResumo.Filter   := '(pessoaid='+QryCargaDestinatario.FieldByName('PessoaId').AsString+') and (Conferido=0)';
            FdMemCargaVolumesResumo.Filtered := True;
         End
         Else if (ChkDestinatario.IsChecked) then Begin
            FdMemCargaVolumesResumo.Filter   := 'pessoaid='+QryCargaDestinatario.FieldByName('PessoaId').AsString;
            FdMemCargaVolumesResumo.Filtered := True;
         End
         Else if (ChkPendente.IsChecked) then Begin
            FdMemCargaVolumesResumo.Filter   := '(Conferido=0)';
            FdMemCargaVolumesResumo.Filtered := True;
         End;

         TThread.Synchronize(TThread.CurrentThread, procedure
         Var item : TListViewItem;
             txt  : TListItemText;
             img, Img3 : TListItemImage;
         begin
           LstCargaVolumes.BeginUpdate;
           LstCargaVolumes.Items.Clear;
           FDMemCargaVolumesResumo.First;
           While Not FDMemCargaVolumesResumo.Eof do Begin
             item := LstCargaVolumes.Items.Add;
             item.Objects.Clear;
             item.Tag := FDMemCargaVolumesResumo.FieldByName('PedidoVolumeid').AsLargeInt;
             with item do begin
               img := TListItemImage(Objects.FindDrawable('ImgFdoVolumes'));
               //img.ScalingMode := TImageScalingMode.Stretch;
               If FDMemCargaVolumesResumo.FieldByName('Conferido').AsInteger = 1 Then       //Inicializado
                  img.Bitmap := ImgLstFdoGreen.Bitmap
               Else
                  img.Bitmap := ImgLstFdoYellow.Bitmap;
               img3 := TListItemImage(Objects.FindDrawable('Image3'));
               //img3.ScalingMode := TImageScalingMode.Stretch;
               img3.Bitmap := ImgEye.Bitmap;

               txt := TListItemText(Objects.FindDrawable('PedidoId'));
               txt.Text := FDMemCargaVolumesResumo.FieldByName('PedidoId').AsString;

               txt := TListItemText(Objects.FindDrawable('PedidoVolumeId'));
               txt.Text := FDMemCargaVolumesResumo.FieldByName('PedidoVolumeId').AsString+'/'+
                           FDMemCargaVolumesResumo.FieldByName('Sequencia').AsString;

               txt := TListItemText(Objects.FindDrawable('Embalagem'));
               txt.Text := Copy(FDMemCargaVolumesResumo.FieldByName('Embalagem').AsString, 1, 8);

               txt := TListItemText(Objects.FindDrawable('Conferencia'));
               txt.Text := FDMemCargaVolumesResumo.FieldByName('Zona').AsString;
               //txt := TListItemText(Objects.FindDrawable('Conferencia'));
               //txt.Text := FDMemCargaVolumesResumo.FieldByName('Data').AsString+' '+
               //            FDMemCargaVolumesResumo.FieldByName('Hora').AsString;
             End;
             FDMemCargaVolumesResumo.Next;
           End;
           LstCargaVolumes.EndUpdate;
           FdMemCargaVolumesResumo.Filter   := '';
           FdMemCargaVolumesResumo.Filtered := False;
         End);
       End;
       //JsonArrayVolumes.Free;
     End);
  Th.OnTerminate := ThreadTerminate;
  Th.Start;
end;

Function TFrmCargaConferencia.GetListaCarga(pCarga, pRotaId, pProcessoid : Integer) : Boolean;
Var JsonArrayCarga : TJsonArray;
    vErro          : String;
    xCarga         : Integer;
begin
  Result := False;
  Showloading;
  Try
    JsonArrayCarga := ObjCargaCtrl.Lista(0, 0, 16, 1, 'CO');
    if JsonArrayCarga.Items[0].TryGetValue('Erro', vErro) then Begin
       JsonArrayCarga := Nil;
       HideLoading;
       if vErro <> 'Não foram encontrados dados na pesquisa!' then
          ShowErro(vErro);
       Exit;
    End;
    Result := JsonArrayCarga.Count >= 1;
    If QryListaPadrao.Active then
       QryListaPadrao.EmptyDataSet;
    QryListaPadrao.Close;
    QryListaPadrao.LoadFromJSON(JsonArrayCarga, False);
    LstPrincipal.BeginUpdate;
    LstPrincipal.Items.Clear;
    For xCarga := 0 to Pred(JsonArrayCarga.Count) do Begin
      if ((JsonArrayCarga.Items[xCarga].GetValue<Integer>('processoid')=16) and
         (JsonArrayCarga.Items[xCarga].GetValue<Integer>('statusoper')<>2)) then With LstPrincipal.Items.Add do Begin
        TListItemText(Objects.FindDrawable('CargaId')).Text     := JsonArrayCarga.Items[xCarga].GetValue<Integer>('cargaid').ToString;
        TListItemText(Objects.FindDrawable('Data')).Text        := JsonArrayCarga.Items[xCarga].GetValue<String>('data');
        TListItemText(Objects.FindDrawable('Rota')).Text        := JsonArrayCarga.Items[xCarga].GetValue<String>('rota');
      End;
    End;
    LstPrincipal.EndUpdate;
    HideLoading;
  Except On E: Exception do Begin
    HideLoading;
    ShowErro('Erro: '+E.Message);
    End;
  End;
  JsonArrayCarga := Nil;
end;

procedure TFrmCargaConferencia.GetListaLstCadastro;
begin
  inherited;
  GetListaCarga(0, 0, 16);
end;

procedure TFrmCargaConferencia.GetVolumeProdutos(pPedidoVolumeId : Integer);
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayVolumeLote : TJsonArray;
    vErro : String;
begin
 TTask.Create(
   procedure()
   begin
       Try
         ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
         JsonArrayVolumeLote := ObjPedidoVolumeCtrl.GetVolumeLotes(pPedidoVolumeId);
       Except On E: Exception do
         TThread.Synchronize(nil,
           procedure()
           begin
             raise Exception.Create('Erro: '+E.Message);
         End);
       End;
       if JsonArrayVolumeLote.Items[0].TryGetValue('Erro', vErro) then Begin
          JsonArrayVolumeLote := Nil;
          ObjPedidoVolumeCtrl.Free;
          TThread.Synchronize(nil,
            procedure()
            begin
              raise Exception.Create('Erro: Carregando dados do volume!');
            End);
       End
       Else Begin
         If FDMemVolumeProdutos.Active then
            FDMemVolumeProdutos.EmptyDataSet;
         FDMemVolumeProdutos.Close;
         FDMemVolumeProdutos.LoadFromJSON(JsonArrayVolumeLote, False);
         TThread.Synchronize(Nil, procedure
         Var item : TListViewItem;
             txt  : TListItemText;
             img, Img3 : TListItemImage;
         begin
           LstVolumeProdutos.BeginUpdate;
           LstVolumeProdutos.Items.Clear;
           FDMemVolumeProdutos.First;
           While Not FDMemVolumeProdutos.Eof do Begin
             item := LstVolumeProdutos.Items.Add;
             item.Objects.Clear;
             item.Tag := FDMemVolumeProdutos.FieldByName('LoteId').AsLargeInt;
             with item do begin
               img := TListItemImage(Objects.FindDrawable('ImgBackGround'));
               If FDMemCargaVolumesResumo.Recno mod 2 = 1 then
                  img.Bitmap := ImgFdoGrid01.Bitmap
               Else
                  img.Bitmap := ImgFdoGrid02.Bitmap;

               txt := TListItemText(Objects.FindDrawable('CodProduto'));
               txt.Text := FDMemVolumeProdutos.FieldByName('CodProduto').AsString;

               txt := TListItemText(Objects.FindDrawable('Descricao'));
               txt.Text := FDMemVolumeProdutos.FieldByName('Descricao').AsString;

               txt := TListItemText(Objects.FindDrawable('Endereco'));
               txt.Text := EnderecoMask(FDMemVolumeProdutos.FieldByName('Endereco').AsString,
                                        FDMemVolumeProdutos.FieldByName('Mascara').AsString, True);

               txt := TListItemText(Objects.FindDrawable('Lote'));
               txt.Text := FDMemVolumeProdutos.FieldByName('DescrLote').AsString;

               //txt := TListItemText(Objects.FindDrawable('Vencimento'));
               //txt.Text := FDMemVolumeProdutos.FieldByName('Vencimento').AsString;

               txt := TListItemText(Objects.FindDrawable('Qtde'));
               txt.Text := FDMemVolumeProdutos.FieldByName('QtdSuprida').AsString;
             End;
             FDMemVolumeProdutos.Next;
           End;
           LstVolumeProdutos.EndUpdate;
           JsonArrayVolumeLote := Nil;
           ObjPedidoVolumeCtrl.Free;
         End);
       End;

   End).Start;
End;

procedure TFrmCargaConferencia.GetVolumeProdutosOLD(pPedidoVolumeId : Integer);
Var Th : TThread;
begin
  ShowOk('Abrindo Volume');
  ShowLoading;
  Th := TThread.CreateAnonymousThread(procedure
         Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
         JsonArrayVolumeLote : TJsonArray;
         vErro : String;
     begin
       Try
         ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
         JsonArrayVolumeLote := ObjPedidoVolumeCtrl.GetVolumeLotes(pPedidoVolumeId);
       Except On E: Exception do
         raise Exception.Create('Erro: '+E.Message);
       End;
       if JsonArrayVolumeLote.Items[0].TryGetValue('Erro', vErro) then Begin
          JsonArrayVolumeLote := Nil;
          ObjPedidoVolumeCtrl.Free;
          raise Exception.Create('Erro: Carregando dados do volume!');
       End
       Else Begin
         If FDMemVolumeProdutos.Active then
            FDMemVolumeProdutos.EmptyDataSet;
         FDMemVolumeProdutos.Close;
         FDMemVolumeProdutos.LoadFromJSON(JsonArrayVolumeLote, False);
         TThread.Synchronize(TThread.CurrentThread, procedure
         Var item : TListViewItem;
             txt  : TListItemText;
             img, Img3 : TListItemImage;
         begin
           LstVolumeProdutos.BeginUpdate;
           LstVolumeProdutos.Items.Clear;
           FDMemVolumeProdutos.First;
           While Not FDMemVolumeProdutos.Eof do Begin
             item := LstVolumeProdutos.Items.Add;
             item.Objects.Clear;
             item.Tag := FDMemVolumeProdutos.FieldByName('LoteId').AsLargeInt;
             with item do begin
               img := TListItemImage(Objects.FindDrawable('ImgBackGround'));
               If FDMemCargaVolumesResumo.Recno mod 2 = 1 then
                  img.Bitmap := ImgFdoGrid01.Bitmap
               Else
                  img.Bitmap := ImgFdoGrid02.Bitmap;

               txt := TListItemText(Objects.FindDrawable('CodProduto'));
               txt.Text := FDMemVolumeProdutos.FieldByName('CodProduto').AsString;

               txt := TListItemText(Objects.FindDrawable('Descricao'));
               txt.Text := FDMemVolumeProdutos.FieldByName('Descricao').AsString;

               txt := TListItemText(Objects.FindDrawable('Endereco'));
               txt.Text := EnderecoMask(FDMemVolumeProdutos.FieldByName('Endereco').AsString,
                                        FDMemVolumeProdutos.FieldByName('Mascara').AsString, True);

               txt := TListItemText(Objects.FindDrawable('Lote'));
               txt.Text := FDMemVolumeProdutos.FieldByName('DescrLote').AsString;

               //txt := TListItemText(Objects.FindDrawable('Vencimento'));
               //txt.Text := FDMemVolumeProdutos.FieldByName('Vencimento').AsString;

               txt := TListItemText(Objects.FindDrawable('Qtde'));
               txt.Text := FDMemVolumeProdutos.FieldByName('QtdSuprida').AsString;
             End;
             FDMemVolumeProdutos.Next;
           End;
           LstVolumeProdutos.EndUpdate;
           JsonArrayVolumeLote := Nil;
           ObjPedidoVolumeCtrl.Free;
         End);
       End;
       //JsonArrayVolumes.Free;
     End);
  Th.OnTerminate := ThreadTerminate;
  Th.Start;
end;

procedure TFrmCargaConferencia.InserirDestinatarioSqlLite;
begin
  Exit;
  With DmClient.QryCargaDestinatario do Begin
    Close;
    Sql.Clear;
    SQL.Add('insert into CargaDestinatario values (:pCargaId, :pPessoaId, :pCodPessoaERP, :pRazao, :pOrdem, :pTPed , :pConferido)');
    ParamByName('pCargaId').Value      := ObjCargaCtrl.ObjCargas.cargaid;
    ParamByName('pPessoaId').Value     := QryCargaDestinatario.FieldByName('PessoaId').AsInteger;
    ParamByName('pCodPessoaERP').Value := QryCargaDestinatario.FieldByName('CodPessoaERP').AsInteger;
    ParamByName('pRazao').Value        := QryCargaDestinatario.FieldByName('Razao').AsString;
    ParamByName('pOrdem').Value        := QryCargaDestinatario.FieldByName('Ordem').AsInteger;
    ParamByName('pTPed').Value         := QryCargaDestinatario.FieldByName('TotPed').AsInteger;
    ParamByName('pConferido').Value    := QryCargaDestinatario.FieldByName('Conferido').AsInteger;
    ExecSQL;
  End;
end;

procedure TFrmCargaConferencia.InserirPedidoSqlLite;
begin
  Exit;
  With DmClient.QryCargaPedido do Begin
    Close;
    Sql.Clear;
    SQL.Add('insert into CargaPedido values (:pCargaId, :pPedidoId, :pQtdVolume, :pItens, :pConferido)');
    ParamByName('pCargaId').Value   := ObjCargaCtrl.ObjCargas.cargaid;
    ParamByName('pPedidoId').Value  := QryCargaPedido.FieldByName('PedidoId').AsInteger;
    ParamByName('pQtdVolume').Value := QryCargaPedido.FieldByName('QtdVolume').AsInteger;
    ParamByName('pItens').Value     := QryCargaPedido.FieldByName('Itens').AsInteger;
    ParamByName('pConferido').Value := QryCargaPedido.FieldByName('Conferido').AsInteger;
    ExecSQL;
  End;
end;

procedure TFrmCargaConferencia.InserirVolumeSqlLite;
begin
  Exit;
  With DmClient.QryCargaVolume do Begin
    Close;
    Sql.Clear;
    SQL.Add('insert into CargaVolumes values (:pCargaId, :pPedidoId, :pPessoaId, :pPedidoVolumeId, :pConferido)');
    ParamByName('pCargaId').Value        := ObjCargaCtrl.ObjCargas.cargaid;
    ParamByName('pPedidoId').Value       := QryCargaVolumes.FieldByName('PedidoId').AsInteger;
    ParamByName('pPessoaId').Value       := QryCargaVolumes.FieldByName('PessoaId').AsInteger;
    ParamByName('pPedidoVolumeId').Value := QryCargaVolumes.FieldByName('PedidoVolumeId').AsInteger;
    ParamByName('pConferido').Value      := QryCargaVolumes.FieldByName('Conferido').AsInteger;
    ExecSQL;
  End;
end;

procedure TFrmCargaConferencia.Limpar;
begin
  inherited;
  EdtDtCarga.Text      := '';
  EdtRota.Text         := '';
  LblCircContagem.Text := '';
  LblCircVolumes.Text  := '';
  //EdtDestinatario.Text := '';
  CbDestinatario.Items.Clear;
  EdtVolumeId.Text     := '';
  If QryCargaDestinatario.Active then
     QryCargaDestinatario.EmptyDataSet;
  QryCargaDestinatario.Close;
  If QryCargaPedido.Active then
     QryCargaPedido.EmptyDataSet;
  QryCargaPedido.Close;
  If QryCargaVolumes.Active then
     QryCargaVolumes.EmptyDataSet;
  QryCargaVolumes.Close;
  LstPedidos.Items.Clear;
  EdtCargaId.Enabled   := True;
  EdtVolumeId.Enabled := False;
  DelayEdSetFocus(EdtCargaId);
  BtnSave.Enabled   := False;
  BtnCancel.Enabled := False;
  PthBtnSave.Fill.Color   := TAlphaColorRec.Darkgray;
  PthBtnCancel.Fill.Color := TAlphaColorRec.Darkgray;
  BtnFinalizarConferencia.Enabled := False;
  LytRodapeFinalizar.Visible := False;
end;

procedure TFrmCargaConferencia.LstCargaVolumesItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
  inherited;
  If ItemObject.Name = 'Image3' then Begin
     PgcPrincipal.ActiveTab := TabVolumeProdutos;
     LblVolumeId.Text := LstCargaVolumes.Items[ItemIndex].Tag.ToString;
     GetVolumeProdutos(LstCargaVolumes.Items[ItemIndex].Tag);
  End
end;

procedure TFrmCargaConferencia.LstPrincipalItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstPrincipal.Items[AItem.Index].Objects.FindDrawable('CargaId'));
  EdtConteudoPesq.text := TxtItem.Text; //Txt.TagString;
  EdtCargaId.Text      := TxtItem.Text;
  EdtCodigo.Text       := TxtItem.Text;
end;

procedure TFrmCargaConferencia.MontaCargaDestinatario;
Var DestinatarioConcluido : Boolean;
    vTotPendente : Integer;
    xRecno       : Integer;
begin
  DestinatarioConcluido := True;
  QryCargaDestinatario.First;
  vTotPendente := 0;
  xRecno := QryCargaDestinatario.Recno;
  While Not QryCargaDestinatario.Eof do Begin
    If (QryCargaDestinatario.FieldByName('Conferido').AsInteger = 0) then Begin //or //Não iniciado
       //(QryCargaDestinatario.FieldByName('Conferido').AsInteger < QryCargaDestinatario.FieldByName('TotPed').AsInteger) Then Begin//Em Contagem
       DestinatarioConcluido := False;
       Inc(vTotPendente);
    End;
    QryCargaDestinatario.Next;
  End;
  if ObjCargaCtrl.ObjCargas.ProcessoId = 16 then Begin
     LytRodapeFinalizar.Visible      := True;
     BtnFinalizarConferencia.Enabled := DestinatarioConcluido;
  End;
  LblCircContagem.Text := vTotPendente.ToString();
  QryCargaDestinatario.Recno := xRecno;
end;

{procedure TFrmCargaConferencia.MontaCargaDestinatarioOLD;
Var item : TListViewItem;
     txt : TListItemText;
     img : TListItemImage;
begin
  TThread.Synchronize(TThread.CurrentThread, procedure
  begin
    LstDestinatario.BeginUpdate;
    LstDestinatario.Items.Clear;
    QryCargaDestinatario.First;
    While Not QryCargaDestinatario.Eof do Begin
      item := LstDestinatario.Items.Add;
      item.Objects.Clear;
      item.Tag := QryCargaDestinatario.FieldByName('CodPessoaERP').AsLargeInt;
      with item do begin
        img := TListItemImage(Objects.FindDrawable('ImgFdoDestinatario'));
        img.ScalingMode := TImageScalingMode.Stretch;
        If QryCargaDestinatario.FieldByName('Conferido').AsInteger = 0 Then begin       //Inicializado
           img.Bitmap := ImgLstFdoWhite.Bitmap;
        End
        Else If QryCargaDestinatario.FieldByName('Conferido').AsInteger < QryCargaDestinatario.FieldByName('TotPed').AsInteger Then Begin  //Em Contagem
           img.Bitmap := ImgLstFdoYellow.Bitmap;
        End
        Else Begin  //Concluído/Finalizado
           img.Bitmap := ImgLstFdoGreen.BitMap;
        end;
        txt := TListItemText(Objects.FindDrawable('CodPessoaERP'));
        txt.Text := QryCargaDestinatario.FieldByName('CodPessoaERP').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;

        txt := TListItemText(Objects.FindDrawable('Destinatario'));
        txt.Text := QryCargaDestinatario.FieldByName('Razao').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;

        txt := TListItemText(Objects.FindDrawable('Ordem'));
        txt.Text := QryCargaDestinatario.FieldByName('Ordem').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;

        txt := TListItemText(Objects.FindDrawable('TPed'));
        txt.Text := QryCargaDestinatario.FieldByName('TotPed').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;
      End;
      QryCargaDestinatario.Next;
    End;
    LstDestinatario.EndUpdate;
  End);
end;
}
procedure TFrmCargaConferencia.MontaCargaPedido;
Var item : TListViewItem;
     txt : TListItemText;
     img : TListItemImage;
     Cor : Cardinal;
begin
  TThread.Synchronize(TThread.CurrentThread, procedure
  Var vTotVolumeConferido : Integer;
  begin
    LstPedidos.BeginUpdate;
    LstPedidos.Items.Clear;
    QryCargaPedido.First;
    vTotVolumeConferido := 0;
    While Not QryCargaPedido.Eof do Begin
      item := LstPedidos.Items.Add;
      item.Objects.Clear;
      item.Tag := QryCargaPedido.FieldByName('PedidoId').AsLargeInt;
      with item do begin
        img := TListItemImage(Objects.FindDrawable('ImgFdoCargaVolumes'));
        img.ScalingMode := TImageScalingMode.Stretch;
        If QryCargaPedido.FieldByName('Conferido').AsInteger = 0 Then begin       //Inicializado
           img.Bitmap := ImgLstFdoWhite.Bitmap;
           Cor:= $FF5DA9BC;
        End
        Else If QryCargaPedido.FieldByName('Conferido').AsInteger < QryCargaPedido.FieldByName('QtdVolume').AsInteger Then Begin  //Em Contagem
           img.Bitmap := ImgLstFdoYellow.Bitmap;
           Cor:= $FFE9C168;
        End
        Else Begin  //Concluído/Finalizado
           img.Bitmap := ImgLstFdoGreen.BitMap;
           Cor:= $FF32B932;
        end;
//        TListItemText(Objects.FindDrawable('PedidoId')).Text   := QryCargaPedido.FieldByName('PedidoId').AsString;
        txt := TListItemText(Objects.FindDrawable('PedidoId'));
        txt.Text := QryCargaPedido.FieldByName('PedidoId').AsString;
        txt := TListItemText(Objects.FindDrawable('Data'));
        txt.Text := QryCargaPedido.FieldByName('DocumentoData').AsString;
//        TListItemText(Objects.FindDrawable('QtdVolumes')).Text := QryCargaPedido.FieldByName('QtdVolume').AsString;
        txt := TListItemText(Objects.FindDrawable('QtdVolumes'));
        txt.Text := QryCargaPedido.FieldByName('QtdVolume').AsString;
//        TListItemText(Objects.FindDrawable('Itens')).Text      := QryCargaPedido.FieldByName('Itens').AsString;
        txt := TListItemText(Objects.FindDrawable('Itens'));
        txt.Text := QryCargaPedido.FieldByName('Itens').AsString;
//        TListItemText(Objects.FindDrawable('Conferido')).Text  := QryCargaPedido.FieldByName('Conferido').AsInteger.ToString;
        txt := TListItemText(Objects.FindDrawable('Conferido'));
        txt.Text := QryCargaPedido.FieldByName('Conferido').AsString;
        vTotVolumeConferido := vTotVolumeConferido + QryCargaPedido.FieldByName('Conferido').Asinteger;
      End;
      QryCargaPedido.Next;
    End;
{    QryCargaPedido.Filter := 'Status = 0';
    QryCargaPedido.Filtered := True;
    if QryCargaPedido.IsEmpty then Begin
       MensagemStand('Carga concluída!');
    End;
}    LstPedidos.EndUpdate;
     LblCircVolumes.Text := vTotVolumeConferido.ToString();
  End);
end;

procedure TFrmCargaConferencia.OpenCarga(pCargaId, pRotaId, pProcessoId : Integer);
var Th: TThread;
Begin
  Try
    if pCargaId <= 0 then Begin
       If PgcPrincipal.ActiveTab = TabDetalhes then
          SetCampoDefault('EdtCargaId');
       ShowErro('Id('+pCargaId.ToString()+') inválido!');
       EdtCargaId.Text := '';
       Exit;
    End;
    ShowLoading;
    Th := TThread.CreateAnonymousThread(procedure
    begin
      LstPedidos.Items.Clear;
      GetCarga(pCargaId);
      CargaDestinatario;
      QryCargaDestinatario.First;
      While Not QryCargaDestinatario.Eof do Begin
        if QryCargaDestinatario.FieldByName('Conferido').Value = 0 then
           Break;
         QryCargaDestinatario.Next;
      End;
      //AtivarDestinatario;
      //CargaPedido;
      //CargaVolumes;
      //MontaCargaDestinatario;
      if ObjCargaCtrl.ObjCargas.ProcessoId in [ 16] then Begin
         if ObjCargaCtrl.ObjCargas.ProcessoId = 16 then Begin
            TThread.Synchronize(
              TThread.CurrentThread,
              procedure ()
              begin
                EdtCargaId.Enabled      := False;
                EdtVolumeId.Enabled     := True;
                EdtVolumeid.ReadOnly    := False;
                CbDestinatario.Enabled  := True;
                DelayEdSetFocus(EdtVolumeId);
                BtnSave.Enabled         := True;
                BtnCancel.Enabled       := True;
                PthBtnSave.Fill.Color   := TAlphaColorRec.Chocolate;
                PthBtnCancel.Fill.Color := TAlphaColorRec.Chocolate;
              End);
         End
         Else Begin
            CodConfirmacao := 3;
            LblTituloConfirmacao.Text := 'Reconferência de Carga';
            LblTituloFoot.Text        := 'Carga já conferida.';
            LblMensagem1.Text         := 'Reabrir Conferência?';
            LblMensagem2.Text         := 'Confirma para desfazer a atual conferênia..';
            PgcPrincipal.ActiveTab    := TabConfirmacao;
         End;
      End
      Else Begin
         ShowErro('Conferência de Carga Concluída!');
         //EdtCargaId.Text := '';
         //Limpar;
      End;
      CbDestinatario.Enabled := ObjCargaCtrl.ObjCargas.ProcessoId = 16;
    End);
    Th.OnTerminate := ThreadTerminate;
    Th.Start;
//    JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', 0, '', '', 1);
//    SelecionarClientePedidos(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('pedidos'));
//    CalculaPesoVolume;

  //Montar Lista de Endereços
  Except On E: Exception do Begin
    ShowErro('Erro: '+E.Message);
    HideLoading;
    End;
  End;
  //HideLoading;
end;

function TFrmCargaConferencia.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  Result := True;
end;

procedure TFrmCargaConferencia.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if (PgcPrincipal.ActiveTab = TabDetalhes) then Begin
//     if (QryCargaDestinatario.RecordCount > 0)  then
        BtnArrowRigth.Action := ChgTabCargaVolumes;
//     Else
//        BtnArrowRigth.Action := Nil;
     BtnArrowLeft.Action  := ChgTabLista;
  End
  Else if (PgcPrincipal.ActiveTab = TabLista) then Begin
     BtnArrowRigth.Action := ChgTabDet;
     BtnArrowLeft.Action  := Nil;
  End
  Else If (PgcPrincipal.ActiveTab = TabVolumes) then Begin
     BtnArrowLeft.Action  := ChgTabDet;
     BtnArrowRigth.Action := Nil;
     GetCargaVolumes;
  End
  Else If (PgcPrincipal.ActiveTab = TabVolumeProdutos) then Begin
     BtnArrowLeft.Action  := ChgTabCargaVolumes;
     BtnArrowRigth.Action := Nil;
  End;
end;

procedure TFrmCargaConferencia.ShowDados;
begin
  inherited;
  EdtCargaId.Text := ObjCargaCtrl.ObjCargas.cargaid.ToString();
  EdtCodigo.Text  := ObjCargaCtrl.ObjCargas.cargaid.ToString();
  EdtDtCarga.Text := DateToStr(ObjCargaCtrl.ObjCargas.dtinclusao);
end;

procedure TFrmCargaConferencia.ThreadTerminate(Sender: TObject);
begin
  HideLoading;
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowErro(Exception(TThread(sender).FatalException).Message);
      exit;
    end;
  end;
end;

end.

