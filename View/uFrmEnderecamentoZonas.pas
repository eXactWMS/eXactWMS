unit uFrmEnderecamentoZonas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore, DataSet.Serialize,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtDlgs, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, Generics.Collections, System.JSOn
  , EnderecamentoZonaCtrl, EnderecamentoZonaClass
  , RastroCtrl, RastroClass, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmEnderecamentoZonas = class(TFrmBase)
    Label2: TLabel;
    EdtZonaId: TEdit;
    Label3: TLabel;
    EdtDescricao: TEdit;
    lblEndereco: TLabel;
    EdtEstruturaId: TEdit;
    BtnPesqEstrutura: TBitBtn;
    LblEstrutura: TLabel;
    CbEstoqueTipo: TComboBox;
    Label4: TLabel;
    Label23: TLabel;
    CbRastroTipo: TComboBox;
    ChkLoteReposicao: TCheckBox;
    ChkSeparacaoConsolidada: TCheckBox;
    ChkProdutoSngpc: TCheckBox;
    CbTagVolumeOrdem: TComboBox;
    Label40: TLabel;
    Label5: TLabel;
    EdtSigla: TEdit;
    Label6: TLabel;
    CbPickingDinamico: TComboBox;
    ChkAuditavel: TCheckBox;
    procedure BtnPesqEstruturaClick(Sender: TObject);
    procedure EdtEstruturaIdExit(Sender: TObject);
    procedure EdtEstruturaIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtZonaIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure EdtZonaIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    //procedure BtnOpeFileClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
  private
    { Private declarations }
    LstRastro              : TObjectList<TRastro>;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
    Function GetListaEnderecamentoZonas(pZonaId : Integer; pDescricao : String) : Boolean;
    Procedure DefineField;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
    procedure OpenFileImport; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmEnderecamentoZonas: TFrmEnderecamentoZonas;

implementation

{$R *.dfm}

Uses uFuncoes, Views.Pequisa.EnderecamentoEstruturas, EnderecamentoEstruturaCtrl;

procedure TFrmEnderecamentoZonas.BtnEditarClick(Sender: TObject);
begin
  if (StrToIntDef(EdtZonaId.Text, 0) > 0) and (StrToIntDef(EdtZonaId.Text, 0) <= 3) then Begin
     ShowErro('Alteração não permitida. Zona/Setor definida pelo eXactWMS.');
     Exit;
  End;
  inherited;
  EdtDescricao.SetFocus;
end;

procedure TFrmEnderecamentoZonas.BtnExcluirClick(Sender: TObject);
begin
  if (StrToIntDef(EdtZonaId.Text, 0) > 0) and (StrToIntDef(EdtZonaId.Text, 0) <= 3) then Begin
     ShowErro('Alteração não permitida. Zona/Setor definida pelo eXactWMS.');
     Exit;
  End;
  inherited;
end;

procedure TFrmEnderecamentoZonas.BtnImportClick(Sender: TObject);
Var JsonRetorno : TJsonObject;
    vErro :String;
begin
  inherited;
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemPesqGeral.RecordCount;
  PbImportaFile.Position := 0;
  FdMemPesqGeral.First;
  While Not FdMemPesqGeral.Eof Do Begin
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ZonaId        := 0;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Descricao     := FdMemPesqGeral.FieldByName('Descricao').AsString;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.EstruturaId   := FdMemPesqGeral.FieldByName('EstruturaId').AsInteger;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.EstoqueTipoId := FdMemPesqGeral.FieldByName('EstoqueTipoId').AsInteger;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.RastroId      := FdMemPesqGeral.FieldByName('RastroId').AsInteger;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.LoteReposicao := FdMemPesqGeral.FieldByName('LoteReposicao').AsInteger;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.SeparacaoConsolidada := FdMemPesqGeral.FieldByName('SeparacaoConsolidada').AsInteger;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ProdutoSNGPC  := FdMemPesqGeral.FieldByName('ProdutoSngpc').AsInteger;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Auditavel     := FdMemPesqGeral.FieldByName('Auditavel').AsInteger;
    ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Status        := 1;
    Try
      If Not ObjEnderecamentoZonaCtrl.Salvar then Begin
         MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('Descricao').AsString);
    End;
    Except On E: Exception do Begin
      MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('Descricao').AsString);
      End;
    End;
    PbImportaFile.Position := PbImportaFile.Position + 1;
    Application.ProcessMessages;
    FdMemPesqGeral.Next;
  End;
  ShowMessage('Importação concluída...');
end;

