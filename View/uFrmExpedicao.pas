unit uFrmExpedicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls, Generics.Collections,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.JSON, REST.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin,
  acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC
  , PedidoVolumeCtrl, JvToolEdit, JvBaseEdits, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase,
  ACBrETQ, dxCameraControl, uFrmeXactWMS;

type
  TFrmExpedicao = class(TFrmBase)
    LstASGExpedicao: TAdvStringGrid;
    EdtVolumeId: TJvCalcEdit;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    EdtPedidoId: TEdit;
    Label4: TLabel;
    EdtDocumentoData: TEdit;
    Label5: TLabel;
    EdtDestino: TEdit;
    Label6: TLabel;
    EdtRota: TEdit;
    Label7: TLabel;
    LblOrdem: TLabel;
    Label8: TLabel;
    PnlVolumeCorte: TPanel;
    PnlLateral: TPanel;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    BtnPesqCliente: TBitBtn;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtVolumeIdEnter(Sender: TObject);
    procedure EdtVolumeIdExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabPrincipalShow(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtDestinatarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDestinatarioChange(Sender: TObject);
    procedure LstASGExpedicaoClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    Function GetListaVolumeExpedicao(pCodPessoaERP : Integer = 0; pRotaId : Integer = 0)  : Boolean;
    Function GetListaVolumeExpedido  : Boolean;
    Procedure RegistrarVolume;
    Procedure LimparExpedicao;
  Protected
    Procedure GetListaLstCadastro; OverRide;
  public
    { Public declarations }
  end;

var
  FrmExpedicao: TFrmExpedicao;

implementation

{$R *.dfm}

uses uFuncoes, PessoaCtrl, RotaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Rotas;

procedure TFrmExpedicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmExpedicao := Nil;
end;

procedure TFrmExpedicao.FormCreate(Sender: TObject);
begin
  inherited;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  LstCadastro.ColWidths[0] := 	70+Trunc(70*ResponsivoVideo);
  LstCadastro.ColWidths[1] := 	80+Trunc(80*ResponsivoVideo);
  LstCadastro.ColWidths[2] := 	150+Trunc(150*ResponsivoVideo);
  LstCadastro.ColWidths[3] := 	150+Trunc(150*ResponsivoVideo);
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[1, 0] := taRightJustify;
  //GetListaVolumeExpedido;
  LstASGExpedicao.ColWidths[0] := 	70+Trunc(70*ResponsivoVideo);
  LstASGExpedicao.ColWidths[1] := 	70+Trunc(70*ResponsivoVideo);
  LstASGExpedicao.ColWidths[2] := 	80+Trunc(80*ResponsivoVideo);
  LstASGExpedicao.ColWidths[3] := 	80+Trunc(80*ResponsivoVideo);
  LstASGExpedicao.ColWidths[4] := 120+Trunc(120*ResponsivoVideo);
  LstASGExpedicao.ColWidths[5] := 215+Trunc(215*ResponsivoVideo);
  LstASGExpedicao.Alignments[0, 0] := taRightJustify;
  LstASGExpedicao.FontStyles[0, 0] := [FsBold];
  LstASGExpedicao.Alignments[1, 0] := taRightJustify;
  LstASGExpedicao.Alignments[2, 0] := taCenter;
  PgcBase.ActivePage := TabPrincipal;
end;

procedure TFrmExpedicao.FormDestroy(Sender: TObject);
begin
  ObjPedidoVolumeCtrl.Free;
  inherited;
end;

procedure TFrmExpedicao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;

end;

procedure TFrmExpedicao.GetListaLstCadastro;
begin
  inherited;
  GetListaVolumeExpedido;
end;

function TFrmExpedicao.GetListaVolumeExpedicao(pCodPessoaERP, pRotaId : Integer) : Boolean;
Var xReturn         : Integer;
    ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  LstASGExpedicao.ClearRect(0, 1, LstASGExpedicao.ColCount-1, LstASGExpedicao.RowCount-1);
  ReturnJsonArray      := ObjPedidoVolumeCtrl.VolumeExpedicao(pCodPessoaERP, pRotaId);
  LstASGExpedicao.RowCount := 1;
  If ReturnJsonArray.Get(0).TryGetValue('Erro', vErro) then Begin
     Result := False;
     Exit;
  End;
  LstASGExpedicao.RowCount  := ReturnJsonArray.Count+1;
  Result := ReturnJsonArray.Count >= 1;
  If ReturnJsonArray.Count >= 1 then Begin
     LstASGExpedicao.FixedRows := 1;
     For xReturn := 0 To ReturnJsonArray.Count-1 do begin
       LstASGExpedicao.Cells[0, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidoid').ToString();
       LstASGExpedicao.Cells[1, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidovolumeid').ToString();
       LstASGExpedicao.Cells[2, xReturn+1] := DateEUAtoBr(ReturnJsonArray.Get(xReturn).GetValue<String>('data'));
       LstASGExpedicao.Cells[3, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('embalagem');
       LstASGExpedicao.Cells[4, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('processo');
       LstASGExpedicao.Cells[5, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('fantasia');
       LstASGExpedicao.Alignments[0, xReturn+1] := taRightJustify;
       LstASGExpedicao.FontStyles[0, xReturn+1] := [FsBold];
       LstASGExpedicao.Alignments[1, xReturn+1] := taRightJustify;
       LstASGExpedicao.Alignments[2, xReturn+1] := taCenter;
     end;
     LstASGExpedicao.SortSettings.Column := 1;
     LstASGExpedicao.QSort;
     AdvGridLookupBar1.Column := 1;
     ReturnJsonArray := Nil;
  End;
end;

Function TFrmExpedicao.GetListaVolumeExpedido : Boolean;
Var xReturn         : Integer;
    ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
  ReturnJsonArray      := ObjPedidoVolumeCtrl.VolumeExpedidoDia;
  LstCadastro.RowCount := 1;
  If ReturnJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin
     Result := False;
     ReturnJsonArray := Nil;
     Exit;
  End;
  LstCadastro.RowCount  := ReturnJsonArray.Count+1;
  Result := ReturnJsonArray.Count >= 1;
  If ReturnJsonArray.Count >= 1 then Begin
     LstCadastro.FixedRows := 1;
     For xReturn := 0 To ReturnJsonArray.Count-1 do begin
       LstCadastro.Cells[0, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidoid').ToString();
       LstCadastro.Cells[1, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidovolumeid').ToString();
       LstCadastro.Cells[2, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('embalagem');
       LstCadastro.Cells[3, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('processo');
       LstCadastro.Alignments[0, xReturn+1] := taRightJustify;
       LstCadastro.FontStyles[0, xReturn+1] := [FsBold];
       LstCadastro.Alignments[1, xReturn+1] := taRightJustify;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  ReturnJsonArray := Nil;
end;

procedure TFrmExpedicao.LimparExpedicao;
begin
  EdtVolumeId.Clear;
  EdtPedidoId.Clear;
  EdtDOcumentoData.Clear;
  EdtDestino.Clear;
  EdtRota.Clear;
  LblOrdem.Caption := '';
end;

procedure TFrmExpedicao.LstASGExpedicaoClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin //and (aCol in [0, 1, 2, 3, 4]) then Begin
     TAdvStringGrid(Sender).SortSettings.Column := aCol;
     TAdvStringGrid(Sender).QSort;
  End
end;

procedure TFrmExpedicao.RegistrarVolume;
Var ObjVolumeCtrl    : TPedidoVolumeCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
    vVolumeEtapaId   : Integer;
begin
  Try
    ObjVolumeCtrl := TPedidoVolumeCtrl.Create;
    JsonArrayRetorno := ObjVolumeCtrl.GetVolume(0, StrToInt64Def(EdtVolumeId.Text, 0), 0, 0);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       MensagemSis('Atenção', 'Volume: '+EdtVolumeId.Text, vErro, '', False, True);
       EdtVolumeId.Clear;
       edtvolumeId.setFocus;
       JsonArrayRetorno := Nil;
       ObjVolumeCtrl.Free;
       Exit;
    End
    Else If JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida') = 0 then Begin
       MensagemSis('Atenção', 'Volume: '+EdtVolumeId.Text, 'Cancelar o Volume.', '', False, True);
       EdtVolumeId.Clear;
       edtvolumeId.setFocus;
       JsonArrayRetorno := Nil;
       ObjVolumeCtrl.Free;
       Exit;
    End
    Else Begin
       EdtPedidoId.Text       := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('pedido').GetValue<String>('pedidoid');
       EdtDocumentoData.Text  := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('pedido').GetValue<String>('documentodata');
       EdtDestino.Text        := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('destino').GetValue<String>('codpessoaerp')+' '+
                                 JsonArrayRetorno.Items[0].GetValue<TJsonObject>('destino').GetValue<String>('fantasia');
       EdtRota.Text           := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('rotaid')+' '+
                                 JsonArrayRetorno.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('rota');
       LblOrdem.Caption       := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('ordem');
       PnlVolumeCorte.Visible := (JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida') <> JsonArrayRetorno.Items[0].GetValue<Integer>('demanda'));
    End;
    if Not (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid') in [8, 10, 12]) then Begin
       EdtVolumeId.Text := '';
       MensagemSis('Atenção!', 'Operação não permitida! ', 'Etapa atual: '+JsonArrayRetorno.Items[0].GetValue<String>('processo'), '', False, True);
       EdtVolumeId.SetFocus;
       JsonArrayRetorno := Nil;
       ObjVolumeCtrl.Free;
       Exit;
    End;
    if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExigirReconferenciaToExpedicao = 1) and
        (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid')<>12) then Begin
        LimparExpedicao;
        MensagemSis('Atenção', 'O Volume('+EdtVolumeId.Text+') deve ser Reconferido!', '', '', False, True);
        Exit;
    End
    Else If (FrmeXactWMS.ConfigWMS.ObjConfiguracao.VolumeAuditoria = 1) and (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid')<>12) and
            (JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida') <> JsonArrayRetorno.Items[0].GetValue<Integer>('demanda')) then Begin
       LimparExpedicao;
       MensagemSis('Atenção', 'Enviar Volume'+EdtVolumeId.Text+' para Auditoria!', '', '', False, True);
       Exit;
    End;
    ObjVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExpedicaoOffLine = 0 then
       JsonArrayRetorno := ObjVolumeCtrl.RegistrarDocumentoEtapaComBaixaEstoqueJson(13, 0)
    Else
       JsonArrayRetorno := ObjVolumeCtrl.RegistrarDocumentoEtapaSemBaixaEstoqueJson(13, 0);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       MensagemSis('ATENÇÃO:', 'Erro na Expedição!', vErro, 'Repita o processo.', False, True);
    End
    Else Begin
      ShowOk('concluido');
      GetListaVolumeExpedicao(StrToIntDef(EdtDestino.Text, 0), StrToIntDef(EdtRotaId.Text, 0));
    End;
    EdtVolumeId.Text := '';
    EdtVolumeId.SetFocus;
    JsonArrayRetorno    := Nil;
    ObjVolumeCtrl.Free;
  Except On E: Exception do Begin
    JsonArrayRetorno    := Nil;
    EdtvolumeId.setFocus;
    ObjVolumeCtrl.Free;
    MensagemSis('ATENÇÃO:', 'Erro na Expedição!', E.Message, 'Repita o processo.', False, True);
    End;
  End;
end;

procedure TFrmExpedicao.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  EdtVolumeId.SetFocus;
  GetListaVolumeExpedicao;
end;

procedure TFrmExpedicao.BtnPesqClienteClick(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if ((Sender=BtnPesqCliente) and (EdtDestinatario.ReadOnly)) then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatario.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioExit(EdtDestinatario);
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmExpedicao.BtnPesqRotaClick(Sender: TObject);
begin
  if ((Sender=BtnPesqRota) and (EdtRotaId.ReadOnly)) then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       EdtRotaId.Text := FrmPesquisaRotas.Tag.ToString();
       EdtRotaIdExit(EdtRotaId);
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmExpedicao.EdtDestinatarioChange(Sender: TObject);
begin
  inherited;
  LstASGExpedicao.ClearRect(0, 1, LstASGExpedicao.ColCount-1, LstASGExpedicao.RowCount-1);
  LstASGExpedicao.RowCount := 1;
end;

procedure TFrmExpedicao.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     GetListaVolumeExpedicao(StrToIntDef(EdtDestino.Text, 0), StrToIntDef(EdtRota.Text, 0));
     Exit;
  End;
  if (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
     ShowErro( '😢Destinatário('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     GetListaVolumeExpedicao(StrToIntDef(EdtDestino.Text, 0), StrToIntDef(EdtRota.Text, 0));
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(TEdit(Sender).text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
  GetListaVolumeExpedicao(StrToIntDef(EdtDestinatario.Text, 0), StrToIntDef(EdtRotaId.Text, 0));
end;

procedure TFrmExpedicao.EdtDestinatarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key = #13) then
     SelectNext(ActiveControl, True, true);
  SoNumeros(Key);
end;

procedure TFrmExpedicao.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl   : TRotaCtrl;
    ReturnLstRota : TObjectList<TRotaCtrl>;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     LblRota.Caption := '';
     GetListaVolumeExpedicao(StrToIntDef(EdtDestino.Text, 0), StrToIntDef(EdtRota.Text, 0));
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     LblRota.Caption := '';
     ShowErro( '😢Rota('+TEdit(Sender).Text+') inválida!' );
     TEdit(Sender).Clear;
     GetListaVolumeExpedicao(StrToIntDef(EdtDestino.Text, 0), StrToIntDef(EdtRota.Text, 0));
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     Player('toast4');
     TEdit(Sender).Clear;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  ReturnLstRota := Nil;
  ObjRotaCtrl.Free;
  ExitFocus(Sender);
  GetListaVolumeExpedicao(StrToIntDef(EdtDestinatario.Text, 0), StrToIntDef(EdtRotaId.Text, 0));
end;

procedure TFrmExpedicao.EdtVolumeIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmExpedicao.EdtVolumeIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(EdtVolumeId);
end;

procedure TFrmExpedicao.EdtVolumeIdKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN) then
     if (StrToIntDef(EdtVolumeId.Text, 0) > 0) then
        RegistrarVolume
     Else Begin
        EdtVolumeId.SetFocus;
        ShowErro('Id de Volume('+EdtvolumeId.Text+') Inválido!');
        EdtVolumeId.Clear;
     End;
end;

end.
