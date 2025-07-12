unit uFrmRotas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, System.Math,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC
  , Generics.Collections, System.JSON, REST.Json, System.JSON.Types
  , RotaCtrl, Vcl.Buttons, Vcl.Mask, JvExMask, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.ComCtrls, Vcl.DBGrids, JvToolEdit,
  JvBaseEdits, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmRotas = class(TFrmBase)
    EdtRotaId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    EdtDescricao: TLabeledEdit;
    Panel1: TPanel;
    LstAdvParticipantes: TAdvStringGrid;
    EdtGoogleMaps: TLabeledEdit;
    EdtLatitude: TLabeledEdit;
    EdtLongitude: TLabeledEdit;
    BtnOpenFrameWeb: TBitBtn;
    PnlParticipante: TPanel;
    BtnUpOrdem: TBitBtn;
    BtnDownOrdem: TBitBtn;
    Panel3: TPanel;
    Label2: TLabel;
    EdtDestinatario: TLabeledEdit;
    BtnPesqPessoa: TBitBtn;
    LblDestinatario: TLabel;
    Label3: TLabel;
    EdtPosicao: TJvCalcEdit;
    BtnSalvarParticipante: TPanel;
    sImage1: TsImage;
    BtnCancelarParticipante: TPanel;
    sImage2: TsImage;
    LblRotaParticipante: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtRotaIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtRotaIdEnter(Sender: TObject);
    procedure EdtDescricaoExit(Sender: TObject);
    procedure EdtRotaIdChange(Sender: TObject);
    procedure BtnOpenFrameWebClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LstAdvParticipantesClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure BtnPesqPessoaClick(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure BtnSalvarParticipanteClick(Sender: TObject);
    procedure EdtDestinatarioChange(Sender: TObject);
    procedure BtnCancelarParticipanteClick(Sender: TObject);
    procedure BtnUpOrdemClick(Sender: TObject);
    procedure EdtPosicaoExit(Sender: TObject);
    procedure EdtRotaIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ObjRotaCtrl : TRotaCtrl;
    Function GetListaRota(pRotaId : Integer = 0; pDescricao : String = '') : Boolean;
    Procedure BtnParticipanteOnOff(pOnOff : Boolean);
    Procedure ClearParticipante(Sender: TObject);
    Procedure GetRotaParticipante;
    Procedure ReorganizaRotaOrdem(Sender : TObject);
    function IfThen(AValue: Boolean; const ATrue, AFalse: Integer): Integer;
    Function SalvarUpdParticipante( pRotaId, pParticipanteId, pPosicao : Integer) : Boolean;
    Procedure PosicaoIndicator(pParticipanteId : Integer);
  Protected
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean;  OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRotas: TFrmRotas;

implementation

{$R *.dfm}

uses uFuncoes, Views.Pequisa.Pessoas, PessoaCtrl, Vcl.DialogMessage;

{ TFrmRotas }

procedure TFrmRotas.BtnOpenFrameWebClick(Sender: TObject);
begin
  inherited;
  exit;
  if (Not EdtRotaId.ReadOnly) and (EdtGoogleMaps.Text<>'') then Begin
     TbFrameWeb.TabVisible := True;
     PgcBase.ActivePage    := TbFrameWeb;
     //FrameNavigator1.GetUrl(EdtGoogleMaps.Text);
  End;
end;

procedure TFrmRotas.BtnParticipanteOnOff(pOnOff: Boolean);
begin
  BtnSalvarParticipante.Visible   := pOnOff;
  BtnCancelarParticipante.Visible := pOnOff;
  EdtPosicao.ReadOnly             := Not pOnOff;
end;

procedure TFrmRotas.BtnPesqPessoaClick(Sender: TObject);
begin
  inherited;
  if EdtDestinatario.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatario.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioExit(EdtDestinatario);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmRotas.BtnSalvarParticipanteClick(Sender: TObject);
begin
  if EdtDescricao.Text = '' then Begin
     ShowErro('Informe o código do participante!');
     EdtDestinatario.SetFocus;
     Exit;
  End;
  if StrToIntDef(EdtPosicao.Text, 0) = 0 then Begin
     ShowErro('Informe a posição(ordem de entrega) na rota.');
     Exit;
  End;
  inherited;
  TDialogMessage.ShowWaitMessage('Salvando as Informações...',
     procedure
     begin
       If SalvarUpdParticipante( ObjRotaCtrl.ObjRota.RotaId, LblDestinatario.Tag, StrToIntDef(EdtPosicao.Text, 0)) then Begin
          GetRotaParticipante;
          ReorganizaRotaOrdem(Sender);
       End;
     End);
end;

procedure TFrmRotas.ClearParticipante(Sender: TObject);
begin
  if Not (Sender = EdtDestinatario) then
     EdtDestinatario.Clear;
  LblDestinatario.Caption     := '';
  LblDestinatario.Tag         := 0;
  LblRotaParticipante.Caption := '';
  EdtPosicao.Clear;
  BtnParticipanteOnOff(False);
end;

procedure TFrmRotas.BtnUpOrdemClick(Sender: TObject);
Var xLin, vTagPrimary : Integer;
    vInicio           : Boolean;
    vIndicator        : Integer;
begin
  inherited;
  if (LstAdvParticipantes.Tag < 1) or (BtnIncluir.Grayed) or (BtnEditar.Grayed) then Exit;
  If (Sender = BtnUpOrdem) and (LstAdvParticipantes.Cells[2, LstAdvParticipantes.Tag]='1') then
     showErro('Participante já está na posição 1')
//  Else If (Sender = BtnDownOrdem) and (LstAdvParticipantes.Cells[2, LstAdvParticipantes.Tag]='1') then
//     showErro('Participante já está na posição 1');
  Else If (Sender = BtnUpOrdem) then begin
     for xLin := IfThen(LstAdvParticipantes.Tag>1, LstAdvParticipantes.Tag-1, LstAdvParticipantes.Tag) to LstAdvParticipantes.RowCount-1 do Begin
         if xLin = LstAdvParticipantes.Tag then Begin
            LstAdvParticipantes.Cells[2, xLin]   := (LstAdvParticipantes.Cells[2, xLin-1].ToInteger()).ToString;
            LstAdvParticipantes.Tag := (LstAdvParticipantes.Cells[2, xLin-1].ToInteger());
            SalvarUpdParticipante(ObjRotaCtrl.ObjRota.Rotaid, LstAdvParticipantes.Cells[5, xLin].ToInteger(), LstAdvParticipantes.Tag);
            vIndicator := LstAdvParticipantes.Cells[5, xLin].ToInteger();
         End
         Else If 1 = 2 then Begin
            LstAdvParticipantes.Tag := LstAdvParticipantes.Tag + 1;
            LstAdvParticipantes.Cells[2, xLin] := (LstAdvParticipantes.Tag).ToString;
            SalvarUpdParticipante(ObjRotaCtrl.ObjRota.Rotaid, LstAdvParticipantes.Cells[5, xLin].ToInteger(), LstAdvParticipantes.Tag);
         End;
     End;
  End
  Else If (Sender = BtnDownOrdem) then Begin
     LstAdvParticipantes.Tag := LstAdvParticipantes.Cells[0, LstAdvParticipantes.Tag].ToInteger();
     LstAdvParticipantes.SortSettings.Column := 2;
     LstAdvParticipantes.QSort;
     vInicio := False;
     for xLin := 1 to LstAdvParticipantes.RowCount-1 do Begin
         if LstAdvParticipantes.Tag = LstAdvParticipantes.Cells[0, xLin].ToInteger() then Begin
            if xLin+1 <= LstAdvParticipantes.RowCount-1 then Begin
               LstAdvParticipantes.Cells[2, xLin+1] := LstAdvParticipantes.Cells[2, xLin].ToInteger().ToString;
               vIndicator := LstAdvParticipantes.Cells[5, xLin].ToInteger;
               SalvarUpdParticipante(ObjRotaCtrl.ObjRota.Rotaid, LstAdvParticipantes.Cells[5, xLin+1].ToInteger(), LstAdvParticipantes.Cells[2, xLin].ToInteger());
{
                LstAdvParticipantes.Tag            := LstAdvParticipantes.Cells[2, xLin+1].ToInteger();
                vTagPrimary                        :=  LstAdvParticipantes.Tag;
                LstAdvParticipantes.Cells[2, xLin+1] := (LstAdvParticipantes.Tag-1).ToString;
                SalvarUpdParticipante(ObjRotaCtrl.ObjRota.Rotaid, LstAdvParticipantes.Cells[5, xLin+1].ToInteger(), LstAdvParticipantes.Tag-1);
                vInicio := True;

}            End;
         End
         Else if (vInicio) and (1=2) then Begin
           if LstAdvParticipantes.Tag > vTagPrimary then Begin
              LstAdvParticipantes.Cells[2, xLin] := (LstAdvParticipantes.Tag).ToString;
              SalvarUpdParticipante(ObjRotaCtrl.ObjRota.Rotaid, LstAdvParticipantes.Cells[5, xLin].ToInteger(), LstAdvParticipantes.Tag);
           End;
           LstAdvParticipantes.Tag := LstAdvParticipantes.Tag+1;
         End;
     End;
  End;
  GetRotaParticipante;
  ReorganizaRotaOrdem(Sender);
  PosicaoIndicator(vIndicator);
end;

procedure TFrmRotas.BtnCancelarParticipanteClick(Sender: TObject);
begin
  inherited;
  ClearParticipante(BtnCancelarParticipante);;
  EdtDestinatario.SetFocus;
end;

procedure TFrmRotas.BtnEditarClick(Sender: TObject);
begin
  inherited;
  EdtDescricao.SetFocus;
  LstAdvParticipantes.Enabled  := False;
End;

procedure TFrmRotas.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtDescricao.SetFocus;
  LstAdvParticipantes.Enabled  := False;
end;

function TFrmRotas.DeleteReg: Boolean;
begin
  Result := ObjRotaCtrl.DelRota;
end;

procedure TFrmRotas.EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex = 0 then Begin
     SoNumeros(Key);
  End;
end;

procedure TFrmRotas.EdtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmRotas.EdtDestinatarioChange(Sender: TObject);
begin
  inherited;
  ClearParticipante(EdtDestinatario);
end;

procedure TFrmRotas.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    xObjRotaCtrl    : TRotaCtrl;
    vErro           : String;
    xParticipante   : integer;
begin
  inherited;
  LblDestinatario.Caption     := '';
  LblDestinatario.Tag         := 0;
  LblRotaParticipante.Caption := '';
  if EdtDestinatario.Text = '' then
     Exit;
  if StrToIntDef(EdtDestinatario.Text, 0) <= 0 then Begin
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') inválido!' );
     EdtDestinatario.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     ObjPessoaCtrl.Free;
     //ReturnjsonArray.Free;
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
     BtnParticipanteOnOff(False);
  end
  Else Begin
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
     LblDestinatario.Tag     := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<Integer>('pessoaId');
     if (ReturnjsonArray.Items[0] as TJSONObject).GetValue<Integer>('rotaId') > 0 then Begin
        xObjRotaCtrl := TRotaCtrl.Create;
        LblRotaParticipante.Caption := 'Rota Atual: '+(ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('rotaId')+' - '+
                                       xObjRotaCtrl.GetRota( (ReturnjsonArray.Items[0] as TJSONObject).GetValue<Integer>('rotaId')   )[0].ObjRota.Descricao;
        xObjRotaCtrl.Free;
     End;
     for xParticipante := 1 to Pred(LstAdvParticipantes.RowCount) do Begin
         if LstAdvParticipantes.Cells[5, xParticipante].ToInteger = StrToIntDef(EdtDestinatario.Text, 0) then
            EdtPosicao.Text := LstAdvParticipantes.Cells[2, xParticipante];
     End;
     BtnParticipanteOnOff(True);
  End;
  ObjPessoaCtrl.Free;
  //ReturnjsonArray := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRotas.EdtPosicaoExit(Sender: TObject);
begin
  if (StrToIntDef(EdtPosicao.Text, 0) < 0) then Begin
     EdtPosicao.SetFocus;
     ShowErro('Posição('+Edtposicao.Text+') inválida para o Destinatário!');
     EdtPosicao.Clear;
  End;
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmRotas.EdtRotaIdChange(Sender: TObject);
begin
  inherited;
  if (Sender=EdtRotaId) and (Not EdtRotaId.ReadOnly) and (StrToIntDef(EdtRotaId.Text,0) <> ObjRotaCtrl.ObjRota.RotaId) then
     Limpar;
end;

procedure TFrmRotas.EdtRotaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmRotas.EdtRotaIdExit(Sender: TObject);
begin
  inherited;
  if (Not EdtRotaId.ReadOnly) and (EdtRotaId.Text<>'') and (StrToIntDef(EdtRotaId.Text,0) <> ObjRotaCtrl.ObjRota.RotaId) then Begin
     if StrToInt64Def(EdtRotaId.Text,0)<=0 then
        raise Exception.Create('Id Inválido para pesquisa!');
     Limpar;
     ObjRotaCtrl := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.Text, 0), '')[0];
     ShowDados;
