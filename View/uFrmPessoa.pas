unit uFrmPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, Data.DB, Vcl.ExtDlgs,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, cxPC, acPNG, acImage, dxGDIPlusClasses, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.JSOn,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataSet.Serialize,
  JvFullColorSpaces, JvFullColorCtrls, AdvUtil, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, Vcl.Mask, AdvDropDown, AdvCustomGridDropDown,
  AdvGridDropDown, AdvLookupBar, AdvGridLookupBar, AdvObj, BaseGrid, ImagePicker,
  JvExMask, JvSpin, System.Generics.Collections
  , PessoaCtrl
  , PessoaEnderecoCtrl
  , PessoaTelefoneCtrl, dxSkinsCore, dxSkinsDefaultPainters, Vcl.ComCtrls,
  ACBrBase, ACBrETQ, dxCameraControl;

type

  TTpPessoa = (NotDefined, Cliente, Fornecedor, Transportadora, Motorista);

  TFrmPessoa = class(TFrmBase)
    edtCodigoErp: TLabeledEdit;
    EdtRazao: TLabeledEdit;
    EdtFone: TLabeledEdit;
    EdtEmail: TLabeledEdit;
    EdtHomePage: TLabeledEdit;
    CbTipoPessoa: TComboBox;
    Label2: TLabel;
    EdtID: TLabeledEdit;
    EdtFantasia: TLabeledEdit;
    EdtCNPJCPF: TLabeledEdit;
    FdMemPesqGeralId: TIntegerField;
    FdMemPesqGeralCodPessoa: TIntegerField;
    FdMemPesqGeralRazao: TStringField;
    FdMemPesqGeralFantasia: TStringField;
    FdMemPesqGeralCnpjCpf: TStringField;
    FdMemPesqGeralEmail: TStringField;
    FdMemPesqGeralHomePage: TStringField;
    FdMemPesqGeralStatus: TIntegerField;
    FdMemPesqGeralPessoaTipoID: TIntegerField;
    FdMemPesqGeralPessoaTipoDescricao: TStringField;
    GroupBox2: TGroupBox;
    Label23: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    CbTpFone1: TComboBox;
    CbTpFone2: TComboBox;
    CbTpFone3: TComboBox;
    EdtFone1: TEdit;
    EdtFone2: TEdit;
    EdtFone3: TEdit;
    EdtContato3: TEdit;
    EdtContato2: TEdit;
    EdtContato1: TEdit;
    EdtObs1: TEdit;
    EdtObs2: TEdit;
    EdtObs3: TEdit;
    PgcEndereco: TcxPageControl;
    TbEndereco: TcxTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label76: TLabel;
    EdtCep: TEdit;
    EdtEndereco: TEdit;
    EdtNumEndereco: TEdit;
    EdtComplEnde: TEdit;
    EdtPontoReferencia: TEdit;
    EdtBairro: TEdit;
    EdtCidade: TEdit;
    CbUf: TComboBox;
    EdtEstado: TEdit;
    EdtCodIbge: TEdit;
    TbEndCobranca: TcxTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label77: TLabel;
    EdtCepCob: TEdit;
    EdtEnderecoCob: TEdit;
    EdtNumEndeCob: TEdit;
    EdtComplEndeCob: TEdit;
    EdtPontoReferenciaCob: TEdit;
    EdtBairroCob: TEdit;
    EdtCidadeCob: TEdit;
    CbUfCob: TComboBox;
    EdtEstadoCob: TEdit;
    EdtCodIbgeCob: TEdit;
    EdtRotaId: TLabeledEdit;
    BtnPesqRota: TBitBtn;
    LblRota: TLabel;
    BtnPesqCep: TBitBtn;
    EdtTransportadoraid: TLabeledEdit;
    BtnTransportadoraPesq: TBitBtn;
    LblTransportadora: TLabel;
    LblShelfLife: TLabel;
    EdtShelfLife: TEdit;
    LblShelfLifeMeses: TLabel;
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure ConsGeralCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtCNPJCPFExit(Sender: TObject);
    procedure EdtIDExit(Sender: TObject);
    procedure LstCadastroGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure LstCadastroGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure CbCampoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCepExit(Sender: TObject);
    procedure EdtIDKeyPress(Sender: TObject; var Key: Char);
    procedure EdtFoneKeyPress(Sender: TObject; var Key: Char);
    procedure EdtNumEndeCobKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCodIbgeCobKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCepCobKeyPress(Sender: TObject; var Key: Char);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCepKeyPress(Sender: TObject; var Key: Char);
    procedure BtnExcluirClick(Sender: TObject);
    procedure EdtHomePageEnter(Sender: TObject);
    procedure EdtHomePageExit(Sender: TObject);
    procedure EdtCepCobExit(Sender: TObject);
    procedure CbUfCobChange(Sender: TObject);
    procedure CbUfChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodigoErpExit(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnPesqCepClick(Sender: TObject);
    procedure EdtIDChange(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure BtnTransportadoraPesqClick(Sender: TObject);
    procedure EdtTransportadoraidExit(Sender: TObject);
    procedure BtnImportarStandClick(Sender: TObject);
  private
    { Private declarations }
    pPessoaTipo   : TTpPessoa;
    ObjPessoaCtrl : TPessoaCtrl;
    ObjPessoaEnderecoCtrl : TPessoaEnderecoCtrl;
    Procedure GetEstruturaTabela;
    Procedure DefineField;
  Protected
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Function DeleteReg : Boolean; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
    Procedure Limpar; OverRide;
    procedure OpenFileImport; OverRide;
    Procedure ProcessarFileImport; OverRide;
  public
    { Public declarations }
//    OrdPessoaTipo : Integer;
    Function GetListaPessoa(pIdPessoa : Integer = 0; pCodPessoaERP : Integer = 0; pRazao : String = ''; pFantasia : String = '') : Boolean;
  end;

var
  FrmPessoa: TFrmPessoa;

implementation

{$R *.dfm}

uses uFuncoes, uFrmeXactWMS, uCepAbertoClass, RotaCtrl, Views.Pequisa.Rotas,
  Views.Pequisa.Pessoas;

procedure TFrmPessoa.BtnPesqCepClick(Sender: TObject);
Var ObjCep : TCepAberto;
begin
  inherited;
  BtnPesqCep.Enabled := False;
  if (EdtCep.Text<>'') and (Not EdtCep.ReadOnly) then Begin
     If (Length(EdtCep.Text)<>8) then
        raise Exception.Create('C.E.P. inválido');
   //     ObjCep := TCepAberto.Create;
     Try
       ObjCep := ObjCep.GetCepAberto(EdtCep.Text);
       EdtCep.ReadOnly := False;
       if ObjCep.Logradouro <> '' then Begin
         EdtEndereco.Text  := ObjCep.Logradouro;
         EdtComplEnde.Text := ObjCep.Complemento;
         EdtBairro.Text    := ObjCep.Bairro;
         EdtCidade.Text    := ObjCep.Cidade;
         EdtCodIbge.Text   := ObjCep.Ibge;
         CbUf.ItemIndex    := CbUf.Items.IndexOf(ObjCep.Estado);
         CbUfChange(CbUf);
       End;
       ObjCep := Nil;
     Except
       If Assigned(ObjCep) Then
          ObjCep := Nil;
     End;
  End;
  BtnPesqCep.Enabled := True;
end;

procedure TFrmPessoa.BtnPesqRotaClick(Sender: TObject);
begin
  if EdtRotaId.ReadOnly then Exit;
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

procedure TFrmPessoa.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  if Not BtnCancelar.Enabled then
     EdtRazao.ReadOnly := True;
end;

procedure TFrmPessoa.BtnEditarClick(Sender: TObject);
begin
  inherited;
  If pPessoaTipo in [Cliente, Fornecedor] then Begin
     EdtCnpjCpf.SetFocus;
     EdtRazao.ReadOnly := True;
     EdtRazao.TabStop  := False;
     EdtFantasia.ReadOnly := True;
     EdtFantasia.TabStop  := False;
     EdtCnpjCpf.SetFocus;
  End
  Else Begin
     EdtRazao.ReadOnly := False;
     EdtRazao.TabStop  := True;
     EdtFantasia.ReadOnly := False;
     EdtFantasia.TabStop  := True;
     EdtRazao.SetFocus;
  End;
  EdtId.Enabled        := False;
  edtCodigoErp.Enabled := False;
end;

procedure TFrmPessoa.BtnExcluirClick(Sender: TObject);
begin
  if pPessoaTipo in [Cliente, Fornecedor] then //Ord(pPessoaTipo) < 3 and Ord(pPessoaTipo) then
     raise Exception.Create('Operação não permitida!');
  inherited;
end;

procedure TFrmPessoa.BtnImportarStandClick(Sender: TObject);
begin
   if EdtCodigoERP.ReadOnly = True then Exit;
  inherited;
end;

procedure TFrmPessoa.BtnIncluirClick(Sender: TObject);
begin
  if ((pPessoaTipo = Cliente) and (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadClienteIncluir = 0)) or
     ((pPessoaTipo = Fornecedor) and (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadFornecedorIncluir = 0)) then
     raise Exception.Create('Operação não permitida!');
  inherited;
  If Not (pPessoaTipo in [Cliente, Fornecedor]) then Begin
     EdtRazao.ReadOnly := False;
     EdtRazao.TabStop  := True;
     EdtRazao.SetFocus;
  End;
  EdtId.Enabled        := False;
  edtCodigoErp.Enabled := False;
end;

procedure TFrmPessoa.BtnSalvarClick(Sender: TObject);
begin
  if (EdtCep.Text<>'') and (Length(EdtCep.Text)<>8) then
     raise Exception.Create('C.E.P. inválido!');
  if (EdtCep.Text<>'') and (EdtEndereco.Text='') then
     raise Exception.Create('Informe o endereço!');
  if (EdtCep.Text<>'') and (EdtEndereco.Text<>'') and (EdtCidade.Text = '') then
     raise Exception.Create('Informe o município referente ao endereço.');
  inherited;
  if Not BtnSalvar.Enabled then
     EdtRazao.ReadOnly := True;
end;

procedure TFrmPessoa.BtnTransportadoraPesqClick(Sender: TObject);
begin
  if EdtTransportadoraid.ReadOnly then Exit;
  inherited;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 3;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtTransportadoraid.Text := FrmPesquisaPessoas.Tag.ToString();
       EdtTransportadoraidExit(EdtTransportadoraid);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmPessoa.CbCampoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex in [0, 1] then
     SoNumeros(Key);
end;

procedure TFrmPessoa.CbUfChange(Sender: TObject);
begin
  inherited;
  If CbUf.Text <> '' then EdtEstado.Text := UfNome(CbUf.Text);
end;

procedure TFrmPessoa.CbUfCobChange(Sender: TObject);
begin
  inherited;
  If CbUfCob.Text <> '' then EdtEstadoCob.Text := UfNome(CbUfCob.Text);
end;

procedure TFrmPessoa.ConsGeralCellClick(Column: TColumn);
begin
  If (Not FdMemPesqGeral.IsEmpty) then With ObjPessoaCtrl.ObjPessoa do Begin
     PessoaId  := FdMemPesqGeral.FieldByName('PessoaId').AsInteger;
     CodPessoa := FdMemPesqGeral.FieldByName('CodPessoa').AsInteger;
     Razao     := FdMemPesqGeral.FieldByName('Razao').AsString;
     Fantasia  := FdMemPesqGeral.FieldByName('Fantasia').AsString;
     PessoaTipo.PessoaTipoId := FdMemPesqGeral.FieldByName('PessoaTipoID').AsInteger-1;
     CnpjCpf   := FdMemPesqGeral.FieldByName('CnpjCpf').AsString;
     Email     := FdMemPesqGeral.FieldByName('Email').AsString;
     HomePage  := FdMemPesqGeral.FieldByName('HomePage').AsString;
     Status    := FdMemPesqGeral.FieldByName('Status').AsInteger;
  End;
  inherited;
end;

procedure TFrmPessoa.DefineField;
begin
  If FdMemImportaCSV.Active then Begin
     FdMemImportaCSV.FieldDefs.Clear;
     FdMemImportaCSV.Close;
  End;
  with FdMemImportaCSV.FieldDefs do begin
    Add('CodigoERP', ftInteger, 0,False);
    Add('Razao', ftString, 100, False);
    Add('Fantasia', ftString, 100, False);
    Add('Fone', ftString, 11, False);
    Add('CpfCnpj', ftString, 14, False);
    Add('Email', ftString, 100, False);
    Add('HomePage', ftString, 100, False);
    Add('Status', ftInteger, 0, False);
    FdMemImportaCSV.CreateDataSet;
    FdMemImportaCSV.Open;
  end;
end;

function TFrmPessoa.DeleteReg: Boolean;
begin
  Result := ObjPessoaCtrl.DelPessoa(StrToIntDef(EdtID.Text, 0), Ord(pPessoaTipo));
end;

procedure TFrmPessoa.EdtCepCobExit(Sender: TObject);
begin
  inherited;
  if (EdtCepCob.Text<>'') and (Length(EdtCepCob.Text)<>8) and (Not EdtCepCob.ReadOnly) then
     raise Exception.Create('C.E.P. inválido');
  ExitFocus(Sender);
end;

procedure TFrmPessoa.EdtCepCobKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPessoa.EdtCepExit(Sender: TObject);
Begin
  ExitFocus(Sender);
end;

procedure TFrmPessoa.EdtCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPessoa.EdtCNPJCPFExit(Sender: TObject);
begin
  inherited;
  if (Sender=EdtCnpjCPf) and (Not EdtCnpjCpf.ReadOnly) and (EdtCnpjCpf.Text<>'')then Begin
     if (length(EdtCnpjCpf.Text) = 14) and (Not ValidarCNPJ(EdtCnpjCpf.Text)) then
        raise Exception.Create('C.N.P.J. inválido')
     Else if (length(EdtCnpjCpf.Text) = 11) and (Not ValidarCPF(EdtCnpjCpf.Text)) then
        raise Exception.Create('C.P.F. inválido')
     Else if Not (length(EdtCnpjCpf.Text) in [11, 14]) then
        Raise Exception.Create('Documento CNPJ/CPF inválido');
  End;
  ExitFocus(Sender);
end;

procedure TFrmPessoa.EdtCodIbgeCobKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPessoa.edtCodigoErpExit(Sender: TObject);
begin
  if (EdtCodigoERP.Text<>'')  and (StrToIntDef(EdtCodigoERP.Text,0)<=0) then Begin
     EdtCodigoERP.SetFocus;
     ShowErro('Código('+EdtCodigoERP.Text+') inválido!');
     EdtCodigoERP.Clear;
     Exit;
  End;
  inherited;
  if (Not EdtID.ReadOnly) and (EdtCodigoERP.Text<>'')  and (StrToIntDef(EdtCodigoERP.Text,0)<>ObjPessoaCtrl.ObjPessoa.CodPessoa)then Begin
     if StrToIntDef(EdtCodigoERP.Text, 0) <= 0 then
        raise Exception.Create('Código ERP inválido para pesquisa!');
     Limpar;
     If (EdtRazao.Text='') Then
        If (ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtCodigoERP.Text, 0), '', '', Ord(pPessoaTipo), 1).Count > 0) then Begin
           ShowDados
        End
        Else Begin
           EdtCodigoERP.Clear;
           EdtCodigoERP.SetFocus;
        End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmPessoa.EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (CbCampoPesq.ItemIndex = 1) and (pPessoaTipo in [Cliente, Fornecedor]) then
     SoNumeros(Key);
