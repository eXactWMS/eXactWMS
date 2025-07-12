unit uFrmMonitorLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, DataSet.Serialize,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Generics.Collections,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxCameraControl, acPNG, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  dxGDIPlusClasses, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj,
  BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, JvToolEdit, Vcl.DialogMessage,
  System.Json, Rest.Json, Clipbrd, Vcl.OleCtrls, SHDocVw;

type
  TFrmMonitorLog = class(TFrmBase)
    EdtIdReq: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtDtData: TJvDateEdit;
    EdtHora: TEdit;
    Label5: TLabel;
    EdtUsuario: TEdit;
    Label6: TLabel;
    EdtTerminal: TEdit;
    EdtIp: TEdit;
    Label7: TLabel;
    EdtPorta: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    EdtUrl: TEdit;
    Label10: TLabel;
    EdtParams: TEdit;
    EdtMmBody: TMemo;
    Label11: TLabel;
    Label12: TLabel;
    EdtResponseStr: TEdit;
    EdtMmResponseJson: TMemo;
    Label13: TLabel;
    EdtStatusCode: TEdit;
    EdtUsuarioId: TEdit;
    BtnCopyUrl: TBitBtn;
    BtnCopyParams: TBitBtn;
    BtnCopyBody: TBitBtn;
    BtnCopyResponse: TBitBtn;
    Label14: TLabel;
    CbVerbo: TComboBox;
    Label15: TLabel;
    EdtExecutionTime: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtIdReqExit(Sender: TObject);
    procedure EdtIdReqChange(Sender: TObject);
    procedure BtnCopyUrlClick(Sender: TObject);
  private
    { Private declarations }
    Function GetListaLog(pIdReq : Integer = 0; pUsuarioId : Integer = 0; pDataInicial : TDateTime = 0; pDataFinal : TDateTime = 0;
             pTerminal : String = ''; pIpClient : String = ''; pPorta : String = ''; pStatusCode : Integer = 0; pUrl : String = '') : Boolean;
    Procedure MontaListaLog;
    Procedure GetIdReq;
  Protected
    Function DeleteReg : Boolean; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Procedure Limpar; OverRide;
    Procedure ShowDados; override;
  public
    { Public declarations }
  end;

var
  FrmMonitorLog: TFrmMonitorLog;

implementation

{$R *.dfm}

uses MonitorLogCtrl, uFuncoes;

procedure TFrmMonitorLog.BtnCopyUrlClick(Sender: TObject);
begin
  inherited;
  if (Sender = BtnCopyUrl) and (EdtUrl.Text<>'') then
     ClipBoard.AsText := EdtUrl.Text
  Else if (Sender = BtnCopyParams) and (EdtParams.Text<>'') then
     ClipBoard.AsText := EdtParams.Text
  Else if (Sender = BtnCopyBody) and (EdtMmBody.Lines.Count>0) then
     ClipBoard.AsText := EdtMmBody.Text
  Else if (Sender = BtnCopyResponse) and (EdtMmResponseJson.Lines.count>0) then
     ClipBoard.AsText := EdtMmResponseJson.Text
end;

function TFrmMonitorLog.DeleteReg: Boolean;
Var ObjMonitorLogCtrl : TMonitorLogCtrl;
    JsonArrayRetorno  : TJsonArray;
    vErro             : String;
begin
  ObjMonitorLogCtrl := TMonitorLogCtrl.Create;
  JsonArrayRetorno  := ObjMonitorLogCtrl.DeleteLog(StrToIntDef(EdtIdReq.Text, 0));
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     Result := False;
     Exit;
  End
  Else
     Result := True;
  JsonArrayRetorno := Nil;
  ObjMonitorLogCtrl.Free;
end;

procedure TFrmMonitorLog.EdtIdReqChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmMonitorLog.EdtIdReqExit(Sender: TObject);
begin
  inherited;
  if (Sender=EdtIdReq) and (EdtIdReq.Text<>'') and (Not EdtIdReq.ReadOnly) then Begin
     //Limpar;
     if StrToIntDef(EdtIdReq.Text,0) <= 0 then
        raise Exception.Create('Id inválido para pesquisa!');
     GetIdReq;
  End;
  ExitFocus(Sender);
