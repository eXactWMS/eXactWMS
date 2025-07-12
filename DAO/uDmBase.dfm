object DmBase: TDmBase
  OldCreateOrder = False
  Height = 568
  Width = 1501
  object ConnRhemaWMS: TFDConnection
    Params.Strings = (
      'DriverID=mySQL')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 48
    Top = 14
  end
  object QryTemp: TFDQuery
    AfterPost = QryTempAfterPost
    Connection = ConnRhemaWMS
    SQL.Strings = (
      'Select * From abcaixa')
    Left = 140
    Top = 75
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 99
    Top = 265
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = ConnRhemaWMS
    Params = <>
    Macros = <>
    Left = 141
    Top = 14
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 49
    Top = 192
  end
  object QryData: TFDQuery
    SQL.Strings = (
      'select GETDATE() as Data')
    Left = 139
    Top = 137
  end
  object RESTClientWMS: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://192.168.0.110:8200'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 237
    Top = 76
  end
  object RESTRequestWMS: TRESTRequest
    Client = RESTClientWMS
    Params = <>
    Response = RESTResponseWMS
    Timeout = 150000
    SynchronizedEvents = False
    Left = 238
    Top = 24
  end
  object RESTResponseWMS: TRESTResponse
    Left = 241
    Top = 132
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=mySQL')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 28
    Top = 270
  end
  object RESTClientCep: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://www.cepaberto.com/api/v3/cep?cep=57020510'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 224
    Top = 228
  end
  object RESTRequestCep: TRESTRequest
    Client = RESTClientCep
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'Authorization'
        Options = [poDoNotEncode]
        Value = 'Token token="cca63b874d4c386e5638d050c8af5ce0"'
      end>
    Response = RESTResponseCep
    SynchronizedEvents = False
    Left = 301
    Top = 227
  end
  object RESTResponseCep: TRESTResponse
    Left = 378
    Top = 225
  end
  object ClientGraphics: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://192.168.0.110:8200'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 301
    Top = 284
  end
  object ReqGraphics: TRESTRequest
    Client = ClientGraphics
    Params = <>
    Response = RespGraphics
    SynchronizedEvents = False
    Left = 224
    Top = 284
  end
  object RespGraphics: TRESTResponse
    Left = 367
    Top = 286
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 50
    Top = 128
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 48
    Top = 70
  end
  object ClientReport: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://192.168.0.110:8200'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 329
    Top = 74
  end
  object RequestReport: TRESTRequest
    Client = ClientReport
    Params = <>
    Response = ResponseReport
    Timeout = 150000
    SynchronizedEvents = False
    Left = 330
    Top = 22
  end
  object ResponseReport: TRESTResponse
    Left = 333
    Top = 130
  end
end
