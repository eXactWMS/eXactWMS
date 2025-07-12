unit uFrmuEvolut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CategoryButtons, Vcl.WinXCtrls,
  acPNG, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList, RpRender, RpRenderPDF, RpBase,
  RpSystem, RpDefine, RpRave, uLoggerSingleton, IniFiles, System.JSON, REST.Json, System.JSON.Types
  , ConfiguracaoCtrl
  , UsuarioCtrl
  , uFrmPessoa, Vcl.AppEvnts, View.WebCharts, Vcl.OleCtrls, SHDocVw, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFuncao = Class
    class procedure CreateForm<xForm: TForm>;
  End;

  TTpPessoa = (NotDefined, Cliente, Fornecedor, Transportadora, Motorista);

  TFrmuEvolut = class(TForm)
    rvpPrincipal: TRvProject;
    rvsPrincipal: TRvSystem;
    RvRenderPDF1: TRvRenderPDF;
    ActMenuSplit: TActionList;
    ActClientes: TAction;
    ActFornecedor: TAction;
    ActLaboratorio: TAction;
    ActRecebimento: TAction;
    ActProduto: TAction;
    ActDevolucao: TAction;
    ActMovimentacao: TAction;
    ActPedidoCubagem: TAction;
    ActSeparacao: TAction;
    ActCheckOut: TAction;
    ActExpedicao: TAction;
    ActReposicaoPicking: TAction;
    ActEnderecamento: TAction;
    ActRotas: TAction;
    ActSubRotas: TAction;
    ActTransportadora: TAction;
    ActMotorista: TAction;
    ActVeiculos: TAction;
    ActContrAcessoUsuario: TAction;
    ActTipoEntrada: TAction;
    ActMotivoDevolucao: TAction;
    ActTipoCaixa: TAction;
    ActMotivoInutCaixa: TAction;
    ActRelTAG: TAction;
    ActRelEnderecamento: TAction;
    ActDashEficienciaEntrada: TAction;
    ActDashSeparacao: TAction;
    ActConfiguracao: TAction;
    imlIcons: TImageList;
    TmHoraAtual: TTimer;
    PnlTopRhemaSys: TPanel;
    imgMenu: TImage;
    LblVersao: TLabel;
    LblUsuarioTop: TLabel;
    LblDateTime: TLabel;
    lblTitle: TLabel;
    ImgClose: TImage;
    MenuSplit: TSplitView;
    catMenuItems: TCategoryButtons;
    ActVolumeEmbalagem: TAction;
    ActRelPedidos: TAction;
    ActContrAcessoTopicos: TAction;
    ActContrAcessoFuncionalidades: TAction;
    ActContrAcessoPerfil: TAction;
    ApplicationEvents1: TApplicationEvents;
    ImgLogoProduct: TImage;
    ImgRhemasys: TImage;
    ActPatioAgendamento: TAction;
    ActRelPlanilhaCega: TAction;
    ActExpedicaoCargaMontar: TAction;
    ActExpedicaoCargaCarregar: TAction;
    ActRelReposicaoDemanda: TAction;
    ActRelRupturaAbastecimento: TAction;
    ActRelColetaPulmao: TAction;
    ActRelApanhePicking: TAction;
    ActRelAnaliseRessuprimento: TAction;
    WebBrowser1: TWebBrowser;
    WebCharts1: TWebCharts;
    FdMemDashBoard01: TFDMemTable;
    FdMemDashBoard01Label: TStringField;
    FdMemDashBoard01Value: TIntegerField;
    FdMemDashBoard01RGB: TStringField;
    FdMemDashBoard02: TFDMemTable;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    FdMemDashBoard03: TFDMemTable;
    StringField3: TStringField;
    IntegerField2: TIntegerField;
    StringField4: TStringField;
    FdMemDashBoard04: TFDMemTable;
    StringField5: TStringField;
    IntegerField3: TIntegerField;
    StringField6: TStringField;
    FdMemDashBoard05: TFDMemTable;
    StringField7: TStringField;
    IntegerField4: TIntegerField;
    StringField8: TStringField;
    FdMemDashBoard06: TFDMemTable;
    StringField9: TStringField;
    IntegerField5: TIntegerField;
    StringField10: TStringField;
    FdMemDashBoard07: TFDMemTable;
    StringField11: TStringField;
    IntegerField6: TIntegerField;
    StringField12: TStringField;
    FdMemDashBoard08: TFDMemTable;
    StringField13: TStringField;
    IntegerField7: TIntegerField;
    StringField14: TStringField;
    procedure ImgCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ActRecebimentoExecute(Sender: TObject);
    procedure ActFornecedorExecute(Sender: TObject);
    procedure ActProdutoExecute(Sender: TObject);
    procedure ActMovimentacaoExecute(Sender: TObject);
    procedure ActClientesExecute(Sender: TObject);
    procedure ActRelTAGExecute(Sender: TObject);
    procedure ActLaboratorioExecute(Sender: TObject);
    procedure ActConfiguracaoExecute(Sender: TObject);
    Procedure TrimAppMemorySize;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmHoraAtualTimer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgMenuClick(Sender: TObject);
    procedure ActContrAcessoUsuarioExecute(Sender: TObject);
    procedure ActPedidoCubagemExecute(Sender: TObject);
    procedure ActRotasExecute(Sender: TObject);
    procedure ActVolumeEmbalagemExecute(Sender: TObject);
    procedure ActRelEnderecamentoExecute(Sender: TObject);
    procedure ActRelPedidosExecute(Sender: TObject);
    procedure ActContrAcessoTopicosExecute(Sender: TObject);
    procedure ActContrAcessoFuncionalidadesExecute(Sender: TObject);
    procedure ActContrAcessoPerfilExecute(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure FormResize(Sender: TObject);
    procedure ActTransportadoraExecute(Sender: TObject);
    procedure ActVeiculosExecute(Sender: TObject);
    procedure ActMotoristaExecute(Sender: TObject);
    procedure ActSeparacaoExecute(Sender: TObject);
    procedure ActCheckOutExecute(Sender: TObject);
    procedure ActExpedicaoExecute(Sender: TObject);
    procedure ActRelPlanilhaCegaExecute(Sender: TObject);
    procedure ActExpedicaoCargaMontarExecute(Sender: TObject);
    procedure ActExpedicaoCargaCarregarExecute(Sender: TObject);
    procedure ActRelReposicaoDemandaExecute(Sender: TObject);
    procedure ActRelRupturaAbastecimentoExecute(Sender: TObject);
    procedure ActRelColetaPulmaoExecute(Sender: TObject);
    procedure ActRelApanhePickingExecute(Sender: TObject);
    procedure ActRelAnaliseRessuprimentoExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    NovaVersao : Boolean;
    AtzApp     : String;
    Atual      : String;
    Procedure AtualizarVersao;
    Procedure LogOn;
    Procedure LogEndApp;
    procedure Grafico01;
  public
    { Public declarations }
    TpPessoa : TTpPessoa;
    cancelado : Boolean;
    Tempo : Integer;
    ModuleOpcao, ModuleItem, PathApp : AnsiString;
    CodMenu    : String;
    ConfigWMS  : TConfiguracaoCtrl;
    //TpPessoa   : TTpPessoa;
    ObjUsuarioCtrl : TUsuarioCtrl;
    BASEURL : String;
    Function ConfirmaManutencao(vAcao : String) : Boolean;
    Procedure TrataErro(Sender :TObject; E:Exception);
    Function VerAcesso(CodMenu : String) : Boolean;
  end;

var
  FrmuEvolut: TFrmuEvolut;
//  FrmForn    : TFrmPessoa;

implementation

uses
  uFrmProduto, uFrmLogin,
  UFrmConfirmacao, uFrmLaboratorio, uFrmSair, uFrmControleArmazenagem,
  uFrmEntrada, uFrmConfiguracao, uFuncoes, uFrmUsuario, uFrmPedidoCubagem,
  uFrmRotas, uFrmVolumeEmbalagem, uFrmPrintTAG, uFrmSeparacaoDesktop,
  uFrmFREnderecamentos, uFrmRelPedidos, uFrmTopicos, FuncionalidadeClass,
  uFrmFuncionalidades, uFrmPerfil, uFrmFornecedor, uFrmTransportadora,
  uFrmVeiculo, uFrmMotorista, uFrmCheckOut, uFrmExpedicao, uFrmRelPlanilhaCega,
  uFrmCargaMontar, uDmuEvolut, uFrmCargaCarregar, uFrmRelReposicaoDemanda,
  uFrmRelRupturaAbastecimento, uFrmRelColetaPulmao, uFrmRelApanhePicking,
  uFrmRelAnaliseRessuprimento, Charts.Types, TypInfo
  , PedidoSaidaCtrl;

{$R *.dfm}

Function VersaoExe(Const FileName : String) : String;
Type
  TVersionInfo = Packed Record
    Dummy : Array[0..7] Of Byte;
    v2, v1, v3, v4 : Word;
  End;
Var Zero, Size : Cardinal;
    Data : Pointer;
    VersionInfo : ^TVersionInfo;
Begin
  Size := GetFileVersionInfoSize(Pointer(FileName), Zero);
  if Size = 0 then
     Result := ''
  Else Begin
     GetMem(Data, Size);
     Try
       GetFileVersionInfo(Pointer(FileName), 0, Size, Data);
       VerQueryValue(Data, '\', Pointer(VersionInfo), Size);
       Result := Format('%d.%d.%d.%d.', [VersionInfo.V1, VersionInfo.v2, VersionInfo.V3, VersionInfo.V4]);
     Finally
       FreeMem(Data);
     End;
  End;
End;

//Executa um Aplicativo
Function CreateProcessSimple(Cmd : String) : Boolean;
Var SUinfo : TStartUpInfo;
    ProcInfo : TProcessInformation;
begin
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  SUInfo.Cb      := SizeOf(SUInfo);
  SUInfo.dwFlags := STARTF_USESHOWWINDOW;
  SUInfo.wShowWIndow := SW_SHOWNORMAL;
  Result := CreateProcess(Nil,
                          pChar(Cmd),
                          Nil, Nil, False,
                          CREATE_NEW_CONSOLE or
                          NORMAL_PRIORITY_CLASS,
                          Nil, Nil, SUInfo,
                          ProcInfo);
  if Result then Begin
     CloseHandle(ProcInfo.hProcess);
     CloseHandle(ProcInfo.hThread);
  End;
End;

procedure TFrmuEvolut.ActCheckOutExecute(Sender: TObject);
begin
  if (Assigned(FrmCheckOut) = False) then
    begin
      FrmCheckOut := TFrmCheckOut.Create(Application);
    end;
  try
    FrmCheckOut.Module     := 'P.C.P. - Chão de Fábrica';
    FrmCheckOut.ModuleMenu := 'CheckOut - Conferência';
    FrmCheckOut.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCheckOut);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActClientesExecute(Sender: TObject);
begin
  TpPessoa   := Cliente;
  if (Assigned(FrmPessoa) = False) then
    begin
      FrmPessoa := TFrmPessoa.Create(Application);
    end;
  try
    FrmPessoa.Module     := 'Cadastro';
    FrmPessoa.ModuleMenu := 'Clientes - Lojas';
    FrmPessoa.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmPessoa);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActConfiguracaoExecute(Sender: TObject);
