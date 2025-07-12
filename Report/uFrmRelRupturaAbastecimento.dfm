inherited FrmRelRupturaAbastecimento: TFrmRelRupturaAbastecimento
  Caption = 'FrmRelRupturaAbastecimento'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LblTotRegCaption: TLabel
        Left = 9
        Top = 88
        ExplicitLeft = 9
        ExplicitTop = 88
      end
      inherited LblTotRegistro: TLabel
        Left = 132
        Top = 88
        ExplicitLeft = 132
        ExplicitTop = 88
      end
      inherited LstReport: TAdvStringGrid
        Top = 108
        Height = 416
        ColCount = 6
        ColumnHeaders.Strings = (
          'Id'
          'C'#243'd.ERP'
          'Descri'#231#227'o'
          'Quantidade'
          'Embalagem'
          'Estoque')
        ExplicitTop = 108
        ExplicitHeight = 416
        ColWidths = (
          74
          118
          74
          74
          74
          74)
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 13
        Width = 458
        Height = 69
        CustomHint = BalloonHint1
        Caption = ' [ Per'#237'odo ] '
        TabOrder = 3
        object Label12: TLabel
          Left = 16
          Top = 30
          Width = 32
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Inicial'
        end
        object Label14: TLabel
          Left = 222
          Top = 30
          Width = 26
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Final'
        end
        object EdtDtInicial: TJvDateEdit
          Left = 54
          Top = 26
          Width = 100
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 0
        end
        object EdtDtFinal: TJvDateEdit
          Left = 260
          Top = 26
          Width = 100
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 1
        end
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
    inherited TabimportacaoCSV: TcxTabSheet
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
    Left = 630
    Top = 196
    ExplicitLeft = 630
    ExplicitTop = 196
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralIdProduto: TIntegerField
      FieldName = 'IdProduto'
    end
    object FdMemPesqGeralCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 80
    end
    object FdMemPesqGeralQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object FdMemPesqGeralEmbalagem: TIntegerField
      FieldName = 'Embalagem'
    end
    object FdMemPesqGeralEstoque: TIntegerField
      FieldName = 'Estoque'
    end
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 44699.739246990740000000
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
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
      inherited PageHeader1: TfrxPageHeader
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            'Ruptura no Abastecimento')
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        inherited Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Memo.UTF8W = (
            'Id')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 64.252010000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#243'd.Erp')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 136.063080000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 408.189240000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Demanda')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 483.779840000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Emb.')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 585.827150000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Estoque')
        end
      end
      inherited MasterData1: TfrxMasterData
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 676.535870000000000000
          Top = 11.338590000000000000
          Width = 56.692901180000000000
          Height = 18.897650000000000000
          Visible = False
          Memo.UTF8W = (
            '[frxDBDataset1."IdProduto"]')
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 64.252010000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'CodProduto'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 136.063080000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
        end
        object frxDBDataset1Quantidade: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 408.189240000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Quantidade'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Quantidade"]')
        end
        object frxDBDataset1Embalagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 483.779840000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'Embalagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Embalagem"]')
        end
        object frxDBDataset1Estoque: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 585.827150000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'Estoque'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Estoque"]')
        end
        object frxDBDataset1IdProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 56.692923150000000000
          Height = 18.897650000000000000
          DataField = 'IdProduto'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."IdProduto"]')
        end
      end
    end
  end
end