procedure TFrmEnderecamentoZonas.OpenFileImport;   //BtnOpeFileClick(Sender: TObject);
var ArquivoCSV: TextFile;
    Linha : String;
    I : Integer;
    vEstruturaId   : String;
    vRastroId      : String;
    vEstoqueTipoId : String;
//    JsonArrayProduto, JsonArrayEndereco : TJsonArray;
  Function GetValor: String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';
    inc(I);
    While Linha[I] >= ' ' do
    begin
      If Linha[I] = ';' then // vc pode usar qualquer delimitador ... eu
        // estou usando o ";"
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;
begin
  inherited;
  DefineField;
  if EdtFileIimport.Text = '' then
     raise Exception.Create('Informe o arquivo a ser importado!');
  if Not FileExists(EdtFileIimport.Text) then Begin
     ShowMessage('Arquivo para Importacao não encontrado.');
     Exit;
  End;
  AssignFile(ArquivoCSV, EdtFileIimport.Text);
  try
    TmImportacaoCSV.Enabled := True;
    Reset(ArquivoCSV);
    Readln(ArquivoCSV, Linha);    //Pular Cabecalho
    while not Eoln(ArquivoCSV) do begin
      Readln(ArquivoCSV, Linha);
      I := 0;
      FdMemPesqGeral.Append;
      FdMemPesqGeral.FieldByName('Descricao').AsString      := GetValor;
      vEstruturaId := GetValor;
      if (UpperCase(vEstruturaId) = 'PULMAO') or (vEstruturaId = '1') then
         vEstruturaId := '1'
      Else If (UpperCase(vEstruturaId) = 'PICKING') or (vEstruturaId = '2') then
         vEstruturaId := '2';
      FdMemPesqGeral.FieldByName('EstruturaId').AsInteger   := StrToInt(vEstruturaId);
      vEstoqueTipoId := GetValor;
      if (UpperCase(vEstoqueTipoId) = 'STAGE - ARMAZENAGEM') or (vEstoqueTipoId = '1') then
         vEstruturaId := '1'
      Else If (UpperCase(vEstoqueTipoId) = 'CROSSDOCKING') or (vEstoqueTipoId = '2') then
         vEstruturaId := '2'
      Else If (UpperCase(vEstoqueTipoId) = 'SEGREGADO') or (vEstoqueTipoId = '3') then
         vEstruturaId := '3'
      Else If (UpperCase(vEstoqueTipoId) = 'PRODUCAO') or (vEstoqueTipoId = '4') then
         vEstruturaId := '4';
      FdMemPesqGeral.FieldByName('EstoqueTipoId').AsInteger := StrToInt(vEstoqueTipoId);
      vRastroId := GetValor;
      if (UpperCase(vRastroId) = 'SEM RASTRO') or (vRastroId = '1') then
         vRastroId := '1'
      Else If (UpperCase(vRastroId) = 'VENCIMENTO') or (vRastroId = '2') then
         vRastroId := '2'
      Else If (UpperCase(vRastroId) = 'LOTE') or (vRastroId = '3') then
         vRastroId := '3';
      FdMemPesqGeral.FieldByName('RastroId').AsInteger      := StrToInt(vRastroId);
      FdMemPesqGeral.FieldByName('LoteReposicao').AsInteger := StrToInt(GetValor);
      FdMemPesqGeral.FieldByName('SeparacaoConsolidada').AsInteger := StrToInt(GetValor);
      FdMemPesqGeral.FieldByName('ProdutoSNGPC').AsInteger  := StrToInt(GetValor);
      FdMemPesqGeral.FieldByName('Auditavel').AsInteger     := StrToInt(GetValor);
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemPesqGeral.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmEnderecamentoZonas.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  CbTagVolumeOrdem.ItemIndex := -1;
  EdtDescricao.SetFocus;
end;

procedure TFrmEnderecamentoZonas.BtnPesqEstruturaClick(Sender: TObject);
var LForm: TFrmPesquisaEnderecamentoEstruturas;
begin
  if EdtEstruturaId.ReadOnly then Exit;
  inherited;
  //ShowForm(TFrmPesquisaLaboratorio, LForm);
  FrmPesquisaEnderecamentoEstruturas := TFrmPesquisaEnderecamentoEstruturas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoEstruturas.ShowModal = mrOk) then  Begin
       EdtEstruturaId.Text := FrmPesquisaEnderecamentoEstruturas.Tag.ToString();
       EdtEstruturaIdExit(EdtEstruturaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoEstruturas);
  end;
end;

