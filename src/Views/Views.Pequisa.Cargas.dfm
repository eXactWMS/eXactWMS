inherited FrmPesquisaCargas: TFrmPesquisaCargas
  Caption = 'FrmPesquisaCargas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 118
      Caption = 'Pesquisar Cargas'
      ExplicitWidth = 118
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
          Left = 156
          Top = 10
          Width = 66
          Height = 13
          Caption = 'Identifica'#231#227'o'
          Visible = False
        end
        object Label1: TLabel
          Left = 82
          Top = 10
          Width = 24
          Height = 13
          Caption = 'Rota'
        end
        object EdtIdentificacao: TEdit
          Left = 156
          Top = 29
          Width = 620
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Visible = False
        end
        object EdtCargaId: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 1
        end
        object EdtRotaId: TEdit
          Left = 82
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