begin
  if (Assigned(FrmConfiguracao) = False) then
    begin
      FrmConfiguracao := TFrmConfiguracao.Create(Application);
    end;
  try
    FrmConfiguracao.Module     := 'Configuração';
    FrmConfiguracao.ModuleMenu := 'Parâmetros do WMS';
    FrmConfiguracao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmConfiguracao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActFornecedorExecute(Sender: TObject);
begin
  TpPessoa   := Fornecedor;
  if (Assigned(FrmFornecedor) = False) then Begin
     FrmFornecedor := TFrmFornecedor.Create(Application);
     End;
  try
    //FrmForn.ValidarAcesso;
    FrmFornecedor.Module     := 'Cadastro';
    FrmFornecedor.ModuleMenu := 'Fornecedor';
    FrmFornecedor.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmFornecedor);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActLaboratorioExecute(Sender: TObject);
begin
  if (Assigned(FrmLaboratorio) = False) then
    begin
      FrmLaboratorio := TFrmLaboratorio.Create(Application);
    end;
  try
    //FrmLaboratorios.ValidarAcesso;
    FrmLaboratorio.Module := 'Cadastro';
    FrmLaboratorio.ModuleMenu := 'Fabricantes';
    FrmLaboratorio.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmLaboratorio);
      raise Exception.Create(e.Message);
    end;
  end;