end;

procedure TFrmMonitorLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmMonitorLog := Nil;
end;

procedure TFrmMonitorLog.FormCreate(Sender: TObject);
begin
  inherited;
  With LstCadastro do Begin
    ColWidths[0]  :=  70;
    ColWidths[1]  :=  80;
    ColWidths[2]  :=  80;
    ColWidths[3]  := 280;
    ColWidths[4]  := 120;
    ColWidths[5]  := 100;
    ColWidths[6]  :=  60;
    ColWidths[7]  := 150;
    ColWidths[8]  := 200;
    ColWidths[9]  := 200;
    ColWidths[10] := 120;
    ColWidths[11] := 200;
    ColWidths[12] :=  60;
    FontStyles[0, 0] := [FsBold];
    Alignments[0, 0] := taRightJustify;
    Alignments[1, 0] := taCenter;
    Alignments[2, 0] := taCenter;
    Alignments[12,0] := taRightJustify;
  End;
end;


procedure TFrmMonitorLog.GetIdReq;
Var ObjMonitorLogCtrl : TMonitorLogCtrl;
    JsonArrayLog      : TJsonArray;
    vErro             : String;
begin
  ObjMonitorLogCtrl := TMonitorLogCtrl.Create;
  JsonArrayLog := ObjMonitorLogCtrl.GetListaLog(StrToIntDef(EdtIdReq.Text, 0), 0, 0, 0, '',
                      '', '', 0, '');
  if JsonArrayLog.Items[0].TryGetValue('Erro', vErro) then Begin
     JsonArrayLog := Nil;
     ObjMonitorLogCtrl.Free;
     ShowErro(vErro);
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJson(JsonArrayLog, False);
  JsonArrayLog := Nil;
  ObjMonitorLogCtrl.Free;
  ShowDados;
end;

function TFrmMonitorLog.GetListaLog(pIdReq, pUsuarioId: Integer; pDataInicial,
  pDataFinal: TDateTime; pTerminal, pIpClient, pPorta: String;
  pStatusCode: Integer; pUrl : String): Boolean;
Var ObjMonitorLogCtrl : TMonitorLogCtrl;
    JsonArrayLog      : tJsonArray;
    jSonObj           : tJsonObject;
    I, xLista         : Integer;
    vErro             : String;
begin
  ObjMonitorLogCtrl := TMonitorLogCtrl.Create;
  JsonArrayLog := ObjMonitorLogCtrl.GetListaLog(pIdReq, pUsuarioId, pDataInicial, pDataFinal, pTerminal,
                      pIpClient, pPorta, pStatusCode, pUrl);
  if JsonArrayLog.Items[0].TryGetValue('Erro', vErro) then Begin
     JsonArrayLog := Nil;
     ObjMonitorLogCtrl.Free;
     ShowErro(vErro);
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJson(JsonArrayLog, False);
  MontaListaLog;
  JsonArrayLog := Nil;
  ObjMonitorLogCtrl.Free;
  Result := True;
end;

procedure TFrmMonitorLog.GetListaLstCadastro;
begin
  inherited;
  GetListaLog(0, 0, Date(), Date(), '', '', '', 0, '');
end;

procedure TFrmMonitorLog.Limpar;
begin
  inherited;
   if Not EdtIdReq.Enabled then
      EdtIdReq.Clear;
  if PgcBase.ActivePage = TabPrincipal then
     EdtIdReq.SetFocus;
  EdtDtData.Clear;
  EdtHora.Clear;
  EdtUsuarioId.Clear;
  EdtUsuario.Clear;
  EdtTerminal.Clear;
  EdtIp.Clear;
  EdtPorta.Clear;
  EdtUrl.Clear;
  EdtParams.Clear;
  EdtMmBody.Lines.Clear;
  EdtResponseStr.Clear;
  EdtMmResponseJson.Lines.Clear;
  EdtStatusCode.Clear;
  EdtExecutionTime.Clear;
