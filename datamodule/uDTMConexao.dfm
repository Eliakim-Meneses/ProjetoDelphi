object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = False
  Height = 246
  Width = 351
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = True
    Catalog = ''
    Connected = True
    HostName = '.\SERVERCURSO'
    Port = 1433
    Database = 'vendas'
    User = 'sa'
    Password = '123456'
    Protocol = 'mssql'
    LibraryLocation = 'C:\ProjetoDelphi\ntwdblib.dll'
    Left = 32
    Top = 24
  end
end