end;

procedure TFrmPessoa.EdtFoneKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPessoa.EdtHomePageEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmPessoa.EdtHomePageExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmPessoa.EdtIDChange(Sender: TObject);
begin
  inherited;
  if (Not EdtID.ReadOnly) and ((StrToIntDef(EdtId.Text, 0) <> ObjPessoaCtrl.ObjPessoa.PessoaId) or
     (StrToIntDef(EdtCodigoERP.Text, 0)<>ObjPessoaCtrl.ObjPessoa.CodPessoa)) then Begin
     if (Sender = EdtId) and (EdtCodigoERP.Text<>'') then
        EdtCodigoERP.Clear
     Else if (Sender=EdtCodigoERP) and (EdtId.Text<>'') then
        EdtId.Clear;
     Limpar;
  End;
end;

procedure TFrmPessoa.EdtIDExit(Sender: TObject);
begin
  inherited;
  if (Not EdtID.ReadOnly) and (EdtId.Text<>'') then Begin
     if StrToInt64Def(EdtID.Text, 0) = 0 then
        raise Exception.Create('Id inválido para pesquisa!');
     If (StrToInt64Def(EdtID.Text, 0)<>ObjPessoaCtrl.ObjPessoa.PessoaId) then Begin
        Limpar;
        if StrToIntDef(EdtId.Text, 0) <= 0 then
           raise Exception.Create('Id inválido para pesquisa!');
        If (EdtRazao.Text = '') Then
           if (ObjPessoaCtrl.FindPessoa(StrToIntDef(EdtID.Text, 0), 0, '', '', Ord(pPessoaTipo), 1).Count > 0) then
              ShowDados
           else Begin
             EdtId.Clear;
             EdtId.SetFocus;
           End;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmPessoa.EdtIDKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPessoa.EdtNumEndeCobKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPessoa.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl : TRotaCtrl;
