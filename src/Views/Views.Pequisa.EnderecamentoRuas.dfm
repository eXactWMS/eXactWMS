inherited FrmPesquisaEnderecamentoRuas: TFrmPesquisaEnderecamentoRuas
  Caption = 'FrmPesquisaEnderecamentoRuas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 151
      Caption = 'Pesquisar Ruas do CD'
      ExplicitWidth = 151
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlFiltros: TPanel
        object Label1: TLabel
          Left = 14
          Top = 10
          Width = 33
          Height = 13
          Caption = 'Rua Id'
        end
        object lblPesquisaNome: TLabel
          Left = 84
          Top = 10
          Width = 49
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object EdtRuaId: TEdit
          Left = 14
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtDescricao: TEdit
          Left = 84
          Top = 29
          Width = 231
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
    end
  end
end
