inherited DmeXactWMS: TDmeXactWMS
  OnCreate = DataModuleCreate
  Height = 454
  Width = 1201
  inherited ConnRhemaWMS: TFDConnection
    Left = 38
    Top = 11
  end
  inherited QryTemp: TFDQuery
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 151
    Top = 78
  end
  inherited FDTransaction1: TFDTransaction
    Left = 159
    Top = 148
  end
  inherited FDScript1: TFDScript
    Left = 127
    Top = 25
  end
  inherited FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 39
    Top = 154
  end
  inherited QryData: TFDQuery
    Connection = ConnRhemaWMS
    Left = 151
    Top = 238
  end
  inherited RESTClientWMS: TRESTClient
    BaseURL = 'http://192.168.0.165:8200'
    Left = 222
    Top = 29
  end
  inherited RESTRequestWMS: TRESTRequest
    ConnectTimeout = 600000
    ReadTimeout = 600000
    Left = 414
    Top = 19
  end
  inherited RESTResponseWMS: TRESTResponse
    Left = 425
    Top = 106
  end
  inherited FDConnection1: TFDConnection
    Left = 22
    Top = 216
  end
  inherited RESTClientCep: TRESTClient
    Left = 419
    Top = 174
  end
  inherited RESTRequestCep: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    ConnectTimeout = 300000
    ReadTimeout = 300000
    Left = 481
    Top = 174
  end
  inherited RESTResponseCep: TRESTResponse
    Left = 542
    Top = 172
  end
  inherited ClientGraphics: TRESTClient
    Left = 481
    Top = 219
  end
  inherited ReqGraphics: TRESTRequest
    Left = 419
    Top = 219
  end
  inherited RespGraphics: TRESTResponse
    Left = 534
    Top = 221
  end
  inherited ClientReport: TRESTClient
    Left = 431
    Top = 43
  end
  inherited RequestReport: TRESTRequest
    Left = 496
    Top = 10
  end
  inherited ResponseReport: TRESTResponse
    Left = 578
    Top = 96
  end
  inherited FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 40
    Top = 102
  end
  inherited FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Left = 38
    Top = 56
  end
end