begin
  inherited;
  if (Not EdtRotaId.ReadOnly) or (EdtRotaId.Text<>'') then Begin
     LblRota.Caption := '';
     if (StrToIntDef(EdtRotaId.Text, 0) > 0) then Begin
        ObjRotaCtrl := TRotaCtrl.Create;
        LblRota.Caption := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.Text, 0), '', 1)[0].ObjRota.Descricao;
        ObjRotaCtrl := Nil;
     End;
  End
end;

procedure TFrmPessoa.EdtTransportadoraidExit(Sender: TObject);
Var ObjTransportadoraCtrl : TPessoaCtrl;
    RetornoJsonArray      : TJsonArray;
    vErro                 : String;
begin
  inherited;
  if (Not EdtTransportadoraid.ReadOnly) or (StrToIntDef(EdtTransportadoraid.Text, 0)<>0) Then Begin
     LblTransportadora.Caption := '';
     If (EdtTransportadoraId.Text<>'') then Begin
        ObjTransportadoraCtrl := TPessoaCtrl.Create;
        RetornoJsonArray := ObjTransportadoraCtrl.FindPessoa(StrToIntDef(EdtTransportadoraId.Text, 0), 0, '', '', 3, 1);
        if RetornoJsonArray.Items[0].TryGetValue<String>('Erro', vErro) then Begin
           ShowErro(vErro);
           EdtTransportadoraId.SetFocus;
        End
        Else begin
          LblTransportadora.Caption := RetornoJsonArray.Items[0].GetValue<String>('razao');
        End;
        ObjTransportadoraCtrl.Free;
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPessoa := Nil;
  FrmPessoa.DisposeOf;
