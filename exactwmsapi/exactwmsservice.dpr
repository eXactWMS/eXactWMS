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
  System.Classes,
  IdHTTP,
  IdSSLOpenSSL,
  uFuncoes in '..\uFuncoes.pas',
  uSistemaControl in 'Controller\uSistemaControl.pas',
  PessoaTipoClass in '..\Model\PessoaTipoClass.pas',
  OperacaoNaturezaClass in '..\Model\OperacaoNaturezaClass.Pas',
  OperacaoTipoClass in '..\Model\OperacaoTipoClass.Pas',
  PessoaClass in '..\Model\PessoaClass.Pas',
  MService.ConfiguracaoCtrl in 'Controller\MService.ConfiguracaoCtrl.pas',
  MService.configuracaoDAO in 'DAO\MService.configuracaoDAO.pas',
  DesenhoArmazemClass in '..\Model\DesenhoArmazemClass.pas',
  EnderecamentoZonaClass in '..\Model\EnderecamentoZonaClass.pas',
  EnderecoClass in '..\Model\EnderecoClass.pas',
  EnderecoEstruturaClass in '..\Model\EnderecoEstruturaClass.pas',
  MedicamentoTipoClass in '..\Model\MedicamentoTipoClass.pas',
  ProdutoTipoClass in '..\Model\ProdutoTipoClass.pas',
  UnidadeClass in '..\Model\UnidadeClass.pas',
  ProcessoClass in '..\Model\ProcessoClass.pas',
  RegistroTipoClass in '..\Model\RegistroTipoClass.pas',
  RegistroTipoProcessoClass in '..\Model\RegistroTipoProcessoClass.pas',
  LotesClass in '..\Model\LotesClass.pas',
  RastroClass in '..\Model\RastroClass.pas',
  UsuarioClass in '..\Model\UsuarioClass.pas',
  EnderecamentoRuaClass in '..\Model\EnderecamentoRuaClass.pas',
  PedidoClass in '..\Model\PedidoClass.pas',
  RotaClass in '..\Model\RotaClass.pas',
  Constants in '..\Model\Constants.pas',
  VolumeEmbalagemClass in '..\Model\VolumeEmbalagemClass.pas',
  EmbalagemCaixaClass in '..\Model\EmbalagemCaixaClass.pas',
  PedidoVolumeSeparacaoClass in '..\Model\PedidoVolumeSeparacaoClass.pas',
  EstoqueClass in '..\Model\EstoqueClass.pas',
  PerfilClass in '..\Model\PerfilClass.pas',
  TopicosClass in '..\Model\TopicosClass.pas',
  FuncionalidadeClass in '..\Model\FuncionalidadeClass.pas',
  VeiculoClass in '..\Model\VeiculoClass.pas',
  CargasClass in '..\Model\CargasClass.pas',
  InventarioClass in '..\Model\InventarioClass.pas',
  operacaonaturezamotivoClass in '..\Model\operacaonaturezamotivoClass.Pas',
  ProdutoLinhaClass in '..\Model\ProdutoLinhaClass.pas',
  exactwmsservice.lib.utils in 'Lib\exactwmsservice.lib.utils.pas',
  exactwmsservice.lib.connection in 'Lib\exactwmsservice.lib.connection.pas',
  exactwmsservice.Dao.base in 'DAO\exactwmsservice.Dao.base.pas',
  MService.DesenhoArmazemCtrl in 'Controller\MService.DesenhoArmazemCtrl.pas',
  MService.DesenhoArmazemDAO in 'DAO\MService.DesenhoArmazemDAO.pas',
  MService.EmbalagemCaixaCtrl in 'Controller\MService.EmbalagemCaixaCtrl.pas',
  MService.EmbalagemCaixaDAO in 'DAO\MService.EmbalagemCaixaDAO.pas',
  MService.EnderecamentoRuaCtrl in 'Controller\MService.EnderecamentoRuaCtrl.pas',
  MService.EnderecamentoRuaDAO in 'DAO\MService.EnderecamentoRuaDAO.pas',
  MService.EnderecoEstruturaCtrl in 'Controller\MService.EnderecoEstruturaCtrl.pas',
  MService.EnderecoEstruturaDAO in 'DAO\MService.EnderecoEstruturaDAO.pas',
  MService.EnderecamentoZonaCtrl in 'Controller\MService.EnderecamentoZonaCtrl.pas',
  MService.EnderecamentoZonaDAO in 'DAO\MService.EnderecamentoZonaDAO.pas',
  MService.EnderecoCtrl in 'Controller\MService.EnderecoCtrl.pas',
  MService.EnderecoDAO in 'DAO\MService.EnderecoDAO.pas',
  MService.CargasCtrl in 'Controller\MService.CargasCtrl.pas',
  MService.CargasDAO in 'DAO\MService.CargasDAO.pas',
  MService.EnderecoTipoCtrl in 'Controller\MService.EnderecoTipoCtrl.pas',
  MService.EnderecoTipoDAO in 'DAO\MService.EnderecoTipoDAO.pas',
  MService.EntradaIntegracaoDAO in 'DAO\MService.EntradaIntegracaoDAO.pas',
  MService.EstoqueCtrl in 'Controller\MService.EstoqueCtrl.pas',
  MService.EstoqueDAO in 'DAO\MService.EstoqueDAO.pas',
  MService.FuncionalidadeCtrl in 'Controller\MService.FuncionalidadeCtrl.pas',
  MService.FuncionalidadeDAO in 'DAO\MService.FuncionalidadeDAO.pas',
  MService.InventarioCtrl in 'Controller\MService.InventarioCtrl.pas',
  MService.InventarioDAO in 'DAO\MService.InventarioDAO.pas',
  Services.Inventario in 'Services\Services.Inventario.pas',
  MService.LotesCtrl in 'Controller\MService.LotesCtrl.pas',
  MService.LoteDAO in 'DAO\MService.LoteDAO.pas',
  MService.MedicamentoTiposCtrl in 'Controller\MService.MedicamentoTiposCtrl.pas',
  MService.MedicamentoTipoDAO in 'DAO\MService.MedicamentoTipoDAO.pas',
  MService.MonitorLogCtrl in 'Controller\MService.MonitorLogCtrl.pas',
  Services.MonitorLog in 'Services\Services.MonitorLog.pas',
  MService.NovidadesCtrl in 'Controller\MService.NovidadesCtrl.pas',
  MService.NovidadesDAO in 'DAO\MService.NovidadesDAO.pas',
  MService.OperacaoNaturezaCtrl in 'Controller\MService.OperacaoNaturezaCtrl.Pas',
  MService.OperacaoNaturezaDAO in 'DAO\MService.OperacaoNaturezaDAO.Pas',
  MService.operacaonaturezamotivoCtrl in 'Controller\MService.operacaonaturezamotivoCtrl.Pas',
  MService.operacaonaturezamotivoDAO in 'DAO\MService.operacaonaturezamotivoDAO.Pas',
  MService.OperacaoTipoCtrl in 'Controller\MService.OperacaoTipoCtrl.Pas',
  MService.OperacaoTipoDAO in 'DAO\MService.OperacaoTipoDAO.Pas',
  MService.PedidoSaidaCtrl in 'Controller\MService.PedidoSaidaCtrl.pas',
  PedidoSaidaClass in '..\Model\PedidoSaidaClass.pas',
  PedidoProdutoClass in '..\Model\PedidoProdutoClass.pas',
  ProdutoClass in '..\Model\ProdutoClass.pas',
  LaboratoriosClass in '..\Model\LaboratoriosClass.Pas',
  MService.PedidoSaidaDAO in 'DAO\MService.PedidoSaidaDAO.pas',
  MService.ProdutoDAO in 'DAO\MService.ProdutoDAO.pas',
  MService.PedidoProdutoDAO in 'DAO\MService.PedidoProdutoDAO.pas',
  MService.PedidoVolumeDAO in 'DAO\MService.PedidoVolumeDAO.pas',
  PedidoVolumeClass in '..\Model\PedidoVolumeClass.pas',
  Services.PedidoSaida in 'Services\Services.PedidoSaida.pas',
  MService.PedidoVolumeCtrl in 'Controller\MService.PedidoVolumeCtrl.pas',
  Services.PedidoVolume in 'Services\Services.PedidoVolume.pas',
  MService.PedidoVolumeSeparacaoCtrl in 'Controller\MService.PedidoVolumeSeparacaoCtrl.pas',
  MService.PedidoVolumeSeparacaoDAO in 'DAO\MService.PedidoVolumeSeparacaoDAO.pas',
  MService.LaboratoriosCtrl in 'Controller\MService.LaboratoriosCtrl.Pas',
  uLaboratorioDAO in 'DAO\uLaboratorioDAO.pas',
  MService.PerfilCtrl in 'Controller\MService.PerfilCtrl.pas',
  MService.PerfilDAO in 'DAO\MService.PerfilDAO.pas',
  MService.PessoaDAO in 'DAO\MService.PessoaDAO.Pas',
  MService.PessoaEnderecoCtrl in 'Controller\MService.PessoaEnderecoCtrl.pas',
  MService.PessoaEnderecoDAO in 'DAO\MService.PessoaEnderecoDAO.pas',
  MService.PessoaTelefoneCtrl in 'Controller\MService.PessoaTelefoneCtrl.pas',
  MService.PessoaTelefoneDAO in 'DAO\MService.PessoaTelefoneDAO.pas',
  MService.pessoaCtrl in 'Controller\MService.pessoaCtrl.Pas',
  uPessoaTipoDAO in 'DAO\uPessoaTipoDAO.pas',
  MService.PessoaTipoCtrl in 'Controller\MService.PessoaTipoCtrl.Pas',
  MService.ProcessoCtrl in 'Controller\MService.ProcessoCtrl.pas',
  MService.ProcessoDAO in 'DAO\MService.ProcessoDAO.pas',
  MService.ProdutoCtrl in 'Controller\MService.ProdutoCtrl.pas',
  Services.Produto in 'Services\Services.Produto.pas',
  MService.ProdutoLinhaCtrl in 'Controller\MService.ProdutoLinhaCtrl.pas',
  Services.ProdutoLinha in 'Services\Services.ProdutoLinha.pas',
  MService.ProdutoTipoCtrl in 'Controller\MService.ProdutoTipoCtrl.pas',
  MService.ProdutoTipoDAO in 'DAO\MService.ProdutoTipoDAO.pas',
  MService.RastroCtrl in 'Controller\MService.RastroCtrl.pas',
  MService.RastroDAO in 'DAO\MService.RastroDAO.pas',
  MService.RotaCtrl in 'Controller\MService.RotaCtrl.pas',
  MService.RotaDAO in 'DAO\MService.RotaDAO.pas',
  MService.SegregadoCausaCtrl in 'Controller\MService.SegregadoCausaCtrl.pas',
  Services.SegregadoCausa in 'Services\Services.SegregadoCausa.pas',
  MService.TopicoCtrl in 'Controller\MService.TopicoCtrl.pas',
  MService.TopicoDAO in 'DAO\MService.TopicoDAO.pas',
  MService.UnidadeCtrl in 'Controller\MService.UnidadeCtrl.pas',
  MService.UnidadeDAO in 'DAO\MService.UnidadeDAO.pas',
  MService.UsuarioCtrl in 'Controller\MService.UsuarioCtrl.pas',
  MService.UsuarioDAO in 'DAO\MService.UsuarioDAO.pas',
  Services.Usuarios in 'Services\Services.Usuarios.pas',
  MService.VeiculoCtrl in 'Controller\MService.VeiculoCtrl.pas',
  MService.VeiculoDAO in 'DAO\MService.VeiculoDAO.pas',
  MService.VolumeEmbalagemCtrl in 'Controller\MService.VolumeEmbalagemCtrl.pas',
  MService.VolumeEmbalagemDAO in 'DAO\MService.VolumeEmbalagemDAO.pas',
  ProdutoCodBarrasCtrl in 'Controller\ProdutoCodBarrasCtrl.pas',
  ProdutoCodBarrasClass in '..\Model\ProdutoCodBarrasClass.pas',
  ProdutoCodBarrasDAO in 'DAO\ProdutoCodBarrasDAO.pas',
  MService.LogControleCtrl in 'Controller\MService.LogControleCtrl.pas',
  MService.LogControleDAO in 'DAO\MService.LogControleDAO.pas',
  MService.EntradaCtrl in 'Controller\MService.EntradaCtrl.pas',
  EntradaClass in '..\Model\EntradaClass.pas',
  EntradaItensClass in '..\Model\EntradaItensClass.pas',
  uEntradaDAO in 'DAO\uEntradaDAO.pas',
  Services.Recebimento in 'Services\Services.Recebimento.pas',
  uEntradaItensDAO in 'DAO\uEntradaItensDAO.pas',
  MService.EntradaItensCtrl in 'Controller\MService.EntradaItensCtrl.pas',
  MService.IntegracaoEntradaCtrl in 'Controller\MService.IntegracaoEntradaCtrl.pas',
  MService.IntegracaoSaidaCtrl in 'Controller\MService.IntegracaoSaidaCtrl.pas',
  Services.SaidaIntegracao in 'Services\Services.SaidaIntegracao.pas',
  MService.SaidaIntegracaoDAO in 'DAO\MService.SaidaIntegracaoDAO.pas',
  eXactWMS_Serialize in 'Lib\eXactWMS_Serialize.pas',
  eXactWMS_Serialize.Parallel in 'Lib\eXactWMS_Serialize.Parallel.pas',
  DataSetJSONFrameworkRTTI in 'Lib\DataSetJSONFrameworkRTTI.pas';

