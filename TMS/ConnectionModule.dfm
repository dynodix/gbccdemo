object UniDacMySqlConnection: TUniDacMySqlConnection
  Height = 427
  Width = 576
  object Connection: TUniConnection
    ProviderName = 'mySQL'
    Port = 3306
    Database = 'gbcctms'
    Username = 'root'
    Server = '192.168.0.9'
    Connected = True
    LoginPrompt = False
    AfterConnect = ConnectionAfterConnect
    Left = 72
    Top = 32
  end
  object AureliusConnection1: TAureliusConnection
    AdapterName = 'UniDac'
    AdaptedConnection = Connection
    SQLDialect = 'MySql'
    Left = 72
    Top = 88
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 72
    Top = 168
  end
end