end;
{ TFuncao }

class procedure TFuncao.CreateForm<xForm>;
var
  Form: xForm;
begin
  Application.CreateForm(xForm,Form);
  try
    form.ShowModal;
  finally
    form.Release;
  end;
end;

procedure TFrmuEvolut.ActMotoristaExecute(Sender: TObject);
begin
  TpPessoa   := Motorista;
  if (Assigned(FrmMotorista) = False) then
     FrmMotorista := TFrmMotorista.Create(Application);
  try
    FrmMotorista.Module     := 'Logística';
    FrmMotorista.ModuleMenu := 'Motorista';
    FrmMotorista.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmMotorista);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActMovimentacaoExecute(Sender: TObject);
begin
  if (Assigned(FrmControleArmazenagem) = False) then
     FrmControleArmazenagem := TFrmControleArmazenagem.Create(Application);
  try
    FrmControleArmazenagem.Module     := 'P.C.P - Chão de Fábrica';
    FrmControleArmazenagem.ModuleMenu := 'Controle de Armazenamento';
    FrmControleArmazenagem.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmControleArmazenagem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActPedidoCubagemExecute(Sender: TObject);
begin
  if (Assigned(FrmPedidoCubagem) = False) then
    begin
      FrmPedidoCubagem := TFrmPedidoCubagem.Create(Application);
    end;
  try
    //frmProdutoCadastrar.ValidarAcesso;
    FrmPedidoCubagem.Module := 'Chão de Fábrica';
    FrmPedidoCubagem.ModuleMenu := 'Cubagem de Pedidos';
    FrmPedidoCubagem.Show;
    //FrmProduto.EdtCodProduto.SetFocus;
  except on e: Exception do
    begin
      FreeAndNil(FrmPedidoCubagem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActProdutoExecute(Sender: TObject);
begin
  if (Assigned(FrmProduto) = False) then
    begin
      FrmProduto := TFrmProduto.Create(Application);
    end;
  try
    //frmProdutoCadastrar.ValidarAcesso;
    FrmProduto.Module := 'Cadastro';
    FrmProduto.ModuleMenu := 'Produtos';
    FrmProduto.Show;
    //FrmProduto.EdtCodProduto.SetFocus;
  except on e: Exception do
    begin
      FreeAndNil(FrmProduto);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActRecebimentoExecute(Sender: TObject);
begin
  if (Assigned(FrmEntrada) = False) then
    begin
      FrmEntrada := TFrmEntrada.Create(Application);
    end;
  try
    FrmEntrada.Module     := 'Cadastro';
    FrmEntrada.ModuleMenu := 'Recebimentos';
    FrmEntrada.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEntrada);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActRelAnaliseRessuprimentoExecute(Sender: TObject);
begin
   if (Assigned(FrmRelAnaliseRessuprimento) = False) then
     begin
       FrmRelAnaliseRessuprimento := TFrmRelAnaliseRessuprimento.Create(Application);
     end;
   try
     FrmRelAnaliseRessuprimento.Module     := 'Relatórios';
     FrmRelAnaliseRessuprimento.ModuleMenu := 'Análise de Ressuprimentos';//+#39+'s';
     FrmRelAnaliseRessuprimento.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelAnaliseRessuprimento);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmuEvolut.ActRelApanhePickingExecute(Sender: TObject);
begin
  With TFrmRelApanhePicking.Create(Self) do Try
     BtnImprimirStandClick(BtnImprimirStand);
  Finally
    Free;
  end;
end;

procedure TFrmuEvolut.ActRelColetaPulmaoExecute(Sender: TObject);
begin
  With TFrmRelColetaPulmao.Create(Self) do Try
     BtnImprimirStandClick(BtnImprimirStand);
  Finally
    Free;
  end;
end;

procedure TFrmuEvolut.ActRelEnderecamentoExecute(Sender: TObject);
begin
   if (Assigned(FrmFREnderecamentos) = False) then
     begin
       FrmFREnderecamentos := TFrmFREnderecamentos.Create(Application);
     end;
   try
     FrmFREnderecamentos.Module     := 'Relatórios';
     FrmFREnderecamentos.ModuleMenu := 'Endereçamento';//+#39+'s';
     FrmFREnderecamentos.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmFREnderecamentos);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmuEvolut.ActRelPedidosExecute(Sender: TObject);