end;

procedure TFrmPessoa.FormCreate(Sender: TObject);
Var I : Integer;
begin
  inherited;
  case Ord(FrmeXactWMS.TpPessoa) of
     1: pPessoaTipo := Cliente;
     2: Begin
        pPessoaTipo := Fornecedor;
     End;
     3: pPessoaTipo := Transportadora;
     4: pPessoaTipo := Motorista;
  end;
  LblShelfLife.Visible      := pPessoaTipo = Fornecedor;
  EdtShelfLife.Visible      := pPessoaTipo = Fornecedor;
  LblShelfLifeMeses.Visible := pPessoaTipo = Fornecedor;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  PgcEndereco.ActivePageIndex := 0;
  TbEndCobranca.TabVisible := False;
  With LstCadastro do Begin
    ColWidths[0] := 70;
    ColWidths[1] := 90;
    ColWidths[2] := 320;
    ColWidths[3] := 320;
    ColWidths[4] := 160;
    ColWidths[5] := 200;
    ColWidths[6] := 200;
    ColWidths[7] := 60;
  End;
  //GetListaPessoa ;
  GetEstruturaTabela;
end;

procedure TFrmPessoa.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ObjPessoaCtrl);
end;

procedure TFrmPessoa.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F2 then Begin BtnIncluirClick(BtnIncluir); Exit; End;
  if Key = Vk_F4 then Begin BtnExcluirClick(BtnExcluir); Exit; End;
  inherited;

end;

procedure TFrmPessoa.GetEstruturaTabela;
Var JsonArrayEstrutura : TJsonArray;
    xCol    : Integer;
    vColuna : String;
