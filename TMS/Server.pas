unit Server;

interface

uses 
  ConnectionModule, 
  XData.Server.Module,
  System.SysUtils,
  Sparkle.Middleware.Cors,
  Sparkle.Middleware.Compress,
  Sparkle.Indy.Server,
  Sparkle.HttpServer.Context,
  Sparkle.HttpServer.Module,
  XData.OpenAPI.Service,
  XData.SwaggerUI.Service;

procedure StartServer;
procedure StopServer;

implementation

uses
  System.IOUtils,
  Aurelius.engine.DatabaseManager;

var
  SparkleServer: TIndySparkleHTTPServer;

procedure StartServer;
var
  Module : TAnonymousServerModule;
  DBModule : TXDataServerModule;
begin
  if Assigned(SparkleServer) then
     Exit;

//  SQLiteConnection:=TSQLiteConnection.Create(nil);
  UniDacMySqlConnection:=TUniDacMySqlConnection.Create(nil);

  SparkleServer := TIndySparkleHTTPServer.Create(nil);
  SparkleServer.DefaultPort := 3000;

  RegisterOpenAPIService;

  Module := TAnonymousServerModule.Create(
    'http://+:3000/hello',
    procedure(const C: THttpServerContext)
    begin
      C.Response.StatusCode := 200;
      C.Response.ContentType := 'text/html';
      C.Response.Close(TEncoding.UTF8.GetBytes('<h1>Gamanza Backoffice Chalenge Server</h1><br/>About! xdata server module.'));
    end
  );

  TDatabaseManager.Update(UniDacMySqlConnection.CreateConnection);
  DBModule:=TXDataServerModule.Create(
    'http://+:3000/xdata', UniDacMySqlConnection.CreateConnection
  );
//  DBModule.RegisterSwaggerUIService;
//  SparkleServer.Dispatcher.AddModule(TXDataServerModule.Create(
//    'http://+:3000/xdata', UniDacMySqlConnection.CreateConnection
//  ));

  DBModule.AddMiddleware(TCorsMiddleware.Create);

  SparkleServer.Dispatcher.AddModule(DBModule);

  // Uncomment line below to enable CORS in the server
  //Module.AddMiddleware(TCorsMiddleware.Create);
  // Uncomment line below to allow compressed responses from server
  //Module.AddMiddleware(TCompressMiddleware.Create);

  SparkleServer.Dispatcher.AddModule(Module);
  SparkleServer.Active := True;
  RegisterSwaggerUIService;
  //SparkleServer.AddModule(Module);
  //SparkleServer.Start;

end;

procedure StopServer;
begin
  FreeAndNil(SparkleServer);
end;

initialization
  SparkleServer := nil;
finalization
  StopServer;
end.
