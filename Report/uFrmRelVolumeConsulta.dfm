inherited FrmRelVolumeConsulta: TFrmRelVolumeConsulta
  Caption = 'FrmRelVolumeConsulta'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited DsPesqGeral: TDataSource
    Left = 463
    Top = 284
  end
  inherited FdMemPesqGeral: TFDMemTable
    Left = 385
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 45516.491074201390000000
    ScriptText.Strings = (
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<Line#> Mod 2) then Begin'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := $00EBEBEB;'
      '  End'
      '  else Begin'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := ClNone;'
      '  End;  '
      
        '  Memo12.Text := <frxDBDataset1."Demanda">-<frxDBDataset1."QtdSu' +
        'prida">'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end
      item
        DataSet = frxDBLotes
        DataSetName = 'frxDBLotes'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'vModulo'
        Value = ''
      end
      item
        Name = 'vVersao'
        Value = ''
      end
      item
        Name = 'vUsuario'
        Value = ''
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      inherited PageHeader1: TfrxPageHeader
        Width = 1046.929810000000000000
        inherited Shape1: TfrxShapeView
          Width = 1031.811690000000000000
        end
        inherited Memo1: TfrxMemoView
          Left = 326.929345000000000000
        end
        inherited Memo2: TfrxMemoView
          Left = 326.929345000000000000
          Memo.UTF8W = (
            'Atendimento - Resumo por Volume')
        end
        inherited SysMemo1: TfrxSysMemoView
          Left = 918.425790000000000000
          Width = 102.047261180000000000
        end
        inherited SysMemo3: TfrxSysMemoView
          Left = 918.425790000000000000
          Width = 102.047261180000000000
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        Width = 1046.929810000000000000
        inherited Line2: TfrxLineView
          Left = -0.000002440000000000
          Top = 18.897647560000000000
          Width = 1031.811023620000000000
        end
        inherited Memo4: TfrxMemoView
          Left = 7.559060000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Pedido Id')
        end
        object Memo15: TfrxMemoView
          AllowVectorExport = True
          Left = 196.535560000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Fantasia')
        end
        object Memo20: TfrxMemoView
          AllowVectorExport = True
          Left = 90.708720000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          AllowVectorExport = True
          Left = 468.661720000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Rota')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 464.882190000000000000
        Width = 1046.929810000000000000
        inherited Line1: TfrxLineView
          Width = 1031.811023622047000000
        end
      end
      inherited MasterData1: TfrxMasterData
        Top = 253.228510000000000000
        Width = 1046.929810000000000000
        Child = frxReport1.ChildLotes
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 230.551330000000000000
          Top = 11.338590000000000000
          Width = 75.590551180000000000
          Visible = False
          Memo.UTF8W = (
            '')
        end
        object frxDBDataset1PedidoVolumeId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 75.590600000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PedidoVolumeId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."PedidoVolumeId"]')
        end
        object frxDBDataset1Sequencia: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 158.740260000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'Sequencia'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Sequencia"]')
        end
        object frxDBDataset1Embalagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 207.874150000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          DataField = 'Embalagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Embalagem"]')
        end
        object frxDBDataset1Processo: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 325.039580000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'Processo'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Processo"]')
        end
        object frxDBDataset1Zona: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 457.323130000000000000
          Width = 204.094620000000000000
          Height = 18.897650000000000000
          DataField = 'Zona'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Zona"]')
        end
        object frxDBDataset1Demanda: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 668.976810000000000000
          Width = 64.251968500000000000
          Height = 18.897650000000000000
          DataField = 'Demanda'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Demanda"]')
        end
        object frxDBDataset1QtdSuprida: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 740.787880000000000000
          Width = 64.251968500000000000
          Height = 18.897650000000000000
          DataField = 'QtdSuprida'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdSuprida"]')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 812.598950000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Atendida')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 166.299320000000000000
        Width = 1046.929810000000000000
        Child = frxReport1.ChildVolumes
        Condition = 'frxDBDataset1."PedidoId"'
        object Memo13: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 7.559059999999996000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."PedidoId"]')
        end
        object Memo14: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 196.535560000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Fantasia"]')
        end
        object Memo19: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 90.708720000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Fantasia"]')
        end
        object Memo21: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 468.661720000000000000
          Width = 211.653680000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Rota"]')
        end
      end
      object ChildVolumes: TfrxChild
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 207.874150000000000000
        Width = 1046.929810000000000000
        ToNRows = 0
        ToNRowsMode = rmCount
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 325.039580000000000000
          Top = 7.559060000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Processo')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 457.323130000000000000
          Top = 7.559060000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Zona')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 668.976810000000000000
          Top = 7.559060000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Demanda')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 740.787880000000000000
          Top = 7.559060000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Atendida')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 812.598950000000000000
          Top = 7.559060000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Corte')
        end
        object Memo16: TfrxMemoView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Top = 7.559060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Volume Id')
        end
        object Memo17: TfrxMemoView
          AllowVectorExport = True
          Left = 158.740260000000000000
          Top = 7.559060000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Seq.')
        end
        object Memo18: TfrxMemoView
          AllowVectorExport = True
          Left = 207.874150000000000000
          Top = 7.559060000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Embalagem')
        end
        object Line5: TfrxLineView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Top = 22.677180000000000000
          Width = 801.259842519685000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 381.732530000000000000
        Width = 1046.929810000000000000
        object Line3: TfrxLineView
          AllowVectorExport = True
          Top = 15.118120000000000000
          Width = 1031.811023620000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 336.378170000000000000
        Width = 1046.929810000000000000
        DataSet = frxDBLotes
        DataSetName = 'frxDBLotes'
        RowCount = 0
        object Memo23: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 113.385900000000000000
          Top = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBLotes."CodProduto"]')
        end
        object Memo24: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 196.535560000000000000
          Top = 3.779530000000000000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          DataField = 'Descricao'
          DataSet = frxDBLotes
          DataSetName = 'frxDBLotes'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBLotes."Descricao"]')
        end
        object Memo25: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 495.118430000000000000
          Top = 3.779530000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataField = 'Lote'
          DataSet = frxDBLotes
          DataSetName = 'frxDBLotes'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBLotes."Lote"]')
        end
        object Memo26: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 616.063390000000000000
          Top = 3.779530000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DataField = 'Endereco'
          DataSet = frxDBLotes
          DataSetName = 'frxDBLotes'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBLotes."Endereco"]')
        end
        object Memo28: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 725.669760000000000000
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'Demanda'
          DataSet = frxDBLotes
          DataSetName = 'frxDBLotes'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBLotes."Demanda"]')
        end
        object Memo29: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 778.583180000000000000
          Top = 3.779530000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'QtdSuprida'
          DataSet = frxDBLotes
          DataSetName = 'frxDBLotes'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBLotes."QtdSuprida"]')
        end
        object Memo27: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 835.276130000000000000
          Top = 3.779530000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'PesoKg'
          DataSet = frxDBLotes
          DataSetName = 'frxDBLotes'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBLotes."PesoKg"]')
        end
        object Memo30: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 925.984850000000000000
          Top = 3.779530000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DataField = 'Volm3'
          DataSet = frxDBLotes
          DataSetName = 'frxDBLotes'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBLotes."Volm3"]')
        end
      end
      object ChildLotes: TfrxChild
        FillType = ftBrush
        Frame.Typ = []
        Height = 15.118120000000000000
        Top = 298.582870000000000000
        Width = 1046.929810000000000000
        ToNRows = 0
        ToNRowsMode = rmCount
        object Memo31: TfrxMemoView
          AllowVectorExport = True
          Left = 113.385900000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'd.Prod.')
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Left = 113.385900000000000000
          Top = 15.118120000000000000
          Width = 914.645669291338600000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo32: TfrxMemoView
          AllowVectorExport = True
          Left = 196.535560000000000000
          Width = 294.803340000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Decri'#231#227'o')
        end
        object Memo33: TfrxMemoView
          AllowVectorExport = True
          Left = 495.118430000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Lote')
        end
        object Memo34: TfrxMemoView
          AllowVectorExport = True
          Left = 616.063390000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
        end
        object Memo35: TfrxMemoView
          AllowVectorExport = True
          Left = 725.669760000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Dem.')
        end
        object Memo36: TfrxMemoView
          AllowVectorExport = True
          Left = 778.583180000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Supr.')
        end
        object Memo37: TfrxMemoView
          AllowVectorExport = True
          Left = 835.276130000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Peso(kg)')
        end
        object Memo38: TfrxMemoView
          AllowVectorExport = True
          Left = 925.984850000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Volume(m3)')
        end
      end
    end
  end
  object FDMemLotes: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    IndexFieldNames = 'PedidoVolumeId'
    MasterSource = DsPesqGeral
    MasterFields = 'PedidoVolumeId'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 385
    Top = 445
  end
  object frxDBLotes: TfrxDBDataset
    UserName = 'frxDBLotes'
    CloseDataSource = False
    DataSet = FDMemLotes
    BCDToCurrency = False
    Left = 306
    Top = 453
  end
end
