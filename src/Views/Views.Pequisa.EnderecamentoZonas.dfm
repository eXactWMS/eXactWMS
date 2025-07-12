inherited FrmPesquisaEnderecamentoZonas: TFrmPesquisaEnderecamentoZonas
  Caption = 'FrmPesquisaEnderecamentoZonas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 245
      Caption = 'Pesquisar Zonas de Endere'#231'amento'
      ExplicitWidth = 245
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlFiltros: TPanel
        object Label1: TLabel
          Left = 14
          Top = 10
          Width = 39
          Height = 13
          Caption = 'Zona Id'
        end
        object lblPesquisaNome: TLabel
          Left = 65
          Top = 10
          Width = 49
          Height = 13
          Caption = 'Descri'#231#227'o'
        end
        object EdtZonaId: TEdit
          Left = 14
          Top = 29
          Width = 39
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtDescricao: TEdit
          Left = 65
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
