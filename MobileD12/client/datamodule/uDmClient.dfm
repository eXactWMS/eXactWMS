object dmClient: TdmClient
  Height = 357
  Width = 488
  object RESTResponse1: TRESTResponse
    Left = 298
    Top = 12
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
    Left = 203
    Top = 14
  end
  object RESTClient1: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    BaseURL = 'http://192.168.0.11:8100/datasnap/rest/TdmServidor'
    Params = <>
    SynchronizedEvents = False
    Left = 122
    Top = 16
  end
  object QryVolumeProduto: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 36
    Top = 198
  end
  object DSRestConnection1: TDSRestConnection
    Host = '192.168.0.11'
    Port = 8100
    LoginPrompt = False
    PreserveSessionID = False
    Left = 36
    Top = 18
  end
  object FDStanStorageBinLink1: TFDStanStorageBinLink
    Left = 210
    Top = 100
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 304
    Top = 100
  end
  object FdWmsSqlLite: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'DriverID=sQLite')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 34
    Top = 102
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 126
    Top = 102
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 398
    Top = 98
  end
  object QryTemp: TFDQuery
    Connection = FdWmsSqlLite
    Left = 212
    Top = 196
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
    Left = 124
    Top = 200
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
    Left = 354
    Top = 40
  end
  object QryLimparSqLite: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      'Delete from TbSeparacaoVolumePrd Where CdVolume = :pCdVolume')
    Left = 36
    Top = 260
    ParamData = <
      item
        Name = 'PCDVOLUME'
        DataType = ftLargeint
        ParamType = ptInput
      end>
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Left = 410
    Top = 13
  end
  object QryCargaDestinatario: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 148
    Top = 262
  end
  object QryCargaPedido: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 228
    Top = 264
  end
  object QryCargaVolume: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From TbSeparacaoVolumePrd'
      '')
    Left = 294
    Top = 266
  end
end