procedure TFrmEnderecamentoZonas.DefineField;
begin
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.FieldDefs.Clear;
     FdMemPesqGeral.Close;
  End;
  With FdMemPesqGeral.FieldDefs do begin
     Add('Descricao',     ftString, 30, True);
     Add('EstruturaId',   ftInteger, 0, True);
     Add('EstoqueTipoId', ftInteger, 0, True);
     Add('RastroId',      ftInteger, 0, True);
     Add('LoteReposicao', ftInteger, 0, True);
     Add('SeparacaoConsolidada', ftInteger, 0,True);
     Add('ProdutoSngpc',  ftInteger, 0,  True);
     Add('Auditavel',     ftInteger, 0,  True);
  End;
  FdMemPesqGeral.CreateDataSet;
  FdMemPesqGeral.Open;
end;

function TFrmEnderecamentoZonas.DeleteReg: Boolean;
begin
  Result := ObjEnderecamentoZonaCtrl.DelEnderecamentoZona(StrToIntDef(EdtZonaId.Text, 0));
end;

procedure TFrmEnderecamentoZonas.EdtConteudoPesqKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex in [0] then
     SoNumeros(Key);
end;

procedure TFrmEnderecamentoZonas.EdtEstruturaIdChange(Sender: TObject);
begin
  inherited;
  LblEstrutura.Caption := '';
end;

procedure TFrmEnderecamentoZonas.EdtEstruturaIdExit(Sender: TObject);
Var ObjEnderecoEstruturaCtrl : TEnderecoEstruturaCtrl;
    vErro                    : String;
begin
  if (EdtEstruturaId.Text<>'') and (StrToIntDef(EdtEstruturaId.Text, 0) <= 0) then Begin
     EdtEstruturaId.setFocus;
     ShowErro('Id da Estrutura inválido!');
     EdtEstruturaId.Clear;
     Exit;
  End;
  inherited;
  if (Sender=EdtEstruturaid) and (not EdtEstruturaId.ReadOnly) then Begin
     lblEstrutura.Caption    := '';
     if EdtEstruturaId.text <> '' then Begin
        ObjEnderecoEstruturaCtrl := TEnderecoEstruturaCtrl.Create();
        ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura := ObjEnderecoEstruturaCtrl.GetEnderecoEstrutura(StrToIntDef(EdtEstruturaId.Text, 0), '', 1)[0];
        LblEstrutura.Caption := ObjEnderecoEstruturaCtrl.ObjEnderecoEstrutura.Descricao;
        FreeAndNil(ObjEnderecoEstruturaCtrl);
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEnderecamentoZonas.EdtZonaIdExit(Sender: TObject);
begin
   if (EdtZonaId.Text<>'') and (StrToIntDef(EdtZonaId.Text, 0) <= 0) then Begin
     EdtZonaId.setFocus;
     ShowErro('Id da Zona/Setor inválido!');
     EdtZonaId.Clear;
     Exit;
  End;
 inherited;
  if (Not EdtZonaId.ReadOnly) and (EdtZonaId.Text<>'') and (StrToIntDef(EdtZonaId.Text,0)<>ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ZonaId) then Begin
     Limpar;
     if StrToIntDef(EdtZonaId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtZonaId.Text+') inválido!');
     ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona := ObjEnderecamentoZonaCtrl.GetEnderecamentoZona(StrToIntDef(EdtZonaId.Text, 0), '', 0)[0];
     if ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ZonaId > 0 then
        ShowDados;
  End;
  ExitFocus(Sender);
end;

procedure TFrmEnderecamentoZonas.EdtZonaIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmEnderecamentoZonas.EdtZonaIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Not EdtZonaId.ReadOnly) and (Sender=EdtZonaId) then Begin
     EdtDescricao.Clear;
     Limpar;
  End;
end;

procedure TFrmEnderecamentoZonas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmEnderecamentoZonas := Nil;
end;

procedure TFrmEnderecamentoZonas.FormCreate(Sender: TObject);
Var ObjRastroCtrl : TRastroCtrl;
    xItens        : Integer;