Var
  ArqIni: TIniFile;
  PortaServer: Integer;

  FidScheduleManutencao, FidScheduleExpedicao: Cardinal;

  Halted: Boolean = False;

procedure StartServer;
begin
  MService.ConfiguracaoCtrl.Registry;
  MService.DesenhoArmazemCtrl.Registry;
  MService.EmbalagemCaixaCtrl.Registry;
  MService.EnderecamentoRuaCtrl.Registry;
  MService.EnderecoEstruturaCtrl.Registry;
  MService.EnderecamentoZonaCtrl.Registry;
  MService.EnderecoCtrl.Registry;
  MService.CargasCtrl.Registry;
  MService.EnderecoTipoCtrl.Registry;
  MService.IntegracaoEntradaCtrl.Registry;
  MService.IntegracaoSaidaCtrl.Registry;
  MService.EstoqueCtrl.Registry;
  MService.FuncionalidadeCtrl.Registry;
  MService.InventarioCtrl.Registry;
  MService.LotesCtrl.Registry;
  MService.MedicamentoTiposCtrl.Registry;
  MService.MonitorLogCtrl.Registry;
  MService.NovidadesCtrl.Registry;
  MService.OperacaoNaturezaCtrl.Registry;
  MService.OperacaoTipoCtrl.Registry;
  MService.operacaonaturezamotivoCtrl.Registry;
  MService.PedidoSaidaCtrl.Registry;
  MService.LaboratoriosCtrl.Registry;
  MService.PedidoVolumeCtrl.Registry;
  MService.PedidoVolumeSeparacaoCtrl.Registry;
  MService.PerfilCtrl.Registry; // Perfil de Usu�rio(s)
  MService.pessoaCtrl.Registry;
  MService.PessoaEnderecoCtrl.Registry; // Perfil de Usu�rio(s)
  MService.PessoaTelefoneCtrl.Registry;
  MService.PessoaTipoCtrl.Registry;
  MService.ProcessoCtrl.Registry;
  MService.ProdutoCtrl.Registry;
  MService.ProdutoLinhaCtrl.Registry;
  MService.ProdutoTipoCtrl.Registry;
  MService.RastroCtrl.Registry;
  MService.RotaCtrl.Registry;
  MService.SegregadoCausaCtrl.Registry;
  MService.TopicoCtrl.Registry;
  MService.UnidadeCtrl.Registry;
  MService.UsuarioCtrl.Registry;
  MService.VeiculoCtrl.Registry;
  MService.VolumeEmbalagemCtrl.Registry;
  ProdutoCodBarrasCtrl.Registry;
  MService.LogControleCtrl.Registry;
  MService.EntradaCtrl.Registry;
  MService.EntradaItensCtrl.Registry;

