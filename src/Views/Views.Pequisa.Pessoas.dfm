inherited FrmPesquisaPessoas: TFrmPesquisaPessoas
  Caption = 'FrmPesquisaPessoas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Left = 17
      Top = 9
      ExplicitLeft = 17
      ExplicitTop = 9
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlFiltros: TPanel
        object lblPesquisaCodigo: TLabel
          Left = 10
          Top = 10
          Width = 10
          Height = 13
          Caption = 'Id'
        end
        object lblPesquisaNome: TLabel
          Left = 160
          Top = 10
          Width = 84
          Height = 13
          Caption = 'Raz'#227'o / Fantasia'
        end
        object Label1: TLabel
          Left = 86
          Top = 10
          Width = 60
          Height = 13
          Caption = 'C'#243'digo ERP'
        end
        object EdtPessoaId: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtRazao: TEdit
          Left = 160
          Top = 29
          Width = 616
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          CharCase = ecUpperCase
          TabOrder = 1
        end
        object EdtCodigoERP: TEdit
          Left = 86
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
