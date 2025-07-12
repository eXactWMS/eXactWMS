inherited FrmRelCaixaEmbalagemRastreamento: TFrmRelCaixaEmbalagemRastreamento
  Caption = 'FrmRelCaixaEmbalagemRastreamento'
  ClientHeight = 688
  ExplicitHeight = 690
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Height = 633
    Properties.ActivePage = TabPrincipal
    ClientRectBottom = 633
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstCadastro: TAdvStringGrid
        Height = 571
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 571
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LblTotRegCaption: TLabel
        Left = 20
        Top = 186
        ExplicitLeft = 20
        ExplicitTop = 186
      end
      inherited LblTotRegistro: TLabel
        Left = 143
        Top = 186
        ExplicitLeft = 143
        ExplicitTop = 186
      end
      inherited PnlInfo: TPanel
        Top = 423
      end
      inherited LstReport: TAdvStringGrid
        Top = 204
        Height = 405
        ColCount = 10
        ColumnHeaders.Strings = (
          'Num.Caixa'
          'Volume'
          'Pedido'
          'Data'
          'Cod.Dest.'
          'Fantasia'
          'Rota'
          'Localiza'#231#227'o da Caixa'
          'Modelo Caixa'
          'Identifica'#231#227'o')
        ExplicitTop = 204
        ExplicitHeight = 320
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
          74)
      end
      object GroupBox14: TGroupBox
        Left = 20
        Top = 15
        Width = 167
        Height = 112
        CustomHint = BalloonHint1
        Caption = ' [ Data Pedidos ] '
        TabOrder = 3
        TabStop = True
        object Label45: TLabel
          Left = 22
          Top = 21
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label46: TLabel
          Left = 5
          Top = 76
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtDtPedidoInicial: TJvDateEdit
          Left = 58
          Top = 19
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtDtPedidoInicialChange
        end
        object EdtDtPedidoFinal: TJvDateEdit
          Left = 58
          Top = 75
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtDtPedidoInicialChange
        end
      end
      object GroupBox12: TGroupBox
        Left = 207
        Top = 17
        Width = 621
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Destinat'#225'rio ] '
        TabOrder = 4
        TabStop = True
        object Label25: TLabel
          Left = 8
          Top = 21
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblDestinatario: TLabel
          Left = 161
          Top = 25
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
        object EdtDestinatarioId: TEdit
          Left = 57
          Top = 19
          Width = 73
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtDtPedidoInicialChange
          OnExit = EdtDestinatarioIdExit
          OnKeyPress = EdtDestinatarioIdKeyPress
        end
        object BtnPesqDestinatario: TBitBtn
          Left = 131
          Top = 19
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
          OnClick = BtnPesqDestinatarioClick
        end
      end
      object GroupBox11: TGroupBox
        Left = 207
        Top = 72
        Width = 328
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Processo ] '
        TabOrder = 5
        object Label23: TLabel
          Left = 8
          Top = 22
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblProcesso: TLabel
          Left = 127
          Top = 26
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
        object EdtProcessoId: TEdit
          Left = 25
          Top = 20
          Width = 73
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtDtPedidoInicialChange
          OnExit = EdtProcessoIdExit
          OnKeyPress = EdtDestinatarioIdKeyPress
        end
        object BtnProcesso: TBitBtn
          Left = 97
          Top = 20
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
          OnClick = BtnProcessoClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 535
        Top = 72
        Width = 293
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Faixa de Caixa(s) ] '
        TabOrder = 6
        object Label2: TLabel
          Left = 8
          Top = 22
          Width = 32
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Inicial'
        end
        object Label3: TLabel
          Left = 168
          Top = 22
          Width = 32
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Inicial'
        end
        object EdtNumSequenciaCxaInicial: TEdit
          Left = 46
          Top = 20
          Width = 73
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtDtPedidoInicialChange
          OnKeyPress = EdtDestinatarioIdKeyPress
        end
        object EdtNumSequenciaCxaFinal: TEdit
          Left = 207
          Top = 20
          Width = 73
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnChange = EdtDtPedidoInicialChange
          OnKeyPress = EdtDestinatarioIdKeyPress
        end
      end
      object GroupBox2: TGroupBox
        Left = 834
        Top = 17
        Width = 225
        Height = 110
        CustomHint = BalloonHint1
        Caption = '[ Resumo das Caixas ]'
        Enabled = False
        TabOrder = 7
        object Label4: TLabel
          Left = 43
          Top = 12
          Width = 28
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Total'
        end
        object Label5: TLabel
          Left = 11
          Top = 60
          Width = 60
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dispon'#237'vel'
        end
        object Label6: TLabel
          Left = 163
          Top = 13
          Width = 46
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Em Loja'
        end
        object Label7: TLabel
          Left = 158
          Top = 60
          Width = 51
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Inativa(s)'
        end
        object EdtCaixaTotal: TJvCalcEdit
          Left = 9
          Top = 28
          Width = 64
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
        end
        object EdtCaixaLoja: TJvCalcEdit
          Left = 145
          Top = 28
          Width = 64
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = False
        end
        object EdtCaixaDisponivel: TJvCalcEdit
          Left = 9
          Top = 78
          Width = 64
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
        end
        object EdtCaixaInativa: TJvCalcEdit
          Left = 145
          Top = 78
          Width = 64
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = False
        end
      end
      object GroupBox9: TGroupBox
        Left = 19
        Top = 128
        Width = 516
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Rota ] '
        TabOrder = 8
        object Label19: TLabel
          Left = 7
          Top = 23
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblRota: TLabel
          Left = 100
          Top = 24
          Width = 161
          Height = 16
          CustomHint = BalloonHint1
          AutoSize = False
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object EdtRotaId: TEdit
          Left = 24
          Top = 20
          Width = 45
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnExit = EdtRotaIdExit
        end
        object BtnPesqRota: TBitBtn
          Left = 70
          Top = 20
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
          OnClick = BtnPesqRotaClick
        end
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited DbgImporta: TDBGrid
        Height = 405
      end
    end
    object TabCuboRastreamento: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Cubo Rastreamento'
      ImageIndex = 4
      ExplicitHeight = 524
      object cxDBPivotGrid1: TcxDBPivotGrid
        Left = 0
        Top = 0
        Width = 1157
        Height = 609
        CustomHint = BalloonHint1
        Align = alClient
        DataSource = DsPesqGeral
        Groups = <>
        TabOrder = 0
        ExplicitHeight = 524
        object pvEmbalagemId: TcxDBPivotGridField
          AreaIndex = 3
          IsCaptionAssigned = True
          Caption = 'Emb.Id'
          DataBinding.FieldName = 'EmbalagemId'
          Visible = True
          UniqueName = 'Emb.Id'
        end
        object pvNumSequencia: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 1
          IsCaptionAssigned = True
          Caption = 'Num.Caixa'
          DataBinding.FieldName = 'NumSequencia'
          Visible = True
          UniqueName = 'Num.Caixa'
        end
        object pvPedidoId: TcxDBPivotGridField
          AreaIndex = 0
          IsCaptionAssigned = True
          Caption = 'Pedido'
          DataBinding.FieldName = 'PedidoId'
          Visible = True
          UniqueName = 'Pedido'
        end
        object pvPedidoVolumeId: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 3
          IsCaptionAssigned = True
          Caption = 'Volume'
          DataBinding.FieldName = 'PedidoVolumeId'
          Visible = True
          UniqueName = 'Volume'
        end
        object PvDocumentoData: TcxDBPivotGridField
          AreaIndex = 1
          IsCaptionAssigned = True
          Caption = 'Data'
          DataBinding.FieldName = 'DocumentoData'
          Visible = True
          UniqueName = 'Data'
        end
        object pvCodPessoaERP: TcxDBPivotGridField
          AreaIndex = 5
          IsCaptionAssigned = True
          Caption = 'Cod.Destinat'#225'rio'
          DataBinding.FieldName = 'CodPessoaERP'
          Visible = True
          UniqueName = 'Cod.Destinat'#225'rio'
        end
        object pvFantasia: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 2
          IsCaptionAssigned = True
          Caption = 'Destinat'#225'rio'
          DataBinding.FieldName = 'Fantasia'
          Visible = True
          UniqueName = 'Destinat'#225'rio'
        end
        object pvSituacao: TcxDBPivotGridField
          AreaIndex = 2
          IsCaptionAssigned = True
          Caption = 'Localiza'#231#227'o da Caixa'
          DataBinding.FieldName = 'Situacao'
          Visible = True
          UniqueName = 'Situa'#231#227'o'
        end
        object PvDescricao: TcxDBPivotGridField
          AreaIndex = 4
          IsCaptionAssigned = True
          Caption = 'Descr.Embalagem'
          DataBinding.FieldName = 'Descricao'
          Visible = True
          UniqueName = 'Descr.Embalagem'
        end
        object pvIdentificacao: TcxDBPivotGridField
          Area = faRow
          AreaIndex = 0
          IsCaptionAssigned = True
          Caption = 'Identifica'#231#227'o'
          DataBinding.FieldName = 'Identificacao'
          SummaryType = stCount
          Visible = True
          UniqueName = 'Identifica'#231#227'o'
        end
        object pvTCaixa: TcxDBPivotGridField
          Area = faData
          AreaIndex = 0
          IsCaptionAssigned = True
          Caption = 'Total Caixa(s)'
          DataBinding.FieldName = 'TCaixa'
          Visible = True
          UniqueName = 'Total Caixa(s)'
        end
        object pcRota: TcxDBPivotGridField
          AreaIndex = 6
          IsCaptionAssigned = True
          Caption = 'Rota'
          DataBinding.FieldName = 'Rota'
          Visible = True
          UniqueName = 'Rota'
        end
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 984
    Top = 289
    ExplicitLeft = 984
    ExplicitTop = 289
  end
  inherited PnlErro: TPanel
    Top = 666
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 810
    Top = 288
    ExplicitLeft = 810
    ExplicitTop = 288
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited DsPesqGeral: TDataSource
    Left = 443
    Top = 276
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralEmbalagemId: TIntegerField
      FieldName = 'EmbalagemId'
    end
    object FdMemPesqGeralNumSequencia: TIntegerField
      FieldName = 'NumSequencia'
    end
    object FdMemPesqGeralPedidoVolumeId: TIntegerField
      FieldName = 'PedidoVolumeId'
    end
    object FdMemPesqGeralPedidoId: TIntegerField
      FieldName = 'PedidoId'
    end
    object FdMemPesqGeralDocumentoData: TDateField
      FieldName = 'DocumentoData'
    end
    object FdMemPesqGeralCodPessoaERP: TIntegerField
      FieldName = 'CodPessoaERP'
    end
    object FdMemPesqGeralFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 100
    end
    object FdMemPesqGeralRota: TStringField
      FieldName = 'Rota'
      Size = 60
    end
    object FdMemPesqGeralProcessoId: TIntegerField
      FieldName = 'ProcessoId'
    end
    object FdMemPesqGeralProcesso: TStringField
      FieldName = 'Processo'
      Size = 30
    end
    object FdMemPesqGeralDtProcesso: TDateField
      FieldName = 'DtProcesso'
    end
    object FdMemPesqGeralSituacao: TStringField
      FieldName = 'Situacao'
      Size = 40
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object FdMemPesqGeralIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 5
    end
    object FdMemPesqGeralTCaixa: TIntegerField
      FieldName = 'TCaixa'
    end
  end
  inherited FdMemImportaCSV: TFDMemTable
    Left = 289
    Top = 364
  end
  inherited DsImportaCSV: TDataSource
    Left = 281
    Top = 414
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 45793.727234513890000000
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
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        inherited Memo1: TfrxMemoView
          Left = 162.519790000000000000
        end
        inherited Memo2: TfrxMemoView
          Left = 162.519790000000000000
        end
        inherited Picture1: TfrxPictureView
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
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 396.850650000000000000
      end
      inherited MasterData1: TfrxMasterData
        Top = 257.008040000000000000
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 623.622450000000000000
          Top = 3.779530000000000000
          Width = 79.370007950000000000
          Height = 18.897650000000000000
          Visible = False
          DataField = 'PedidoId'
          Memo.UTF8W = (
            '[frxDBDataset1."PedidoId"]')
        end
        object frxDBDataset1NumSequencia: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 75.590600000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'NumSequencia'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."NumSequencia"]')
        end
        object frxDBDataset1PedidoId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 162.519790000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PedidoId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."PedidoId"]')
        end
        object frxDBDataset1PedidoVolumeId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 253.228510000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'PedidoVolumeId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."PedidoVolumeId"]')
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 166.299320000000000000
        Width = 718.110700000000000000
        Child = frxReport1.Child1
        Condition = 'frxDBDataset1."CodPessoaERP"'
        object frxDBDataset1CodPessoaERP: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 90.708720000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'CodPessoaERP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."CodPessoaERP"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Destinat'#225'rio:')
        end
        object Memo6: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 158.740260000000000000
          Width = 260.787570000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Fantasia"]')
          ParentFont = False
        end
        object frxDBDataset1Rota: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 483.779840000000000000
          Width = 226.771653540000000000
          Height = 18.897650000000000000
          DataField = 'Rota'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Rota"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 442.205010000000000000
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Rota:')
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 18.897650000000000000
          Width = 706.771653543307100000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 302.362400000000000000
        Width = 718.110700000000000000
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 230.551330000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Total Caixa(s) --->')
          ParentFont = False
        end
        object SysMemo4: TfrxSysMemoView
          AllowVectorExport = True
          Left = 370.393940000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[COUNT(MasterData1,0)]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = 11.338590000000000000
          Top = 22.677180000000000000
          Width = 699.213050000000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
      end
      object Child1: TfrxChild
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 211.653680000000000000
        Width = 718.110700000000000000
        ToNRows = 0
        ToNRowsMode = rmCount
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 75.590600000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Nr.Caixa')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 162.519790000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Pedido')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 253.228510000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Volume')
        end
      end
    end
  end
end