begin
   if (Assigned(FrmRelPedidos) = False) then
     begin
       FrmRelPedidos := TFrmRelPedidos.Create(Application);
     end;
   try
     FrmRelPedidos.Module     := 'Relatórios';
     FrmRelPedidos.ModuleMenu := 'Pedidos';//+#39+'s';
     FrmRelPedidos.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelPedidos);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmuEvolut.ActRelPlanilhaCegaExecute(Sender: TObject);
begin
   if (Assigned(FrmRelPlanilhaCega) = False) then
     begin
       FrmRelPlanilhaCega := TFrmRelPlanilhaCega.Create(Application);
     end;
   try
     FrmRelPlanilhaCega.Module     := 'Relatórios';
     FrmRelPlanilhaCega.ModuleMenu := 'Planilha Cega';
     FrmRelPlanilhaCega.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelPlanilhaCega);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmuEvolut.ActRelReposicaoDemandaExecute(Sender: TObject);
begin
  if (Assigned(FrmRelReposicaoDemanda) = False) then
    begin
      FrmRelReposicaoDemanda := TFrmRelReposicaoDemanda.Create(Application);
    end;
  try
    FrmRelReposicaoDemanda.Module     := 'Relatórios';
    FrmRelReposicaoDemanda.ModuleMenu := 'Reposição Demanda';//+#39+'s';
    FrmRelReposicaoDemanda.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelReposicaoDemanda);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActRelRupturaAbastecimentoExecute(Sender: TObject);
begin
  With TFrmRelRupturaAbastecimento.Create(Self) do Try
     BtnImprimirStandClick(BtnImprimirStand);
  Finally
    Free;
  end;
end;

procedure TFrmuEvolut.ActRelTAGExecute(Sender: TObject);
begin
   inherited;
   if (Assigned(frmPrintTAG) = False) then
     begin
       frmPrintTAG := TfrmPrintTAG.Create(Application);
     end;
   try
     FrmPrintTAG.Module     := 'Relatórios';
     FrmPrintTAG.ModuleMenu := 'Impressão Tag';//+#39+'s';
     FrmPrintTAG.Show;
   except on e: Exception do
     begin
       FreeAndNil(frmPrintTAG);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmuEvolut.ActRotasExecute(Sender: TObject);
begin
  if (Assigned(FrmRotas) = False) then
    begin
      FrmRotas := TFrmRotas.Create(Application);
    end;
  try
    FrmRotas.Module     := 'Logística';
    FrmRotas.ModuleMenu := 'Rotas';
    FrmRotas.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRotas);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActSeparacaoExecute(Sender: TObject);
begin
  if (Assigned(FrmSeparacaoDesktop) = False) then
    begin
      FrmSeparacaoDesktop := TFrmSeparacaoDesktop.Create(Application);
    end;
  try
    FrmSeparacaoDesktop.Module     := 'P.C.P. / Chão de Fábrica';
    FrmSeparacaoDesktop.ModuleMenu := 'Apanhe - Separação';
    FrmSeparacaoDesktop.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmSeparacaoDesktop);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActTransportadoraExecute(Sender: TObject);
begin
  TpPessoa   := Transportadora;
  if (Assigned(FrmTransportadora) = False) then
    begin
      FrmTransportadora := TFrmTransportadora.Create(Application);
    end;
  try
    FrmTransportadora.Module     := 'Logística';
    FrmTransportadora.ModuleMenu := 'Transportadoras';
    FrmTransportadora.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmTransportadora);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActContrAcessoFuncionalidadesExecute(Sender: TObject);
begin
  if (Assigned(FrmFuncionalidades) = False) then
    begin
      FrmFuncionalidades := TFrmFuncionalidades.Create(Application);
    end;
  try
    FrmFuncionalidades.Module     := 'Controle de Acesso';
    FrmFuncionalidades.ModuleMenu := 'Funcionalidades';
    FrmFuncionalidades.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmFuncionalidades);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActContrAcessoPerfilExecute(Sender: TObject);
begin
  if (Assigned(Frmperfil) = False) then
    begin
      Frmperfil := TFrmperfil.Create(Application);
    end;
  try
    Frmperfil.Module     := 'Controle de Acesso';
    Frmperfil.ModuleMenu := 'Perfil de Usuário';
    Frmperfil.Show;
  except on e: Exception do
    begin
      FreeAndNil(Frmperfil);
      raise Exception.Create(e.Message);
    end;
  end;end;

procedure TFrmuEvolut.ActContrAcessoTopicosExecute(Sender: TObject);
begin
  if (Assigned(FrmTopicos) = False) then
    begin
      FrmTopicos := TFrmTopicos.Create(Application);
    end;
  try
    FrmTopicos.Module     := 'Controle de Acesso';
    FrmTopicos.ModuleMenu := 'Tópicos';
    FrmTopicos.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmTopicos);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActContrAcessoUsuarioExecute(Sender: TObject);
begin
  if (Assigned(FrmUsuario) = False) then
    begin
      FrmUsuario := TFrmUsuario.Create(Application);
    end;
  try
    FrmUsuario.Module     := 'Configuração';
    FrmUsuario.ModuleMenu := 'Usuário';
    FrmUsuario.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmUsuario);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActExpedicaoCargaMontarExecute(Sender: TObject);