//     ShowMessage(ObjRotaCtrl.Distancia(ObjRotaCtrl.ObjRota.Latitude, ObjRotaCtrl.ObjRota.Longitude).ToString());
  End;
  ExitFocus(Sender);
end;

procedure TFrmRotas.EdtRotaIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRotas.EdtRotaIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = 13) and (EdtRotaId.Text='') or (StrToIntDef(EdtRotaId.Text, 0)<=0) then Begin
     Key := 0;
     EdtRotaId.SetFocus;
     ShowErro('Id da Rota('+EdtRotaId.Text+') inválido!');
     EdtRotaId.Clear;
     Exit;
  End;
end;

procedure TFrmRotas.ReorganizaRotaOrdem(Sender: TObject);
begin
  LstAdvParticipantes.SortSettings.Column := 2;
  LstAdvParticipantes.QSort;
end;

procedure TFrmRotas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmRotas := Nil;
end;

procedure TFrmRotas.FormCreate(Sender: TObject);
begin
  inherited;
  ObjRotaCtrl := TRotaCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[1] := 300+Trunc(300*ResponsivoVideo);
    ColWidths[2] :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[3] :=  80+Trunc(80*ResponsivoVideo);
    ColWidths[4] :=  50+Trunc(50*ResponsivoVideo);
    ColWidths[5] :=  80+Trunc(80*ResponsivoVideo);
    Alignments[0 ,0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[4 ,0] := taCenter;
    Alignments[5 ,0] := taRightJustify;
  End;
  //LstAdvParticipantes.ColWidths[0] := 70;
  LstAdvParticipantes.ColWidths[0] := 100+Trunc(100*ResponsivoVideo);
  LstAdvParticipantes.ColWidths[1] := 350+Trunc(350*ResponsivoVideo);
  LstAdvParticipantes.ColWidths[2] :=  50+Trunc(50*ResponsivoVideo);
  LstAdvParticipantes.ColWidths[3] :=  50+Trunc(50*ResponsivoVideo);
  LstAdvParticipantes.ColWidths[4] :=  40+Trunc(40*ResponsivoVideo);
  LstAdvParticipantes.Alignments[0, 0] := taRightJustify;
  LstAdvParticipantes.Alignments[3, 0] := taCenter;
  LstAdvParticipantes.Alignments[4 ,0] := taCenter;
  LstAdvParticipantes.FontStyles[0, 0] := [FsBold];
  LstAdvParticipantes.HideColumn(5);
End;

procedure TFrmRotas.FormDestroy(Sender: TObject);
begin
  ObjRotaCtrl.Destroy;
  inherited;

end;

procedure TFrmRotas.GetListaLstCadastro;
begin
  inherited;
  GetListaRota;
end;

function TFrmRotas.GetListaRota(pRotaId: Integer; pDescricao: String): Boolean;
Var xLista, xImg : Integer;
    LstRota      : TObjectList<TRotaCtrl>;
begin
  if pDescricao = '' then
     LstRota := ObjRotaCtrl.GetRota(pRotaId, '')
  Else LstRota := ObjRotaCtrl.GetRota(0, pDescricao);
  Result := LstRota.Count >= 1;
  LstCadastro.RowCount  := 1;
  If LstRota.Count >= 1 then Begin
     LstCadastro.RowCount := LstRota.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount - 1 do
       LstCadastro.AddDataImage(4, xImg, 0, haCenter, vaTop);
     For xLista := 0 To LstRota.Count-1 do begin
       With LstRota[xLista].ObjRota do Begin
         LstCadastro.Cells[0, xLista+1] := RotaId.ToString();
         LstCadastro.Cells[1, xLista+1] := Descricao;
         LstCadastro.Cells[2, xLista+1] := DateToStr(DtInclusao);
         LstCadastro.Cells[3, xLista+1] := TimeToStr(HrInclusao);
   //      if Status = 0 then LstCadastro.Cells[4, xLista+1] := 'Desativada' Else LstCadastro.Cells[4, xLista+1] := 'Ativa';
         LstCadastro.Cells[4, xLista+1] := Status.ToString;
         LstCadastro.Cells[5, xLista+1] := NParticipante.ToString();
       End;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[4, xLista+1] := taCenter;
       LstCadastro.Alignments[5, xLista+1] := taRightJustify;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  LstRota := nil;
end;

procedure TFrmRotas.GetRotaParticipante;
Var JsonArrayReturn : TJsonArray;
    vErro : String;
    xParticipantes : Integer;
begin
  JsonArrayReturn := ObjRotaCtrl.GetRotaParticipante(ObjRotaCtrl.ObjRota.RotaId, 0);
  LstAdvParticipantes.RowCount := 1;
  LstAdvParticipantes.Enabled  := False;
  if (JsonArrayReturn.Count>0) then Begin
     if JsonArrayReturn.Get(0).TryGetValue('Erro', vErro) then
        ShowErro(JsonArrayReturn.Get(0).GetValue<String>('Erro'))
     Else Begin
       LstAdvParticipantes.RowCount  := JsonArrayReturn.Count+1;
       LstAdvParticipantes.FixedRows := 1;
       For xParticipantes := 1 to LstAdvParticipantes.RowCount do Begin
         LstAdvParticipantes.AddDataImage(3, xParticipantes, 0, haCenter, vaTop);
         LstAdvParticipantes.AddDataImage(4, xParticipantes, 2, haCenter, vaTop);
       End;
       For xParticipantes := 0 to Pred(JsonArrayReturn.Count) do Begin
         LstAdvParticipantes.Cells[5, xParticipantes+1] := JsonArrayReturn.Get(xParticipantes).getValue<Integer>('pessoaid').ToString;
         LstAdvParticipantes.Cells[0, xParticipantes+1] := JsonArrayReturn.Get(xParticipantes).getValue<Integer>('codpessoaerp').ToString;
         LstAdvParticipantes.Cells[1, xParticipantes+1] := JsonArrayReturn.Get(xParticipantes).getValue<String>('fantasia');
         LstAdvParticipantes.Cells[2, xParticipantes+1] := JsonArrayReturn.Get(xParticipantes).getValue<Integer>('ordem').ToString;
         LstAdvParticipantes.Cells[3, xParticipantes+1] := '1';
         LstAdvParticipantes.Cells[4, xParticipantes+1] := '2'; //Ação Delete
         LstAdvParticipantes.Alignments[0, xParticipantes+1] := taRightJustify;
         LstAdvParticipantes.Alignments[2, xParticipantes+1] := taRightJustify;
         LstAdvParticipantes.Alignments[3, xParticipantes+1] := taCenter;
         LstAdvParticipantes.Alignments[4 ,xParticipantes+1] := taCenter;
         LstAdvParticipantes.FontStyles[0, xParticipantes+1] := [FsBold];
       End;
       LstAdvParticipantes.Tag := 1;
       LstAdvParticipantes.Enabled  := True;
     End;
  End
end;

function TFrmRotas.IfThen(AValue: Boolean; const ATrue, AFalse: Integer): Integer;
begin
 if AValue then
    Result := ATrue
 else
    Result := AFalse;
end;

procedure TFrmRotas.Limpar;
begin
  if Not (EdtRotaId.Enabled) then
     EdtRotaId.Clear;
  EnabledButtons := False;
  If Assigned(ObjRotaCtrl) Then ObjRotaCtrl.ObjRota.Limpar;
  EdtDescricao.Clear;
  ChkCadastro.Checked          := False;
  ClearParticipante(PnlParticipante);
  PnlParticipante.Enabled      := False;
  LstAdvParticipantes.RowCount := 1;
  lblDestinatario.Tag := 0;
end;

procedure TFrmRotas.LstAdvParticipantesClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if aRow > 0 then Begin
     LstAdvParticipantes.Tag := aRow;
     LstAdvParticipantes.Row := aRow;
     if (aCol = 4) then Begin //Remover Participante da Rota
        //Solicitar Confirmar
        If Confirmacao('Remover Participante da Rota.', 'Deseja remover o participante da rota?', True) then begin
           If ObjRotaCtrl.Delparticipante(LstAdvParticipantes.Cells[5, ARow].ToInteger()) then Begin
              Confirmacao('Rotas.', 'Participante removido da Rota com sucesso!', False);
              Player('concluido');
              GetRotaParticipante;
              ReorganizaRotaOrdem(Sender);
           End
           else ShowErro('Não foi possível remover o participante da Rota!');
        end;
     End;
  End
  Else Begin
     LstAdvParticipantes.SortSettings.Column := aCol;
     LstAdvParticipantes.QSort;
  End;
end;

procedure TFrmRotas.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtRotaId.Text := LstCadastro.Cells[aCol, aRow];
  EdtRotaIdExit(EdtRotaId);
  PgcBase.ActivePage := TabPrincipal;
end;

function TFrmRotas.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then Begin//0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) = 0 then
           raise Exception.Create('Id inválido para pesquisa.');
        Result := GetListaRota(StrToInt(EdtConteudoPesq.Text), '')
     End
     Else if CbCampoPesq.ItemIndex = 1 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaRota(0, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmRotas.PosicaoIndicator(pParticipanteId: Integer);
Var xParticipante : Integer;
begin
  for xParticipante := 1 to Pred(LstAdvParticipantes.RowCount) do Begin
    if LstAdvParticipantes.Cells[5, xParticipante].ToInteger = pParticipanteId then Begin
       LstAdvParticipantes.Tag := xParticipante;
       LstAdvParticipantes.Row := xParticipante;
    End;
  End;
end;

function TFrmRotas.SalvarReg: Boolean;
begin
  With ObjRotaCtrl.ObjRota do begin
    RotaId     := StrToIntDef(EdtRotaId.Text, 0);
    Descricao  := EdtDescricao.Text;
    GoogleMaps := EdtGoogleMaps.text;
    Latitude   := EdtLatitude.Text;
    Longitude  := EdtLongitude.Text;
    Status := Ord(ChkCadastro.Checked);
  end;
  Result := ObjRotaCtrl.Salvar;
  if Result then ObjRotaCtrl.ObjRota.RotaId := 0;
end;

Function TFrmRotas.SalvarUpdParticipante(pRotaId, pParticipanteId,
  pPosicao: Integer) : Boolean;
Var JsonArrayRetorno : TJsonArray;
    JsonParticipante : TJsonObject;
    vErro            : String;
begin
  Result := False;
  Try
    JsonParticipante := TJsonObject.Create;
    JsonParticipante.AddPair('rotaid', TJsonNumber.Create(pRotaId));
    JsonParticipante.AddPair('pessoaid', TJsonNumber.Create(pParticipanteId));
    JsonParticipante.AddPair('posicao', TJsonNumber.Create(pPosicao));
    JsonArrayRetorno := ObjRotaCtrl.RotaParticipante(JsonParticipante);
    if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then
       ShowErro(vErro)
    else Begin
       BtnParticipanteOnOff(False);
       ClearParticipante(BtnSalvarParticipante);
    End;
    EdtDestinatario.SetFocus;
    JsonParticipante.Free;
    Result := True;
  Except On E: Exception do Begin
    ShowErro('Erro: '+E.Message);
    EdtDestinatario.SetFocus;
    JsonParticipante.Free;
    End;
  End;
end;

procedure TFrmRotas.ShowDados;
begin
  inherited;
  If ObjRotaCtrl.ObjRota.RotaId > 0 then With ObjRotaCtrl.ObjRota do Begin
     If RotaId <> 0 Then Begin
        PgcBase.ActivePage     := TabPrincipal;
        EnabledButtons         := True;
     End;
     EdtRotaId.Text      := RotaId.ToString;
     EdtDescricao.Text   := Descricao;
     EdtGoogleMaps.Text  := GoogleMaps;
     EdtLatitude.Text    := Latitude;
     EdtLongitude.Text   := Longitude;
     PnlParticipante.Enabled := True;
     ChkCadastro.Checked := Status = 1;
     GetRotaParticipante;
     ReorganizaRotaOrdem(LstAdvParticipantes);
  End;
end;

end.
