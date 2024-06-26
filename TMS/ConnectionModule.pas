unit ConnectionModule;

interface

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.UniDac, 
  System.SysUtils, System.Classes, Aurelius.Sql.MySQL, Aurelius.Schema.MySQL,
  Aurelius.Comp.Connection, Data.DB, DBAccess, Uni, UniProvider,
  MySQLUniProvider, Sparkle.HttpServer.Module, Sparkle.HttpServer.Context,
  XData.Server.Module, Sparkle.Comp.Server, XData.Comp.Server,
  Sparkle.Comp.HttpSysDispatcher, XData.Comp.ConnectionPool;

type
  TUniDacMySqlConnection = class(TDataModule)
    Connection: TUniConnection;
    AureliusConnection1: TAureliusConnection;
    MySQLUniProvider1: TMySQLUniProvider;
    procedure ConnectionAfterConnect(Sender: TObject);
  private
  public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
     
    class function CreatePool(APoolSize: Integer): IDBConnectionPool;
  end;

var
  UniDacMySqlConnection: TUniDacMySqlConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses  
  XData.Aurelius.ConnectionPool,
  Aurelius.Drivers.Base;

{$R *.dfm}

{ TMyConnectionModule }

procedure TUniDacMySqlConnection.ConnectionAfterConnect(Sender: TObject);
begin
  //
end;

class function TUniDacMySqlConnection.CreateConnection: IDBConnection;
begin 
  Result := UniDacMySqlConnection.AureliusConnection1.CreateConnection; 
end;

class function TUniDacMySqlConnection.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end
  );
end;

class function TUniDacMySqlConnection.CreatePool(APoolSize: Integer): IDBConnectionPool;
begin
  Result := TDBConnectionPool.Create(APoolSize, CreateFactory);
end;

end.
