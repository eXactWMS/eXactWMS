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
    Left = 127
    Top = 78
  end
  inherited FDTransaction1: TFDTransaction
    Left = 79
    Top = 212
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
    Left = 111
    Top = 110
  end
  inherited RESTClientWMS: TRESTClient
    BaseURL = 'http://192.168.0.165:8200'
    Left = 190
    Top = 61
  end
  inherited RESTRequestWMS: TRESTRequest
    ConnectTimeout = 600000
    ReadTimeout = 600000
    Left = 190
    Top = 19
  end
  inherited RESTResponseWMS: TRESTResponse
    Left = 193
    Top = 106
  end
  inherited FDConnection1: TFDConnection
    Left = 22
    Top = 216
  end
  inherited RESTClientCep: TRESTClient
    Left = 179
    Top = 182
  end
  inherited RESTRequestCep: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    ConnectTimeout = 300000
    ReadTimeout = 300000
    Left = 241
    Top = 182
  end
  inherited RESTResponseCep: TRESTResponse
    Left = 302
    Top = 180
  end
  inherited ClientGraphics: TRESTClient
    Left = 241
    Top = 227
  end
  inherited ReqGraphics: TRESTRequest
    Left = 179
    Top = 227
  end
  inherited RespGraphics: TRESTResponse
    Left = 294
    Top = 229
  end
  inherited ClientReport: TRESTClient
    Left = 263
    Top = 59
  end
  inherited RequestReport: TRESTRequest
    Left = 264
    Top = 18
  end
  inherited ResponseReport: TRESTResponse
    Left = 266
    Top = 104
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