{
  // Rotinas de Integra��


   // Perfil de Usu�rio(s)

  MService.DevolucaoCtrl.Registry;
}
  try
    THorse.Listen(PortaServer,
    Procedure(horse: THorse)
    Begin
      WriteLn('');
      WriteLn('');
      WriteLn('Rhemasys Soluções(c) - 2024/2025.');
      WriteLn('');
      Writeln(Format('eXactWMSService(API) V1.2606-29  Ativo na Porta: %d. Ativo em: %sh. ',[horse.Port, DateTimeToStr(Now())]));
      WriteLn('');
      WriteLn(Format('Para testar use: [127.0.0.1]:%d/eXactWMS(r)', [horse.Port]));
      WriteLn('');
      writeln('Para visualizar log ou testar atividade use o Postman ou o eXactWMS.');
      WriteLn('');
      WriteLn('Suporte: desenvolvimento@rhemasys.com.br');
      WriteLn('         (63) 9 9240-6343.');
      WriteLn('         WhatsApp - Atendimento virtual: RheMarcos(Em BREVE)!');
      ReadLn;
    End);
  except
    on E: Exception do
    begin
      Writeln('Erro no servidor: ' + E.Message);
    end;
  end;

end;

procedure MonitorServer;
var
  Http: TIdHTTP;
  RetryCount: Integer;