begin
  JsonArrayEstrutura := ObjPessoaCtrl.GetEstrutura;
  For xCol := 0 to Pred(JsonArrayEstrutura.Count) do Begin
    vColuna := JsonArrayEstrutura.Get(xCol).GetValue<String>('coluna');
    if vColuna = 'razao' then EdtRazao.MaxLength := JsonArrayEstrutura.Get(xCol).GetValue<Integer>('tamanho')
    Else if vColuna = 'fantasia' then EdtFantasia.MaxLength := JsonArrayEstrutura.Get(xCol).GetValue<Integer>('tamanho')
    Else if vColuna = 'fone' then EdtFone.MaxLength := JsonArrayEstrutura.Get(xCol).GetValue<Integer>('tamanho')
    Else if vColuna = 'cnpjcpf' then EdtCNPJCPF.MaxLength := JsonArrayEstrutura.Get(xCol).GetValue<Integer>('tamanho')
    Else if vColuna = 'email' then EdtEmail.MaxLength := JsonArrayEstrutura.Get(xCol).GetValue<Integer>('tamanho')
    Else if vColuna = 'homepage' then EdtHomePage.MaxLength := JsonArrayEstrutura.Get(xCol).GetValue<Integer>('tamanho')
  End;
end;

procedure TFrmPessoa.GetListaLstCadastro;
begin
  inherited;
  GetListaPessoa;
end;

Function TFrmPessoa.GetListaPessoa(pIdPessoa : Integer = 0; pCodPessoaERP : Integer = 0; pRazao : String = ''; pFantasia : String= '') : Boolean;
Var ArrayListPessoa : tJsonArray;
    jSonObj         : tJsonObject;
    I, xLista       : Integer;
begin
  ArrayListPessoa := ObjPessoaCtrl.FindPessoa(pIdPessoa, pCodPessoaERP, pRazao, pFantasia, Ord(pPessoaTipo), 0);
  Result := ArrayListPessoa.Count >= 1;
  If ArrayListPessoa.Count >= 1 then Begin
     LstCadastro.RowCount := ArrayListPessoa.Count+1;
     for i := 1 to LstCadastro.RowCount - 1 do
       LstCadastro.AddDataImage(7,i,0,haCenter,vaTop);
     For xLista := 0 To ArrayListPessoa.Count-1 do begin
       jSonObj := tJsonObject.Create;
       jSonObj := ArrayListPessoa.Items[xLista] as TJSONObject;
       LstCadastro.Cells[0, xLista+1] := GetValueInjSon(jSonObj, 'pessoaid');
       LstCadastro.Cells[1, xLista+1] := GetValueInjSon(jSonObj, 'codpessoaerp');
       LstCadastro.Cells[2, xLista+1] := GetValueInjSon(jSonObj, 'razao');
       LstCadastro.Cells[3, xLista+1] := GetValueInjSon(jSonObj, 'fantasia');
       LstCadastro.Cells[4, xLista+1] := GetValueInjSon(jSonObj, 'cnpjcpf');
       LstCadastro.Cells[5, xLista+1] := GetValueInjSon(jSonObj, 'email');
       LstCadastro.Cells[6, xLista+1] := GetValueInjSon(jSonObj, 'homepage');
       LstCadastro.Cells[7, xLista+1] := JsonObj.GetValue<Integer>('status').ToString();
       jSonObj := Nil;
       jSonObj.DisposeOf;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[1, xLista+1] := taRightJustify;
     end;
     LstCadastro.FixedRows := 1;
     LstCadastro.SortSettings.Column := 2;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 2;
//     MontarPaginacao(ObjPessoaCtrl.MontarPaginacao(OrdPessoaTipo));
  End;
end;

procedure TFrmPessoa.Limpar;
begin
  EnabledButtons       := False;
  EdtId.Enabled        := True;
  edtCodigoErp.Enabled := True;
  if Not (EdtId.Enabled) then Begin
     //EdtCodigoERP.Clear;
     //EdtId.Clear;
  End;
  If Assigned(ObjPessoaCtrl) then ObjPessoaCtrl.ObjPessoa.Limpar;
  CbTipoPessoa.ItemIndex := -1;
  EdtRazao.Clear;
  EdtRazao.ReadOnly := True;
  EdtFantasia.Clear;
  EdtCNPJCPF.Clear;
  EdtFone.Clear;
  EdtEmail.Clear;
  EdtHomePage.Clear;
  ChkCadastro.Checked := False;
  EdtRotaId.Clear;
  LblRota.Caption := '';
  EdtCep.Clear;
  EdtEndereco.Clear;
  EdtNumEndereco.Clear;
  EdtComplEnde.Clear;
  EdtPontoReferencia.Clear;
  EdtBairro.Clear;
  EdtCidade.Clear;
  CbUf.ItemIndex := -1;
  EdtEstado.Clear;
  EdtCodIbge.Clear;
  CbTpFone1.ItemIndex := -1;
  EdtFone1.Clear;
  EdtContato1.Clear;
  EdtObs1.Clear;
  CbTpFone2.ItemIndex := -1;
  EdtFone2.Clear;
  EdtContato2.Clear;
  EdtObs2.Clear;
  CbTpFone3.ItemIndex := -1;
  EdtFone3.Clear;
  EdtContato3.Clear;
  EdtObs3.Clear;