begin
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  inherited;
  //Buscar Dados Complementares
  ObjRastroCtrl := TRastroCtrl.Create;
  LstRastro     := ObjRastroCtrl.GetRastro;
  CbRastroTipo.Items.Clear;
  for XItens := 0 to LstRastro.Count-1 do
    CbRastroTipo.Items.Add(LstRastro.Items[xItens].Descricao);
  ObjRastroCtrl.DisposeOf;
  LstCadastro.RowCount := 1;
  LstCadastro.ColWidths[0]  :=  60;
  LstCadastro.ColWidths[1]  := 250;
  LstCadastro.ColWidths[2]  := 150;
  LstCadastro.ColWidths[3]  := 180;
  LstCadastro.ColWidths[4]  := 100;
  LstCadastro.ColWidths[5]  :=  70;
  LstCadastro.ColWidths[6]  :=  70;
  LstCadastro.ColWidths[7]  :=  70;
  LstCadastro.ColWidths[8]  :=  70;
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[5, 0] := taCenter;
  LstCadastro.Alignments[6, 0] := taCenter;
  LstCadastro.Alignments[7, 0] := taCenter;
  LstCadastro.Alignments[8, 0] := taCenter;
end;

procedure TFrmEnderecamentoZonas.FormDestroy(Sender: TObject);
begin
  ObjEnderecamentoZonaCtrl.Free;
  inherited;
end;

function TFrmEnderecamentoZonas.GetListaEnderecamentoZonas(pZonaId: Integer; pDescricao: String): Boolean;
Var LstEnderecos  : TObjectList<TEnderecamentoZona>;
    JsonArrayRetorno : TJsonArray;
    xLista, xImg  : Integer;
    vErro         : String;
