inherited FrmPesquisaEndereco: TFrmPesquisaEndereco
  Caption = 'FrmPesquisaEndereco'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 141
      Caption = 'Pesquisar Endere'#231'os'
      ExplicitWidth = 141
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlFiltros: TPanel
        object Label1: TLabel
          Left = 14
          Top = 10
          Width = 48
          Height = 13
          Caption = 'Endere'#231'o'
        end
        object lblPesquisaNome: TLabel
          Left = 122
          Top = 10
          Width = 26
          Height = 13
          Caption = 'Zona'
        end
        object EdtEndereco: TEdit
          Left = 14
          Top = 29
          Width = 99
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtZona: TEdit
          Left = 122
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
