program MicroservicesExpedicao;
{$APPTYPE CONSOLE}
{$R *.res}
uses
  System.SysUtils, //Vcl.Dialogs,  WinApi.Windows,
  Server.AngularModel in '..\Common\Server\Server.AngularModel.pas',
  Server.Attributes in '..\Common\Server\Server.Attributes.pas',
  Server.Config in '..\Common\Server\Server.Config.pas',
  Server.Connection in '..\Common\Server\Server.Connection.pas',
  Server.Constants in '..\Common\Server\Server.Constants.pas',
  Server.DAO in '..\Common\Server\Server.DAO.pas',
  Server.Log in '..\Common\Server\Server.Log.pas',
  Server.Message in '..\Common\Server\Server.Message.pas',
  Server.MessageList in '..\Common\Server\Server.MessageList.pas',
  Server.Records in '..\Common\Server\Server.Records.pas',
  Server.ResourceBaseClass in '..\Common\Server\Server.ResourceBaseClass.pas',
  Server.ServerConsole in '..\Common\Server\Server.ServerConsole.pas',
  Server.Swagger in '..\Common\Server\Server.Swagger.pas',
  Server.Token in '..\Common\Server\Server.Token.pas',
  Server.WebModule in '..\Common\Server\Server.WebModule.pas' {WebModuleApi: TWebModule},
  Server.Util in '..\Common\Utils\Server.Util.pas',
  Server.Utils.Criptografia in '..\Common\Utils\Server.Utils.Criptografia.pas',
  Server.Utils.JsonSearchToWhere in '..\Common\Utils\Server.Utils.JsonSearchToWhere.pas',
  Server.Utils.SectionVariables in '..\Common\Utils\Server.Utils.SectionVariables.pas',
  Server.Utils.SingletonPermisao in '..\Common\Utils\Server.Utils.SingletonPermisao.pas',
  Server.Utils.Strings in '..\Common\Utils\Server.Utils.Strings.pas',
  JOSE.Builder in '..\Common\JWT\JOSE.Builder.pas',
  JOSE.Consumer in '..\Common\JWT\JOSE.Consumer.pas',
  JOSE.Consumer.Validators in '..\Common\JWT\JOSE.Consumer.Validators.pas',
  JOSE.Context in '..\Common\JWT\JOSE.Context.pas',
  JOSE.Core.Base in '..\Common\JWT\JOSE.Core.Base.pas',
  JOSE.Core.Builder in '..\Common\JWT\JOSE.Core.Builder.pas',
  JOSE.Core.JWA.Compression in '..\Common\JWT\JOSE.Core.JWA.Compression.pas',
  JOSE.Core.JWA.Encryption in '..\Common\JWT\JOSE.Core.JWA.Encryption.pas',
  JOSE.Core.JWA.Factory in '..\Common\JWT\JOSE.Core.JWA.Factory.pas',
  JOSE.Core.JWA in '..\Common\JWT\JOSE.Core.JWA.pas',
  JOSE.Core.JWA.Signing in '..\Common\JWT\JOSE.Core.JWA.Signing.pas',
  JOSE.Core.JWE in '..\Common\JWT\JOSE.Core.JWE.pas',
  JOSE.Core.JWK in '..\Common\JWT\JOSE.Core.JWK.pas',
  JOSE.Core.JWS in '..\Common\JWT\JOSE.Core.JWS.pas',
  JOSE.Core.JWT in '..\Common\JWT\JOSE.Core.JWT.pas',
  JOSE.Core.Parts in '..\Common\JWT\JOSE.Core.Parts.pas',
  JOSE.Encoding.Base64 in '..\Common\JWT\JOSE.Encoding.Base64.pas',
  JOSE.Hashing.HMAC in '..\Common\JWT\JOSE.Hashing.HMAC.pas',
  JOSE.OpenSSL.Headers in '..\Common\JWT\JOSE.OpenSSL.Headers.pas',
  JOSE.Signing.Base in '..\Common\JWT\JOSE.Signing.Base.pas',
  JOSE.Signing.ECDSA in '..\Common\JWT\JOSE.Signing.ECDSA.pas',
  JOSE.Signing.RSA in '..\Common\JWT\JOSE.Signing.RSA.pas',
  JOSE.Types.Arrays in '..\Common\JWT\JOSE.Types.Arrays.pas',
  JOSE.Types.Bytes in '..\Common\JWT\JOSE.Types.Bytes.pas',
  JOSE.Types.JSON in '..\Common\JWT\JOSE.Types.JSON.pas',
  JOSE.Types.Utils in '..\Common\JWT\JOSE.Types.Utils.pas',
  Swager.Json.Body in '..\Common\Swager\Swager.Json.Body.pas',
  Swager.Json.Definitions in '..\Common\Swager\Swager.Json.Definitions.pas',
  Swager.Json.DTO in '..\Common\Swager\Swager.Json.DTO.pas',
  Swager.Json.Paths in '..\Common\Swager\Swager.Json.Paths.pas',
  Swager.ResourceBaseClass in '..\Common\Swager\Swager.ResourceBaseClass.pas',
  Services.PedidoVolume in 'Services\Services.PedidoVolume.pas',
  Repository.SqlScripts.PedidoVolume in 'Repository\SqlScripts\Repository.SqlScripts.PedidoVolume.pas',
  Schedule.expedicao in 'Schedule\Schedule.expedicao.pas',
  Web.WebReq,
  System.Classes;

const CLogoAscArt =
    '+-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+-+-+ +-+ +-+ +-+ +-+-+-+ +-+-|'+#13#10+
    '|E| |x| |p| |e| |d| |i| |ç| |ã| |o|   |S| |e| |r| |v| |i| |c| |e|'+#13#10+
    '| | | | | | | | |R|H|E|M|A|S|Y|S| |S|O|L|U|Ç|Õ|E|S| | | | | | | |'+#13#10+
    '+-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+-+-+ +-+ +-+ +-+ +-+-+-+ +-+-|';
  CServerTitle = 'Exact Microservice Expedicao';

//Var HprevHist : HWND;
begin
  try
//    HprevHist := FindWindow(Nil, PChar(''));
//    if HprevHist = 0 then begin
       Writeln('----------------------------------------------------------------|');
       Writeln(CLogoAscArt);
       Writeln(' ® ' + CServerTitle + '                                 |');
       Writeln('----------------------------------------------------------------|');
       if WebRequestHandler <> nil then
          WebRequestHandler.WebModuleClass := WebModuleClass;
       StartClassGroup(TComponent);
       ActivateClassGroup(TComponent);
       ServerConsole.Title := CServerTitle;
       ServerConsole.Description := '';
       if Not ServerConsole.RunServer(8081) then Begin
          Writeln('**** Não foi possível abrir a instância da Aplicação. A mesma já está em execução. *****');
          Sleep(4000);
          Exit;
       End;
//    end
//    Else
//       MessageDlg('Service® já está ativado. Não pode ter mais de uma instância ativa!',MtInformation,[MbOk],0);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
