program exactwmsservice;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.Threading,
  {$IFDEF linux}
  Posix.SysMman,
  {$ENDIF }
  System.JSON,
  IniFiles,
  horse,
  horse.jhonson,
  horse.Compression,
  horse.Utils.ClientIP,
  System.SysUtils,
  uFuncoes in '..\uFuncoes.pas',
  uLaboratorioDAO in 'DAO\uLaboratorioDAO.pas',
  uSistemaControl in 'Controller\uSistemaControl.pas',
  MService.PessoaTipoCtrl in 'Controller\MService.PessoaTipoCtrl.Pas',
  PessoaTipoClass in '..\Model\PessoaTipoClass.pas',
  MService.LaboratoriosCtrl in 'Controller\MService.LaboratoriosCtrl.Pas',
  uPessoaTipoDAO in 'DAO\uPessoaTipoDAO.pas',
  OperacaoNaturezaClass in '..\Model\OperacaoNaturezaClass.Pas',
  MService.OperacaoNaturezaCtrl in 'Controller\MService.OperacaoNaturezaCtrl.Pas',
  MService.OperacaoNaturezaDAO in 'DAO\MService.OperacaoNaturezaDAO.Pas',
  MService.OperacaoTipoCtrl in 'Controller\MService.OperacaoTipoCtrl.Pas',
  MService.OperacaoTipoDAO in 'DAO\MService.OperacaoTipoDAO.Pas',
  OperacaoTipoClass in '..\Model\OperacaoTipoClass.Pas',
  PessoaClass in '..\Model\PessoaClass.Pas',
  MService.pessoaCtrl in 'Controller\MService.pessoaCtrl.Pas',
  MService.PessoaDAO in 'DAO\MService.PessoaDAO.Pas',
  LaboratoriosClass in '..\Model\LaboratoriosClass.Pas',
  MService.ConfiguracaoCtrl in 'Controller\MService.ConfiguracaoCtrl.pas',
  MService.configuracaoDAO in 'DAO\MService.configuracaoDAO.pas',
  DesenhoArmazemClass in '..\Model\DesenhoArmazemClass.pas',
  EnderecamentoZonaClass in '..\Model\EnderecamentoZonaClass.pas',
  EnderecoClass in '..\Model\EnderecoClass.pas',
  EnderecoEstruturaClass in '..\Model\EnderecoEstruturaClass.pas',
  MedicamentoTipoClass in '..\Model\MedicamentoTipoClass.pas',
  ProdutoClass in '..\Model\ProdutoClass.pas',
  ProdutoTipoClass in '..\Model\ProdutoTipoClass.pas',
  UnidadeClass in '..\Model\UnidadeClass.pas',
  MService.UnidadeCtrl in 'Controller\MService.UnidadeCtrl.pas',
  MService.UnidadeDAO in 'DAO\MService.UnidadeDAO.pas',
  MService.DesenhoArmazemCtrl in 'Controller\MService.DesenhoArmazemCtrl.pas',
  MService.DesenhoArmazemDAO in 'DAO\MService.DesenhoArmazemDAO.pas',
  MService.EnderecamentoZonaCtrl in 'Controller\MService.EnderecamentoZonaCtrl.pas',
  MService.EnderecamentoZonaDAO in 'DAO\MService.EnderecamentoZonaDAO.pas',
  MService.EnderecoEstruturaCtrl in 'Controller\MService.EnderecoEstruturaCtrl.pas',
  MService.EnderecoEstruturaDAO in 'DAO\MService.EnderecoEstruturaDAO.pas',
  MService.EnderecoCtrl in 'Controller\MService.EnderecoCtrl.pas',
  MService.EnderecoDAO in 'DAO\MService.EnderecoDAO.pas',
  MService.ProdutoCtrl in 'Controller\MService.ProdutoCtrl.pas',
  MService.ProdutoDAO in 'DAO\MService.ProdutoDAO.pas',
  MService.ProcessoCtrl in 'Controller\MService.ProcessoCtrl.pas',
  MService.ProcessoDAO in 'DAO\MService.ProcessoDAO.pas',
  ProcessoClass in '..\Model\ProcessoClass.pas',
  MService.RegistroTipoCtrl in 'Controller\MService.RegistroTipoCtrl.pas',
  RegistroTipoClass in '..\Model\RegistroTipoClass.pas',
  MService.RegistroTipoDAO in 'DAO\MService.RegistroTipoDAO.pas',
  MService.RegistroTipoProcessoCtrl in 'Controller\MService.RegistroTipoProcessoCtrl.pas',
  RegistroTipoProcessoClass in '..\Model\RegistroTipoProcessoClass.pas',
  MService.RegistroTipoProcessoDAO in 'DAO\MService.RegistroTipoProcessoDAO.pas',
  MService.LotesCtrl in 'Controller\MService.LotesCtrl.pas',
  LotesClass in '..\Model\LotesClass.pas',
  MService.LoteDAO in 'DAO\MService.LoteDAO.pas',
  MService.ProdutoTipoCtrl in 'Controller\MService.ProdutoTipoCtrl.pas',
  MService.ProdutoTipoDAO in 'DAO\MService.ProdutoTipoDAO.pas',
  MService.EntradaCtrl in 'Controller\MService.EntradaCtrl.pas',
  uEntradaDAO in 'DAO\uEntradaDAO.pas',
  EntradaClass in '..\Model\EntradaClass.pas',
  EntradaItensClass in '..\Model\EntradaItensClass.pas',
  MService.EntradaItensCtrl in 'Controller\MService.EntradaItensCtrl.pas',
  uEntradaItensDAO in 'DAO\uEntradaItensDAO.pas',
  ProdutoCodBarrasCtrl in 'Controller\ProdutoCodBarrasCtrl.pas',
  ProdutoCodBarrasClass in '..\Model\ProdutoCodBarrasClass.pas',
  ProdutoCodBarrasDAO in 'DAO\ProdutoCodBarrasDAO.pas',
  RastroClass in '..\Model\RastroClass.pas',
  MService.RastroCtrl in 'Controller\MService.RastroCtrl.pas',
  MService.RastroDAO in 'DAO\MService.RastroDAO.pas',
  MService.MedicamentoTiposCtrl in 'Controller\MService.MedicamentoTiposCtrl.pas',
  MService.MedicamentoTipoDAO in 'DAO\MService.MedicamentoTipoDAO.pas',
  UsuarioClass in '..\Model\UsuarioClass.pas',
  MService.UsuarioCtrl in 'Controller\MService.UsuarioCtrl.pas',
  MService.UsuarioDAO in 'DAO\MService.UsuarioDAO.pas',
  MService.EnderecamentoRuaCtrl in 'Controller\MService.EnderecamentoRuaCtrl.pas',
  MService.EnderecamentoRuaDAO in 'DAO\MService.EnderecamentoRuaDAO.pas',
  EnderecamentoRuaClass in '..\Model\EnderecamentoRuaClass.pas',
  MService.IntegracaoEntradaCtrl in 'Controller\MService.IntegracaoEntradaCtrl.pas',
  MService.EntradaIntegracaoDAO in 'DAO\MService.EntradaIntegracaoDAO.pas',
  PedidoSaidaClass in '..\Model\PedidoSaidaClass.pas',
  PedidoProdutoClass in '..\Model\PedidoProdutoClass.pas',
  MService.PedidoProdutoDAO in 'DAO\MService.PedidoProdutoDAO.pas',
  MService.PedidoSaidaCtrl in 'Controller\MService.PedidoSaidaCtrl.pas',
  MService.PedidoSaidaDAO in 'DAO\MService.PedidoSaidaDAO.pas',
  PedidoClass in '..\Model\PedidoClass.pas',
  MService.PedidoDAO in 'DAO\MService.PedidoDAO.pas',
  RotaClass in '..\Model\RotaClass.pas',
  MService.RotaDAO in 'DAO\MService.RotaDAO.pas',
  MService.RotaCtrl in 'Controller\MService.RotaCtrl.pas',
  Constants in '..\Model\Constants.pas',
  VolumeEmbalagemClass in '..\Model\VolumeEmbalagemClass.pas',
  MService.VolumeEmbalagemCtrl in 'Controller\MService.VolumeEmbalagemCtrl.pas',
  MService.VolumeEmbalagemDAO in 'DAO\MService.VolumeEmbalagemDAO.pas',
  PedidoVolumeClass in '..\Model\PedidoVolumeClass.pas',
  EmbalagemCaixaClass in '..\Model\EmbalagemCaixaClass.pas',
  MService.PedidoVolumeCtrl in 'Controller\MService.PedidoVolumeCtrl.pas',
  MService.PedidoVolumeDAO in 'DAO\MService.PedidoVolumeDAO.pas',
  MService.EmbalagemCaixaCtrl in 'Controller\MService.EmbalagemCaixaCtrl.pas',
  MService.EmbalagemCaixaDAO in 'DAO\MService.EmbalagemCaixaDAO.pas',
  PedidoVolumeSeparacaoClass in '..\Model\PedidoVolumeSeparacaoClass.pas',
  MService.PedidoVolumeSeparacaoCtrl in 'Controller\MService.PedidoVolumeSeparacaoCtrl.pas',
  MService.PedidoVolumeSeparacaoDAO in 'DAO\MService.PedidoVolumeSeparacaoDAO.pas',
  MService.IntegracaoSaidaCtrl in 'Controller\MService.IntegracaoSaidaCtrl.pas',
  MService.SaidaIntegracaoDAO in 'DAO\MService.SaidaIntegracaoDAO.pas',
  MService.EstoqueCtrl in 'Controller\MService.EstoqueCtrl.pas',
  EstoqueClass in '..\Model\EstoqueClass.pas',
  PerfilClass in '..\Model\PerfilClass.pas',
  TopicosClass in '..\Model\TopicosClass.pas',
  FuncionalidadeClass in '..\Model\FuncionalidadeClass.pas',
  MService.TopicoCtrl in 'Controller\MService.TopicoCtrl.pas',
  MService.FuncionalidadeCtrl in 'Controller\MService.FuncionalidadeCtrl.pas',
  MService.PerfilCtrl in 'Controller\MService.PerfilCtrl.pas',
  MService.TopicoDAO in 'DAO\MService.TopicoDAO.pas',
  MService.FuncionalidadeDAO in 'DAO\MService.FuncionalidadeDAO.pas',
  MService.PerfilDAO in 'DAO\MService.PerfilDAO.pas',
  MService.EnderecoTipoCtrl in 'Controller\MService.EnderecoTipoCtrl.pas',
  MService.EnderecoTipoDAO in 'DAO\MService.EnderecoTipoDAO.pas',
  MService.PessoaEnderecoCtrl in 'Controller\MService.PessoaEnderecoCtrl.pas',
  MService.PessoaEnderecoDAO in 'DAO\MService.PessoaEnderecoDAO.pas',
  MService.PessoaTelefoneCtrl in 'Controller\MService.PessoaTelefoneCtrl.pas',
  MService.PessoaTelefoneDAO in 'DAO\MService.PessoaTelefoneDAO.pas',
  VeiculoClass in '..\Model\VeiculoClass.pas',
  MService.VeiculoCtrl in 'Controller\MService.VeiculoCtrl.pas',
  MService.VeiculoDAO in 'DAO\MService.VeiculoDAO.pas',
  MService.EstoqueDAO in 'DAO\MService.EstoqueDAO.pas',
  CargasClass in '..\Model\CargasClass.pas',
  MService.CargasCtrl in 'Controller\MService.CargasCtrl.pas',
  MService.CargasDAO in 'DAO\MService.CargasDAO.pas',
  MService.InventarioCtrl in 'Controller\MService.InventarioCtrl.pas',
  InventarioClass in '..\Model\InventarioClass.pas',
  MService.InventarioDAO in 'DAO\MService.InventarioDAO.pas',
  MService.DevolucaoCtrl in 'Controller\MService.DevolucaoCtrl.pas',
  MService.DevolucaoDAO in 'DAO\MService.DevolucaoDAO.pas',
  MService.operacaonaturezamotivoCtrl in 'Controller\MService.operacaonaturezamotivoCtrl.Pas',
  operacaonaturezamotivoClass in '..\Model\operacaonaturezamotivoClass.Pas',
  MService.operacaonaturezamotivoDAO in 'DAO\MService.operacaonaturezamotivoDAO.Pas',
  Services.Recebimento in 'Services\Services.Recebimento.pas' {ServiceRecebimento: TDataModule},
  Services.PedidoSaida in 'Services\Services.PedidoSaida.pas' {ServicePedidoSaida: TDataModule},
  Services.PedidoVolume in 'Services\Services.PedidoVolume.pas' {ServicePedidoVolume: TDataModule},
  MService.NovidadesCtrl in 'Controller\MService.NovidadesCtrl.pas',
  MService.NovidadesDAO in 'DAO\MService.NovidadesDAO.pas',
  Services.Produto in 'Services\Services.Produto.pas' {ServiceProduto: TDataModule},
  Services.SegregadoCausa in 'Services\Services.SegregadoCausa.pas' {ServiceSegregadoCausa: TDataModule},
  MService.SegregadoCausaCtrl in 'Controller\MService.SegregadoCausaCtrl.pas',
  Services.SaidaIntegracao in 'Services\Services.SaidaIntegracao.pas' {ServiceSaidaIntegracao: TDataModule},
  ProdutoLinhaClass in '..\Model\ProdutoLinhaClass.pas',
  Services.ProdutoLinha in 'Services\Services.ProdutoLinha.pas' {ServiceProdutoLinha: TDataModule},
  MService.ProdutoLinhaCtrl in 'Controller\MService.ProdutoLinhaCtrl.pas',
  Services.Inventario in 'Services\Services.Inventario.pas' {ServiceInventario: TDataModule},
  MService.MonitorLogCtrl in 'Controller\MService.MonitorLogCtrl.pas',
  Services.MonitorLog in 'Services\Services.MonitorLog.pas' {ServiceMonitorLog: TDataModule},
  Services.Usuarios in 'Services\Services.Usuarios.pas' {ServiceUsuario: TDataModule},
  exactwmsservice.lib.utils in 'Lib\exactwmsservice.lib.utils.pas',
  exactwmsservice.lib.connection in 'Lib\exactwmsservice.lib.connection.pas',
  exactwmsservice.Dao.base in 'DAO\exactwmsservice.Dao.base.pas',
  MService.LogControleCtrl in 'Controller\MService.LogControleCtrl.pas',
  MService.LogControleDAO in 'DAO\MService.LogControleDAO.pas';