End;

procedure TFrmMonitorLog.MontaListaLog;
Var xLog : Integer;
begin
  LstCadastro.RowCount := FdMemPesqGeral.RecordCount+1;
  xLog := 0;
{
   FdMemPesqGeral.First;
   While Not FdMemPesqGeral.Eof do begin
     Inc(xLog);
     LstCadastro.AddDataImage(8, xLog, 0, haCenter,vaTop);
     LstCadastro.AddDataImage(9, xLog, 0, haCenter,vaTop);
     FdMemPesqGeral.Next;
   end;
}
  xLog := 0;
  FdMemPesqGeral.First;
  FdMemPesqGeral.First;
  While Not FdMemPesqGeral.Eof do begin
    Inc(xLog);
    LstCadastro.Cells[0,  xLog] := FdMemPesqGeral.FieldByName('IdReq').AsString;
    LstCadastro.Cells[1,  xLog] := DateEUAtoBr(FdMemPesqGeral.FieldByName('Data').AsString);
    LstCadastro.Cells[2,  xLog] := Copy(FdMemPesqGeral.FieldByName('hora').AsString,1,8);
    LstCadastro.Cells[3,  xLog] := FdMemPesqGeral.FieldByName('UsuarioId').AsString+' '+FdMemPesqGeral.FieldByName('Nome').AsString;;
    LstCadastro.Cells[4,  xLog] := FdMemPesqGeral.FieldByName('Terminal').AsString;
    LstCadastro.Cells[5,  xLog] := FdMemPesqGeral.FieldByName('ipclient').AsString;
    LstCadastro.Cells[6,  xLog] := FdMemPesqGeral.FieldByName('port').AsString;
    LstCadastro.Cells[7,  xLog] := FdMemPesqGeral.FieldByName('url').AsString;
    LstCadastro.Cells[8,  xLog] := FdMemPesqGeral.FieldByName('params').AsString;
    LstCadastro.Cells[9,  xLog] := FdMemPesqGeral.FieldByName('body').AsString;
    LstCadastro.Cells[10, xLog] := FdMemPesqGeral.FieldByName('responsestr').AsString;
    LstCadastro.Cells[11, xLog] := FdMemPesqGeral.FieldByName('responsejson').AsString;
    LstCadastro.Cells[12, xLog] := FdMemPesqGeral.FieldByName('statuscode').AsString;
    LstCadastro.FontStyles[0, xLog] := [FsBold];
    LstCadastro.Alignments[0, xLog] := taRightJustify;
    LstCadastro.Alignments[1, xLog] := taCenter;
    LstCadastro.Alignments[2, xLog] := taCenter;
    LstCadastro.Alignments[12,xLog] := taRightJustify;
    FdMemPesqGeral.Next;
  end;
  LstCadastro.FixedRows := 1;
  LstCadastro.SortSettings.Column := 2;
  LstCadastro.QSort;
  AdvGridLookupBar1.Column := 1;
end;

procedure TFrmMonitorLog.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtIdReq.Text := LstCadastro.Cells[0, aRow];
  EdtIdReqExit(EdtIdReq);
end;

