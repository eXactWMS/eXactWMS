inherited FrmRelReposicaoDemanda: TFrmRelReposicaoDemanda
  Caption = 'FrmRelReposicaoDemanda'
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
      inherited LstReport: TAdvStringGrid
        Top = 92
        Height = 432
        ColCount = 8
        ColumnHeaders.Strings = (
          'Prod.Id'
          'C'#243'digo ERP'
          'Descri'#231#227'o'
          'Endere'#231'o'
          'Embalagem'
          'Demanda'
          'Dispon'#237'vel'
          'Qtd.Repo.')
        ExplicitTop = 92
        ExplicitHeight = 432
        ColWidths = (
          74
          118
          74
          74
          74
          74
          74
          74)
      end
      object GroupBox1: TGroupBox
        Left = 21
        Top = 16
        Width = 183
        Height = 58
        CustomHint = BalloonHint1
        Caption = ' [ Data do Ressuprimento ] '
        TabOrder = 3
        object EdtDtDocumento: TJvDateEdit
          Left = 20
          Top = 22
          Width = 121
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtDtDocumentoChange
        end
      end
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnPesquisarStand: TsImage
        Left = 73
        ExplicitLeft = 73
      end
    end
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 668
    ExplicitLeft = 668
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited DsPesqGeral: TDataSource
    Left = 315
    Top = 286
  end
  inherited FdMemPesqGeral: TFDMemTable
    OnCalcFields = FdMemPesqGeralCalcFields
    StoreDefs = True
    Top = 283
    object FdMemPesqGeralProdutoid: TIntegerField
      FieldName = 'IdProduto'
    end
    object FdMemPesqGeralCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 80
    end
    object FdMemPesqGeralEnderecoId: TIntegerField
      FieldName = 'EnderecoId'
    end
    object FdMemPesqGeralEndereco: TStringField
      FieldName = 'Endereco'
      Size = 11
    end
    object FdMemPesqGeralFatorConversao: TIntegerField
      FieldName = 'FatorConversao'
    end
    object FdMemPesqGeralEmbalagemPadrao: TIntegerField
      FieldName = 'EmbalagemPadrao'
    end
    object FdMemPesqGeralQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object FdMemPesqGeralFracionado: TIntegerField
      FieldName = 'Fracionado'
    end
    object FdMemPesqGeralEstPicking: TIntegerField
      FieldName = 'EstPicking'
    end
    object FdMemPesqGeralQtdReposicao: TIntegerField
      FieldName = 'QtdReposicao'
    end
    object FdMemPesqGeralReAbastecer: TIntegerField
      FieldName = 'ReAbastecer'
    end
    object FdMemPesqGeralEmbalagem: TStringField
      FieldName = 'Embalagem'
      Size = 50
    end
    object FdMemPesqGeralQtdSuprida: TIntegerField
      FieldName = 'QtdSuprida'
    end
    object FdMemPesqGeralDisponivel: TIntegerField
      FieldName = 'Disponivel'
    end
    object FdMemPesqGeralEnderecoFormatado: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'EnderecoFormatado'
      Size = 14
    end
    object FdMemPesqGeralMascara: TStringField
      FieldName = 'Mascara'
      Size = 14
    end
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 44789.615646134260000000
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
            'Reposi'#231#227'o Demanda')
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        inherited Memo4: TfrxMemoView
          Left = 15.118120000000000000
          Width = 56.692950000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'd.Erp')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 170.078850000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 480.000310000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Embalagem')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 657.638220000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Q.Repo')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 563.149970000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Dem.')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 612.283860000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Disp.')
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 253.228510000000000000
      end
      inherited MasterData1: TfrxMasterData
        Height = 26.456710000000000000
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 597.165740000000000000
          Top = 11.338590000000000000
          Width = 56.692876770000000000
          Height = 18.897650000000000000
          Visible = False
          DataField = 'Produtoid'
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Produtoid"]')
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 18.897650000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataField = 'CodProduto'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 170.078850000000000000
          Width = 302.362400000000000000
          Height = 18.897650000000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
        end
        object frxDBDataset1FatorConversao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 480.000310000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'Embalagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Embalagem"]')
        end
        object frxDBDataset1reabastecer: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 657.638220000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataField = 'reabastecer'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."reabastecer"]')
        end
        object Memo11: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 563.149970000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."qtdsuprida"]')
        end
        object Memo12: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 612.283860000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."disponivel"]')
        end
        object frxDBDataset1EnderecoFormatado: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 75.590600000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EnderecoFormatado'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."EnderecoFormatado"]')
        end
      end
    end
  end
end