Var
  ArqIni: TIniFile;
  PortaServer: Integer;

  FidScheduleManutencao, FidScheduleExpedicao: Cardinal;

begin
  // ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
  FormatSettings.LongDateFormat := 'DD/MM/YYYY';
  FormatSettings.ShortTimeFormat := 'hh:mm';
  FormatSettings.LongTimeFormat := 'hh:mm:ss';

  THorse.Use(Compression()).Use(jhonson);
  MService.ConfiguracaoCtrl.Registry;
  MService.LaboratoriosCtrl.Registry;
  MService.LotesCtrl.Registry;
  MService.OperacaoNaturezaCtrl.Registry;
  MService.OperacaoTipoCtrl.Registry;
  MService.PessoaTipoCtrl.Registry;
  MService.pessoaCtrl.Registry;
  MService.UnidadeCtrl.Registry;
  MService.DesenhoArmazemCtrl.Registry;
  MService.EnderecamentoRuaCtrl.Registry;
  MService.EnderecamentoZonaCtrl.Registry;
  MService.EnderecoEstruturaCtrl.Registry;
  MService.EnderecoCtrl.Registry;
  MService.ProdutoCtrl.Registry;
  MService.ProdutoTipoCtrl.Registry;
  MService.ProdutoLinhaCtrl.Registry;
  MService.RastroCtrl.Registry;
  MService.ProcessoCtrl.Registry;
  MService.MedicamentoTiposCtrl.Registry;
  MService.EntradaCtrl.Registry;
  MService.EntradaItensCtrl.Registry;
  MService.PedidoSaidaCtrl.Registry;
  ProdutoCodBarrasCtrl.Registry;
  MService.UsuarioCtrl.Registry;
  // Rotinas de Integra��
  MService.IntegracaoEntradaCtrl.Registry;
  MService.IntegracaoSaidaCtrl.Registry;
  MService.RotaCtrl.Registry;
  MService.EmbalagemCaixaCtrl.Registry;
  MService.VolumeEmbalagemCtrl.Registry;
  MService.PedidoVolumeCtrl.Registry;
  MService.PedidoVolumeSeparacaoCtrl.Registry;
  MService.EstoqueCtrl.Registry;
  MService.TopicoCtrl.Registry;
  MService.FuncionalidadeCtrl.Registry;
  MService.PerfilCtrl.Registry; // Perfil de Usu�rio(s)
  MService.EnderecoTipoCtrl.Registry; // Perfil de Usu�rio(s)
  MService.PessoaEnderecoCtrl.Registry; // Perfil de Usu�rio(s)
  MService.PessoaTelefoneCtrl.Registry;
  MService.VeiculoCtrl.Registry;
  MService.CargasCtrl.Registry;
  MService.InventarioCtrl.Registry;
  MService.DevolucaoCtrl.Registry;
  MService.operacaonaturezamotivoCtrl.Registry;
  MService.NovidadesCtrl.Registry;
  MService.SegregadoCausaCtrl.Registry;
  MService.MonitorLogCtrl.Registry;
  MService.LogControleCtrl.Registry;

  THorse.MaxConnections := 150;
  THorse.ListenQueue    := 150;
  PortaServer           := 8200;

  try
    if GetEnvironmentVariable('RHEMA_SERVER_PORT') <> '' then
    begin
      PortaServer := strtoint(GetEnvironmentVariable('RHEMA_SERVER_PORT'));
    end
    else
    begin
      if fileexists(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini')
      then
      Begin
        Writeln('arquivo de configuração carrregado com sucesso ');
        ArqIni := TIniFile.create(ExtractFilePath(GetModuleName(HInstance)) +
          'eXactWMS.ini');
        PortaServer := ArqIni.Readinteger('Server', 'Port', 8200);
        FreeAndNil(ArqIni);
      End
      else
        Writeln('Arquivo de configuracao não encontrado  !! ' +
          ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini');
    end;
  except

  end;
  TSistemaControl.GetInstance();
  Tutil.SetConectionsDef();
  THorse.Get('/eXactWMS',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('Servidor eXactWMS Ativo - Rhemasys Soluçõees (63) 9 9240-6343');
    end);

  THorse.Get('/serverbd',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send(Tutil.ServerBd);
    end);

  Tutil.gravalog('Inciando Servidor v2024-03-06');
  THorse.Listen(PortaServer,
    Procedure(horse: THorse)
    Begin
      Writeln(Format('Servidor v2024-03-06  Ativo na Porta: %d Versão: V1  Ativo em: %s. Para testar use 127.0.0.1:%d/eXactWMS',
                     [horse.Port, DateTimeToStr(Now()), horse.Port]));
    End);

end.
