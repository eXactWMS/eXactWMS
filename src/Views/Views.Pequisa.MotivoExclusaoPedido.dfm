inherited FrmPesquisaMotivoExclusaoPedido: TFrmPesquisaMotivoExclusaoPedido
  Caption = 'FrmPesquisaMotivoExclusaoPedido'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 341
      Caption = 'Pesquisar MEP (Motivo para Exclus'#227'o de Pedidos)'
      ExplicitWidth = 341
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited pnlFiltros: TPanel
        object lblPesquisaCodigo: TLabel
          Left = 21
          Top = 10
          Width = 49
          Height = 13
          Caption = 'Motivo Id'
        end
        object lblPesquisaNome: TLabel
          Left = 76
          Top = 10
          Width = 49
          Height = 13
          Caption = 'Descri'#231#227'o'
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
          TabOrder = 1
        end
      end
    end
  end
end
