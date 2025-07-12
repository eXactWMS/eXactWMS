inherited FrmRelProdutos: TFrmRelProdutos
  Caption = 'FrmRelProdutos'
  ClientHeight = 867
  ClientWidth = 1259
  ExplicitWidth = 1261
  ExplicitHeight = 869
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1260
    Height = 812
    ExplicitWidth = 1260
    ExplicitHeight = 812
    ClientRectBottom = 812
    ClientRectRight = 1260
    inherited TabListagem: TcxTabSheet
      ExplicitWidth = 1260
      ExplicitHeight = 788
      inherited LstCadastro: TAdvStringGrid
        Width = 1240
        Height = 750
        ExplicitWidth = 1240
        ExplicitHeight = 750
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 750
        ExplicitHeight = 750
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1260
        ExplicitWidth = 1260
        inherited BtnPesqConsGeral: TsImage
          Left = 701
          ExplicitLeft = 701
        end
        inherited LblClearFilter: TLabel
          Left = 736
          ExplicitLeft = 736
        end
        inherited LblRegTit: TLabel
          Left = 940
          ExplicitLeft = 940
        end
        inherited LblTotReg: TLabel
          Left = 1076
          ExplicitLeft = 1076
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 359
          ExplicitWidth = 359
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1260
      ExplicitHeight = 788
      inherited LblTotRegCaption: TLabel
        Top = 132
        ExplicitTop = 132
      end
      inherited LblTotRegistro: TLabel
        Top = 132
        ExplicitTop = 132
      end
      object LblExportando: TLabel [3]
        Left = 448
        Top = 129
        Width = 160
        Height = 21
        CustomHint = BalloonHint1
        Caption = 'Exportando Registro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited PnlInfo: TPanel
        Top = 602
        ExplicitTop = 602
      end
      inherited LstReport: TAdvStringGrid
        Top = 152
        Width = 1260
        Height = 636
        ColCount = 27
        ColumnHeaders.Strings = (
          'C'#243'digo'
          'Descri'#231#227'o'
          'Embalagem'
          'Zona'
          'Endere'#231'o'
          'Rastro'
          'Fabricante'
          'Curva'
          'Peso(kg)'
          'Alt'
          'Larg'
          'Compr'
          'Volume Cm'
          'Volume m3'
          'SNGPC'
          'Estoque'
          'Ean 01'
          'Ean 02'
          'Ean 03'
          'Ean 04'
          'Ean 05'
          'Ean 06'
          'Ean 07'
          'Ean 08'
          'Ean 09'
          'Ean 10'
          'Cxa.Fec.')
        ExplicitTop = 155
        ExplicitWidth = 1260
        ExplicitHeight = 372
        ColWidths = (
          74
          118
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74)
      end
      object GbProduto: TGroupBox
        Left = 8
        Top = 3
        Width = 535
        Height = 52
        CustomHint = BalloonHint1
        Caption = ' [ Produto ] '
        TabOrder = 3
        object LblProduto: TLabel
          Left = 151
          Top = 21
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object BtnSchProduto: TBitBtn
          Left = 123
          Top = 18
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            36090000424D3609000000000000360000002800000018000000180000000100
            2000000000000009000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000004390FFE24390FFE20000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000004792FFDB277FFFFF277FFFFF4490FFE10000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE7000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00004792FFDB277FFFFF277FFFFF277FFFFF408EFFE70000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE700000000000000000000
            0000000000000000000000000000000000000000000000000000000000004792
            FFDB277FFFFF277FFFFF277FFFFF408EFFE7000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000004792FFDB277F
            FFFF277FFFFF277FFFFF408EFFE700000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000067A5FF40438FFFE32A81
            FFFE277FFFFF277FFFFF2A81FFFE4490FFE168A5FF3B68A5FF3B277FFFFF277F
            FFFF277FFFFF4390FFE20000000000000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005399FFB6277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
            FFFF4390FFE2000000000000000000000000000000000000000000000000277F
            FFFF4390FFE200000000000000005399FFB6277FFFFF277FFFFF3185FFFA5A9D
            FF976AA7FF236AA7FF23599DFF993185FFFA277FFFFF277FFFFF277FFFFF67A5
            FF40000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000067A5FF42277FFFFF277FFFFF4591FFDD000000000000
            0000000000000000000000000000000000004591FFDF277FFFFF277FFFFF67A5
            FF42000000000000000000000000000000000000000000000000000000000000
            00000000000000000000428FFFE5277FFFFF3285FFFA00000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000000000
            000000000000000000002880FFFF277FFFFF5A9DFF9600000000000000000000
            00000000000000000000000000000000000000000000599DFF99277FFFFF2980
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            000000000000000000002980FFFF277FFFFF5A9DFF9400000000000000000000
            000000000000000000000000000000000000000000005A9DFF97277FFFFF2A81
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000418EFFE6277FFFFF3286FFF900000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000066A4FF47277FFFFF277FFFFF4792FFDB000000000000
            0000000000000000000000000000000000004591FFDD277FFFFF277FFFFF68A5
            FF3B00000000000000004390FFE200000000000000000000000000000000277F
            FFFF4390FFE200000000000000005198FFBB277FFFFF277FFFFF3286FFF95A9D
            FF946BA7FF206BA7FF205A9DFF963285FFFA277FFFFF277FFFFF5399FFB40000
            0000000000004390FFE2277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005298FFB8277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF5399FFB4000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000066A5FF45428FFFE52980
            FFFF277FFFFF277FFFFF2A81FFFE428FFFE467A5FF3D00000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE100000000000000000000
            000000000000000000000000000000000000000000004792FFDB277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE1000000000000
            0000000000000000000000000000000000004792FFDB277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          TabStop = False
          OnClick = BtnSchProdutoClick
        end
        object EdtProdutoId: TEdit
          Left = 13
          Top = 17
          Width = 110
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtProdutoIdChange
          OnExit = EdtProdutoIdExit
        end
      end
      object GbZona: TGroupBox
        Left = 8
        Top = 57
        Width = 535
        Height = 52
        CustomHint = BalloonHint1
        Caption = ' [ Zona ] '
        TabOrder = 4
        object LblZona: TLabel
          Left = 79
          Top = 21
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object BtnSchZona: TBitBtn
          Left = 51
          Top = 18
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            36090000424D3609000000000000360000002800000018000000180000000100
            2000000000000009000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000004390FFE24390FFE20000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000004792FFDB277FFFFF277FFFFF4490FFE10000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE7000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00004792FFDB277FFFFF277FFFFF277FFFFF408EFFE70000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE700000000000000000000
            0000000000000000000000000000000000000000000000000000000000004792
            FFDB277FFFFF277FFFFF277FFFFF408EFFE7000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000004792FFDB277F
            FFFF277FFFFF277FFFFF408EFFE700000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000067A5FF40438FFFE32A81
            FFFE277FFFFF277FFFFF2A81FFFE4490FFE168A5FF3B68A5FF3B277FFFFF277F
            FFFF277FFFFF4390FFE20000000000000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005399FFB6277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
            FFFF4390FFE2000000000000000000000000000000000000000000000000277F
            FFFF4390FFE200000000000000005399FFB6277FFFFF277FFFFF3185FFFA5A9D
            FF976AA7FF236AA7FF23599DFF993185FFFA277FFFFF277FFFFF277FFFFF67A5
            FF40000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000067A5FF42277FFFFF277FFFFF4591FFDD000000000000
            0000000000000000000000000000000000004591FFDF277FFFFF277FFFFF67A5
            FF42000000000000000000000000000000000000000000000000000000000000
            00000000000000000000428FFFE5277FFFFF3285FFFA00000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000000000
            000000000000000000002880FFFF277FFFFF5A9DFF9600000000000000000000
            00000000000000000000000000000000000000000000599DFF99277FFFFF2980
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            000000000000000000002980FFFF277FFFFF5A9DFF9400000000000000000000
            000000000000000000000000000000000000000000005A9DFF97277FFFFF2A81
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000418EFFE6277FFFFF3286FFF900000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000066A4FF47277FFFFF277FFFFF4792FFDB000000000000
            0000000000000000000000000000000000004591FFDD277FFFFF277FFFFF68A5
            FF3B00000000000000004390FFE200000000000000000000000000000000277F
            FFFF4390FFE200000000000000005198FFBB277FFFFF277FFFFF3286FFF95A9D
            FF946BA7FF206BA7FF205A9DFF963285FFFA277FFFFF277FFFFF5399FFB40000
            0000000000004390FFE2277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005298FFB8277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF5399FFB4000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000066A5FF45428FFFE52980
            FFFF277FFFFF277FFFFF2A81FFFE428FFFE467A5FF3D00000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE100000000000000000000
            000000000000000000000000000000000000000000004792FFDB277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE1000000000000
            0000000000000000000000000000000000004792FFDB277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          TabStop = False
          OnClick = BtnSchZonaClick
        end
        object EdtZonaId: TEdit
          Left = 12
          Top = 17
          Width = 39
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtZonaIdChange
          OnExit = EdtZonaIdExit
        end
      end
      object GbOpcoes: TGroupBox
        Left = 542
        Top = 3
        Width = 614
        Height = 52
        CustomHint = BalloonHint1
        Caption = '[ Op'#231#245'es ]'
        TabOrder = 5
        object ChkSaldoEstoque: TCheckBox
          Left = 12
          Top = 25
          Width = 129
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Saldo de Estoque'
          Enabled = False
          TabOrder = 0
          OnClick = ChkSaldoEstoqueClick
        end
        object ChkSemPicking: TCheckBox
          Left = 164
          Top = 25
          Width = 129
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Sem Picking'
          Enabled = False
          TabOrder = 1
          OnClick = ChkSaldoEstoqueClick
        end
        object ChkDadosLogisticos: TCheckBox
          Left = 308
          Top = 25
          Width = 129
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dados Log'#237'ticos'
          Enabled = False
          TabOrder = 2
          OnClick = ChkSaldoEstoqueClick
        end
        object ChkListaEan: TCheckBox
          Left = 454
          Top = 25
          Width = 157
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Listar C'#243'digo de Barras'
          Enabled = False
          TabOrder = 3
          OnClick = ChkSaldoEstoqueClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 542
        Top = 57
        Width = 614
        Height = 52
        CustomHint = BalloonHint1
        Caption = ' [ Fabricante ] '
        TabOrder = 6
        object LblLaboratorio: TLabel
          Left = 79
          Top = 21
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object BtnSchLaboratorio: TBitBtn
          Left = 51
          Top = 18
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            36090000424D3609000000000000360000002800000018000000180000000100
            2000000000000009000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000004390FFE24390FFE20000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000004792FFDB277FFFFF277FFFFF4490FFE10000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE7000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00004792FFDB277FFFFF277FFFFF277FFFFF408EFFE70000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF408EFFE700000000000000000000
            0000000000000000000000000000000000000000000000000000000000004792
            FFDB277FFFFF277FFFFF277FFFFF408EFFE7000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            00000000000000000000000000000000000000000000000000004792FFDB277F
            FFFF277FFFFF277FFFFF408EFFE700000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000067A5FF40438FFFE32A81
            FFFE277FFFFF277FFFFF2A81FFFE4490FFE168A5FF3B68A5FF3B277FFFFF277F
            FFFF277FFFFF4390FFE20000000000000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005399FFB6277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
            FFFF4390FFE2000000000000000000000000000000000000000000000000277F
            FFFF4390FFE200000000000000005399FFB6277FFFFF277FFFFF3185FFFA5A9D
            FF976AA7FF236AA7FF23599DFF993185FFFA277FFFFF277FFFFF277FFFFF67A5
            FF40000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000067A5FF42277FFFFF277FFFFF4591FFDD000000000000
            0000000000000000000000000000000000004591FFDF277FFFFF277FFFFF67A5
            FF42000000000000000000000000000000000000000000000000000000000000
            00000000000000000000428FFFE5277FFFFF3285FFFA00000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000000000
            000000000000000000002880FFFF277FFFFF5A9DFF9600000000000000000000
            00000000000000000000000000000000000000000000599DFF99277FFFFF2980
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            00000000000000000000277FFFFF277FFFFF6AA7FF2300000000000000000000
            000000000000000000000000000000000000000000006AA7FF26277FFFFF277F
            FFFF000000000000000000000000000000000000000000000000000000000000
            000000000000000000002980FFFF277FFFFF5A9DFF9400000000000000000000
            000000000000000000000000000000000000000000005A9DFF97277FFFFF2A81
            FFFE000000000000000000000000000000000000000000000000000000000000
            00000000000000000000418EFFE6277FFFFF3286FFF900000000000000000000
            000000000000000000000000000000000000000000003185FFFA277FFFFF438F
            FFE3000000000000000000000000000000000000000000000000000000004390
            FFE2000000000000000066A4FF47277FFFFF277FFFFF4792FFDB000000000000
            0000000000000000000000000000000000004591FFDD277FFFFF277FFFFF68A5
            FF3B00000000000000004390FFE200000000000000000000000000000000277F
            FFFF4390FFE200000000000000005198FFBB277FFFFF277FFFFF3286FFF95A9D
            FF946BA7FF206BA7FF205A9DFF963285FFFA277FFFFF277FFFFF5399FFB40000
            0000000000004390FFE2277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000005298FFB8277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF5399FFB4000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000066A5FF45428FFFE52980
            FFFF277FFFFF277FFFFF2A81FFFE428FFFE467A5FF3D00000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF0000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE100000000000000000000
            000000000000000000000000000000000000000000004792FFDB277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
            FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF4490FFE1000000000000
            0000000000000000000000000000000000004792FFDB277FFFFF277FFFFF277F
            FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          TabOrder = 1
          TabStop = False
          OnClick = BtnSchLaboratorioClick
        end
        object EdtLaboratorioId: TEdit
          Left = 12
          Top = 17
          Width = 39
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtLaboratorioIdChange
          OnExit = EdtLaboratorioIdExit
        end
      end
      object ChkSomenteCxaFechada: TCheckBox
        Left = 22
        Top = 109
        Width = 267
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Produtos Atendidos somente Cxa.Fechada'
        Enabled = False
        TabOrder = 7
      end
      object ChkAtivo: TCheckBox
        Left = 554
        Top = 109
        Width = 267
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Somente Ativos'
        Enabled = False
        TabOrder = 8
        OnClick = ChkAtivoClick
      end
      object ChkBloqueado: TCheckBox
        Left = 1022
        Top = 109
        Width = 267
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Somente Bloqueado'
        Enabled = False
        TabOrder = 9
        OnClick = ChkBloqueadoClick
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitWidth = 1260
      ExplicitHeight = 788
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitWidth = 1260
      ExplicitHeight = 788
      inherited DbgImporta: TDBGrid
        Width = 1260
        Height = 584
      end
    end
  end
  inherited PnHeader: TPanel
    Width = 1259
    ExplicitWidth = 1259
    inherited ImgClose: TImage
      Left = 1226
      ExplicitLeft = 1226
    end
    inherited ImgMinimize: TImage
      Left = 1206
      ExplicitLeft = 1206
    end
    inherited PanWin8: TPanel
      Width = 1259
      ExplicitWidth = 1259
      inherited BtnExportarStand: TsImage
        Top = 5
        ExplicitTop = 5
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1057
    Top = -81
    ExplicitLeft = 1057
    ExplicitTop = -81
  end
  inherited PnlErro: TPanel
    Top = 845
    Width = 1259
    ExplicitTop = 845
    ExplicitWidth = 1259
    inherited LblMensShowErro: TLabel
      Width = 1259
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 957
    Top = 475
    ExplicitLeft = 957
    ExplicitTop = 475
  end
  inherited FdMemPesqGeral: TFDMemTable
    OnCalcFields = FdMemPesqGeralCalcFields
    object FdMemPesqGeralCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FdMemPesqGeralEmbalagem: TStringField
      FieldName = 'Embalagem'
      Size = 30
    end
    object FdMemPesqGeralZonaDescricao: TStringField
      FieldName = 'ZonaDescricao'
      Size = 30
    end
    object FdMemPesqGeralEndereco: TStringField
      FieldName = 'Endereco'
      Size = 11
    end
    object FdMemPesqGeralMascara: TStringField
      FieldName = 'Mascara'
      Visible = False
      Size = 14
    end
    object FdMemPesqGeralRastro: TStringField
      FieldName = 'Rastro'
    end
    object FdMemPesqGeralLaboratorioId: TIntegerField
      FieldName = 'LaboratorioId'
    end
    object FdMemPesqGeralFabricante: TStringField
      FieldName = 'Fabricante'
      Size = 100
    end
    object FdMemPesqGeralCurva: TStringField
      FieldName = 'Curva'
      Size = 2
    end
    object FdMemPesqGeralPesoLiquido: TFloatField
      FieldName = 'PesoLiquido'
    end
    object FdMemPesqGeralAltura: TFloatField
      FieldName = 'Altura'
    end
    object FdMemPesqGeralLargura: TFloatField
      FieldName = 'Largura'
    end
    object FdMemPesqGeralComprimento: TFloatField
      FieldName = 'Comprimento'
    end
    object FdMemPesqGeralVolCm3: TFloatField
      FieldName = 'Volm3'
    end
    object FdMemPesqGeralSngpc: TIntegerField
      FieldName = 'Sngpc'
    end
    object FdMemPesqGeralEstoque: TIntegerField
      FieldName = 'Estoque'
    end
    object FdMemPesqGeralEnderecoFormatado: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'EnderecoFormatado'
      Size = 14
    end
    object FdMemPesqGeralEan01: TStringField
      FieldName = 'Ean01'
      Size = 25
    end
    object FdMemPesqGeralEan02: TStringField
      FieldName = 'Ean02'
      Size = 25
    end
    object FdMemPesqGeralEan03: TStringField
      FieldName = 'Ean03'
      Size = 25
    end
    object FdMemPesqGeralEan04: TStringField
      FieldName = 'Ean04'
      Size = 25
    end
    object FdMemPesqGeralEan05: TStringField
      FieldName = 'Ean05'
      Size = 25
    end
    object FdMemPesqGeralEan06: TStringField
      FieldName = 'Ean06'
      Size = 25
    end
    object FdMemPesqGeralEan07: TStringField
      FieldName = 'Ean07'
      Size = 25
    end
    object FdMemPesqGeralEan08: TStringField
      FieldName = 'Ean08'
      Size = 25
    end
    object FdMemPesqGeralEan09: TStringField
      FieldName = 'Ean09'
      Size = 25
    end
    object FdMemPesqGeralEan10: TStringField
      FieldName = 'Ean10'
      Size = 25
    end
    object FdMemPesqGeralSomenteCxaFechada: TIntegerField
      FieldName = 'SomenteCxaFechada'
    end
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 44826.424975462960000000
    ScriptText.Strings = (
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'vModulo'
        Value = Null
      end
      item
        Name = 'vVersao'
        Value = Null
      end
      item
        Name = 'vUsuario'
        Value = Null
      end
      item
        Name = 'vFiltro'
        Value = Null
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        Height = 68.031540000000000000
        inherited Shape1: TfrxShapeView
          Height = 64.252010000000000000
        end
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            'Relat'#243'rio de Produtos')
        end
        inherited Picture1: TfrxPictureView
          Left = 7.559060000000000000
        end
        object vFiltro: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 45.354360000000000000
          Top = 41.574830000000000000
          Width = 627.401980000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[vFiltro]')
          ParentFont = False
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        Top = 109.606370000000000000
        inherited Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          HAlign = haRight
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 60.472480000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 374.173470000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Embalagem')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 559.370440000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Zona')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 464.882190000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 676.535870000000000000
          Width = 41.574803150000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Curva')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 275.905690000000000000
      end
      inherited MasterData1: TfrxMasterData
        Top = 192.756030000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint_inherited'
        inherited frxDBDataset1Background: TfrxMemoView
          Visible = False
          OnBeforePrint = 'frxDBDataset1BackgroundOnBeforePrint_inherited'
          HAlign = haRight
          WordWrap = False
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 52.913385826771650000
          Height = 18.897650000000000000
          DataField = 'CodProduto'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 60.472480000000000000
          Width = 309.921460000000000000
          Height = 18.897650000000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
        end
        object frxDBDataset1Embalagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 374.173470000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'Embalagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Embalagem"]')
        end
        object frxDBDataset1ZonaDescricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 559.370440000000000000
          Width = 109.606370000000000000
          Height = 18.897650000000000000
          DataField = 'ZonaDescricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."ZonaDescricao"]')
        end
        object frxDBDataset1EnderecoFormatado: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 464.882190000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          DataField = 'EnderecoFormatado'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."EnderecoFormatado"]')
        end
        object frxDBDataset1Curva: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 676.535870000000000000
          Width = 41.574830000000000000
          Height = 18.897650000000000000
          DataField = 'Curva'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Curva"]')
        end
      end
    end
  end
  object frxDadosLogisticos: TfrxReport
    Version = '6.4.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'Grupo X3'
    ReportOptions.CreateDate = 41746.768122685200000000
    ReportOptions.LastChange = 44807.003568263890000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 246
    Top = 403
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'vModulo'
        Value = Null
      end
      item
        Name = 'vVersao'
        Value = Null
      end
      item
        Name = 'vUsuario'
        Value = Null
      end
      item
        Name = 'vFiltro'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 68.031540000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 710.551640000000000000
          Height = 64.252010000000000000
          Frame.Typ = []
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 162.519790000000000000
          Width = 393.071120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'eXactWMS')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 162.519790000000000000
          Top = 15.118120000000000000
          Width = 393.071120000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Relat'#243'rio de Produtos - Dados Log'#237'sticos')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 34.015770000000000000
          Frame.Typ = []
          Picture.Data = {
            0B54504E474772617068696356D00000424D56D0000000000000360000002800
            0000780000006F000000010020000000000020D0000000000000000000000000
            000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719701157
            1970115719701157197011571970115719701157197011571970115719701157
            1970115719701157197011571970115719701157197011571970115719701157
            1970115719701157197011571970FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719781157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980125D1A7C1598277A12EC3B7A12EF
            3C7A12EF3C7A12EF3C7A13EF3D7A12EF3D7A13EF3D7A12EF3C7A12F03D7A12EF
            3C7A12EF3C7A13F03D7A12EF3C7A12EF3C7A13EF3D7A13EF3D7A12EF3C7A13EF
            3D7A12EF3C7A13F03D7A13EF3D7A12EF3C7A13EF3D7A13EF3D7A12EF3C7A13EF
            3C7A12EF3C7A12EF3C7A12F03C7A13EF3D7A13F03D7A12EF3C7A12EF3D7A12EF
            3C7A13F03D7A13F03D7A12EF3C7A12F03C7A13EF3D7A12EF3C7AFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980158D258012EE3C8012EF
            3C8013F03D8013F03D8013EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012F0
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8013F03C8013EF3D8012EF3C8013F03D8012F0
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571970115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801158198015CD348013EF3D8012EF
            3C8012EF3C8013F03D8013EF3D8013F03D8012EF3C8013EF3D8013EF3C8013EF
            3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8013EF3D8012F03C8012EF3C8013F03D8013EF3D8013EF3C8013EF3D8013EF
            3D8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8012F03C8013EF3D8012EF3C8012F03C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197F115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198014721F8012EB3B8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8013EF3D8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057195811571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198014A62B8013EF3D8013EF3D8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03C8012EF3C8012EF3C8013EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013F03D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057197811571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980125F1B8014D7368012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3C8013EF3C8012EF3C8013F0
            3D8013EF3D8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8012F03C8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8013EF3D8013EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801480228012ED3C8013F03D8012EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012F0
            3C8013F03D8013EF3C8012EF3C8013F03D8013EF3D8013EF3D8012F03C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8013F03D8013F03D8012EF3C8013F03D8013EF
            3D8013EF3D8013EF3C8013F03D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1157196E1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801158198015C1318013EF3D8012F03C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013F0
            3D8013EF3D8013F03D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8012F0
            3C8013EF3C8013EF3D8012EF3C8012EF3C8013EF3C8012EF3C8013EF3D8013EF
            3D8013F03D8012EF3C8012EF3C8013F03C8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197E1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198013671C8013E4398012F03C8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3C8012EF3C8013EF3D8013EF3D8013F0
            3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF
            3C8012EF3C8012F03C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3C8013EF
            3D8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801596278012EE3C8012F03C8013EF3D8012EF3C8012EF
            3C8013EF3D8012EF3C8013F03C8013EF3D8013F03D8012EF3B8013EF3D8012EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8013F03C8013EF3D8013F03D8013EF3D8013EF3D8013EF3C8013EF3D8013EF
            3D8012EF3C8013EF3C8012EF3C8013F03D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF1157197A115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980125C1A8014C9338012EF3C8013EF3D8013EF3D8012EF3C8012F0
            3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8013EF3D8013EF3D8013F03D8013EF3C8012EF3C8012EF3C8013F03D8013EF
            3D8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012F03C8013EF
            3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1058183F11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198014731F8012EC3B8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8013EF3D8013EF3D8012F0
            3C8012EF3C8012EF3C8012F03C8012F03C8013EF3D8013F03C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3C8013EF3D8013EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013F03D8013F03D8013EF
            3D8012EF3C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157196A11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801158198015AA2C8012EF3C8012F03C8012F03C8013EF3D8013F03D8012EF
            3C8013EF3D8013F03D8012F03C8013EF3D8012EF3C8013EF3D8012F03C8012F0
            3C8013EF3D8012F03C8013F03D8013EF3D8012EF3C8012F03C8013F03D8013EF
            3D8013EF3C8013EF3D8013EF3D8012EF3C8013F03D8012EF3C8012F03C8013EF
            3D8013EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8013EF3C8013EF
            3D8013F03D8013EF3C8012EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157197D11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198012611B8014DA378012EF3C8013F03D8013F03D8012EF3C8013EF3D8012EF
            3C8013EF3D8013F03D8012EF3C8012EF3C8012EF3C8012F03C8012EF3C8013EF
            3D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3C8012EF3C8013EF3D8013EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012F0
            3C8012F03C8012F03C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF115718591157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801587248013ED3C8012EF3C8012EF3C8013EF3D8013F03C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013F03D8013EF3D8013EF
            3D8013EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF
            3C8013F03D8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8013F0
            3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8013F03D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF115719781157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198014C5328013EF3D8012F03C8013EF3D8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C8013F03D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C8013F03D8013F03D8012EF3C8012EF3C8012EF3C8013EF
            3D8013F03D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057
            1841115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198011571980146D
            1E8013E73A8013EF3D8013EF3D8013EF3D8013EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012EF3C8013F03D8013EF
            3D8012EF3C8012EF3C8013EF3D8013F03D8012F03C8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8013F03D8013EF3D8012F03C8013EF3D8012EF
            3C8012F03C8012EF3C8012EF3C8013F03D8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            196B115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198011571980159E
            288012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012F03C8013EF3D8013F03D8013EF3D8012F03C8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3C8013F03D8013EF3D8012F03C8013EF3D8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF3D8012EF
            3C8012F03C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            197E115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980125C1A8015CC
            348012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF
            3C8013EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8012F03C8013F03D8012EF3C8013EF
            3D8012EF3C8012F03C8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8013F03D8013EF3D8012EF3C8012F03C8013F03D8013EF3C8013EF3D8013F0
            3C8013F03D8013F03D8012EF3C8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105718521157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980115719801376208014E9
            3B8013EF3D8012F03C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8012F03C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3C8013F03D8012EF3C8012EF
            3C8013F03D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012F03C8013EF
            3D8013EF3D8012EF3C8013EF3D8012F03C8012EF3C8012EF3C8013F03D8012EF
            3C8012EF3C8013EF3C8012EF3C8012EF3C8013F03D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719781157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198015B12D8012EF
            3C8013EF3D8012EF3C8013EF3D8013F03D8013EF3D8012F03C8013EF3D8013EF
            3D8012EF3C8012EF3C7212EF3C6712EF3C6712EF3C6712EF3C6712EF3C6712EF
            3C6712EF3C6712EF3C6712EF3C6713EF3C6712EF3C6713EF3C6712EF3C6712EF
            3C6813EF3D7D12EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8013EF3D8013EF3D8013F03D8012EF3C8013EF3D8013EF3D8013EF3D8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198013631C8013DF388013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF
            3C8012EF3C64FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EE
            3D0712F03C7613EF3D8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8012F03C8013EF3D8013EF3D8013EF
            3D8013EF3D8012EF3C8013EF3C8013EF3D8013F03D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157196B115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980158E258012ED3C8013EF
            3D8012EF3C8012EF3C8013EF3D8013F03D8013EF3D8012EF3C8012EF3C8012F0
            3C52FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3C7612EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013F03D8013F03D8013EF
            3D8013F03D8013EF3D8013EF3D8012EF3C8012EF3C8013F03D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197F115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980125A198015C3318012EF3C8012EF
            3C8012EF3C8013F03D8012EF3C8013EF3D8013EF3D8013F03D8013F03D4DFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12F03D7612EF3C8012EF3C8013F03D8013EF3C8013EF3D8013EF3D8012F0
            3C8013F03D8013F03D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8013EF3D8012F03C8012EF3C8012EF3C8013F03D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1158185411571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980136E1E8013E73A8012F03C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3C80FFFFFFFEFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF13F03D7613EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013F0
            3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197911571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980159E298012EF3C8013EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C7EFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3C7612EF3C8013F03D8013EF3D8012EF3C8013F03D8012EF3C8012EF
            3C8012EF3C8012EF3C8013F03D8013EF3C8013F03D8013EF3D8013EF3D8012EF
            3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980125D1A8015D1358012EF3C8012EF3C8012EF
            3C8012F03C8013EF3D8012EF3C7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12F03C7612EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013F0
            3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012F0
            3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115719691157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980147D218013EB3B8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12F03C7612EF3C8012EF3C8012EF3C8013F03D8012F03C8013EF3C8013F0
            3C8013EF3D8013EF3D8013EF3D8013EF3D8013F03D8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197E1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198015B32E8012EF3C8013EF3D8012EF3C8013EF
            3D8011EF3C77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3C7612EF3C8012EF3C8013F03D8013EF3D8013EF3D8013F03D8012EF
            3C8013F03D8013EF3C8013F03D8012EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8013F03D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF11571953115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198013621B8013E1398012EF3C8012EF3C8012EF3C8012EF
            3C6CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EA3B7613ED3C8012EF3C8013EF3D8013EF3C8012EF3C8013EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8013F03D8012EF3C8012EF3C8012F03C8012EF3C8013F03D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF11571977115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801591268012EF3C8013EF3D8012EF3C8013EF3D6AFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12DF387612E6398013EB3B8013EE3C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8013EF3D8013F03D8013EF3D8012EF3C8013EF3D8013EF3D8013EF
            3D8013F03D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801156198012591A8015C3328013EF3D8012EF3C8012F03D5DFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF15D1357613D9378012E0388012E63A8012EA3B8013ED3C8013EF3D8012EF
            3C8013EF3D8012EF3C8013F03D8013EF3D8013F03D8012EF3C8013F03D8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3C8013EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1058196A11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115619801257198012561980115519801254
            198011531980146C1E8012E7398012EF3C8012F03C54FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF18C7337617CB348014D1358013D9378012E0398012E6398013EB3A8012ED
            3B8013EE3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157197E11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801257
            1980125719801256198011561980115419801254198011531880115219801150
            1880114F1880159D298013F03D80FEFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF14E0397A18C8348018C6338017CB348014D1368013D9378012E0388012E7
            3A8013EB3B8012EE3B8013EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8013EF3D8013EF3D8013F03D8013EF3D8013EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF115718531157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011561980115619801255
            19801154198011531980115218801151188011501880114E1880114D1780114B
            17801251188014D6367FFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F0
            3D7D13F03D8013E93B8016D3368019C4338018C6338016CB348015D1358013D9
            378013E1398012E83A8012EC3B8013EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8012F03C8013F03D8013EF3D8013F03D8013F03C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157197DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF105719771157198011571980115719801157198011571980115719801157
            1980115719801256198011561980125519801255198012541980125218801151
            188011501880114E1880114D1880114C1780114A178011491780114816801147
            16801572207FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03C5412EF3C7F13EF
            3C8013F03D8012F03C8012EF3C8014E1398018C8338019C3328018C6338016CC
            348013D4368012DC388012E5398012EB3B8012EE3B8013EF3D8013EF3D8013EF
            3C8013EF3D8013EF3D8012EF3C8013EF3D8012F03C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157196CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF115719801157198011571980115719801157198011571980115619801256
            19801255198012541880115318801151188011501880114F1880114D1780114C
            1780114B17801149178011481780114716801146168011451680114416801146
            167FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03D6E12EF3C8013F03D8013EF
            3D8013EF3D8013EF3D8013EF3D8013EF3D8013EB3C8015D6368018C4328019C4
            338017C8338015CF358013D9378012E1398012E83A8012ED3B8013EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3C8013EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057
            1966115719801157198011571980115619801156198012551980125419801153
            19801151188011501880114E1780114C1780114B178011491680114816801147
            1680114616801145168011441680114416801145168011491780115018801155
            19801157185BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03C7A12EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8013EF3C8013F03D8013EF3D8013F03D8012EF3C8014E33A8017C9
            348019C3338018C6338016CC348013D5368012DE388012E6398012EB3B8013EE
            3C8013EF3C8012EF3C8012EF3C8012EF3C8013F03D8013F03D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157197AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            197E115619801256198012551980125419801152188011511880114F1780114D
            1880114C1780114A178011491680114816801146168011451680114416801144
            15801144168011471780114C1780115118801156198011571980115719801157
            1980115719801157186F10571931FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFDFFFDFB12EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EB
            3B8015D6368018C5338019C5338017C9348015D1358012DA378012E1388013E8
            3A8012EC3B8013EE3C8013EF3D8012F03C8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1255
            1980115419801153198011511880114F1880114E1880114C1780114A17801149
            168011471680114616801145168011441780114316801144168011481780114D
            1780115318801156198011571980115719801157198011571980115719801157
            198011571980115719801157197D1157194FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3D7313EF3D8013EF3D8012EF3C8012EF3C8012F03C8012EF3C8012EF
            3C8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013F03D8012EF
            3C8012EF3C8014E43A8017CB348019C3328018C6338016CC348014D3368012DC
            388012E4398012EA3B8013ED3C8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157197FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115218781150
            1880114F1880114E1880114C1780114A17801149168011471680114616801144
            1680114416801143158011451680114A17801150188011541980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801158196AFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFD13EF
            3D7E12EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013F0
            3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012F0
            3C8012F03C8013EF3D8012EC3B8015D8378018C4338018C3338017C7338015CE
            348014D6378012DF388012E73A8013ED3B8013EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801158196AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF114D1880114C
            1780114B17801149168011471680114616801145168011441680114417801147
            1780114B17801152188011561980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157197911571949FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03C5E12EF3C8013EF
            3D8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013F03D8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013E53A8017CB348019C3328018C4
            338017C9338015D1358013DB378013E5398013EB3B8012EE3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11491664114816801148
            16801146168011451680114416801144168011481780114E1780115318801156
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980115719801157197F1157
            1967FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF3C7512EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013ED3C8015D7368018C3
            328019C1328018C6338015CD348013D8378012E2398012E93A80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1974FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1145167D114516801145
            168011461680114B178011511880115519801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157197410581841FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFEFFFEFD12EF3C8013F03D8013EF3D8012EF3C8012EF
            3C8012EF3C8013F03D8012EF3C8012EF3C8013EF3D8012EF3C8012F03C8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8013F0
            3D8013EF3D8012EF3C8013EF3D8013F03D8013EF3D8013EF3D8012EF3C8013E7
            3A8017CD348019C2328018C4328016CB348014D4368012DE3880FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801057
            1850FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11461680114C17801152
            1880115619801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157197EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF12EF3C6712EF3C8013EF3D8013EF3D8012F03C8012EF3C8013EF
            3D8013EF3D8013F03D8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8012F03C8013EF3D8013EF3D8012EF3C8013EF3C8012EF3C8013EF3D8013EF
            3D8013EF3C8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8012EF3C8013EF
            3D8013ED3C8015DA378018C4328019C2328017C8338015D03580FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980115719801157197EFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1153186111571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3D7B12EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3B8013EF
            3C8013EF3D8012EF3C8013E63A8017CE348019C2328018C53380FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198011571965FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105818541157197B1157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFC13EF
            3D8012EF3C8013EF3D8012EF3C8013EF3D8013F03D8013F03D8013F03D8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013F03D8012EF3C8012EF
            3C8012EF3C8012F03C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8013EF3D8013EF3D8013F03D8013EF3D8013EF3D8013EF3D8012EF3C8012EF
            3C8013F03D8012EF3C8013EF3D8012EE3C8015DD388018C53380FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157197FFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105718361157
            1971115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFF13F03D6F13EF3D8012EF
            3C8013F03D8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3C8013EF3D8012EF3C8012F03C8012EF3C8012EF
            3C8013F03D8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8013F03C8013F03D8012EF3C8012EF
            3C8012EF3C8013F03C8012EF3C8013EF3D8012EF3C8013EA3B7FFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198011571964FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF105719551157197D11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980105D1A3EFFFFFFFF13EF3D7C12EF3C8012F03C8013EF
            3D8012EF3C8013F03D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3C8013F0
            3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8012F03C8013EF3D8012EF3C8013F03D8012EF
            3C8013EF3D8013F03D8013F03D8013F03D8012EF3C70FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801057
            1861FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF10571974115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198014A0297212EF3C8013F03D8012F03C8013EF3C8013EF
            3D8012EF3C8012EF3C8013EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8013F03D8012F03C8013F03D8012F03C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8012EF
            3C8013F03D8012EF3C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8013F0
            3D8013F03D8013EF3D8012EF3C80FDFFFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801058186AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF105818581157197D11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8013F03D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3C8012EF3C8012EF3C8012EF3C8013EF3C8012F03C8012F0
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013F0
            3D8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8013F03D8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C7DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157186AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057183D115719751157197F1157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8012EF3C8012EF3C8013F03D8012EF
            3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012F03C8012EF3C8013F0
            3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012F03C69FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157186FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057195E1157
            197F115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012EF3C8013EF3D8013EF3C8013F0
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8013EF3D8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3D8013F03D8013EF3D8013EF3D8012EF3C8013EF3D8012F0
            3C8012F03C8013F03D8012EF3C8013F03C8012EF3C8013EF3D8012EF3C7FFEFF
            FEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            193F115719761157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013F03D8013EF
            3D8012EF3C8013EF3D8012F03C8012EF3C8012EF3C8013EF3D8013EF3D8013EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C77FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157196411571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8013EF3D8013EF3C8013EF
            3D8013F03D8012EF3C8013F03D8012EF3C8012EF3C8013F03D8013EF3D8012F0
            3C8013F03D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3D8012F03C8013EF3D8012EF3C66FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF10571946115719751157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8013EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8013EF3D8013F03D8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8013EF
            3D8012EF3C8012F03C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D7FFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157196B11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8012EF3C8013F03D8012EF3C8012EF
            3C8013F03D8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF
            3C8012EF3C8013EF3D8013EF3C8013F03D8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8012F03D73FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3C8012EF3C8012EF3C8013EF3D8013F03D8013F03D8012EF3C8013EF
            3D8012EF3C8012F03C8013F03D8012EF3C8013EF3D8012F03C8012EF3C8013EF
            3D8012EF3C8013F03D8012F03C8012EF3C8012EF3C8012F03C8013EF3D8013EF
            3D8012F03D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012EF3C8012EF3C8012EF3C8013F0
            3D8012EF3C8012EF3C8013EF3D8013EF3D8012F03C8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8013EF
            3D8012F03C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C7CFFFF
            FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8013EF3D8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012F03C8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3C8012EF3C8012EF3C8013EF3D6FFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8013EF3D8013EF3D8013EF3D8012EF
            3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF
            3C8012F03C8012EF3C8013EF3D8013F03D8012EF3C8012EF3C8013EF3D8013EF
            3D8013EF3D8013F03C8012EF3C8013EF3C80FDFFFDFBFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF
            3C8012EF3C8013EF3D8013EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8012EF3C8013F03D8013EF3D7DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFCFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013EF3C8012EF3C8012F03C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8012F03C8013EF3D8012EF3C8013EF3D8012F03C8013F03D8013EF
            3D8013EF3D8012EF3D6AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D7913EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8012EF3C8012EF3C8013EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8013F03D8013EF3D8013EF
            3D8013EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8012F03C8012EF
            3C7FFEFFFEFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF12EF3C5A12EF3C8012F03C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8013F03D8013EF3D8012F03C8013EF3D8013EF3D78FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF13F03D7812EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013EF3C8013EF3D8012EF3C8012EF3C8013F0
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012F03C8013EF
            3C8012EF3C8013EF3D8012EF3C8013EF3C8013EF3D8012F03C64FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F0
            3C6213EF3D8012EF3C8012EF3C8013EF3C8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8013F03D8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012F03C7FFEFFFEFDFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF3C7712EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012F03C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8013EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012F03C73FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03D5D12EF3C8012EF3C8013EF
            3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013F03D8013EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C63FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF13EF3D7D12EF3C8012F03C8012EF3C8012EF
            3C8013F03D8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013F03D8013EF3D8012F03C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8013F03D8012EF
            3C7CFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF12F03C6113EF3C8013EF3D8013EF3D8012F03C8013EF3D8012EF
            3C8013EF3D8013F03D8013EF3D8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012F03C73FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFE12EF3C7C13F03D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8012EF3C8012F03C8012EF3C8013EF3C8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8013EF3D8013EF3D8013F03C8012EF
            3C8013F03D8013EF3D8012EF3C8012EF3C8012EF3C80FDFFFDFBFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D6612EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8012F03C8013F03D8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198014A92B8012EF3C8012EF3C8013EF3D8012EF3C8013EF
            3C8012EF3C8013F03D8012EF3C8012F03C7BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D7E12EF3C8013EF
            3D8012EF3C8013F03D8013EF3C8012EF3C8013EF3D8012F03C8013EF3D8013EF
            3D8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8013F03D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8012EF3C8012F03C6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D6D13EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013F03D8013EF
            3D8013EF3D8013EF3D8013EF3D8012EF3C8013F03D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8013F03D8012F03C6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF13EF3C7C13EF3D8013EF3C8013EF3D8013F03D8012EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12F03C6413F03D8012EF3C8013EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3D7612EF3C8012EF3C8013EF3D8013EF3D8012F03C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8013EF
            3D8013F03D8013F03D8013F03D8013EF3D8013F03D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8013EF3D8013F03D8013EF3C8013EF
            3D8012EF3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF13F03D7612F03C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013F03D8013EF3D8013F03D8013EF3D8013EF3D8012F0
            3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8012EF3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3C7613F03D8012EF3C8012EF3C8013EF3C8013EF3D8012EF3C8013EF
            3D8012F03C8012EF3C8012EF3C8012F03C8013F03D8012EF3C8013F03D8013EF
            3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3C7612EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3C8013EF
            3D8013EF3D8013EF3D8013EF3D8013EF3D8013F03D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8012EF3C8012EF3C8012F03C8013EF
            3D8012EF3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF13EF3D7612EF3C8013EF3D8013EF3D8012EF3C8012F03C8013EF3D8012EF
            3C8012F03C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF13F03D7612EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8013F03D8012EF3C8013EF3C8013F03D8013EF3D8012F0
            3C8013EF3C8013EF3D8012EF3C8013F03D8013EF3D8013F03D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3C8013EF3D80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3C7613EF3D8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012F0
            3C8012EF3C8012EF3C8012EF3C8013F03C8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198014A92B8013EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013F03D64FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F0
            3D2612EF3C7A13F03D8012EF3C8012F03C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8013EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF
            3C8013F03D8013EF3D8013EF3D8013F03D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198010571848FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057184B11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012F03C8013EF3D8013F03D8013F0
            3D8013EF3D8012F03C8013F03C8013EF3D8013EF3C8013EF3D8012EF3C8013EF
            3D8013EF3C8013F03D8013F03D8012EF3C8013F03D8012EF3C8012EF3C8013EF
            3D8012F03C8012F03C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013F03D8013F03D8012EF3C8013EF3D8013EF
            3C8013F03D8012EF3C8012EF3C8013F03D8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157197F1157197D1157197D1157197D1157
            197D1157197D1157197D1157197D1157197D1157197D1157197D1157197D1157
            197D1157197D1157197D1157197D1157197D1157197F11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8013EF3D8013EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012F03C8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8013F03D8012EF3C8013F03D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012EF3C8012F03C8012EF3C8013EF
            3D8013F03D8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8012F03C8012F0
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013F03D8013EF3D8013EF3C8013EF3D8012F03C8012F03C8013F03D8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3C8013F03D8012EF3C8013EF3D8013EF3C8013EF
            3D8012F03C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8012F03C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8012EF3C8012F03C8012EF3C8012F0
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013F0
            3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8013F03D8013EF3D8012EF
            3C8013F03D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8013F03D8012EF3C8012F03C8012EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8012EF3C8013F03D8013EF3D8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012F03C8013F03D8012EF3C8013EF
            3D8012EF3C8013EF3C8012EF3C8012EF3C8013F03C8012EF3C8012EF3C8013EF
            3C8012EF3C8012F03C8012EF3C8013F03D8013EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157194C115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013F03D8012EF3C8013EF3D8013F03C8013EF3D8013EF
            3D8013F03D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3C8013F03D8013EF3C8013EF3D8013EF3D8012EF3C8013EF3C8013F03D8012EF
            3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197D115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012F0
            3C8013EF3D8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012F03C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013F03D8013EF3D8012EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F0
            3D8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197611571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8012EF
            3C8013EF3D8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF3C8013EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013F0
            3D8013F03D8012EF3C8012EF3C8013EF3C8012EF3C8013EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1057186F1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013F03D8013EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3C8012F0
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013F03D8012EF3C8013F0
            3D8012EF3C8012EF3C8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF
            3C8012EF3C8013F03D8013EF3D8013EF3D8013EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF1157195D115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012EF3C8012F03C8013EF3D8012EF3C8013F0
            3D8013EF3D8012EF3C8013F03C8013EF3D8012F03C8012EF3B8013EF3D8013EF
            3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8012F03C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3D8012EF3C8013F03D8012EF3C8012EF3C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF115719491157197E115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A92B8013EF3C8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013F03D8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8013EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013F0
            3C8013F03C8013EF3C8013EF3C8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF105718341157197E11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82A8013EF3D8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3C8013F03D8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8012F03C8012EF3C8013EF3C8013EF3D8013EF3D8013EF
            3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF
            3D8013EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012F03C8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012F03C8012F03C80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF1157197B1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015A82B8012F03C8012F03C8013EF3D8013EF3D8012EF
            3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013F03D8012EF3C8012EF
            3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012F03C8013EF3D8013F0
            3D8013EF3C8013EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3C8013EF3C8013EF3C8013EF3C8013EF
            3D8013EF3D8013EF3D8013F03D8012EF3C8013EF3C8013EF3D80FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057
            1872115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198014B12D8013EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013F03D8012F03C8012EF3C8013EF3D8012EF3C8013EF3D8012F0
            3C8012EF3C8013EF3D8012EF3C8013F03D8013EF3D8012EF3C8012EF3C8012F0
            3C8012F03C8013F03D8012EF3C8013EF3D8013EF3D8013F03D8012EF3C8013F0
            3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C7EFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF115819651157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198012621B8014D5368012EF3C8012F03C8013F03D8012EF3C8013EF
            3D8013EF3D8012EF3C8013EF3D8013EF3D8012EF3C8013F03D8013EF3D8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013F03C8012EF
            3C8013F03D8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8013F0
            3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8013F03D8012F03C6AFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571851115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801594278013EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF
            3C8012EF3C8012EF3C8013EF3C8013EF3D8013EF3D8012EF3C8012F03C8013EF
            3D8013EF3D8013F03D8012EF3C8012EF3C8013EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012F0
            3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D7FFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105718401157197E115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980146F1E8013E4398012EF3C8013EF3D8013F03D8012EF3C8013EF3D8012EF
            3C8012EF3C8012F03C8012EF3C8013EF3D8013EF3D8012EF3C8013F03D8012EF
            3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8013EF3D8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012F03C8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8012F03C8012EF3C8012EF3C8012F03D80FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197D11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801366
            1C8015D3358012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013F03D8013EF3D8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8013F0
            3D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8012EF3C80FEFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115719741157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980136C1D8014CD
            348013F03C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013F03D8013EF3D8012F03C8013F03D8012EF3C8012EF
            3C8012F03C8013F03D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3C8012EF3C8012EF
            3C8013F03D8012EF3C79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFF
            FEFDFEFFFEFCFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFCFEFFFEFCFEFFFEFDFEFF
            FEFCFEFFFEFDFEFFFEFCFEFFFEFCFEFFFEFCFEFFFEFCFEFFFEFDFEFFFEFCFEFF
            FEFDFEFFFEFDFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFDFEFFFEFDFEFFFEFDFEFF
            FEFDFEFFFEFCFEFFFEFCFEFFFEFCFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFCFEFF
            FEFDFEFFFEFDFEFFFEFCFEFFFEFCFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFCFEFF
            FEFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object SysMemo1: TfrxSysMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Frame.Typ = []
          Memo.UTF8W = (
            'Data: [DATE]')
        end
        object SysMemo3: TfrxSysMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Top = 22.677180000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Frame.Typ = []
          Memo.UTF8W = (
            'Hora: [Time]')
        end
        object vFiltro: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 45.354360000000000000
          Top = 41.574830000000000000
          Width = 627.401980000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[vFiltro]')
          ParentFont = False
        end
      end
      object ColumnHeader1: TfrxColumnHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 109.606370000000000000
        Width = 718.110700000000000000
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = -0.000002440000000000
          Top = 15.118117560000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 52.913420000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 370.393940000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Embalagem')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 445.984540000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Altura')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 566.929500000000000000
          Width = 37.795275590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Larg.')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 608.504330000000000000
          Width = 41.574805590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Compr')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 665.197280000000000000
          Width = 49.133865590000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Vol.m3')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 268.346630000000000000
        Width = 718.110700000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Rhemasys Solu'#231#245'es')
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Left = -0.000000000000000444
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Lblusuario: TfrxMemoView
          AllowVectorExport = True
          Left = 230.551330000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Usu'#225'rio: ')
        end
        object vUsuario: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[vUsuario]')
        end
        object SysMemo2: TfrxSysMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'P'#225'g: [Page#] de [TOTALPAGES#]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 188.976500000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint_inherited'
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object frxDBDataset1Background: TfrxMemoView
          AllowVectorExport = True
          Left = 7559.055118110236000000
          Width = 75.590551181102360000
          Height = 22.677180000000000000
          Visible = False
          OnBeforePrint = 'frxDBDataset1BackgroundOnBeforePrint_inherited'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = ' Frac(<Line> / 2) = 0.5'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          Highlight.Frame.Typ = []
          Highlight.Visible = False
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
          WordWrap = False
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
          ParentFont = False
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 52.913420000000000000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
          ParentFont = False
        end
        object frxDBDataset1Embalagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 370.393940000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'Embalagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Embalagem"]')
          ParentFont = False
        end
        object frxDBDataset1EnderecoFormatado: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 445.984540000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'EnderecoFormatado'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."EnderecoFormatado"]')
          ParentFont = False
        end
        object frxDBDataset1Altura: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 525.354670000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'Altura'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Altura"]')
          ParentFont = False
        end
        object frxDBDataset1Largura: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 566.929500000000000000
          Width = 37.795300000000000000
          Height = 15.118120000000000000
          DataField = 'Largura'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Largura"]')
          ParentFont = False
        end
        object frxDBDataset1Comprimento: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 608.504330000000000000
          Width = 41.574830000000000000
          Height = 15.118120000000000000
          DataField = 'Comprimento'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Comprimento"]')
          ParentFont = False
        end
        object frxDBDataset1Volm3: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 653.858690000000000000
          Width = 60.472450710000000000
          Height = 15.118120000000000000
          DataField = 'Volm3'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Volm3"]')
          ParentFont = False
        end
      end
    end
  end
  object frxListaEan: TfrxReport
    Version = '6.4.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.Author = 'Grupo X3'
    ReportOptions.CreateDate = 41746.768122685200000000
    ReportOptions.LastChange = 44807.909038043980000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 244
    Top = 337
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'vModulo'
        Value = Null
      end
      item
        Name = 'vVersao'
        Value = Null
      end
      item
        Name = 'vUsuario'
        Value = Null
      end
      item
        Name = 'vFiltro'
        Value = Null
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 68.031540000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'PageHeader1OnBeforePrint'
        object Shape1: TfrxShapeView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 1035.591220000000000000
          Height = 64.252010000000000000
          Frame.Typ = []
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 326.929345000000000000
          Width = 393.071120000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'eXactWMS')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 162.519790000000000000
          Top = 15.118120000000000000
          Width = 778.583180000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Relat'#243'rio de Produtos - Lista C'#243'digo de Barras')
          ParentFont = False
        end
        object Picture1: TfrxPictureView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 34.015770000000000000
          Frame.Typ = []
          Picture.Data = {
            07544269746D617056D00000424D56D000000000000036000000280000007800
            00006F000000010020000000000020D000000000000000000000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571970115719701157
            1970115719701157197011571970115719701157197011571970115719701157
            1970115719701157197011571970115719701157197011571970115719701157
            19701157197011571970FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571978115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980125D1A7C1598277A12EC3B7A12EF3C7A12EF
            3C7A12EF3C7A13EF3D7A12EF3D7A13EF3D7A12EF3C7A12F03D7A12EF3C7A12EF
            3C7A13F03D7A12EF3C7A12EF3C7A13EF3D7A13EF3D7A12EF3C7A13EF3D7A12EF
            3C7A13F03D7A13EF3D7A12EF3C7A13EF3D7A13EF3D7A12EF3C7A13EF3C7A12EF
            3C7A12EF3C7A12F03C7A13EF3D7A13F03D7A12EF3C7A12EF3D7A12EF3C7A13F0
            3D7A13F03D7A12EF3C7A12F03C7A13EF3D7A12EF3C7AFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980158D258012EE3C8012EF3C8013F0
            3D8013F03D8013EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012F03C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8013F03C8013EF3D8012EF3C8013F03D8012F03C8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801158198015CD348013EF3D8012EF3C8012EF
            3C8013F03D8013EF3D8013F03D8012EF3C8013EF3D8013EF3C8013EF3D8013EF
            3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8012F03C8012EF3C8013F03D8013EF3D8013EF3C8013EF3D8013EF3D8012F0
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012F03C8013EF3D8012EF3C8012F03C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197F11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198014721F8012EB3B8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF3D8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF105719581157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198014A62B8013EF3D8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013F03C8012EF3C8012EF3C8013EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8013EF3D8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF105719781157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980125F1B8014D7368012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3D8013EF3D8013EF3C8013EF3C8012EF3C8013F03D8013EF
            3D8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8012F03C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8013EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801480228012ED3C8013F03D8012EF3C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012F03C8013F0
            3D8013EF3C8012EF3C8013F03D8013EF3D8013EF3D8012F03C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8013F03D8013F03D8012EF3C8013F03D8013EF3D8013EF
            3D8013EF3C8013F03D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF1157196E115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801158198015C1318013EF3D8012F03C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013F03D8013EF
            3D8013F03D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8012F03C8013EF
            3C8013EF3D8012EF3C8012EF3C8013EF3C8012EF3C8013EF3D8013EF3D8013F0
            3D8012EF3C8012EF3C8013F03C8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF1157197E115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198013671C8013E4398012F03C8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3C8012EF3C8013EF3D8013EF3D8013F03D8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF
            3C8012F03C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801596278012EE3C8012F03C8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8013F03C8013EF3D8013F03D8012EF3B8013EF3D8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013F0
            3C8013EF3D8013F03D8013EF3D8013EF3D8013EF3C8013EF3D8013EF3D8012EF
            3C8013EF3C8012EF3C8013F03D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157197A11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980125C1A8014C9338012EF3C8013EF3D8013EF3D8012EF3C8012F03C8012EF
            3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8013EF3D8013F03D8013EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF
            3D8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012F03C8013EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF1058183F1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198014731F8012EC3B8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013F03D8012EF3C8012EF3C8013EF3D8013EF3D8012F03C8012EF
            3C8012EF3C8012F03C8012F03C8013EF3D8013F03C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3C8013EF3D8013EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8013F03D8013F03D8013EF3D8012EF
            3C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF1157196A1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801158
            198015AA2C8012EF3C8012F03C8012F03C8013EF3D8013F03D8012EF3C8013EF
            3D8013F03D8012F03C8013EF3D8012EF3C8013EF3D8012F03C8012F03C8013EF
            3D8012F03C8013F03D8013EF3D8012EF3C8012F03C8013F03D8013EF3D8013EF
            3C8013EF3D8013EF3D8012EF3C8013F03D8012EF3C8012F03C8013EF3D8013EF
            3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8013EF3C8013EF3D8013F0
            3D8013EF3C8012EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF1157197D1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801261
            1B8014DA378012EF3C8013F03D8013F03D8012EF3C8013EF3D8012EF3C8013EF
            3D8013F03D8012EF3C8012EF3C8012EF3C8012F03C8012EF3C8013EF3D8012EF
            3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3C8012EF
            3C8013EF3D8013EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012F03C8012F0
            3C8012F03C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            1859115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801587
            248013ED3C8012EF3C8012EF3C8013EF3D8013F03C8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8013F03D8013EF3D8013EF3D8013EF
            3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8013F0
            3D8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8013F03D8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF
            3C8012EF3C8013EF3D8012EF3C8013F03D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            1978115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980115719801157198014C5
            328013EF3D8012F03C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013F0
            3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013F03D8013F03D8012EF3C8012EF3C8012EF3C8013EF3D8013F0
            3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105718411157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980146D1E8013E7
            3A8013EF3D8013EF3D8013EF3D8013EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8013F03D8013EF3D8012EF3C8013F03D8013EF3D8012EF
            3C8012EF3C8013EF3D8013F03D8012F03C8013EF3D8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8013F03D8013EF3D8012F03C8013EF3D8012EF3C8012F0
            3C8012EF3C8012EF3C8013F03D8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157196B1157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980159E288012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012F0
            3C8013EF3D8013F03D8013EF3D8012F03C8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3C8013F03D8013EF3D8012F03C8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF3D8012EF3C8012F0
            3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197E1157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980125C1A8015CC348012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8013EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8012F03C8013F03D8012EF3C8013EF3D8012EF
            3C8012F03C8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013F0
            3D8013EF3D8012EF3C8012F03C8013F03D8013EF3C8013EF3D8013F03C8013F0
            3D8013F03D8012EF3C8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF10571852115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801376208014E93B8013EF
            3D8012F03C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8012F03C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3C8013F03D8012EF3C8012EF3C8013F0
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012F03C8013EF3D8013EF
            3D8012EF3C8013EF3D8012F03C8012EF3C8012EF3C8013F03D8012EF3C8012EF
            3C8013EF3C8012EF3C8012EF3C8013F03D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571978115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198015B12D8012EF3C8013EF
            3D8012EF3C8013EF3D8013F03D8013EF3D8012F03C8013EF3D8013EF3D8012EF
            3C8012EF3C7212EF3C6712EF3C6712EF3C6712EF3C6712EF3C6712EF3C6712EF
            3C6712EF3C6712EF3C6713EF3C6712EF3C6713EF3C6712EF3C6712EF3C6813EF
            3D7D12EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8013EF3D8013F03D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198013631C8013DF388013EF3D8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF
            3C64FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EE3D0712F0
            3C7613EF3D8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8012F03C8013EF3D8013EF3D8013EF3D8013EF
            3D8012EF3C8013EF3C8013EF3D8013F03D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157196B11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980158E258012ED3C8013EF3D8012EF
            3C8012EF3C8013EF3D8013F03D8013EF3D8012EF3C8012EF3C8012F03C52FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3C7612EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8013F03D8013F03D8013EF3D8013F0
            3D8013EF3D8013EF3D8012EF3C8012EF3C8013F03D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197F11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980125A198015C3318012EF3C8012EF3C8012EF
            3C8013F03D8012EF3C8013EF3D8013EF3D8013F03D8013F03D4DFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F0
            3D7612EF3C8012EF3C8013F03D8013EF3C8013EF3D8013EF3D8012F03C8013F0
            3D8013F03D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8012F03C8012EF3C8012EF3C8013F03D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115818541157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980136E1E8013E73A8012F03C8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3C80FFFFFFFEFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F0
            3D7613EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8013EF
            3D8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013F03C8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115719791157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980159E298012EF3C8013EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C7EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3C7612EF3C8013F03D8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8012EF
            3C8012EF3C8013F03D8013EF3C8013F03D8013EF3D8013EF3D8012EF3C8013EF
            3D8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980125D1A8015D1358012EF3C8012EF3C8012EF3C8012F0
            3C8013EF3D8012EF3C7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F0
            3C7612EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013F03C8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012F03C8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF11571969115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980147D218013EB3B8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F0
            3C7612EF3C8012EF3C8012EF3C8013F03D8012F03C8013EF3C8013F03C8013EF
            3D8013EF3D8013EF3D8013EF3D8013F03D8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF1157197E115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198015B32E8012EF3C8013EF3D8012EF3C8013EF3D8011EF
            3C77FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3C7612EF3C8012EF3C8013F03D8013EF3D8013EF3D8013F03D8012EF3C8013F0
            3D8013EF3C8013F03D8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8012EF3C8013F03D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157195311571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198013621B8013E1398012EF3C8012EF3C8012EF3C8012EF3C6CFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EA
            3B7613ED3C8012EF3C8013EF3D8013EF3C8012EF3C8013EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013F0
            3D8012EF3C8012EF3C8012F03C8012EF3C8013F03D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157197711571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801591268012EF3C8013EF3D8012EF3C8013EF3D6AFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12DF
            387612E6398013EB3B8013EE3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8013EF3D8013F03D8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013F0
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801156
            198012591A8015C3328013EF3D8012EF3C8012F03D5DFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF15D1
            357613D9378012E0388012E63A8012EA3B8013ED3C8013EF3D8012EF3C8013EF
            3D8012EF3C8013F03D8013EF3D8013F03D8012EF3C8013F03D8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3C8013EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF1058196A1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011561980125719801256198011551980125419801153
            1980146C1E8012E7398012EF3C8012F03C54FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF18C7
            337617CB348014D1358013D9378012E0398012E6398013EB3A8012ED3B8013EE
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF1157197E1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980125719801257
            198012561980115619801154198012541980115318801152198011501880114F
            1880159D298013F03D80FEFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF14E0
            397A18C8348018C6338017CB348014D1368013D9378012E0388012E73A8013EB
            3B8012EE3B8013EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8013EF3D8013F03D8013EF3D8013EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            1853115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801156198011561980125519801154
            198011531980115218801151188011501880114E1880114D1780114B17801251
            188014D6367FFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D7D13F0
            3D8013E93B8016D3368019C4338018C6338016CB348015D1358013D9378013E1
            398012E83A8012EC3B8013EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012F0
            3C8013F03D8013EF3D8013F03D8013F03C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157197DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057
            1977115719801157198011571980115719801157198011571980115719801157
            1980125619801156198012551980125519801254198012521880115118801150
            1880114E1880114D1880114C1780114A17801149178011481680114716801572
            207FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03C5412EF3C7F13EF3C8013F0
            3D8012F03C8012EF3C8014E1398018C8338019C3328018C6338016CC348013D4
            368012DC388012E5398012EB3B8012EE3B8013EF3D8013EF3D8013EF3C8013EF
            3D8013EF3D8012EF3C8013EF3D8012F03C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157196CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            1980115719801157198011571980115719801157198011561980125619801255
            198012541880115318801151188011501880114F1880114D1780114C1780114B
            17801149178011481780114716801146168011451680114416801146167FFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03D6E12EF3C8013F03D8013EF3D8013EF
            3D8013EF3D8013EF3D8013EF3D8013EB3C8015D6368018C4328019C4338017C8
            338015CF358013D9378012E1398012E83A8012ED3B8013EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8013EF3C8013EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105719661157
            1980115719801157198011561980115619801255198012541980115319801151
            188011501880114E1780114C1780114B17801149168011481680114716801146
            1680114516801144168011441680114516801149178011501880115519801157
            185BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF12F03C7A12EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8013EF3C8013F03D8013EF3D8013F03D8012EF3C8014E33A8017C9348019C3
            338018C6338016CC348013D5368012DE388012E6398012EB3B8013EE3C8013EF
            3C8012EF3C8012EF3C8012EF3C8013F03D8013F03D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157197AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197E1156
            19801256198012551980125419801152188011511880114F1780114D1880114C
            1780114A17801149168011481680114616801145168011441680114415801144
            168011471780114C178011511880115619801157198011571980115719801157
            19801157186F10571931FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFDFFFDFB12EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EB3B8015D6
            368018C5338019C5338017C9348015D1358012DA378012E1388013E83A8012EC
            3B8013EE3C8013EF3D8012F03C8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF125519801154
            19801153198011511880114F1880114E1880114C1780114A1780114916801147
            1680114616801145168011441780114316801144168011481780114D17801153
            1880115619801157198011571980115719801157198011571980115719801157
            1980115719801157197D1157194FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3D7313EF3D8013EF3D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8013F0
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013F03D8012EF3C8012EF
            3C8014E43A8017CB348019C3328018C6338016CC348014D3368012DC388012E4
            398012EA3B8013ED3C8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            197FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1152187811501880114F
            1880114E1880114C1780114A1780114916801147168011461680114416801144
            16801143158011451680114A1780115018801154198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801158196AFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFD13EF3D7E12EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013F03D8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012F03C8012F0
            3C8013EF3D8012EC3B8015D8378018C4338018C3338017C7338015CE348014D6
            378012DF388012E73A8013ED3B8013EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801158
            196AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF114D1880114C1780114B
            178011491680114716801146168011451680114416801144178011471780114B
            1780115218801156198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157197911571949FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03C5E12EF3C8013EF3D8013EF
            3D8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013F03D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013E53A8017CB348019C3328018C4338017C9
            338015D1358013DB378013E5398013EB3B8012EE3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198011571980FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1149166411481680114816801146
            168011451680114416801144168011481780114E178011531880115619801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157197F11571967FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF3C7512EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8013ED3C8015D7368018C3328019C1
            328018C6338015CD348013D8378012E2398012E93A80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198011571974FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1145167D11451680114516801146
            1680114B17801151188011551980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            197410581841FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFEFFFEFD12EF3C8013F03D8013EF3D8012EF3C8012EF3C8012EF
            3C8013F03D8012EF3C8012EF3C8013EF3D8012EF3C8012F03C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8013F03D8013EF
            3D8012EF3C8013EF3D8013F03D8013EF3D8013EF3D8012EF3C8013E73A8017CD
            348019C2328018C4328016CB348014D4368012DE3880FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198010571850FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11461680114C1780115218801156
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157197EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12EF3C6712EF3C8013EF3D8013EF3D8012F03C8012EF3C8013EF3D8013EF
            3D8013F03D8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012F0
            3C8013EF3D8013EF3D8012EF3C8013EF3C8012EF3C8013EF3D8013EF3D8013EF
            3C8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8012EF3C8013EF3D8013ED
            3C8015DA378018C4328019C2328017C8338015D03580FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157197EFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115318611157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3D7B12EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013F0
            3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012F03C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3B8013EF3C8013EF
            3D8012EF3C8013E63A8017CE348019C2328018C53380FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571965FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105818541157197B115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFC13EF3D8012EF
            3C8013EF3D8012EF3C8013EF3D8013F03D8013F03D8013F03D8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8012EF
            3C8012F03C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8013EF3D8013F03D8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8013F0
            3D8012EF3C8013EF3D8012EE3C8015DD388018C53380FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157197FFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF10571836115719711157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980FFFFFFFFFFFFFFFFFFFFFFFF13F03D6F13EF3D8012EF3C8013F0
            3D8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3C8013EF3D8012EF3C8012F03C8012EF3C8012EF3C8013F0
            3D8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8013F03C8013F03D8012EF3C8012EF3C8012EF
            3C8013F03C8012EF3C8013EF3D8012EF3C8013EA3B7FFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571964FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057
            19551157197D1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980105D1A3EFFFFFFFF13EF3D7C12EF3C8012F03C8013EF3D8012EF
            3C8013F03D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3C8013F03D8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8012F03C8013EF3D8012EF3C8013F03D8012EF3C8013EF
            3D8013F03D8013F03D8013F03D8012EF3C70FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198010571861FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1057197411571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198014A0297212EF3C8013F03D8012F03C8013EF3C8013EF3D8012EF
            3C8012EF3C8013EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8013F03D8012F03C8013F03D8012F03C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8012EF3C8013F0
            3D8012EF3C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8013F03D8013F0
            3D8013EF3D8012EF3C80FDFFFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801058
            186AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF105818581157197D1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8013F03D8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3C8012EF3C8012EF3C8012EF3C8013EF3C8012F03C8012F03C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8013F03D8013EF
            3D8013EF3D8013EF3D8013EF3D8012EF3C8013F03D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C7DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157186AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1057183D115719751157197F115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8012EF3C8012EF3C8013F03D8012EF3C8013EF
            3D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012F03C8012EF3C8013F03D8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012F0
            3C69FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157186FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057195E1157197F1157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012EF3C8013EF3D8013EF3C8013F03D8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8013F03D8013EF3D8013EF3D8012EF3C8013EF3D8012F03C8012F0
            3C8013F03D8012EF3C8013F03C8012EF3C8013EF3D8012EF3C7FFEFFFEFDFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157193F1157
            1976115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013F03D8013EF3D8012EF
            3C8013EF3D8012F03C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C77FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF115719641157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8013EF3D8013EF3D8013EF3C8013EF3D8013F0
            3D8012EF3C8013F03D8012EF3C8012EF3C8013F03D8013EF3D8012F03C8013F0
            3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8012F03C8013EF3D8012EF3C66FFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1057194611571975115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8013F03D8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8013EF3D8012EF
            3C8012F03C8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D7FFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1157196B1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8013F0
            3D8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3C8012EF
            3C8013EF3D8013EF3C8013F03D8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C8012F03D73FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3C8012EF3C8012EF3C8013EF3D8013F03D8013F03D8012EF3C8013EF3D8012EF
            3C8012F03C8013F03D8012EF3C8013EF3D8012F03C8012EF3C8013EF3D8012EF
            3C8013F03D8012F03C8012EF3C8012EF3C8012F03C8013EF3D8013EF3D8012F0
            3D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF
            3C8012EF3C8013EF3D8013EF3D8012F03C8013EF3D8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8012F0
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C7CFFFFFFFEFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF
            3D8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012F03C8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3C8012EF3C8012EF3C8013EF3D6FFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8013EF3D8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012F0
            3C8012EF3C8013EF3D8013F03D8012EF3C8012EF3C8013EF3D8013EF3D8013EF
            3D8013F03C8012EF3C8013EF3C80FDFFFDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3C8012EF
            3C8013EF3D8013EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8013F03D8013EF3D7DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFEFCFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013EF3C8012EF3C8012F03C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C8012F03C8013EF3D8012EF3C8013EF3D8012F03C8013F03D8013EF3D8013EF
            3D8012EF3D6AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D7913EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8012EF3C8012EF3C8013EF3C8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8013F03D8013EF3D8013EF3D8013EF
            3C8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8012F03C8012EF3C7FFEFF
            FEFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF12EF3C5A12EF3C8012F03C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8012EF3C8013F03D8013EF3D8012F03C8013EF3D8013EF3D78FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF13F03D7812EF3C8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013EF3C8013EF3D8012EF3C8012EF3C8013F03D8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012F03C8013EF3C8012EF
            3C8013EF3D8012EF3C8013EF3C8013EF3D8012F03C64FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03C6213EF
            3D8012EF3C8012EF3C8013EF3C8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8013F03D8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012F03C7FFEFFFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF3C7712EF3C8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012F03C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF
            3D8012EF3C8013EF3D8012EF3C8013EF3D8013EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012F03C73FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF12F03D5D12EF3C8012EF3C8013EF3C8013EF
            3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013F03D8013EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C63FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF13EF3D7D12EF3C8012F03C8012EF3C8012EF3C8013F0
            3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013F03D8013EF3D8012F03C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8013F03D8012EF3C7CFFFF
            FFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF12F03C6113EF3C8013EF3D8013EF3D8012F03C8013EF3D8012EF3C8013EF
            3D8013F03D8013EF3D8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012F03C73FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE12EF
            3C7C13F03D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C8012F03C8012EF3C8013EF3C8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8013EF3D8013EF3D8013F03C8012EF3C8013F0
            3D8013EF3D8012EF3C8012EF3C8012EF3C80FDFFFDFBFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D6612EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012F03C8013F03D8012EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198014A92B8012EF3C8012EF3C8013EF3D8012EF3C8013EF3C8012EF
            3C8013F03D8012EF3C8012F03C7BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D7E12EF3C8013EF3D8012EF
            3C8013F03D8013EF3C8012EF3C8013EF3D8012F03C8013EF3D8013EF3D8012EF
            3C8013EF3D8013EF3D8012EF3C8013EF3D8013F03D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012F03C6EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF13F03D6D13EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013F03D8013EF3D8013EF
            3D8013EF3D8013EF3D8012EF3C8013F03D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013F0
            3D8012F03C6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF13EF3C7C13EF3D8013EF3C8013EF3D8013F03D8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12F0
            3C6413F03D8012EF3C8013EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3D7612EF3C8012EF3C8013EF3D8013EF3D8012F03C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8013EF3D8013F0
            3D8013F03D8013F03D8013EF3D8013F03D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8013EF3D8013F03D8013EF3C8013EF3D8012EF
            3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F0
            3D7612F03C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8013F03D8013EF3D8013F03D8013EF3D8013EF3D8012F03C8013EF
            3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF
            3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3C7613F03D8012EF3C8012EF3C8013EF3C8013EF3D8012EF3C8013EF3D8012F0
            3C8012EF3C8012EF3C8012F03C8013F03D8012EF3C8013F03D8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3C7612EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3C8013EF3D8013EF
            3D8013EF3D8013EF3D8013EF3D8013F03D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8012EF3C8012EF3C8012F03C8013EF3D8012EF
            3C80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13EF
            3D7612EF3C8013EF3D8013EF3D8012EF3C8012F03C8013EF3D8012EF3C8012F0
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013F03D8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F0
            3D7612EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8013F03D8012EF3C8013EF3C8013F03D8013EF3D8012F03C8013EF
            3C8013EF3D8012EF3C8013F03D8013EF3D8013F03D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8012EF3C8013EF3D8012EF3C8013EF3C8013EF
            3D80FCFFFDFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF12EF
            3C7613EF3D8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012F03C8012EF
            3C8012EF3C8012EF3C8013F03C8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198014A92B8013EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013F03D64FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF13F03D2612EF
            3C7A13F03D8012EF3C8012F03C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8013EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8013F0
            3D8013EF3D8013EF3D8013F03D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198010571848FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1057184B1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012F03C8013EF3D8013F03D8013F03D8013EF
            3D8012F03C8013F03C8013EF3D8013EF3C8013EF3D8012EF3C8013EF3D8013EF
            3C8013F03D8013F03D8012EF3C8013F03D8012EF3C8012EF3C8013EF3D8012F0
            3C8012F03C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8013F03D8013F03D8012EF3C8013EF3D8013EF3C8013F0
            3D8012EF3C8012EF3C8013F03D8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157197F1157197D1157197D1157197D1157197D1157
            197D1157197D1157197D1157197D1157197D1157197D1157197D1157197D1157
            197D1157197D1157197D1157197D1157197F1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8013EF3D8013EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012F03C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF
            3C8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8013F03D8012EF3C8013F03D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012EF3C8012F03C8012EF3C8013EF3D8013F0
            3D8013F03D8013EF3D8012EF3C8013EF3D8012EF3C8012F03C8012F03C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F0
            3D8013EF3D8013EF3C8013EF3D8012F03C8012F03C8013F03D8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3C8013F03D8012EF3C8013EF3D8013EF3C8013EF3D8012F0
            3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3C8013EF3D8013EF3D8012EF3C8013EF3D8012F0
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8012EF3C8012F03C8012EF3C8012F03C8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013F03D8013EF
            3D8012EF3C8013EF3D8012EF3C8013EF3D8013F03D8013EF3D8012EF3C8013F0
            3D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013F0
            3D8012EF3C8012F03C8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8012EF3C8013F03D8013EF3D8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8012F03C8013F03D8012EF3C8013EF3D8012EF
            3C8013EF3C8012EF3C8012EF3C8013F03C8012EF3C8012EF3C8013EF3C8012EF
            3C8012F03C8012EF3C8013F03D8013EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8013EF3D8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157194C11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013F03D8012EF3C8013EF3D8013F03C8013EF3D8013EF3D8013F0
            3D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3C8013F0
            3D8013EF3C8013EF3D8013EF3D8012EF3C8013EF3C8013F03D8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197D11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012F03C8013EF
            3D8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012F03C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8013F03D8013EF3D8012EF3C8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F03D8012EF
            3C8012EF3C8013F03D8012EF3C8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF115719761157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013F03D8012EF3C8013EF
            3D8013F03D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8012EF3C8013EF
            3D8013EF3D8012EF3C8013EF3D8012EF3C8013EF3C8013EF3C8012EF3C8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013F03D8013F0
            3D8012EF3C8012EF3C8013EF3C8012EF3C8013EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF1057186F115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013F0
            3D8013EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF3C8012F03C8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8013F03D8012EF3C8013F03D8012EF
            3C8012EF3C8013EF3D8012EF3C8012F03C8012EF3C8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8012EF
            3C8013F03D8013EF3D8013EF3D8013EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF1157195D11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012EF3C8012F03C8013EF3D8012EF3C8013F03D8013EF
            3D8012EF3C8013F03C8013EF3D8012F03C8012EF3B8013EF3D8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF3C8013EF3D8012F0
            3C8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF
            3C8013EF3D8012EF3C8013F03D8012EF3C8012EF3C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF115719491157197E11571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A92B8013EF3C8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8013F03D8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8013EF3C8012EF3C8013EF
            3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C8013F03C8013F0
            3C8013EF3C8013EF3C8013EF3D8012EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1057
            18341157197E1157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82A8013EF3D8013EF3D8013EF3D8012EF3C8012EF3C8012EF
            3C8013EF3C8013F03D8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8012F03C8012EF3C8013EF3C8013EF3D8013EF3D8013EF3D8012EF
            3C8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8013EF3D8013EF
            3C8012EF3C8012EF3C8012EF3C8012EF3C8012F03C8013EF3D8012EF3C8012EF
            3C8012EF3C8013EF3D8012EF3C8012F03C8012F03C80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157
            197B115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198015A82B8012F03C8012F03C8013EF3D8013EF3D8012EF3C8012EF
            3C8013EF3D8013EF3D8013EF3D8012EF3C8013F03D8012EF3C8012EF3C8012EF
            3C8012F03C8012EF3C8012EF3C8012EF3C8012F03C8013EF3D8013F03D8013EF
            3C8013EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8013EF3D8013EF3C8013EF3C8013EF3C8013EF3C8013EF3D8013EF
            3D8013EF3D8013F03D8012EF3C8013EF3C8013EF3D80FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF105718721157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198014B12D8013EF3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8013F03D8012F03C8012EF3C8013EF3D8012EF3C8013EF3D8012F03C8012EF
            3C8013EF3D8012EF3C8013F03D8013EF3D8012EF3C8012EF3C8012F03C8012F0
            3C8013F03D8012EF3C8013EF3D8013EF3D8013F03D8012EF3C8013F03D8013EF
            3D8013EF3D8012EF3C8012EF3C8012EF3C8012EF3C7EFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF11581965115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198012621B8014D5368012EF3C8012F03C8013F03D8012EF3C8013EF3D8013EF
            3D8012EF3C8013EF3D8013EF3D8012EF3C8013F03D8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013EF3D8012EF3C8013F03C8012EF3C8013F0
            3D8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8013EF3D8013F03D8012EF
            3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8013EF3D8013EF3D8012EF3C8013F03D8012F03C6AFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1157185111571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801594278013EF3C8012EF3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF
            3C8013EF3D8012EF3C8013EF3D8013EF3D8012EF3C8012EF3C8013EF3C8012EF
            3C8012EF3C8013EF3C8013EF3D8013EF3D8012EF3C8012F03C8013EF3D8013EF
            3D8013F03D8012EF3C8012EF3C8013EF3C8012EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8012F03C8013EF
            3D8012EF3C8013EF3D8012EF3C8013EF3D7FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF105718401157197E11571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198011571980146F
            1E8013E4398012EF3C8013EF3D8013F03D8012EF3C8013EF3D8012EF3C8012EF
            3C8012F03C8012EF3C8013EF3D8013EF3D8012EF3C8013F03D8012EF3C8012EF
            3C8012EF3C8012EF3C8013F03D8012EF3C8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8012EF3C8012F03C8012EF3C8012EF3C8012F03C8012EF3C8013EF
            3D8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF3D8012EF3C8012F0
            3C8012EF3C8012EF3C8012F03D80FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF1157197D1157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            198011571980115719801157198011571980115719801157198013661C8015D3
            358012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8013EF3D8013F03D8013EF3D8012EF3C8012EF3C8013EF
            3D8012EF3C8012EF3C8013F03D8012EF3C8012EF3C8012EF3C8013F03D8012EF
            3C8013EF3D8012EF3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8012EF
            3C8012EF3C8012EF3C8012EF3C8013F03D8013EF3D8013EF3D8012EF3C8012EF
            3C8012EF3C8012EF3C80FEFFFFFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF11571974115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            1980115719801157198011571980115719801157198011571980115719801157
            19801157198011571980115719801157198011571980136C1D8014CD348013F0
            3C8013EF3D8012EF3C8012EF3C8013EF3D8013EF3D8013EF3D8012EF3C8013EF
            3D8012EF3C8013EF3D8013EF3D8013EF3D8013EF3C8012EF3C8012EF3C8013EF
            3D8012EF3C8013F03D8013EF3D8012F03C8013F03D8012EF3C8012EF3C8012F0
            3C8013F03D8013EF3D8012EF3C8012EF3C8013EF3D8012EF3C8012EF3C8012EF
            3C8012EF3C8012EF3C8012EF3C8013EF3D8013EF3C8012EF3C8012EF3C8013F0
            3D8012EF3C79FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFFFEFDFEFF
            FEFCFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFCFEFFFEFCFEFFFEFDFEFFFEFCFEFF
            FEFDFEFFFEFCFEFFFEFCFEFFFEFCFEFFFEFCFEFFFEFDFEFFFEFCFEFFFEFDFEFF
            FEFDFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFDFEFFFEFDFEFFFEFDFEFFFEFDFEFF
            FEFCFEFFFEFCFEFFFEFCFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFCFEFFFEFDFEFF
            FEFDFEFFFEFCFEFFFEFCFEFFFEFDFEFFFEFDFEFFFEFCFEFFFEFCFEFFFEFCFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFF}
          HightQuality = False
          Transparent = False
          TransparentColor = clWhite
        end
        object SysMemo1: TfrxSysMemoView
          AllowVectorExport = True
          Left = 944.881889763779500000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Frame.Typ = []
          Memo.UTF8W = (
            'Data: [DATE]')
        end
        object SysMemo3: TfrxSysMemoView
          AllowVectorExport = True
          Left = 944.881889763779500000
          Top = 22.677180000000000000
          Width = 75.590551180000000000
          Height = 18.897650000000000000
          AutoWidth = True
          Frame.Typ = []
          Memo.UTF8W = (
            'Hora: [Time]')
        end
        object vFiltro: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 45.354360000000000000
          Top = 41.574830000000000000
          Width = 895.748610000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[vFiltro]')
          ParentFont = False
        end
      end
      object ColumnHeader1: TfrxColumnHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 109.606370000000000000
        Width = 1046.929810000000000000
        object Line2: TfrxLineView
          AllowVectorExport = True
          Top = 15.118117560000000000
          Width = 1039.370750000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'digo')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 52.913420000000000000
          Width = 124.724490000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 370.393940000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Embalagem')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 445.984540000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Ean 01')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 608.504330000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Ean 02')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 695.433520000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Ean 03')
          ParentFont = False
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 778.583180000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Ean 04')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 861.732840000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Ean 05')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 944.882500000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Ean 06')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 268.346630000000000000
        Width = 1046.929810000000000000
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Rhemasys Solu'#231#245'es')
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Width = 1039.370750000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
        object Lblusuario: TfrxMemoView
          AllowVectorExport = True
          Left = 230.551330000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Usu'#225'rio: ')
        end
        object vUsuario: TfrxMemoView
          AllowVectorExport = True
          Left = 294.803340000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            '[vUsuario]')
        end
        object SysMemo2: TfrxSysMemoView
          AllowVectorExport = True
          Left = 925.984850000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'P'#225'g: [Page#] de [TOTALPAGES#]')
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 188.976500000000000000
        Width = 1046.929810000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint_inherited'
        DataSet = frxDBDataset1
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object frxDBDataset1Background: TfrxMemoView
          AllowVectorExport = True
          Left = 7559.055118110240000000
          Width = 75.590551181102400000
          Height = 22.677180000000000000
          Visible = False
          OnBeforePrint = 'frxDBDataset1BackgroundOnBeforePrint_inherited'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = ' Frac(<Line> / 2) = 0.5'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = clSilver
          Highlight.Frame.Typ = []
          Highlight.Visible = False
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
          WordWrap = False
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Width = 45.354330710000000000
          Height = 15.118120000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
          ParentFont = False
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 52.913420000000000000
          Width = 313.700990000000000000
          Height = 15.118120000000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
          ParentFont = False
        end
        object frxDBDataset1Embalagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 370.393940000000000000
          Width = 71.811070000000000000
          Height = 15.118120000000000000
          DataField = 'Embalagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Embalagem"]')
          ParentFont = False
        end
        object frxDBDataset1EnderecoFormatado: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 445.984540000000000000
          Width = 75.590600000000000000
          Height = 15.118120000000000000
          DataField = 'EnderecoFormatado'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."EnderecoFormatado"]')
          ParentFont = False
        end
        object frxDBDataset1Ean01: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 525.354670000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'Ean01'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Ean01"]')
          ParentFont = False
        end
        object frxDBDataset1Ean02: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 608.504330000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'Ean02'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Ean02"]')
        end
        object frxDBDataset1Ean03: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 695.433520000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'Ean03'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Ean03"]')
        end
        object frxDBDataset1Ean04: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 778.583180000000000000
          Width = 79.370130000000000000
          Height = 15.118120000000000000
          DataField = 'Ean04'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Ean04"]')
        end
        object frxDBDataset1Ean05: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 861.732840000000000000
          Width = 79.370056770000000000
          Height = 15.118120000000000000
          DataField = 'Ean05'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Ean05"]')
        end
        object frxDBDataset1Ean06: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 944.882500000000000000
          Width = 79.370078740000000000
          Height = 15.118120000000000000
          DataField = 'Ean06'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Ean06"]')
        end
      end
    end
  end
end
