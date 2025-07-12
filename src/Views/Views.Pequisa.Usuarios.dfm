inherited FrmPesquisaUsuario: TFrmPesquisaUsuario
  Caption = 'FrmPesquisaUsuario'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 131
      Caption = 'Pesquisar Usu'#225'rios'
      ExplicitWidth = 131
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
          Left = 76
          Top = 10
          Width = 30
          Height = 13
          Caption = 'Nome'
        end
        object EdtUsuarioId: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtNome: TEdit
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