begin
  if (Assigned(FrmCargaMontar) = False) then
     FrmCargaMontar := TFrmCargaMontar.Create(Application);
  try
    FrmCargaMontar.Module     := 'Expedição';
    FrmCargaMontar.ModuleMenu := 'Montar Carga';
    FrmCargaMontar.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCargaMontar);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActExpedicaoCargaCarregarExecute(Sender: TObject);
begin
  if (Assigned(FrmCargaCarregar) = False) then
     FrmCargaCarregar := TFrmCargaCarregar.Create(Application);
  try
    FrmCargaCarregar.Module     := 'Expedição';
    FrmCargaCarregar.ModuleMenu := 'Carregar Carga';
    FrmCargaCarregar.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCargaCarregar);
      raise Exception.Create(e.Message);
    end;
  end;

end;

procedure TFrmuEvolut.ActExpedicaoExecute(Sender: TObject);
begin
  if (Assigned(FrmExpedicao) = False) then
     FrmExpedicao := TFrmExpedicao.Create(Application);
  try
    FrmExpedicao.Module     := 'Expedição';
    FrmExpedicao.ModuleMenu := 'Registrar Volume';
    FrmExpedicao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmExpedicao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActVeiculosExecute(Sender: TObject);
begin
  if (Assigned(FrmVeiculo) = False) then
    begin
      FrmVeiculo := TFrmVeiculo.Create(Application);
    end;
  try
    FrmVeiculo.Module     := 'Logística';
    FrmVeiculo.ModuleMenu := 'Veículos';
    FrmVeiculo.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmVeiculo);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ActVolumeEmbalagemExecute(Sender: TObject);
begin
  if (Assigned(FrmVolumeEmbalagem) = False) then
    begin
      FrmVolumeEmbalagem := TFrmVolumeEmbalagem.Create(Application);
    end;
  try
    FrmVolumeEmbalagem.Module     := 'Logística';
    FrmVolumeEmbalagem.ModuleMenu := 'Embalagem - Volumes';
    FrmVolumeEmbalagem.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmVolumeEmbalagem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmuEvolut.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
Var oLogger: TLoggerSingleton;
begin
   oLogger := TLoggerSingleton.ObterInstancia;
   oLogger.RegistrarLog('    Erro: '+E.Message +' às '+ Copy(TimeToStr(Time()),1,5)+'h.');
end;

procedure TFrmuEvolut.AtualizarVersao;
Var Update : String;
    Str : TStrings;
begin
  if DebugHook <> 0 Then Begin
     NovaVersao := False;
     Exit;
  End;
  NovaVersao := False;
  Str := TStringList.Create;
  Str.LoadFromFile(ExtractFilePath(ParamStr(0))+'\ConfigAtualizador.dat');

  Atual := ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0));
  Update := Str[0];
  AtzApp := ExtractFilePath(ParamStr(0))+'Atualizador.Exe';
  if FileExists(Atual) then Begin
     if FileExists(Update) then Begin
        if VersaoExe(Atual) <> VersaoExe(Update) then Begin
           ShowMessage('Existem uma nova atualização do Software. Vamos atualizar agora!!!');
           if Not FileExists(AtzApp) then MessageDlg('Existe uma versão atualizada.'+#13+#10+
              'O Software não pode ser atualizado automaticamente.', MtWarning, [MbOk], 0);
           NovaVersao := True;
           Close;
        End;
     End
     Else Begin
//       ShowMessage('Sem Atualização.');//;'Erro: Versão de Atualização '+Update+' não foi encontrada.');
       exit;
     End;
     Caption := 'eXactWMS '+VersaoExe(Atual);
     Str.Free;
  End;
end;

function TFrmuEvolut.ConfirmaManutencao(vAcao: String): Boolean;
begin
  Result := False;
  With TFrmConfirmacao.Create(Self) do Try
    If vAcao = 'Upd' Then
    Begin
      Mensag1.Caption := 'Salvar Dados';
      Mensag2.Caption := 'Todos os Dados serão salvos';
      ImgOk.Visible   := True;
    End
    Else if vAcao = 'Del' Then
    Begin
      Mensag1.Caption := 'Excluir Dados';
      Mensag2.Caption := 'Todos os dados serão apagados';
      ImgOk.Visible   := True;
    End
    Else if vAcao = 'Canc' then
    Begin
      Mensag1.Caption := 'Cancelar Digitação.';
      Mensag2.Caption := 'Os dados digitados serão perdidos...';
      ImgCancel.Visible   := True;
    End
    Else
      Exit;

    If ShowModal = MrOk Then Begin
       Self.Cancelado := False;
       Result := True;
       End
    Else Begin
       abort;
       Self.Cancelado := True;
       Result := False;
       Exit;
    End;
  Finally
    Free;
  end;
end;

procedure TFrmuEvolut.FormActivate(Sender: TObject);
begin
  If DebugHook = 0  then
     Grafico01;
end;

