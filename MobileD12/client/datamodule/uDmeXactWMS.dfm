object DmeXactWMS: TDmeXactWMS
  Height = 470
  Width = 530
  object RESTRequestWMS: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClientWMS
    Params = <>
    Response = RESTResponseWMS
    ConnectTimeout = 300000
    ReadTimeout = 300000
    SynchronizedEvents = False
    Left = 52
    Top = 28
  end
  object RESTClientWMS: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'http://192.168.0.165:8200'
    Params = <>
    RaiseExceptionOn500 = False
    SynchronizedEvents = False
    Left = 53
    Top = 82
  end
  object RESTResponseWMS: TRESTResponse
    Left = 57
    Top = 138
  end
  object RESTClientCep: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://www.cepaberto.com/api/v3/cep?cep=57020510'
    Params = <>
    RaiseExceptionOn500 = False
    SynchronizedEvents = False
    Left = 398
    Top = 6
  end
  object RESTRequestCep: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClientCep
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'Authorization'
        Options = [poDoNotEncode]
        Value = 'Token token="cca63b874d4c386e5638d050c8af5ce0"'
      end>
    Response = RESTResponseCep
    ConnectTimeout = 300000
    ReadTimeout = 300000
    SynchronizedEvents = False
    Left = 333
    Top = 25
  end
  object RESTResponseCep: TRESTResponse
    Left = 460
    Top = 27
  end
  object FdWmsSqlLite: TFDConnection
    Params.Strings = (
      'LockingMode=Normal'
      'OpenMode=ReadWrite'
      'DriverID=sQLite')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 202
    Top = 98
  end
  object QryVolumeProduto: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From PedidoVolumeProduto'
      'Order by Endereco')
    Left = 44
    Top = 206
  end
  object QryVolumeProdutoSalvar: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--https://www.sqlitetutorial.net/sqlite-functions/sqlite-iif/'
      'Update PedidoVolumeProduto'
      
        '--  Set QtdSuprida = iif(:F3Press = 1, :QtdF3Press, :Quantidade)' +
        ','
      '    Set qtdsuprida = (case :F3Press'
      '                       when 0 then QtdSuprida + :quantidade'
      '                          else :qtdf3press'
      '                       End),'
      '      usuarioid = :usuarioid,'
      '      QtdCorte  = QtdCorte + :QtdCorte,'
      '      data = date('#39'now'#39'),'
      '      horarioinicio = (case horarioinicio'
      '                       when 0 then time('#39'now'#39', '#39'localtime'#39')'
      '                          else horarioinicio'
      '                       End),'
      '        horariotermino   = time('#39'now'#39', '#39'localtime'#39')'
      
        'where PedidoVolumeid = :pedidovolumeid and codproduto = :codprod' +
        'uto')
    Left = 156
    Top = 206
    ParamData = <
      item
        Name = 'F3PRESS'
        ParamType = ptInput
      end
      item
        Name = 'QUANTIDADE'
        ParamType = ptInput
      end
      item
        Name = 'QTDF3PRESS'
        ParamType = ptInput
      end
      item
        Name = 'USUARIOID'
        ParamType = ptInput
      end
      item
        Name = 'QTDCORTE'
        ParamType = ptInput
      end
      item
        Name = 'PEDIDOVOLUMEID'
        ParamType = ptInput
      end
      item
        Name = 'CODPRODUTO'
        ParamType = ptInput
      end>
  end
  object QryVolumeLote: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--Codigo Nao usado, passado em tempo de execucao'
      'Select * From PedidoVolumeProduto'
      '')
    Left = 40
    Top = 260
  end
  object QryVolumeLoteSalvar: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      '--https://www.sqlitetutorial.net/sqlite-functions/sqlite-iif/'
      'Update PedidoVolumeLote'
      
        '--  Set QtdSuprida = iif(:F3Press = 1, :QtdF3Press, :Quantidade)' +
        ','
      '    Set qtdsuprida = (case :F3Press'
      '                       when 0 then QtdSuprida + :quantidade'
      '                          else :qtdf3press'
      '                       End),'
      '      QtdCorte  = QtdCorte + :QtdCorte,'
      '      usuarioid = :usuarioid,'
      '      data = date('#39'now'#39'),'
      '      horarioinicio = (case horarioinicio'
      '                       when 0 then time('#39'now'#39', '#39'localtime'#39')'
      '                          else horarioinicio'
      '                       End),'
      '        horariotermino   = time('#39'now'#39', '#39'localtime'#39')'
      
        'where PedidoVolumeid = :pedidovolumeid and codproduto = :codprod' +
        'uto and lote = :lote'
      ''
      ''
      ''
      '/*'
      'Update PedidoVolumeLote'
      '  Set QtdSuprida = QtdSuprida + :Quantidade,'
      '        usuarioid = :usuarioid,'
      '        data = date('#39'now'#39'),'
      '        horarioinicio = (case horarioinicio'
      '                          when 0 then time('#39'now'#39', '#39'localtime'#39')'
      '                          else horarioinicio'
      '                       End),'
      '        horariotermino   = time('#39'now'#39', '#39'localtime'#39')'
      
        'where PedidoVolumeid = :pedidovolumeid and codproduto = :codprod' +
        'uto and lote = :lote'
      '*/')
    Left = 156
    Top = 268
    ParamData = <
      item
        Name = 'F3PRESS'
        ParamType = ptInput
      end
      item
        Name = 'QUANTIDADE'
        ParamType = ptInput
      end
      item
        Name = 'QTDF3PRESS'
        ParamType = ptInput
      end
      item
        Name = 'QTDCORTE'
        ParamType = ptInput
      end
      item
        Name = 'USUARIOID'
        ParamType = ptInput
      end
      item
        Name = 'PEDIDOVOLUMEID'
        ParamType = ptInput
      end
      item
        Name = 'CODPRODUTO'
        ParamType = ptInput
      end
      item
        Name = 'LOTE'
        ParamType = ptInput
      end>
  end
  object QryGetVolumeProduto: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      ''
      'Select *'
      ' From PedidoVolumeProduto'
      'Where PedidoVolumeId = :PedidoVolumeId'
      'Order by Endereco;')
    Left = 272
    Top = 224
    ParamData = <
      item
        Name = 'PEDIDOVOLUMEID'
        ParamType = ptInput
      end>
  end
  object QryGetVolumeLote: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      ''
      'Select * From PedidoVolumeLote'
      'Where PedidoVolumeId = :PedidoVolumeId'
      '   And CodProduto = :CodProduto')
    Left = 272
    Top = 278
    ParamData = <
      item
        Name = 'PEDIDOVOLUMEID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CODPRODUTO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object QryDelVolumeProdutoLote: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      ''
      
        'Delete From PedidoVolumeProduto Where PedidoVolumeId = :PedidoVo' +
        'lumeIdPrd;'
      
        'Delete From PedidoVolumeLote Where PedidoVolumeId = :PedidoVolum' +
        'eIdLote;'
      ''
      '')
    Left = 390
    Top = 216
    ParamData = <
      item
        Name = 'PEDIDOVOLUMEIDPRD'
        ParamType = ptInput
      end
      item
        Name = 'PEDIDOVOLUMEIDLOTE'
        ParamType = ptInput
      end>
  end
  object QryPesquisa: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      ''
      
        'Delete From PedidoVolumeProduto Where PedidoVolumeId = :PedidoVo' +
        'lumeIdPrd'
      
        'Delete From PedidoVolumeLote Where PedidoVolumeId = :PedidoVolum' +
        'eIdLote'
      ''
      '')
    Left = 204
    Top = 152
    ParamData = <
      item
        Name = 'PEDIDOVOLUMEIDPRD'
        ParamType = ptInput
      end
      item
        Name = 'PEDIDOVOLUMEIDLOTE'
        ParamType = ptInput
      end>
  end
  object QryVolumeEAN: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      ''
      
        'select Vl.PedidoVolumeId, Pc.ProdutoId, CodBarras, UnidadesEmbal' +
        'agem'
      'From PedidoVOlumeLotes Vl'
      'Inner join ProdutoLotes Pl on Pl.LoteId = Vl.LoteId'
      'inner join ProdutocodBarras Pc On Pc.ProdutoId = Pl.ProdutoId'
      'where Vl.PedidoVOlumeId = :PedidoVolumeId'
      'Order by produtoid, pc.CodBarras')
    Left = 394
    Top = 270
    ParamData = <
      item
        Name = 'PEDIDOVOLUMEID'
        ParamType = ptInput
      end>
    object QryVolumeEANpedidovolumeid: TIntegerField
      FieldName = 'pedidovolumeid'
    end
    object QryVolumeEANprodutoid: TIntegerField
      FieldName = 'produtoid'
    end
    object QryVolumeEANcodbarras: TStringField
      FieldName = 'codbarras'
      Size = 25
    end
    object QryVolumeEANunidadesembalagem: TIntegerField
      FieldName = 'unidadesembalagem'
    end
  end
  object QryPesquisaVolumeLote: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      ''
      
        'Delete From PedidoVolumeProduto Where PedidoVolumeId = :PedidoVo' +
        'lumeIdPrd'
      
        'Delete From PedidoVolumeLote Where PedidoVolumeId = :PedidoVolum' +
        'eIdLote'
      ''
      '')
    Left = 272
    Top = 334
    ParamData = <
      item
        Name = 'PEDIDOVOLUMEIDPRD'
        ParamType = ptInput
      end
      item
        Name = 'PEDIDOVOLUMEIDLOTE'
        ParamType = ptInput
      end>
  end
  object ClientReport: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://www.cepaberto.com/api/v3/cep?cep=57020510'
    Params = <>
    RaiseExceptionOn500 = False
    SynchronizedEvents = False
    Left = 396
    Top = 80
  end
  object RequestReport: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = ClientReport
    Params = <
      item
        Kind = pkHTTPHEADER
        Name = 'Authorization'
        Options = [poDoNotEncode]
        Value = 'Token token="cca63b874d4c386e5638d050c8af5ce0"'
      end>
    Response = ResponseReport
    ConnectTimeout = 300000
    ReadTimeout = 300000
    SynchronizedEvents = False
    Left = 331
    Top = 99
  end
  object ResponseReport: TRESTResponse
    Left = 458
    Top = 101
  end
  object QryVolumeCorteLote: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      'Update PedidoVolumeLote'
      '    Set qtdcorte = Demanda - QtdSuprida,'
      '      usuarioid = :usuarioid,'
      '      data = date('#39'now'#39'),'
      '      horarioinicio = (case horarioinicio'
      '                       when 0 then time('#39'now'#39', '#39'localtime'#39')'
      '                          else horarioinicio'
      '                       End),'
      '        horariotermino   = time('#39'now'#39', '#39'localtime'#39')'
      'where PedidoVolumeid = :pedidovolumeid'
      '  and codproduto = :codproduto'
      '  and Demanda > QtdSuprida')
    Left = 156
    Top = 330
    ParamData = <
      item
        Name = 'USUARIOID'
        ParamType = ptInput
      end
      item
        Name = 'PEDIDOVOLUMEID'
        ParamType = ptInput
      end
      item
        Name = 'CODPRODUTO'
        ParamType = ptInput
      end>
  end
  object QryFinalizarVolumeLote: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      'select Vp.ProdutoId, Vl.*, Vp.EnderecoId'
      'From pedidovolumelote Vl'
      
        'inner join pedidovolumeproduto vp on vp.codproduto = vl.codprodu' +
        'to'
      'Where Vl.PedidoVolumeId = :PedidoVolumeId'
      '  and Vl.UsuarioId = :UsuarioId'
      'Order by Vl.CodProduto')
    Left = 398
    Top = 340
    ParamData = <
      item
        Name = 'PEDIDOVOLUMEID'
        ParamType = ptInput
      end
      item
        Name = 'USUARIOID'
        ParamType = ptInput
      end>
  end
  object QryVolumeDivergencia: TFDQuery
    Connection = FdWmsSqlLite
    SQL.Strings = (
      ''
      'select Sum(Demanda) Demanda, Sum(QtdSuprida) QtdSuprida'
      'from PedidoVOlumeProduto'
      'where PedidoVolumeId = :pPedidoVolumeId;')
    Left = 272
    Top = 396
    ParamData = <
      item
        Name = 'PPEDIDOVOLUMEID'
        ParamType = ptInput
      end>
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 234
    Top = 14
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 138
    Top = 16
  end
end
