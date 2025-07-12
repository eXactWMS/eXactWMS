inherited FrmRelProdutoSemPicking: TFrmRelProdutoSemPicking
  Caption = 'FrmRelProdutoSemPicking'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralProdutoId: TIntegerField
      FieldName = 'ProdutoId'
    end
    object FdMemPesqGeralCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FdMemPesqGeralEmbalagem: TIntegerField
      FieldName = 'Embalagem'
    end
    object FdMemPesqGeralAltura: TFloatField
      FieldName = 'Altura'
    end
    object FdMemPesqGeralLargura: TFloatField
      FieldName = 'Largura'
    end
    object FdMemPesqGeralComprimento: TFloatField
      FieldName = 'Comprimento'
    end
    object FdMemPesqGeralVolume: TFloatField
      FieldName = 'Volume'
    end
    object FdMemPesqGeralPeso: TFloatField
      FieldName = 'Peso'
    end
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 44499.401528310180000000
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
            'Produto(s) Sem Picking')
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        inherited Line2: TfrxLineView
          Left = -0.000002440000000000
        end
        inherited Memo4: TfrxMemoView
          Left = 7.559060000000000000
          Width = 56.692950000000000000
          Memo.UTF8W = (
            'Id')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 68.031540000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'C'#243'd.Erp')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 132.283550000000000000
          Width = 287.244280000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 430.866420000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Emb.')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 476.220780000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Alt.')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Larg.')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 570.709030000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Compr.')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 616.063390000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vol.Cm3')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 676.535870000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Peso')
        end
      end
      inherited MasterData1: TfrxMasterData
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 309.921460000000000000
          Width = 83.149660000000000000
          Height = 18.897637800000000000
          Visible = False
          Memo.UTF8W = (
            '[frxDBDataset1."ProdutoId"]')
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 132.283550000000000000
          Width = 279.685220000000000000
          Height = 18.897637800000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
        end
        object frxDBDataset1ProdutoId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'ProdutoId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."ProdutoId"]')
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 68.031540000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'CodProduto'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
        end
        object frxDBDataset1Largura: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 525.354670000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'Largura'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Largura"]')
        end
        object frxDBDataset1Embalagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 423.307360000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'Embalagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Embalagem"]')
        end
        object frxDBDataset1Altura: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 476.220780000000000000
          Width = 41.574800710000000000
          Height = 18.897650000000000000
          DataField = 'Altura'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Altura"]')
        end
        object frxDBDataset1Comprimento: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 570.709030000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          DataField = 'Comprimento'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Comprimento"]')
        end
        object frxDBDataset1Volume: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 616.063390000000000000
          Width = 56.692950000000000000
          Height = 18.897650000000000000
          DataField = 'Volume'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Volume"]')
        end
        object frxDBDataset1Peso: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 676.535870000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataField = 'Peso'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Peso"]')
        end
      end
    end
  end
end