function TFrmMonitorLog.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para pesquisa!');
     If CbCampoPesq.ItemIndex = 0 then Begin   //UsuarioId
        If StrToIntDef(EdtConteudoPesq.Text, 0) <= 0 then
           raise Exception.Create('Id do Usuário é inválido!')
        Else
           Result := GetListaLog(0, StrToIntDef(EdtConteudoPesq.Text, 0), 0, 0, '', '', '', 0, '');
     End
     Else If CbCampoPesq.ItemIndex = 1 then Begin //Data
        Try
          StrToDate(EdtConteudoPesq.Text);
        Except On E: Exception do
          raise Exception.Create('Data inválida!')
        End;
        Result := GetListaLog(0, 0, StrToDate(EdtConteudoPesq.Text), StrToDate(EdtConteudoPesq.Text), '', '', '', 0, '')
     End
     Else If CbCampoPesq.ItemIndex = 2 then  //Terminal
        Result := GetListaLog(0, 0, 0, 0, EdtConteudoPesq.Text, '', '', 0, '')
     Else If CbCampoPesq.ItemIndex = 3 then  //Ip Client
        Result := GetListaLog(0, 0, 0, 0, '', EdtConteudoPesq.Text, '', 0, '')
     Else If CbCampoPesq.ItemIndex = 4 then Begin //Porta
        If StrToIntDef(EdtConteudoPesq.Text, 0) <= 0 then
           raise Exception.Create('Porta de comunicação inválida!')
        Else
           Result := GetListaLog(0, 0, 0, 0, '', '', EdtConteudoPesq.Text, 0, '');
     End
     Else If CbCampoPesq.ItemIndex = 5 then Begin
        If StrToIntDef(EdtConteudoPesq.Text, 0) <= 0 then
           raise Exception.Create('Status Code do retorno inválido!')
        Else
           Result := GetListaLog(0, 0, 0, 0, '', '', '', StrToIntDef(EdtConteudoPesq.Text, 0), '');
     End
     Else If CbCampoPesq.ItemIndex = 6 then
        Result := GetListaLog(0, 0, 0, 0, '', '', '', 0, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

procedure TFrmMonitorLog.ShowDados;
begin
  inherited;
  EdtDtData.Text         := DateEUAtoBr(FdMemPesqGeral.FieldByName('Data').AsString);
  EdtHora.Text           := FdMemPesqGeral.FieldByName('Hora').AsString;
  EdtUsuarioId.Text      := FdMemPesqGeral.FieldByName('UsuarioId').AsString;
  EdtUsuario.Text        := FdMemPesqGeral.FieldByName('Nome').AsString;
  EdtTerminal.Text       := FdMemPesqGeral.FieldByName('Terminal').AsString;
  EdtIp.Text             := FdMemPesqGeral.FieldByName('ipclient').AsString;
  EdtPorta.Text          := FdMemPesqGeral.FieldByName('port').AsString;
  EdtUrl.Text            := FdMemPesqGeral.FieldByName('url').AsString;
  EdtParams.Text         := FdMemPesqGeral.FieldByName('params').AsString;
  EdtMmBody.Text         := FdMemPesqGeral.FieldByName('body').AsString;
  EdtResponseStr.Text    := FdMemPesqGeral.FieldByName('responsestr').AsString;
  EdtMmResponseJson.Text := FdMemPesqGeral.FieldByName('responsejson').AsString;
  if (FdMemPesqGeral.FieldByName('statuscode').AsInteger > 0) and
     (FdMemPesqGeral.FieldByName('statuscode').AsInteger < 300) then
     EdtStatusCode.Font.Color := ClGreen
  Else
     EdtStatusCode.Font.Color := ClRed;
  EdtStatusCode.Text     := FdMemPesqGeral.FieldByName('statuscode').AsString;
  EdtExecutionTime.Text  := FdMemPesqGeral.FieldByName('timeexecution').AsString+'s';
  If FdMemPesqGeral.FieldByName('verbo').AsString = 'Any' then
     CbVerbo.ItemIndex := 0
  Else If FdMemPesqGeral.FieldByName('verbo').AsString = 'Get' then
     CbVerbo.ItemIndex := 1
  Else If FdMemPesqGeral.FieldByName('verbo').AsString = 'Put' then
     CbVerbo.ItemIndex := 2
  Else If FdMemPesqGeral.FieldByName('verbo').AsString = 'Post' then
     CbVerbo.ItemIndex := 3
  Else If FdMemPesqGeral.FieldByName('verbo').AsString = 'Head' then
     CbVerbo.ItemIndex := 4
  Else If FdMemPesqGeral.FieldByName('verbo').AsString = 'Delete' then
     CbVerbo.ItemIndex := 5
  Else If FdMemPesqGeral.FieldByName('verbo').AsString = 'Patch' then
     CbVerbo.ItemIndex := 6;
end;

end.