end;

procedure TFrmPessoa.LstCadastroGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
Var I : Integer;
begin
//  inherited;
  if not Assigned(AEditLink) then
    Exit;
  If aCol = 5 then begin
     with (aEditLink.GetEditControl as TImagePicker) do begin
       BeginUpdate;
       Items.Clear;
       for i := 0 to 1 do
         Items.Add.ImageIndex := i;
       EndUpdate;
     end;
 end;
end;

procedure TFrmPessoa.LstCadastroGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
//  inherited;
  if acol<7 then LstCadastro.EditLink:=el1
  Else if acol=7 then LstCadastro.EditLink:=el6;
  if acol in [2,3,4,5,6,7] then aEditor:=edCustom;
end;

procedure TFrmPessoa.OpenFileImport;
var ArquivoCSV: TextFile;
    Linha : String;
    I : Integer;
    vLaboratorioId : Integer;
    vLaboratorio, vErro : String;
    JsonArrayProduto, JsonArrayEndereco : TJsonArray;
  Function MontaValor: String;
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
      //vCdProduto := MontaValor;
      FdMemImportaCSV.Append;
      FdMemImportaCSV.FieldByName('CodigoERP').AsInteger := StrToInt64(MontaValor);
      FdMemImportaCSV.FieldByName('Razao').AsString      := MontaValor;
      FdMemImportaCSV.FieldByName('Fantasia').AsString   := MontaValor;
      FdMemImportaCSV.FieldByName('fone').AsString       := StringReplace(StringReplace(StringReplace(StringReplace(MontaValor, '(', '', [rfReplaceAll]),
                                                            ')', '', [rfReplaceAll]), ' ', '', [rfReplaceAll]), '-', '', [rfReplaceAll]);
      FdMemImportaCSV.FieldByName('CpfCnpj').AsString    := StringReplace(StringReplace(StringReplace(MontaValor,'.', '',[rfReplaceAll]),
                                                            '/', '', [rfReplaceAll]), '-', '', [rfReplaceAll]);
      FdMemImportaCSV.FieldByName('Email').AsString      := MontaValor;
      FdMemImportaCSV.FieldByName('HomePage').AsString   := MontaValor;
      FdMemImportaCSV.FieldByName('Status').AsInteger    := 1;
      LblImportaCSV.Caption := 'Importando: '+FdMemImportaCSV.FieldByName('CodigoERP').AsString;
      Application.ProcessMessages;
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemImportaCSV.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0',FdMemImportaCSV.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmPessoa.PesquisarClickInLstCadastro(aCol, aRow : Integer);
begin
  inherited;
  EdtId.Clear;
  EdtCodigoERP.Clear;
  Limpar;
  EdtID.Text := LstCadastro.Cells[aCol, aRow];
  EdtIDExit(EdtID);
  PgcBase.ActivePage := TabPrincipal;
end;