begin
  JsonArrayRetorno := ObjEnderecamentoZonaCtrl.GetEnderecamentoZonaJson(pZonaId, pDescricao, 0);
  Result := (JsonArrayRetorno.Count >= 1);
  If JsonArrayRetorno.Count >= 1 then  Begin
     LstCadastro.RowCount  := JsonArrayRetorno.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to JsonArrayRetorno.Count do Begin
       LstCadastro.AddDataImage(5, xImg, 0, haCenter, vaTop);
       LstCadastro.AddDataImage(6, xImg, 0, haCenter, vaTop);
       LstCadastro.AddDataImage(7, xImg, 0, haCenter, vaTop);
       LstCadastro.AddDataImage(8, xImg, 0, haCenter, vaTop);
     End;
     for xLista := 0 to Pred(JsonArrayRetorno.Count) do Begin
       LstCadastro.Cells[0, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('zonaid');// LstEnderecos.Items[xLista].ZonaId.ToString();
       LstCadastro.Cells[1, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('descricao');// LstEnderecos.Items[xLista].Descricao;
       LstCadastro.Cells[2, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('estrutura');
       LstCadastro.Cells[3, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<TJsonObject>('estoquetipo').getValue<String>('descricao');
       LstCadastro.Cells[4, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<TJsonObject>('rastro').getValue<String>('descricao');
       LstCadastro.Cells[5, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('lotereposicao');
       LstCadastro.Cells[6, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('separacaoconsolidada');
       LstCadastro.Cells[7, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('produtosngpc');
       LstCadastro.Cells[8, xLista+1] := JsonArrayRetorno.Items[xLista].GetValue<String>('auditavel');
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[5, xLista+1] := taCenter;
       LstCadastro.Alignments[6, xLista+1] := taCenter;
       LstCadastro.Alignments[7, xLista+1] := taCenter;
       LstCadastro.Alignments[8, xLista+1] := taCenter;
     End;
  End;
  LstCadastro.QSort;
  AdvGridLookupBar1.Column := 1;
  JsonArrayRetorno := Nil;
end;

procedure TFrmEnderecamentoZonas.GetListaLstCadastro;
begin
  inherited;
  GetListaEnderecamentoZonas(0, '');
end;

procedure TFrmEnderecamentoZonas.Limpar;
begin
  inherited;
  EnabledButtons          := False;
  //EdtZonaId.ReadOnly      := False;
  EdtDescricao.Clear;
  EdtSigla.Text                   := '';
  EdtEstruturaId.Clear;
  LblEstrutura.Caption    := '';
  CbEstoqueTipo.ItemIndex := -1;
  CbPickingDinamico.ItemIndex := 0;
  CbRastroTipo.ItemIndex  := -1;
  CbTagVolumeOrdem.ItemIndex      := -1;
  ChkLoteReposicao.Checked        := False;
  ChkSeparacaoConsolidada.Checked := False;
  ChkProdutoSngpc.Checked         := False;
  ChkCadastro.Checked             := False;
  ChkAuditavel.Checked            := False;
//  ShCadastro.Brush.Color := ClRed;
//  ShCadastro.Pen.Color   := ClRed;
  If Assigned(ObjEnderecamentoZonaCtrl) Then ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Limpar;
end;

procedure TFrmEnderecamentoZonas.PesquisarClickInLstCadastro(aCol,
  aRow: Integer);
begin
  inherited;
  EdtZonaId.Text := LstCadastro.Cells[0, aRow];
  EdtZonaIdExit(EdtZonaId);
end;

function TFrmEnderecamentoZonas.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para pesquisar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        if StrToIntDef(EdtConteudoPesq.Text, 0) > 0 then
           Result := GetListaEnderecamentoZonas(StrToIntDef(EdtConteudoPesq.Text, 0), '')
        else raise Exception.Create('Id da Zona inválido para pesquisar!')
     Else if CbCampoPesq.ItemIndex = 1 then
        Result := GetListaEnderecamentoZonas(0, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmEnderecamentoZonas.SalvarReg: Boolean;
Var vErro : String;
begin
  Result := False;
  if EdtDescricao.Text = '' then Begin
     ShowErro('Informa a descricao da Zona/Setor.');
     Exit;
  End;
  if EdtDescricao.Text = '' then Begin
     ShowErro('Informa a descricao da Zona/Setor.');
     Exit;
  End;
  Try
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ZonaId          := StrToIntDef(EdtZonaId.Text, 0);
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Descricao       := EdtDescricao.Text;
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Sigla           := EdtSigla.Text;
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.EstruturaId     := StrToIntDef(EdtEstruturaId.Text, 0);
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.EstoqueTipoId   := CbEstoqueTipo.ItemIndex+1;
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.pickingdinamico := CbPickingDinamico.ItemIndex;
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.RastroId        := CbRastroTipo.Items.IndexOf(CbRastroTipo.Text)+1;
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.TagVolumeOrdem  := CbTagVolumeOrdem.ItemIndex;
  if ChkLoteReposicao.Checked then
     ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.LoteReposicao   := 1
  Else ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.LoteReposicao := 0;
  if ChkSeparacaoConsolidada.Checked then
     ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.SeparacaoConsolidada   := 1
  Else ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.SeparacaoConsolidada := 0;
  if ChkProdutoSngpc.Checked then
     ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ProdutoSNGPC   := 1
  Else ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ProdutoSNGPC := 0;
  If ChkCadastro.Checked Then
     ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Status := 1
  Else
     ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Status      := 0;
  ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Auditavel := Ord(ChkAuditavel.Checked);
  If Not ObjEnderecamentoZonaCtrl.Salvar then Begin
     ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ZonaId := 0;
     Result := False
  End
  Else Result := True;
  Except On E: Exception do Begin
    ShowErro('Erro: '+E.Message);
    End;
  End;
end;

procedure TFrmEnderecamentoZonas.ShowDados;
Var ObjRastroCtrl : TRastroCtrl;
    ObjRastro : TRastro;
begin
  inherited;
  If EdtZonaId.Text = '' then EdtZonaId.Text := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ZonaId.ToString();
  EdtDescricao.Text   := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Descricao;
  EdtSigla.Text       := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Sigla;
  EdtEstruturaId.Text := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.EstruturaId.ToString();
  EdtEstruturaIdExit(EdtEstruturaId);
  CbEstoqueTipo.ItemIndex     := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.EstoqueTipoId-1;
  CbPickingDinamico.ItemIndex := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.pickingdinamico;
  ObjRastroCtrl               := TRastroCtrl.Create();
  CbRastroTipo.itemIndex      := CbRastroTipo.Items.IndexOf(ObjRastroCtrl.GetRastro(ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.RastroId).Items[0].Descricao);
  CbTagVolumeOrdem.ItemIndex      := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.TagVolumeOrdem;
  ChkLoteReposicao.Checked        := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.LoteReposicao = 1;
  ChkSeparacaoConsolidada.Checked := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.SeparacaoConsolidada = 1;
  ChkProdutoSngpc.Checked         := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.ProdutoSNGPC = 1;
  ChkCadastro.Checked             := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Status    = 1;
  ChkAuditavel.Checked            := ObjEnderecamentoZonaCtrl.ObjEnderecamentoZona.Auditavel = 1;
  if ChkCadastro.Checked then Begin
    ShCadastro.Brush.Color := ClGreen;
    ShCadastro.Pen.Color   := ClGreen;
  End
  Else Begin
    ShCadastro.Brush.Color := ClRed;
    ShCadastro.Pen.Color   := ClRed;
  End;
end;

procedure TFrmEnderecamentoZonas.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  If EdtZonaId.Enabled then
     EdtZonaId.SetFocus;

end;

end.
