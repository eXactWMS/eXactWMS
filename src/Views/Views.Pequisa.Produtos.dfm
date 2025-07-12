inherited FrmPesquisaProduto: TFrmPesquisaProduto
  Caption = 'FrmPesquisaProduto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 133
      Caption = 'Pesquisar Produtos'
      ExplicitWidth = 133
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlFiltros: TPanel
        object lblPesquisaCodigo: TLabel
          Left = 10
          Top = 10
          Width = 55
          Height = 13
          Caption = 'Produto Id'
        end
        object lblPesquisaNome: TLabel
          Left = 150
          Top = 10
          Width = 49
          Height = 13
          Caption = 'Descricao'
        end
        object Label1: TLabel
          Left = 80
          Top = 10
          Width = 60
          Height = 13
          Caption = 'C'#243'digo ERP'
        end
        object EdtProdutoId: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtDescricao: TEdit
          Left = 150
          Top = 29
          Width = 626
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object EdtCodigoERP: TEdit
          Left = 80
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 2
        end
      end
    end
  end
end
