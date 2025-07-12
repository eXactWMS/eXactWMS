object dmClient: TdmClient
  Height = 446
  Width = 610
  PixelsPerInch = 120
  object RESTResponse1: TRESTResponse
    Left = 373
    Top = 15
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Params = <
      item
        Kind = pkURLSEGMENT
        Name = 'Cdusuario'
        Options = [poAutoCreated]
      end>
    Resource = 'GetUsuario/{Cdusuario}'
    Response = RESTResponse1
    ConnectTimeout = 150000
    ReadTimeout = 150000
    SynchronizedEvents = False
    Left = 254
    Top = 18
  end
  object RESTClient1: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    BaseURL = 'http://192.168.0.11:8100/datasnap/rest/TdmServidor'
    Params = <>
    SynchronizedEvents = False
    Left = 153
    Top = 20
  end
  object QryVolumeProduto: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 45
    Top = 248
  end
  object DSRestConnection1: TDSRestConnection
    Host = '192.168.0.11'
    Port = 8100
    LoginPrompt = False
    PreserveSessionID = False
    Left = 45
    Top = 23
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 263
    Top = 125
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 380
    Top = 125
  end
  object FdWmsSqlLite: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=sQLite')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 43
    Top = 128
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 158
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 498
    Top = 123
  end
  object QryTemp: TFDQuery
    Connection = FdWmsSqlLite
    Left = 265
    Top = 245
  end
  object QrySaveSeparacaoProduto: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      'Update TbSeparacaoVolumePrd'
      '    Set QtSeparada = :pQtSeparada'
      '         , DataHoraSeparacao = :pDataHoraSeparacao'
      '         , Status  = :pStatus'
      '         , QtCorte = :pQtCorte'
      'Where CdVolume = :pCdVolume and CdProduto = :pCdProduto')
    Left = 155
    Top = 250
    ParamData = <
      item
        Name = 'PQTSEPARADA'
        ParamType = ptInput
      end
      item
        Name = 'PDATAHORASEPARACAO'
        ParamType = ptInput
      end
      item
        Name = 'PSTATUS'
        ParamType = ptInput
      end
      item
        Name = 'PQTCORTE'
        ParamType = ptInput
      end
      item
        Name = 'PCDVOLUME'
        ParamType = ptInput
      end
      item
        Name = 'PCDPRODUTO'
        ParamType = ptInput
      end>
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = '1'
    Password = 'senhadodia'
    Left = 443
    Top = 50
  end
  object QryLimparSqLite: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      'Delete from TbSeparacaoVolumePrd Where CdVolume = :pCdVolume')
    Left = 45
    Top = 325
    ParamData = <
      item
        Name = 'PCDVOLUME'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Left = 513
    Top = 16
  end
  object QryCargaDestinatario: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 185
    Top = 328
  end
  object QryCargaPedido: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 285
    Top = 330
  end
  object QryCargaVolume: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 368
    Top = 333
  end
end