procedure TFrmuEvolut.FormClose(Sender: TObject; var Action: TCloseAction);
var oLogger: TLoggerSingleton;
begin
  // obtém a instância do Singleton para registrar um log
  if (Not NovaVersao) and (MessageBox(Handle, 'Deseja SAIR do WMS?', 'Sair', MB_ICONQUESTION + MB_YESNO) = mrNo) then
      Abort;
  oLogger := TLoggerSingleton.ObterInstancia;
  oLogger.RegistrarLog(ObjUsuarioCtrl.ObjUsuario.Nome+', encerrou a aplicação às '+Copy(TimeToStr(Time()),1,5)+'h.'+#13+#13);
  oLogger := Nil;
  oLogger.DisposeOf;
  action := caFree;
  if NovaVersao then
     CreateProcessSimple(AtzApp);
end;

procedure TFrmuEvolut.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
Var vModalResult : TModalResult;
begin
  if NovaVersao then
     CanClose := True
  Else Begin
    With TFrmSair.Create(self) do
      Try
        vmodalResult := ShowModal;
        if vModalResult = MrOk then Begin
           LogEndApp;
           Application.Terminate;
        End
        else if vModalResult = mrRetry then
           LogOn;
      Finally
        Free;
      End;
    CanClose := False;
  End;
end;

procedure TFrmuEvolut.FormCreate(Sender: TObject);
begin
  BASEURL := DmuEvolut.BASEURL;
  FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
  FormatSettings.LongDateFormat  := 'DD/MM/YYYY';
  FormatSettings.ShortTimeFormat := 'hh:mm';
  FormatSettings.LongTimeFormat 	:= 'hh:mm:ss';
  Application.HelpFile := 'uEvolut.chm';
  KeyPreview:= True;
  Application.OnException := TrataErro;
  PathApp := ExtractFilePath( Application.ExeName );
  Self.Menu := Nil;
  ConfigWMS    := TConfiguracaoCtrl.Create;
  Try
    ConfigWMS.ObjConfiguracao   := ConfigWMS.GetConfiguracao[0];    //ConfigWMS.GetConfigWMS; //
  Except
    Application.MessageBox(pWideChar('Não foi possível acessar o servidor.'+
                                     #13+#13+'O eXactWMS será finalizado.'), 'Erro: Server eXactWMS!', MB_ICONERROR);
    Application.Terminate;
  End;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  NullStrictConvert           := False;
  if (FileExists(PathApp + '\uEvolut.rav') = True) then
      rvpPrincipal.ProjectFile := PathApp + '\uEvolut.rav'
  else
      Application.MessageBox('Arquivo uEvolut.rav não localizado!', 'Erro', MB_ICONERROR + MB_OK);
  ObjUsuarioCtrl := TUsuarioCtrl.Create;
end;

procedure TFrmuEvolut.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ObjUsuarioCtrl);
  FreeAndNil(ConfigWMS);
  ConfigWMS := Nil;
  COnfigWMS.DisposeOf;
  if NovaVersao then
     WinExec(pAnsiChar(AtzApp), SW_NORMAL);
end;

procedure TFrmuEvolut.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F1 then
     Application.HelpContext(50);
end;

procedure TFrmuEvolut.FormResize(Sender: TObject);
begin                                   // 728                 //50
  ImgLogoProduct.Top  := ((Height-PnlTopRhemaSys.Height) Div 2) - (ImgLogoProduct.Height Div 2) + PnlTopRhemaSys.Height;
  ImgLogoProduct.Left := ((Width-MenuSplit.Width) Div 2) - (ImgLogoProduct.Width Div 2) + MenuSplit.Width;
//  ImgRhemasys.Top     := ImgLogoProduct.Top - (ImgRhemasys.Height Div 2);
//  ImgRhemasys.Left    := ImgLogoProduct.Left - (ImgRhemasys.Width Div 2);
  LblUsuarioTop.Caption := 'Usuário: '+ObjUsuarioCtrl.ObjUsuario.Nome;
end;

procedure TFrmuEvolut.FormShow(Sender: TObject);
begin
  frmLogin := TfrmLogin.Create(Application);
  frmLogin.LblVersao.Caption := 'Versão: ' + Versao;//(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
    if (frmLogin.ShowModal = mrOk) then begin
       FrmuEvolut.LblVersao.Caption := 'Versão: ' + Versao;//(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
       AtualizarVersao;
    End
    Else Begin
       ShowMessage('Acesso não permitido!');
       Application.terminate;
    End;
  FrmLogin := Nil;
end;

procedure TFrmuEvolut.ImgCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmuEvolut.imgMenuClick(Sender: TObject);
begin
//  MenuSplit.Opened := Not MenuSplit.Opened;
end;

procedure TFrmuEvolut.LogEndApp;
var oLogger: TLoggerSingleton;
begin
  oLogger := TLoggerSingleton.ObterInstancia;
  oLogger.RegistrarLog(ObjUsuarioCtrl.ObjUsuario.Nome+', encerrou a aplicação às '+Copy(TimeToStr(Time()),1,5)+'h.'+#13+#13);
  oLogger := Nil;
  oLogger.DisposeOf;
end;

procedure TFrmuEvolut.LogOn;
begin
   frmLogin := TfrmLogin.Create(Application);
   if (frmLogin.ShowModal = mrOk) then Begin

   End
   Else Begin
      ShowMessage('Acesso não permitido!');
      Application.terminate;
   End;
end;

procedure TFrmuEvolut.TmHoraAtualTimer(Sender: TObject);
begin
  LblDateTime.Caption := FormatDateTime('dd/mm/yyyy hh:mm', now())+'h';
end;

procedure TFrmuEvolut.TrataErro(Sender: TObject; E: Exception);
begin
  MessageDlg(E.Message+#13+#13,MtError, [MbOk] ,0);
end;

procedure TFrmuEvolut.TrimAppMemorySize;
Var MainHandle : THandle;
begin
  try
  MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false,
  GetCurrentProcessID) ;
  SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
  CloseHandle(MainHandle) ;
  except
  end;
  Application.ProcessMessages;
end;

function TFrmuEvolut.VerAcesso(CodMenu: String): Boolean;
begin
  Result := True;
end;

Procedure TFrmuEvolut.Grafico01;
Var ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    JsonDashBoard0102  : TJsonObject;
    JsonDashBoard030405, JsonDashBoard06 : TJsonArray;
    xRetorno : Integer;
Begin
//Pegar os dados
  ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
  JsonDashBoard0102  := ObjPedidoSaidaCtrl.GetDashBoard0102(date(), Date());
  //Checkare retorno de erro
  if not (FdMemDashBoard01.Active) then
     FdMemDashBoard01.Open;
  FdMemDashBoard01.EmptyDataSet;
  if not (FdMemDashBoard02.Active) then
     FdMemDashBoard02.Open;
  FdMemDashBoard02.EmptyDataSet;
  if JsonDashBoard0102.Count > 0  then Begin
     If JsonDashBoard0102.GetValue<TJsonArray>('diario').Count>0 then Begin
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Demanda';
        FdMemDashBoard01.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('diario').Items[0].GetValue<Integer>('demanda');
        FdMemDashBoard01.FieldByName('RGB').AsString    := '118, 112, 45';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Expedicao';
        FdMemDashBoard01.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('diario').Items[0].GetValue<Integer>('expedicao');
        FdMemDashBoard01.FieldByName('RGB').AsString    := '80, 90, 145';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Cancelado';
        FdMemDashBoard01.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('diario').Items[0].GetValue<Integer>('cancelado');
        FdMemDashBoard01.FieldByName('RGB').AsString    := '118, 35, 120';
     End
     Else Begin
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Demanda';
        FdMemDashBoard01.FieldByName('Value').AsInteger := 0;
        FdMemDashBoard01.FieldByName('RGB').AsString    := '58, 112, 45';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Expedicao';
        FdMemDashBoard01.FieldByName('Value').AsInteger := 0;
        FdMemDashBoard01.FieldByName('RGB').AsString    := '80, 90, 145';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Cancelado';
        FdMemDashBoard01.FieldByName('Value').AsInteger := 0;
        FdMemDashBoard01.FieldByName('RGB').AsString    := '118, 35, 48';
     End;
     If JsonDashBoard0102.GetValue<TJsonArray>('mensal').Count>0 then Begin
        FdMemDashBoard02.Append;
        FdMemDashBoard02.FieldByName('Label').AsString  := 'Demanda';
        FdMemDashBoard02.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('mensal').Items[0].GetValue<Integer>('demanda');
        FdMemDashBoard02.FieldByName('RGB').AsString    := '125, 110, 117';
        FdMemDashBoard02.Append;
        FdMemDashBoard02.FieldByName('Label').AsString  := 'Expedicao';
        FdMemDashBoard02.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('mensal').Items[0].GetValue<Integer>('expedicao');
        FdMemDashBoard02.FieldByName('RGB').AsString  := '108, 23, 48';
        FdMemDashBoard02.Append;
        FdMemDashBoard02.FieldByName('Label').AsString  := 'Cancelado';
        FdMemDashBoard02.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('mensal').Items[0].GetValue<Integer>('cancelado');
        FdMemDashBoard02.FieldByName('RGB').AsString  := '25 ,70, 85';
     End;
  End;
//Demanda, Expedição e Cancelado por Loja
  JsonDashBoard030405  := ObjPedidoSaidaCtrl.GetDashBoard030405(date(), Date());
  //Checkare retorno de erro
  if not (FdMemDashBoard03.Active) then
     FdMemDashBoard03.Open;
  FdMemDashBoard03.EmptyDataSet;
  if not (FdMemDashBoard04.Active) then
     FdMemDashBoard04.Open;
  FdMemDashBoard04.EmptyDataSet;
  if not (FdMemDashBoard05.Active) then
     FdMemDashBoard05.Open;
  FdMemDashBoard05.EmptyDataSet;
  if JsonDashBoard030405.Count > 0  then Begin
     for xRetorno := 0 to Pred(JsonDashBoard030405.Count) do  Begin
        FdMemDashBoard03.Append;
        FdMemDashBoard03.FieldByName('Label').AsString  := JsonDashBoard030405.Items[xRetorno].GetValue<String>('codpessoaerp')+' '+
                                                           JsonDashBoard030405.Items[xRetorno].GetValue<String>('razao');
        FdMemDashBoard03.FieldByName('Value').AsInteger := JsonDashBoard030405.Items[xRetorno].GetValue<Integer>('demanda');
        FdMemDashBoard03.FieldByName('RGB').AsString    := '125, 110, 117';
        FdMemDashBoard04.Append;
        FdMemDashBoard04.FieldByName('Label').AsString  := JsonDashBoard030405.Items[xRetorno].GetValue<String>('codpessoaerp')+' '+
                                                           JsonDashBoard030405.Items[xRetorno].GetValue<String>('razao');
        FdMemDashBoard04.FieldByName('Value').AsInteger := JsonDashBoard030405.Items[xRetorno].GetValue<Integer>('expedicao');
        FdMemDashBoard04.FieldByName('RGB').AsString    := '108, 23, 48';
        FdMemDashBoard05.Append;
        FdMemDashBoard05.FieldByName('Label').AsString  := JsonDashBoard030405.Items[xRetorno].GetValue<String>('codpessoaerp')+' '+
                                                           JsonDashBoard030405.Items[xRetorno].GetValue<String>('razao');
        FdMemDashBoard05.FieldByName('Value').AsInteger := JsonDashBoard030405.Items[xRetorno].GetValue<Integer>('cancelado');
        FdMemDashBoard05.FieldByName('RGB').AsString    := '25 ,70, 85';
     End;
  End
  Else
  Begin
    FdMemDashBoard03.Append;
    FdMemDashBoard03.FieldByName('Label').AsString  := 'Nenhum Destino';
    FdMemDashBoard03.FieldByName('Value').AsInteger := 0;
    FdMemDashBoard03.FieldByName('RGB').AsString  := '25 ,70, 85';
  End;

//Demanda, Expedição e Cancelado por Rota
  JsonDashBoard06  := ObjPedidoSaidaCtrl.GetDashBoard06(date(), Date());
  //Checkare retorno de erro
  if not (FdMemDashBoard06.Active) then
     FdMemDashBoard06.Open;
  FdMemDashBoard06.EmptyDataSet;
  if not (FdMemDashBoard07.Active) then
     FdMemDashBoard07.Open;
  FdMemDashBoard07.EmptyDataSet;
  if not (FdMemDashBoard08.Active) then
     FdMemDashBoard08.Open;
  FdMemDashBoard08.EmptyDataSet;
  if JsonDashBoard06.Count > 0  then Begin
     for xRetorno := 0 to Pred(JsonDashBoard06.Count) do Begin
        FdMemDashBoard06.Append;
        FdMemDashBoard06.FieldByName('Label').AsString  := JsonDashBoard06.Items[xRetorno].GetValue<String>('rotaid')+' '+
                                                           JsonDashBoard06.Items[xRetorno].GetValue<String>('rota');
        FdMemDashBoard06.FieldByName('Value').AsInteger := JsonDashBoard06.Items[xRetorno].GetValue<Integer>('demanda');
        FdMemDashBoard06.FieldByName('RGB').AsString    := '125, 110, 117';
        FdMemDashBoard07.Append;
        FdMemDashBoard07.FieldByName('Label').AsString  := JsonDashBoard06.Items[xRetorno].GetValue<String>('rotaid')+' '+
                                                           JsonDashBoard06.Items[xRetorno].GetValue<String>('rota');
        FdMemDashBoard07.FieldByName('Value').AsInteger := JsonDashBoard06.Items[xRetorno].GetValue<Integer>('expedicao');
        FdMemDashBoard07.FieldByName('RGB').AsString    := '108, 23, 48';
        FdMemDashBoard08.Append;
        FdMemDashBoard08.FieldByName('Label').AsString  := JsonDashBoard06.Items[xRetorno].GetValue<String>('rotaid')+' '+
                                                           JsonDashBoard06.Items[xRetorno].GetValue<String>('rota');
        FdMemDashBoard08.FieldByName('Value').AsInteger := JsonDashBoard06.Items[xRetorno].GetValue<Integer>('cancelado');
        FdMemDashBoard08.FieldByName('RGB').AsString    := '25 ,70, 85';
     End;
  End
  Else
  Begin
    FdMemDashBoard06.Append;
    FdMemDashBoard06.FieldByName('Label').AsString  := 'Nenhuma Rota';
    FdMemDashBoard06.FieldByName('Value').AsInteger := 0;
    FdMemDashBoard06.FieldByName('RGB').AsString  := '25 ,70, 85';
  End;


  WebCharts1
  .NewProject
  .Rows
  .tag
  .add(
    WebCharts1
    .ContinuosProject
       .Charts
         ._ChartType(doughnut)
           .Attributes
             .Name('Diariox')
             .ColSpan(6)
             .Options
               .SemiCircule(True)
             .&End
             .Heigth(120)
             .Options
                .Title
                  .Text('Produção Diária')
                .&End
             .&End
             .DataSet
               .textLabel('Diarioy')
               //.BackgroundColor('30,182,100')
               .DataSet(FdMemDashBoard01)
               .Fill(False)
               .BorderWidth(2)
               .BorderColor('25,78,125')
             .&End
           .&End
         .&End
         .HTML
    )
  .&End
//Grafico 02
  .tag
    .add(
      WebCharts1
      .ContinuosProject
         .Charts
           ._ChartType(doughnut)
             .Attributes
               .Name('Mensal')
               .ColSpan(6)
               .Options
                 .SemiCircule(True)
               .&End
               .Options
                  .Title
                    .Text('Produção Mensal')
                  .&End
               .&End
               .Heigth(120)
               .DataSet
                 .textLabel('Mensal01')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard02)
               .&End
             .&End
           .&End
           .HTML
      )
    .&End
//Grafico 03
  .tag
    .add(
      WebCharts1
      .ContinuosProject
         .Charts
           ._ChartType(horizontalBar)//  bar)
             .Attributes
               .Name('Análise por Destino')
               .ColSpan(6)
               .Options
                 .SemiCircule(True)
               .&End
               .Options
                  .Title
                    .Text('Produção Diária por Destino')
                  .&End
               .&End
               .Heigth(220)
               .DataSet
                 .textLabel('Demanda')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard03)
               .&End
               .DataSet
                 .textLabel('Expedição')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard04)
               .&End
               .DataSet
                 .textLabel('Cancelado')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard05)
               .&End
             .&End
           .&End
           .HTML
      )
    .&End
//Grafico 04
  .tag
    .add(
      WebCharts1
      .ContinuosProject
         .Charts
           ._ChartType(horizontalBar)//  bar)
             .Attributes
               .Name('Análise por Rota')
               .ColSpan(6)
               .Options
                 .SemiCircule(True)
               .&End
               .Options
                  .Title
                    .Text('Produção Diária por Rota')
                  .&End
               .&End
               .Heigth(220)
               .DataSet
                 .textLabel('Demanda')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard06)
               .&End
               .DataSet
                 .textLabel('Expedição')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard07)
               .&End
               .DataSet
                 .textLabel('Cancelado')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard08)
               .&End
             .&End
           .&End
           .HTML
      )
    .&End

  .&End


  .WebBrowser(WebBrowser1)
  .Generated;

  JsonDashBoard0102   := Nil;
  JsonDashBoard030405 := Nil;
  JsonDashBoard06     := Nil;
  ObjPedidoSaidaCtrl  := Nil;
End;

end.
