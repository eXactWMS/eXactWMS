inherited FrmPesquisaFuncionalidade: TFrmPesquisaFuncionalidade
  Caption = 'FrmPesquisaFuncionalidade'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 182
      Caption = 'Pesquisar Funcionalidades'
      ExplicitWidth = 182
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlFiltros: TPanel
        object lblPesquisaNome: TLabel
          Left = 76
          Top = 10
          Width = 49
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object lblPesquisaCodigo: TLabel
          Left = 10
          Top = 10
          Width = 10
          Height = 13
          Caption = 'Id'
        end
        object EdtFuncionalidadeId: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtFuncionalidade: TEdit
          Left = 76
          Top = 29
          Width = 700
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
    end
  end
end
