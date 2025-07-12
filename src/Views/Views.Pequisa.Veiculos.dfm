inherited FrmPesquisaVeiculos: TFrmPesquisaVeiculos
  Caption = 'FrmPesquisaVeiculos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlHeader: TPanel
    inherited lblTitle: TLabel
      Width = 127
      Caption = 'Pesquisar Ve'#237'culos'
      ExplicitWidth = 127
    end
  end
  inherited CardPanel: TCardPanel
    inherited CardVisualizar: TCard
      inherited DBGrid: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'veiculoid'
            Title.Alignment = taRightJustify
            Title.Caption = 'Id'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'placa'
            Title.Caption = 'Placa'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'tipo'
            Title.Caption = 'Tipo'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'marca'
            Title.Caption = 'Marca'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'modelo'
            Title.Caption = 'Modelo'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cor'
            Title.Caption = 'Cor'
            Width = 90
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'tarakg'
            Title.Alignment = taRightJustify
            Title.Caption = 'Tara Kg'
            Width = 60
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'capacidade'
            Title.Alignment = taRightJustify
            Title.Caption = 'Capacidade Kg'
            Width = 90
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'Volume'
            Title.Caption = 'Volume m3'
            Width = 80
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'transportadoraid'
            Title.Alignment = taRightJustify
            Title.Caption = 'Transp.Id'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'transportadora'
            Title.Caption = 'Transportadora'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'status'
            Title.Caption = 'Status'
            Width = 60
            Visible = True
          end>
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
          Width = 79
          Height = 13
          Caption = 'Transportadora'
        end
        object EdtVeiculoId: TEdit
          Left = 10
          Top = 29
          Width = 60
          Height = 21
          Alignment = taRightJustify
          NumbersOnly = True
          TabOrder = 0
        end
        object EdtTransportadora: TEdit
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
