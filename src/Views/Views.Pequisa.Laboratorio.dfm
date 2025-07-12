inherited FrmPesquisaLaboratorio: TFrmPesquisaLaboratorio
  Caption = 'FrmPesquisaLaboratorio'
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 148
      Caption = 'Pesquisar Fabricantes'
      ExplicitWidth = 148
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlBotoes: TPanel
        inherited btnIncluir: TSpeedButton
          Left = 105
          ExplicitLeft = 112
          ExplicitTop = -6
        end
        inherited btnAlterar: TSpeedButton
          Left = 210
          ExplicitLeft = 153
          ExplicitTop = 2
        end
        inherited btnExcluir: TSpeedButton
          Left = 315
          ExplicitLeft = 363
          ExplicitTop = 2
        end
        inherited btnPesquisar: TSpeedButton
          Left = 0
          ExplicitLeft = 21
          ExplicitTop = -2
        end
        inherited BtnFecharPb: TSpeedButton
          ExplicitLeft = 457
          ExplicitTop = 2
        end
      end
      inherited pnlFiltros: TPanel
        object lblPesquisaCodigo: TLabel
          Left = 10
          Top = 10
          Width = 10
          Height = 13
          Caption = 'Id'
        end
        object lblPesquisaNome: TLabel
          Left = 76
          Top = 10
          Width = 91
          Height = 13
          Caption = 'Nome Frabricante'
        end
        object edtPesquisaCodigo: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object edtPesquisaNome: TEdit
          Left = 76
          Top = 29
          Width = 700
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          TabOrder = 1
        end
      end
    end
  end
end