function TFrmPessoa.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex in [0, 1] then Begin //0 Id 1-Criar no server consulta por Cod.ERP
        If StrToInt64Def(EdtConteudoPesq.Text,0) = 0 then raise Exception.Create('Conteúdo para pesquisa inválido! Tente novamente.');
        if CbCampoPesq.ItemIndex = 0 then
           Result := GetListaPessoa(StrToInt64Def(EdtConteudoPesq.Text,0), 0)
        Else Result := GetListaPessoa(0, StrToInt64Def(EdtConteudoPesq.Text,0));
     End
     Else if CbCampoPesq.ItemIndex = 2 then //Razao Social
        Result := GetListaPessoa(0, 0, EdtConteudoPesq.Text)
     Else if CbCampoPesq.ItemIndex = 3 then //Fantasia
        Result := GetListaPessoa(0, 0, '', EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
  //if Result = False then
  //   raise Exception.Create('Não econtrei dados da pesquisa!');
end;

procedure TFrmPessoa.ProcessarFileImport;
Var RetJsonArray : TJsonArray;
    vErro :String;
    vProblema : Boolean;
begin
  inherited;
  if (Not FdMemImportaCSV.Active) or (FdMemImportaCSV.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemImportaCSV.RecordCount;
  PbImportaFile.Position := 0;
  vProblema := False;
  FdMemImportaCSV.First;
  While Not FdMemImportaCSV.Eof Do Begin
    With ObjPessoaCtrl.ObjPessoa do Begin
      PessoaId  := 0;
      CodPessoa := FdMemImportaCSV.FieldByName('CodigoERP').AsInteger;
      Razao     := FdMemImportaCSV.FieldByName('Razao').AsString;
      Fantasia  := FdMemImportaCSV.FieldByName('Fantasia').AsString;
      PessoaTipo.PessoaTipoId := Ord(pPessoaTipo); //Pegar o ID do Objeto PessoaTipo
      If (FdMemImportaCSV.FieldByName('CpfCnpj').AsString <> '') Or
          (Not (length(FdMemImportaCSV.FieldByName('CpfCnpj').AsString) in [11, 14])) or
          (Not ValidarCNPJ(FdMemImportaCSV.FieldByName('CpfCnpj').AsString)) then
         CnpjCpf   := ''
      Else
         CnpjCpf   := FdMemImportaCSV.FieldByName('CpfCnpj').AsString;
      Fone      := FdMemImportaCSV.FieldByName('Fone').AsString;
      Email     :=FdMemImportaCSV.FieldByName('Email').AsString;
      HomePage  := FdMemImportaCSV.FieldByName('HomePage').AsString;
      RotaId    := 0;
      TransportadoraId := 0;
      ShelfLife := 12;
      Status    := FdMemImportaCSV.FieldByName('Status').AsInteger;
   End;
   If ObjPessoaCtrl.Salvar(Ord(pPessoaTipo)) < 0 then Begin
       MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodigoERP').AsString+' - '+FdMemImportaCSV.FieldByName('Fantasia').AsString);
       vProblema := True;
    End;
    PbImportaFile.Position := PbImportaFile.Position + 1;
    Application.ProcessMessages;
    FdMemImportaCSV.Next;
  End;
  if Not vProblema then
     ShowMessage('Importação concluída...')
  Else ShowMessage('Importação concluída com erros...');
end;

function TFrmPessoa.SalvarReg: Boolean;
Var Obj1PessoaEnderecoCtrl : TPessoaEnderecoCtrl;
    ObjPessoaTelefoneCtrl : TPessoaTelefoneCtrl;
begin
  EdtRotaIdExit(EdtRotaid);
  With ObjPessoaCtrl.ObjPessoa do Begin
    PessoaId  := StrToIntDef(EdtID.Text, 0);
    CodPessoa := StrToIntDef(EdtCodigoERP.Text, 0);
    Razao     := EdtRazao.Text;
    Fantasia  := EdtFantasia.Text;
    PessoaTipo.PessoaTipoId := Ord(pPessoaTipo); //Pegar o ID do Objeto PessoaTipo
    CnpjCpf   := EdtCnpjCpf.Text;
    Fone      := EdtFone.Text;
    Email     := EdtEmail.Text;
    HomePage  := EdtHomePage.Text;
    RotaId    := StrToIntDef(EdtRotaId.Text, 0);
    TransportadoraId := StrToIntDef(EdtTransportadoraId.Text, 0);
    ShelfLife := StrToIntDef(EdtShelfLife.Text, 0);
    Status           := Ord(ChkCadastro.Checked);
  End;
  ObjPessoaCtrl.ObjPessoa.PessoaId := ObjPessoaCtrl.Salvar(Ord(pPessoaTipo));
  Result := ObjPessoaCtrl.ObjPessoa.PessoaId > 0;
  if Result then Begin
     ObjPessoaEnderecoCtrl := TPessoaEnderecoCtrl.Create;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Id := 0;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Pessoaid     := ObjPessoaCtrl.ObjPessoa.PessoaId;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.EnderecoTipo.EnderecoTipoId := 2;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.EnderecoTipo.Descricao := 'Principal';
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Endereco     := EdtEndereco.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Numero       := EdtNumEndereco.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Complemento  := EdtComplEnde.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Referencia   := EdtPontoReferencia.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Bairro       := EdtBairro.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Municipio    := EdtCidade.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Uf           := CbUf.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Cep          := EdtCep.Text;
     ObjPessoaEnderecoCtrl.ObjPessoaEndereco.CodIbge      := EdtCodIbge.Text;
     if ObjPessoaEnderecoCtrl.ObjPessoaEndereco.Endereco <> '' then
        ObjPessoaEnderecoCtrl.Salvar;
     ObjPessoaEnderecoCtrl.DisposeOf;

     ObjPessoaTelefoneCtrl := TPessoaTelefoneCtrl.Create();
     if EdtFone1.Text <> '' then Begin
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.IndFone  := 1;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.PessoaId := ObjPessoaCtrl.ObjPessoa.PessoaId;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Tipo     := CbTpFone1.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Telefone := EdtFone1.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.CodPais  := '55';
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Contato := EdtContato1.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Observacao := EdtObs1.Text;
        ObjPessoaTelefoneCtrl.Salvar;
     End
     Else Begin
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.IndFone  := 1;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.PessoaId := ObjPessoaCtrl.ObjPessoa.PessoaId;
        ObjPessoaTelefoneCtrl.DelPessoaTelefone;
     End;
     if EdtFone2.Text <> '' then Begin
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.IndFone  := 2;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.PessoaId := ObjPessoaCtrl.ObjPessoa.PessoaId;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Tipo     := CbTpFone2.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Telefone := EdtFone2.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.CodPais  := '55';
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Contato := EdtContato2.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Observacao := EdtObs2.Text;
        ObjPessoaTelefoneCtrl.Salvar;
     End
     Else Begin
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.IndFone  := 2;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.PessoaId := ObjPessoaCtrl.ObjPessoa.PessoaId;
        ObjPessoaTelefoneCtrl.DelPessoaTelefone;
     End;
     if EdtFone3.Text <> '' then Begin
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.IndFone  := 3;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.PessoaId := ObjPessoaCtrl.ObjPessoa.PessoaId;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Tipo     := CbTpFone3.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Telefone := EdtFone3.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.CodPais  := '55';
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Contato := EdtContato3.Text;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.Observacao := EdtObs3.Text;
        ObjPessoaTelefoneCtrl.Salvar;
     End
     Else Begin
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.IndFone  := 3;
        ObjPessoaTelefoneCtrl.ObjPessoaTelefone.PessoaId := ObjPessoaCtrl.ObjPessoa.PessoaId;
        ObjPessoaTelefoneCtrl.DelPessoaTelefone;
     End;
     ObjPessoaTelefoneCtrl := Nil;
  End;
  ObjPessoaCtrl.ObjPessoa.PessoaId := 0;
end;

procedure TFrmPessoa.ShowDados;
Var ObjPessoaEnderecoCtrl : TPessoaEnderecoCtrl;
    ObjPessoaTelefoneCtrl : TPessoaTelefoneCtrl;
    LstPessoaEnderecoCtrl : TObjectList<TPessoaEnderecoCtrl>;
    LstPessoaTelefoneCtrl : TObjectList<TPessoaTelefoneCtrl>;
    xEnd : Integer;
begin
  inherited;
  With ObjPessoaCtrl.ObjPessoa do Begin
    EdtID.Text        := PessoaId.ToString();
    EdtCodigoERP.Text := CodPessoa.ToString();
    EdtRazao.Text     := Razao;
    EdtFantasia.Text  := Fantasia;
    CbTipoPessoa.ItemIndex := PessoaTipo.PessoaTipoId;
    EdtFone.Text      := Fone;
    EdtCnpjCpf.Text   := CnpjCpf;
    EdtEmail.Text     := Email;
    EdtHomePage.Text  := HomePage;
    EdtRotaId.Text    := RotaId.ToString();
    EdtRotaId.ReadOnly := False;
    EdtRotaIdExit(EdtRotaId);
    EdtRotaId.ReadOnly := True;
    EdtTransportadoraId.Text := TransportadoraId.ToString();
    EdtTransportadoraidExit(EdtTransportadoraid);
    EdtShelfLife.Text := ShelfLife.ToString;
    ChkCadastro.Checked := Status = 1;
  End;
  ObjPessoaEnderecoCtrl := TPessoaEnderecoCtrl.Create;
  LstPessoaEnderecoCtrl := ObjPessoaenderecoCtrl.GetPessoaEndereco(0, ObjPessoaCtrl.ObjPessoa.PessoaId, 0);
  For xEnd := 0 to Pred(LstPessoaEnderecoCtrl.Count) do Begin
    If UpperCase(LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.EnderecoTipo.Descricao) = 'PRINCIPAL' then Begin
       EdtCep.Text := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.cep;
       EdtEndereco.Text    := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Endereco;
       EdtNumEndereco.Text := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Numero;
       EdtComplEnde.Text   := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Complemento;
       EdtPontoReferencia.Text := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Referencia;
       EdtBairro.Text      := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Bairro;
       EdtCidade.Text      := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Municipio;
       CbUf.ItemIndex      := CbUf.Items.IndexOf(LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.UF);
       CbUfChange(CbUf);
       EdtCodIbge.Text     := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.CodIbge;
    End
    Else If LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Id = 1 then Begin
       EdtCepCob.Text         := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.cep;
       EdtEnderecoCob.Text    := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Endereco;
       EdtNumEndeCob.Text     := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Numero;
       EdtComplEndeCob.Text   := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Complemento;
       EdtPontoReferenciaCob.Text := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Referencia;
       EdtBairroCob.Text      := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Bairro;
       EdtCidadeCob.Text      := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.Municipio;
       CbUfCob.ItemIndex      := CbUf.Items.IndexOf(LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.UF);
       CbUfCobChange(CbUfCob);
       EdtCodIbgeCob.Text     := LstPessoaEnderecoCtrl[0].ObjPessoaEndereco.CodIbge;
    End;
  End;
  ObjPessoaTelefoneCtrl := TPessoaTelefoneCtrl.Create;
  LstPessoaTelefoneCtrl := ObjPessoaTelefoneCtrl.GetPessoaTelefone(0, ObjPessoaCtrl.ObjPessoa.PessoaId, 0);
  For xEnd := 0 to Pred(LstPessoaTelefoneCtrl.Count) do Begin
    if LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.IndFone = 1 then Begin
       CbTpFone1.ItemIndex := CbTpFone1.Items.IndexOf(LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Tipo);
       Edtfone1.Text       := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Telefone;
       EdtContato1.Text    := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Contato;
       EdtObs1.Text        := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Observacao;
    End
    Else if LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.IndFone = 2 then Begin
       CbTpFone2.ItemIndex := CbTpFone1.Items.IndexOf(LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Tipo);
       Edtfone2.Text       := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Telefone;
       EdtContato2.Text    := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Contato;
       EdtObs2.Text        := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Observacao;
    End
    Else if LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.IndFone = 3 then Begin
       CbTpFone3.ItemIndex := CbTpFone1.Items.IndexOf(LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Tipo);
       Edtfone3.Text       := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Telefone;
       EdtContato3.Text    := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Contato;
       EdtObs3.Text        := LstPessoaTelefoneCtrl[xEnd].ObjPessoaTelefone.Observacao;
    End;
  End;
  ObjPessoaEnderecoCtrl := Nil;
  ObjPessoaTelefoneCtrl := Nil;
  If pPessoaTipo in [Cliente, Fornecedor] then
     EdtFantasia.SetFocus
  Else EdtRazao.SetFocus;
end;

end.