begin
  RetryCount := 0;
  Http := TIdHTTP.Create(nil);
  try
    while not Halted do
    begin
      try
        Sleep(30000); // Aguarda 30s entre verificacoes
        Http.Get('http://127.0.0.1:'+portaserver.ToString()+'/ping');
        RetryCount := 0; // Reset se sucesso
      except
        on E: Exception do
        begin
          Inc(RetryCount);
          Writeln('Falha na verificação da API (' + E.Message + '). Tentativa: ' + RetryCount.ToString);
          if RetryCount >= 2 then
          begin
            Writeln('API não responde. Finalizando processo para reinício externo...');
            Halt(1); // Força término para que Watchdog externo reinicie
          end;
        end;
      end;
    end;
  finally
    Http.Free;
  end;
end;



begin
  WriteLn('Inicializando Controle Log bom Buffer...');
  InitializeAsyncLog;
  // ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  FormatSettings := TFormatSettings.Create('pt-BR');
  FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
  FormatSettings.LongDateFormat := 'DD/MM/YYYY';
  FormatSettings.ShortTimeFormat := 'hh:mm';
  FormatSettings.LongTimeFormat := 'hh:mm:ss';

  THorse.Use(Compression()).Use(jhonson);



  THorse.MaxConnections := 250;
  THorse.ListenQueue    := 250;
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
        ArqIni := TIniFile.create(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini');
        PortaServer := ArqIni.Readinteger('Server', 'Port', 8200);
        FreeAndNil(ArqIni);
      End
      else
        Writeln('Arquivo de configuracao não encontrado  !! ' + ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini');
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

  THorse.Get('/eXactWMS/health',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    Var vHealth : String;
    begin
      vHealth := GlobalConnectionPool.GetStatus;//  GetConnectionsInfo;
      Res.Send('API Heath: '+vHealth);
      WriteLn('    ' + vHealth);
    end);

  THorse.Get('/serverbd',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send(Tutil.ServerBd);
    end);


  Try
    try
      StartServer;
      //TThread.CreateAnonymousThread(procedure begin StartServer; end).Start;
      //TThread.CreateAnonymousThread(procedure begin MonitorServer; end).Start;
  //    Writeln(' ');
  //    Writeln('CONFIGURAR BANCO DE DADOS COM ARQRUIVO INI');
      Writeln(' ');
      Writeln('API e monitoramento iniciados. Pressione Ctrl+C para sair.');

      while not Halted do
        Sleep(1000);

    except
      on E: Exception do
        Writeln('Erro fatal: ' + E.Message);
    end;
  finally
    WriteLn('Finalizando Controle Log bom Buffer...');
    FinalizeAsyncLog;
  End




{  Tutil.gravalog('Iniciando Servidor v2025-03-29');
  THorse.Listen(PortaServer,
    Procedure(horse: THorse)
    Begin
      WriteLn('');
      WriteLn('');
      WriteLn('Rhemasys Soluções(c) - 2024/2025.');
      WriteLn('');
      Writeln(Format('eXactWMSService(API) V1.2505-07  Ativo na Porta: %d. Ativo em: %sh. ',[horse.Port, DateTimeToStr(Now())]));
      WriteLn('');
      WriteLn(Format('Para testar use: [127.0.0.1]:%d/eXactWMS(r)', [horse.Port]));
      WriteLn('');
      writeln('Para visualizar log ou testar atividade use o Postman ou o eXactWMS.');
      WriteLn('');
      WriteLn('Suporte: desenvolvimento@rhemasys.com.br');
      WriteLn('         (63) 9 9240-6343.');
      WriteLn('         WhatsApp - Atendimento virtual: RheMarcos(Em BREVE)!');
    End);

}

end.
