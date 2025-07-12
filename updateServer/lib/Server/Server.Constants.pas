unit Server.Constants;

interface




resourcestring
  sPortInUse = '- Error: Port %s already in use';
  sPortSet = '- Port set to %s';
  sServerRunning = '- The Server is already running';
  sStartingServer = '- Starting HTTP Server on port %d';
  sStoppingServer = '- Stopping Server';
  sServerStopped = '- Server Stopped';
  sServerNotRunning = '- The Server is not running';
  sInvalidCommand = '- Error: Invalid Command';
  sIndyVersion = '- Indy Version: ';
  sActive = '- Active: ';
  sPort = '- Port: ';
  sSessionID = '- Session ID CookieName: ';
  sCommands = 'Enter a Command: ' + slineBreak +
    '   - "start" to start the server'+ slineBreak +
    '   - "stop" to stop the server'+ slineBreak +
    '   - "set port" to change the default port'+ slineBreak +
    '   - "status" for Server status'+ slineBreak +
    '   - "help" to show commands'+ slineBreak +
    '   - "exit" to close the application';

const
  cArrow = '->';
  cCommandStart = 'start';
  cCommandStop = 'stop';
  cCommandStatus = 'status';
  cCommandHelp = 'help';
  cCommandSetPort = 'set port';
  cCommandExit = 'exit';
  cWebRepository = 'www' ;
  cAppWeb ='https://localost';
  cUrlApi ='localhost:8081';
  cConnectionDefName ='UpdateServer';
  cConfigFileName  ='ConfigServer.ini' ;
  cFileAPK ='exactwmsmobile.apk';
 cLogoAscArt  =
 '+-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+   +-+ +-+ +-+ ' + #13#10+
 '|U| |p| |d| |a| |t| |e| ||   |S| |e|r|v| |e| r| ' + #13#10+
 '+-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+ +-+   +-+ +-+ +-+ ' + #13#10;

implementation

end.


