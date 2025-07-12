inherited FrmRelPedidos: TFrmRelPedidos
  Caption = 'FrmRelPedidos'
  ClientHeight = 768
  ClientWidth = 1366
  ExplicitWidth = 1368
  ExplicitHeight = 770
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1367
    Height = 713
    Properties.ActivePage = TabRelVolumes
    ExplicitWidth = 1367
    ExplicitHeight = 713
    ClientRectBottom = 713
    ClientRectRight = 1367
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1367
      ExplicitHeight = 689
      inherited LstCadastro: TAdvStringGrid
        Width = 1347
        Height = 651
        ExplicitWidth = 1343
        ExplicitHeight = 678
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 651
        ExplicitHeight = 651
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1367
        ExplicitWidth = 1367
        inherited BtnPesqConsGeral: TsImage
          Left = 808
          ExplicitLeft = 804
        end
        inherited LblClearFilter: TLabel
          Left = 843
          ExplicitLeft = 839
        end
        inherited LblRegTit: TLabel
          Left = 1047
          ExplicitLeft = 1043
        end
        inherited LblTotReg: TLabel
          Left = 1183
          ExplicitLeft = 1179
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 466
          ExplicitWidth = 466
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      Caption = 'Pedidos - Sa'#237'das'
      ExplicitWidth = 1367
      ExplicitHeight = 689
      inherited PnlInfo: TPanel
        Top = 503
        ExplicitTop = 503
      end
      inherited ChkCadastro: TCheckBox
        TabOrder = 5
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 3
        Width = 167
        Height = 110
        CustomHint = BalloonHint1
        Caption = '[ Per'#237'odo ]'
        TabOrder = 1
        TabStop = True
        object Label2: TLabel
          Left = 22
          Top = 21
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label3: TLabel
          Left = 5
          Top = 76
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtInicio: TJvDateEdit
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
          OnChange = EdtInicioChange
        end
        object EdtTermino: TJvDateEdit
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
          OnChange = EdtInicioChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 174
        Top = 3
        Width = 327
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Pedido ]'
        TabOrder = 2
        TabStop = True
        object Label11: TLabel
          Left = 8
          Top = 21
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object Label10: TLabel
          Left = 144
          Top = 21
          Width = 54
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Docto Nr'
        end
        object EdtPedidoId: TEdit
          Left = 25
          Top = 19
          Width = 84
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
          OnChange = EdtInicioChange
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object EdtDocumentoNr: TEdit
          Left = 203
          Top = 19
          Width = 104
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
          OnChange = EdtInicioChange
          OnKeyPress = EdtPedidoIdKeyPress
        end
      end
      object GroupBox5: TGroupBox
        Left = 174
        Top = 58
        Width = 327
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Rota ]'
        TabOrder = 3
        object Label13: TLabel
          Left = 7
          Top = 23
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblRota: TLabel
          Left = 96
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
          OnChange = EdtInicioChange
          OnExit = EdtRotaIdExit
        end
        object BtnPesqRota: TBitBtn
          Left = 66
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
      object GroupBox4: TGroupBox
        Left = 499
        Top = 3
        Width = 426
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Destinat'#225'rio ]'
        TabOrder = 4
        TabStop = True
        object Label9: TLabel
          Left = 8
          Top = 21
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblDestinatario: TLabel
          Left = 157
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
        object EdtDestinatario: TEdit
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
          OnChange = EdtInicioChange
          OnExit = EdtDestinatarioExit
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object BtnPesqCliente: TBitBtn
          Left = 127
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
          OnClick = BtnPesqClienteClick
        end
      end
      object PgcPedidos: TcxPageControl
        Left = 9
        Top = 178
        Width = 1350
        Height = 495
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 6
        Properties.ActivePage = TabVolumes
        Properties.CustomButtons.Buttons = <>
        Properties.Style = 9
        ClientRectBottom = 495
        ClientRectRight = 1350
        ClientRectTop = 24
        object TabPedidos: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Pedidos'
          ImageIndex = 0
          OnShow = TabPedidosShow
          object LstPedidosAdv: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 681
            Height = 471
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alClient
            ColCount = 27
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstPedidosAdvClickCell
            OnDblClickCell = LstPedidosAdvDblClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Pedido Id'
              'Data'
              'Opera'#231#227'o'
              'C'#243'digo'
              'Destinat'#225'rio'
              'Processo'
              'Dt.Processo'
              'Picking'
              'Itens'
              'Demanda'
              'Qtd.Suprida'
              'Volumes'
              'Cxa.Fechada'
              'V.Fracionado'
              'Cancelado'
              'Peso Kg'
              'Vol.m3'
              'Documento Nr'
              'Docto Original'
              'NF-e'
              'Rota'
              'Carga'
              'Status'
              'Rota Id'
              'Integra'#231#227'o'
              'A'#231#227'o'
              'Motivo da Exclus'#227'o')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ExplicitLeft = -1
            ColWidths = (
              74
              78
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
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
          object LstPedidoProcesso: TAdvStringGrid
            Left = 681
            Top = 0
            Width = 669
            Height = 471
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alRight
            Anchors = [akLeft, akTop, akRight, akBottom]
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            FixedCols = 0
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            Visible = False
            HoverRowCells = [hcNormal, hcSelected]
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Processo'
              'Data'
              'Hora'
              'Usu'#225'rio'
              'Esta'#231#227'o')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
        object TabResumo: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Resumo Atendimento'
          ImageIndex = 2
          object LstPedidoResumoAdv: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 1350
            Height = 471
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alClient
            ColCount = 10
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstPedidoResumoAdvClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Id'
              'C'#243'digo'
              'Descri'#231#227'o'
              'Picking'
              'Zona'
              'Demanda'
              'Embal.'
              'Suprida'
              'Volume(Cm3)'
              'Peso(Kg)')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
              74
              74
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
        object TabVolumes: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Volumes'
          ImageIndex = 1
          DesignSize = (
            1350
            471)
          object LstVolumesAdv: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 890
            Height = 247
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alLeft
            ColCount = 12
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            OnClick = LstVolumesAdvClick
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstVolumesAdvClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Volume Id'
              'Seq.'
              'Embalagem'
              'Tp.Embalagem'
              'Ident.'
              'Tara'
              'Caixa'
              'Processo'
              'A'#231#227'o'
              'Carga'
              'Print'
              'ProcessoId')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
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
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
          object LstVolumeProdutosAdv: TAdvStringGrid
            Left = 0
            Top = 247
            Width = 1350
            Height = 224
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alBottom
            ColCount = 13
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstVolumeProdutosAdvClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'C'#243'digo'
              'Descri'#231#227'o'
              'Lote'
              'Vencimento'
              'Endere'#231'o'
              'Zona/Setor'
              'Demanda'
              'Qtd.Suprida'
              'Peso(kg)'
              'Volume(m3)'
              'Operador'
              'Data/Hora'
              'Esta'#231#227'o')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
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
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
          object LstVolumeEtapas: TAdvStringGrid
            Left = 926
            Top = 0
            Width = 424
            Height = 247
            Cursor = crDefault
            CustomHint = BalloonHint1
            Anchors = [akTop, akRight, akBottom]
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            FixedCols = 0
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 2
            HoverRowCells = [hcNormal, hcSelected]
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Processo'
              'Data'
              'Hora'
              'Usu'#225'rio'
              'Esta'#231#227'o')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 499
        Top = 58
        Width = 426
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Processo ]'
        TabOrder = 7
        object Label4: TLabel
          Left = 8
          Top = 22
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblProcesso: TLabel
          Left = 129
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
          Left = 26
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
          OnChange = EdtInicioChange
          OnExit = EdtProcessoIdExit
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object BtnPesqProcesso: TBitBtn
          Left = 99
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
          OnClick = BtnPesqProcessoClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 921
        Top = 3
        Width = 228
        Height = 186
        CustomHint = BalloonHint1
        Caption = '[ Detalhes ]'
        TabOrder = 8
        object Label5: TLabel
          Left = 9
          Top = 19
          Width = 94
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Ressuprimento: '
        end
        object Label6: TLabel
          Left = 69
          Top = 42
          Width = 34
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Itens: '
        end
        object LblRegistro: TLabel
          Left = 100
          Top = 19
          Width = 65
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Resgistro: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblItens: TLabel
          Left = 127
          Top = 42
          Width = 38
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Itens: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 40
          Top = 65
          Width = 63
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Demanda: '
        end
        object Label8: TLabel
          Left = 62
          Top = 88
          Width = 41
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Perda: '
        end
        object LblDemanda: TLabel
          Left = 106
          Top = 65
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Demanda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblPerda: TLabel
          Left = 122
          Top = 88
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblPercPerda: TLabel
          Left = 177
          Top = 88
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 14
          Top = 114
          Width = 89
          Height = 17
          CustomHint = BalloonHint1
          Caption = #209' Processado: '
        end
        object LblNProcessado: TLabel
          Left = 122
          Top = 114
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 28
          Top = 137
          Width = 75
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Processado: '
        end
        object LblProcessado: TLabel
          Left = 122
          Top = 137
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Left = 38
          Top = 161
          Width = 65
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Conclu'#237'do: '
        end
        object LblConcluido: TLabel
          Left = 122
          Top = 161
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblPercNProc: TLabel
          Left = 177
          Top = 114
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblPercProc: TLabel
          Left = 177
          Top = 137
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblPercConcluido: TLabel
          Left = 177
          Top = 161
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox7: TGroupBox
        Left = 9
        Top = 114
        Width = 492
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Produto ]'
        TabOrder = 9
        object Label12: TLabel
          Left = 9
          Top = 23
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblProduto: TLabel
          Left = 158
          Top = 24
          Width = 326
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
        object EdtCodProduto: TEdit
          Left = 58
          Top = 20
          Width = 72
          Height = 24
          CustomHint = BalloonHint1
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtInicioChange
          OnExit = EdtCodProdutoExit
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object BtnPesqProduto: TBitBtn
          Left = 130
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
          OnClick = BtnPesqProdutoClick
        end
      end
      object ChkPedidoPendente: TCheckBox
        Left = 710
        Top = 137
        Width = 129
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Todos Pendentes'
        Enabled = False
        TabOrder = 10
        OnClick = ChkPedidoPendenteClick
      end
      object GbNotaFiscal: TGroupBox
        Left = 499
        Top = 114
        Width = 196
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Nota Fiscal ]'
        TabOrder = 11
        object LblNotaFiscal: TLabel
          Left = 17
          Top = 23
          Width = 26
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Nf-e'
        end
        object EdtNotaFiscalERP: TEdit
          Left = 49
          Top = 20
          Width = 120
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
          OnChange = EdtInicioChange
        end
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1367
      ExplicitHeight = 689
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1367
      ExplicitHeight = 689
      inherited DbgImporta: TDBGrid
        Width = 1367
        Height = 485
      end
    end
    object TabRelVolumes: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Volumes - Consulta'
      ImageIndex = 4
      OnShow = TabRelVolumesShow
      object GroupBox8: TGroupBox
        Left = 171
        Top = 9
        Width = 327
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Pedido ] '
        TabOrder = 1
        TabStop = True
        object Label15: TLabel
          Left = 8
          Top = 21
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object Label17: TLabel
          Left = 144
          Top = 21
          Width = 54
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Docto Nr'
        end
        object EdtPedido_AnalRua: TEdit
          Left = 25
          Top = 19
          Width = 84
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object EdtDocumentoNr_AnalRua: TEdit
          Left = 203
          Top = 19
          Width = 104
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 5
        Top = 120
        Width = 327
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Rota ] '
        TabOrder = 5
        object Label19: TLabel
          Left = 7
          Top = 23
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblRotaVolume_Consulta: TLabel
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
        object EdtRotaId_AnalRua: TEdit
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
          OnExit = EdtRotaIdExit
        end
        object BtnPesqRotaVolume_Consulta: TBitBtn
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
      object GroupBox10: TGroupBox
        Left = 496
        Top = 120
        Width = 621
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Produto ] '
        TabOrder = 7
        object Label21: TLabel
          Left = 9
          Top = 23
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblProdutoConsulta: TLabel
          Left = 182
          Top = 24
          Width = 441
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
        object EdtCodProduto_AnalRua: TEdit
          Left = 58
          Top = 20
          Width = 93
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
          OnExit = EdtCodProdutoExit
        end
        object BtnPesqProdutoConsulta: TBitBtn
          Left = 152
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
          OnClick = BtnPesqProdutoClick
        end
      end
      object GroupBox11: TGroupBox
        Left = 300
        Top = 64
        Width = 328
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Processo ] '
        TabOrder = 4
        object Label23: TLabel
          Left = 8
          Top = 22
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblProcessoVolume: TLabel
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
        object EdtProcessoId_AnalRua: TEdit
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
          OnExit = EdtProcessoIdExit
        end
        object BtnProcesso_Consulta: TBitBtn
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
          OnClick = BtnPesqProcessoClick
        end
      end
      object GroupBox12: TGroupBox
        Left = 496
        Top = 9
        Width = 621
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Destinat'#225'rio ] '
        TabOrder = 3
        TabStop = True
        object Label25: TLabel
          Left = 8
          Top = 21
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblDestinatarioVolume_Consulta: TLabel
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
        object EdtDestinatario_AnalRua: TEdit
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
          OnExit = EdtDestinatarioExit
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object BtnPesqDestinatarioVolume_Consulta: TBitBtn
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
          OnClick = BtnPesqClienteClick
        end
      end
      object PgcVolumesGeral: TcxPageControl
        Left = 0
        Top = 206
        Width = 1367
        Height = 483
        CustomHint = BalloonHint1
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 8
        TabStop = False
        Properties.ActivePage = TabVolumeResumo
        Properties.CustomButtons.Buttons = <>
        Properties.Style = 9
        ClientRectBottom = 483
        ClientRectRight = 1367
        ClientRectTop = 24
        object TabVolumeResumo: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Resumo'
          ImageIndex = 0
          OnShow = TabVolumeResumoShow
          object LstVolumeProdutosConsulta: TAdvStringGrid
            Left = 0
            Top = 259
            Width = 1367
            Height = 200
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alBottom
            ColCount = 13
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstVolumeProdutosAdvClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'C'#243'digo'
              'Descri'#231#227'o'
              'Lote'
              'Vencimento'
              'Endere'#231'o'
              'Zona/Setor'
              'Demanda'
              'Qtd.Suprida'
              'Peso(kg)'
              'Volume(m3)'
              'Operador'
              'Data/Hora'
              'Esta'#231#227'o')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
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
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
          object PnlVolumeConsulta: TPanel
            Left = 0
            Top = 0
            Width = 1367
            Height = 259
            CustomHint = BalloonHint1
            Align = alTop
            Anchors = [akLeft, akTop, akRight, akBottom]
            TabOrder = 1
            object LstVolumeConsulta: TAdvStringGrid
              Left = 1
              Top = 1
              Width = 800
              Height = 257
              Cursor = crDefault
              CustomHint = BalloonHint1
              Align = alLeft
              ColCount = 12
              DefaultColWidth = 74
              DefaultRowHeight = 25
              DrawingStyle = gdsClassic
              RowCount = 25
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
              OnClick = LstVolumeConsultaClick
              HoverRowCells = [hcNormal, hcSelected]
              OnClickCell = LstVolumesAdvClickCell
              HintColor = 5080903
              ActiveCellShow = True
              ActiveCellFont.Charset = DEFAULT_CHARSET
              ActiveCellFont.Color = clWindowText
              ActiveCellFont.Height = -11
              ActiveCellFont.Name = 'MS Sans Serif'
              ActiveCellFont.Style = []
              ActiveCellColor = 5080903
              Bands.Active = True
              Bands.PrimaryColor = 16117735
              CellNode.ShowTree = False
              ColumnHeaders.Strings = (
                'Volume Id'
                'Seq.'
                'Pedido'
                'Embalagem'
                'Extra'
                'Ident.'
                'Caixa'
                'Processo'
                'A'#231#227'o'
                'Carga'
                'Print'
                'ProcessoId')
              ControlLook.FixedGradientHoverFrom = 13619409
              ControlLook.FixedGradientHoverTo = 12502728
              ControlLook.FixedGradientHoverMirrorFrom = 12502728
              ControlLook.FixedGradientHoverMirrorTo = 11254975
              ControlLook.FixedGradientDownFrom = 8816520
              ControlLook.FixedGradientDownTo = 7568510
              ControlLook.FixedGradientDownMirrorFrom = 7568510
              ControlLook.FixedGradientDownMirrorTo = 6452086
              ControlLook.FixedGradientDownBorder = 14007466
              ControlLook.ControlStyle = csClassic
              ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
              ControlLook.DropDownHeader.Font.Color = clWindowText
              ControlLook.DropDownHeader.Font.Height = -11
              ControlLook.DropDownHeader.Font.Name = 'Tahoma'
              ControlLook.DropDownHeader.Font.Style = []
              ControlLook.DropDownHeader.Visible = True
              ControlLook.DropDownHeader.Buttons = <>
              ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
              ControlLook.DropDownFooter.Font.Color = clWindowText
              ControlLook.DropDownFooter.Font.Height = -11
              ControlLook.DropDownFooter.Font.Name = 'Tahoma'
              ControlLook.DropDownFooter.Font.Style = []
              ControlLook.DropDownFooter.Visible = True
              ControlLook.DropDownFooter.Buttons = <>
              Filter = <>
              FilterDropDown.Font.Charset = DEFAULT_CHARSET
              FilterDropDown.Font.Color = clWindowText
              FilterDropDown.Font.Height = -11
              FilterDropDown.Font.Name = 'Tahoma'
              FilterDropDown.Font.Style = []
              FilterDropDown.TextChecked = 'Checked'
              FilterDropDown.TextUnChecked = 'Unchecked'
              FilterDropDownClear = '(All)'
              FilterEdit.TypeNames.Strings = (
                'Starts with'
                'Ends with'
                'Contains'
                'Not contains'
                'Equal'
                'Not equal'
                'Larger than'
                'Smaller than'
                'Clear')
              FixedColWidth = 74
              FixedRowHeight = 25
              FixedFont.Charset = DEFAULT_CHARSET
              FixedFont.Color = clBlack
              FixedFont.Height = -11
              FixedFont.Name = 'MS Sans Serif'
              FixedFont.Style = []
              FloatFormat = '%.2f'
              GridImages = ImgListSimNao
              HoverButtons.Buttons = <>
              HoverButtons.Position = hbLeftFromColumnLeft
              HTMLSettings.ImageFolder = 'images'
              HTMLSettings.ImageBaseName = 'img'
              Look = glListView
              Lookup = True
              MouseActions.DirectEdit = True
              Multilinecells = True
              Navigation.AdvanceOnEnter = True
              Navigation.AdvanceInsert = True
              PrintSettings.DateFormat = 'dd/mm/yyyy'
              PrintSettings.Font.Charset = DEFAULT_CHARSET
              PrintSettings.Font.Color = clWindowText
              PrintSettings.Font.Height = -11
              PrintSettings.Font.Name = 'MS Sans Serif'
              PrintSettings.Font.Style = []
              PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
              PrintSettings.FixedFont.Color = clWindowText
              PrintSettings.FixedFont.Height = -11
              PrintSettings.FixedFont.Name = 'Tahoma'
              PrintSettings.FixedFont.Style = []
              PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
              PrintSettings.HeaderFont.Color = clWindowText
              PrintSettings.HeaderFont.Height = -11
              PrintSettings.HeaderFont.Name = 'MS Sans Serif'
              PrintSettings.HeaderFont.Style = []
              PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
              PrintSettings.FooterFont.Color = clWindowText
              PrintSettings.FooterFont.Height = -11
              PrintSettings.FooterFont.Name = 'MS Sans Serif'
              PrintSettings.FooterFont.Style = []
              PrintSettings.Borders = pbNoborder
              PrintSettings.Centered = False
              PrintSettings.PageNumSep = '/'
              RowIndicator.Data = {
                36090000424D3609000000000000360000002800000018000000180000000100
                2000000000000009000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000277F
                FFFF00000000000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000277F
                FFFF00000000000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              ScrollWidth = 16
              SearchFooter.Color = clBtnFace
              SearchFooter.FindNextCaption = 'Find &next'
              SearchFooter.FindPrevCaption = 'Find &previous'
              SearchFooter.Font.Charset = DEFAULT_CHARSET
              SearchFooter.Font.Color = clWindowText
              SearchFooter.Font.Height = -11
              SearchFooter.Font.Name = 'Tahoma'
              SearchFooter.Font.Style = []
              SearchFooter.HighLightCaption = 'Highlight'
              SearchFooter.HintClose = 'Close'
              SearchFooter.HintFindNext = 'Find next occurence'
              SearchFooter.HintFindPrev = 'Find previous occurence'
              SearchFooter.HintHighlight = 'Highlight occurences'
              SearchFooter.MatchCaseCaption = 'Match case'
              SearchFooter.ResultFormat = '(%d of %d)'
              SelectionColor = clHighlight
              SelectionTextColor = clHighlightText
              SortSettings.DefaultFormat = ssAutomatic
              SortSettings.HeaderColorTo = 16579058
              SortSettings.HeaderMirrorColor = 16380385
              SortSettings.HeaderMirrorColorTo = 16182488
              Version = '8.4.2.2'
              WordWrap = False
              ColWidths = (
                74
                78
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
              RowHeights = (
                24
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25)
            end
            object LstVolumeHistoricoConsulta: TAdvStringGrid
              Left = 922
              Top = -173
              Width = 424
              Height = 428
              Cursor = crDefault
              CustomHint = BalloonHint1
              DefaultColWidth = 74
              DefaultRowHeight = 25
              DrawingStyle = gdsClassic
              FixedCols = 0
              RowCount = 25
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 1
              HoverRowCells = [hcNormal, hcSelected]
              HintColor = 5080903
              ActiveCellShow = True
              ActiveCellFont.Charset = DEFAULT_CHARSET
              ActiveCellFont.Color = clWindowText
              ActiveCellFont.Height = -11
              ActiveCellFont.Name = 'MS Sans Serif'
              ActiveCellFont.Style = []
              ActiveCellColor = 5080903
              Bands.Active = True
              Bands.PrimaryColor = 16117735
              CellNode.ShowTree = False
              ColumnHeaders.Strings = (
                'Processo'
                'Data'
                'Hora'
                'Usu'#225'rio'
                'Esta'#231#227'o')
              ControlLook.FixedGradientHoverFrom = 13619409
              ControlLook.FixedGradientHoverTo = 12502728
              ControlLook.FixedGradientHoverMirrorFrom = 12502728
              ControlLook.FixedGradientHoverMirrorTo = 11254975
              ControlLook.FixedGradientDownFrom = 8816520
              ControlLook.FixedGradientDownTo = 7568510
              ControlLook.FixedGradientDownMirrorFrom = 7568510
              ControlLook.FixedGradientDownMirrorTo = 6452086
              ControlLook.FixedGradientDownBorder = 14007466
              ControlLook.ControlStyle = csClassic
              ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
              ControlLook.DropDownHeader.Font.Color = clWindowText
              ControlLook.DropDownHeader.Font.Height = -11
              ControlLook.DropDownHeader.Font.Name = 'Tahoma'
              ControlLook.DropDownHeader.Font.Style = []
              ControlLook.DropDownHeader.Visible = True
              ControlLook.DropDownHeader.Buttons = <>
              ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
              ControlLook.DropDownFooter.Font.Color = clWindowText
              ControlLook.DropDownFooter.Font.Height = -11
              ControlLook.DropDownFooter.Font.Name = 'Tahoma'
              ControlLook.DropDownFooter.Font.Style = []
              ControlLook.DropDownFooter.Visible = True
              ControlLook.DropDownFooter.Buttons = <>
              Filter = <>
              FilterDropDown.Font.Charset = DEFAULT_CHARSET
              FilterDropDown.Font.Color = clWindowText
              FilterDropDown.Font.Height = -11
              FilterDropDown.Font.Name = 'Tahoma'
              FilterDropDown.Font.Style = []
              FilterDropDown.TextChecked = 'Checked'
              FilterDropDown.TextUnChecked = 'Unchecked'
              FilterDropDownClear = '(All)'
              FilterEdit.TypeNames.Strings = (
                'Starts with'
                'Ends with'
                'Contains'
                'Not contains'
                'Equal'
                'Not equal'
                'Larger than'
                'Smaller than'
                'Clear')
              FixedColWidth = 74
              FixedRowHeight = 25
              FixedFont.Charset = DEFAULT_CHARSET
              FixedFont.Color = clBlack
              FixedFont.Height = -11
              FixedFont.Name = 'MS Sans Serif'
              FixedFont.Style = []
              FloatFormat = '%.2f'
              GridImages = ImgListSimNao
              HoverButtons.Buttons = <>
              HoverButtons.Position = hbLeftFromColumnLeft
              HTMLSettings.ImageFolder = 'images'
              HTMLSettings.ImageBaseName = 'img'
              Look = glListView
              Lookup = True
              MouseActions.DirectEdit = True
              Multilinecells = True
              Navigation.AdvanceOnEnter = True
              Navigation.AdvanceInsert = True
              PrintSettings.DateFormat = 'dd/mm/yyyy'
              PrintSettings.Font.Charset = DEFAULT_CHARSET
              PrintSettings.Font.Color = clWindowText
              PrintSettings.Font.Height = -11
              PrintSettings.Font.Name = 'MS Sans Serif'
              PrintSettings.Font.Style = []
              PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
              PrintSettings.FixedFont.Color = clWindowText
              PrintSettings.FixedFont.Height = -11
              PrintSettings.FixedFont.Name = 'Tahoma'
              PrintSettings.FixedFont.Style = []
              PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
              PrintSettings.HeaderFont.Color = clWindowText
              PrintSettings.HeaderFont.Height = -11
              PrintSettings.HeaderFont.Name = 'MS Sans Serif'
              PrintSettings.HeaderFont.Style = []
              PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
              PrintSettings.FooterFont.Color = clWindowText
              PrintSettings.FooterFont.Height = -11
              PrintSettings.FooterFont.Name = 'MS Sans Serif'
              PrintSettings.FooterFont.Style = []
              PrintSettings.Borders = pbNoborder
              PrintSettings.Centered = False
              PrintSettings.PageNumSep = '/'
              RowIndicator.Data = {
                36090000424D3609000000000000360000002800000018000000180000000100
                2000000000000009000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000277F
                FFFF00000000000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
                FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000277FFFFF277F
                FFFF277FFFFF000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                000000000000000000000000000000000000000000000000000000000000277F
                FFFF00000000000000000000000000000000000000000000000000000000277F
                FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000}
              ScrollWidth = 16
              SearchFooter.Color = clBtnFace
              SearchFooter.FindNextCaption = 'Find &next'
              SearchFooter.FindPrevCaption = 'Find &previous'
              SearchFooter.Font.Charset = DEFAULT_CHARSET
              SearchFooter.Font.Color = clWindowText
              SearchFooter.Font.Height = -11
              SearchFooter.Font.Name = 'Tahoma'
              SearchFooter.Font.Style = []
              SearchFooter.HighLightCaption = 'Highlight'
              SearchFooter.HintClose = 'Close'
              SearchFooter.HintFindNext = 'Find next occurence'
              SearchFooter.HintFindPrev = 'Find previous occurence'
              SearchFooter.HintHighlight = 'Highlight occurences'
              SearchFooter.MatchCaseCaption = 'Match case'
              SearchFooter.ResultFormat = '(%d of %d)'
              SelectionColor = clHighlight
              SelectionTextColor = clHighlightText
              SortSettings.DefaultFormat = ssAutomatic
              SortSettings.HeaderColorTo = 16579058
              SortSettings.HeaderMirrorColor = 16380385
              SortSettings.HeaderMirrorColorTo = 16182488
              Version = '8.4.2.2'
              WordWrap = False
              ColWidths = (
                74
                78
                74
                74
                74)
              RowHeights = (
                24
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25
                25)
            end
          end
        end
        object TabAnalisePorSetor: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'An'#225'lise por Setor'
          ImageIndex = 2
          OnShow = TabAnalisePorSetorShow
          object Panel1: TPanel
            Left = 306
            Top = 12
            Width = 471
            Height = 44
            CustomHint = BalloonHint1
            BevelOuter = bvLowered
            TabOrder = 0
            object Label20: TLabel
              Left = 7
              Top = 2
              Width = 49
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Pedidos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotPedido_AnalisePorSetor: TLabel
              Left = 7
              Top = 18
              Width = 47
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label50: TLabel
              Left = 93
              Top = 2
              Width = 105
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Cxa.Fechada'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolumeCxaFechada_AnalisePorSetor: TLabel
              Left = 101
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object LblTotVolumeFracionado_AnalisePorSetor: TLabel
              Left = 235
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label55: TLabel
              Left = 227
              Top = 2
              Width = 103
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Fracionados'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label56: TLabel
              Left = 363
              Top = 2
              Width = 88
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Total Volumes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolume_AnalisePorSetor: TLabel
              Left = 371
              Top = 18
              Width = 82
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
          end
          object LstAnalisePorSetor: TAdvStringGrid
            Left = 0
            Top = 60
            Width = 1367
            Height = 399
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ColCount = 8
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstAnalisePorSetorClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Id'
              'Zona'
              'Vlm.Cxa Fechada'
              'Vlm.Fracionado'
              'Unid.Cxa.Fechada'
              'Unid.Fracionadas'
              'Total Volumes'
              'Total Unidades')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
        object TabAnalisePorRua: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'An'#225'lise por Rua'
          ImageIndex = 1
          OnShow = TabAnalisePorRuaShow
          object GbEstrutura: TGroupBox
            Left = 3
            Top = 3
            Width = 302
            Height = 51
            CustomHint = BalloonHint1
            Caption = ' [ Estrutura ] '
            TabOrder = 0
            object ChkPulmao: TCheckBox
              Left = 12
              Top = 22
              Width = 153
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Pulm'#227'o / Porta Pallet'
              Enabled = False
              TabOrder = 0
            end
            object ChkPicking: TCheckBox
              Left = 208
              Top = 22
              Width = 81
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Picking'
              Enabled = False
              TabOrder = 1
            end
          end
          object LstAnalisePorRua: TAdvStringGrid
            Left = 0
            Top = 60
            Width = 1367
            Height = 399
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ColCount = 9
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstAnalisePorRuaClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Id'
              'Zona'
              'Rua'
              'Vlm.Cxa Fechada'
              'Vlm.Fracionado'
              'Unid.Cxa.Fechada'
              'Unid.Fracionadas'
              'Total Volumes'
              'Total Unidades')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
              74
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
          object PnlVolumeTotal: TPanel
            Left = 304
            Top = 10
            Width = 471
            Height = 44
            CustomHint = BalloonHint1
            BevelOuter = bvLowered
            TabOrder = 2
            object Label47: TLabel
              Left = 7
              Top = 2
              Width = 49
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Pedidos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotPedido_AnalisePorRua: TLabel
              Left = 7
              Top = 18
              Width = 47
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label49: TLabel
              Left = 93
              Top = 2
              Width = 105
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Cxa.Fechada'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolumeCxaFechada_AnalisePorRua: TLabel
              Left = 101
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object LblTotVolumeFracionado_AnalisePorRua: TLabel
              Left = 235
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label52: TLabel
              Left = 227
              Top = 2
              Width = 103
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Fracionados'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label53: TLabel
              Left = 363
              Top = 2
              Width = 88
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Total Volumes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolume_AnalisePorRua: TLabel
              Left = 371
              Top = 18
              Width = 82
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
          end
        end
        object TabAnalisePorRota: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'An'#225'lise por Rota'
          ImageIndex = 3
          OnShow = TabAnalisePorRotaShow
          object PnlVolumeTotalPorRota: TPanel
            Left = 308
            Top = 14
            Width = 471
            Height = 44
            CustomHint = BalloonHint1
            BevelOuter = bvLowered
            TabOrder = 0
            object Label22: TLabel
              Left = 7
              Top = 2
              Width = 49
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Pedidos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotPedido_AnalisePorRota: TLabel
              Left = 7
              Top = 18
              Width = 47
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label51: TLabel
              Left = 93
              Top = 2
              Width = 105
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Cxa.Fechada'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolumeCxaFechada_AnalisePorRota: TLabel
              Left = 101
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object LblTotVolumeFracionado_AnalisePorRota: TLabel
              Left = 235
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label58: TLabel
              Left = 227
              Top = 2
              Width = 103
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Fracionados'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label59: TLabel
              Left = 363
              Top = 2
              Width = 88
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Total Volumes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolume_AnalisePorRota: TLabel
              Left = 371
              Top = 18
              Width = 82
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
          end
          object LstAnalisePorRota: TAdvStringGrid
            Left = 0
            Top = 60
            Width = 1367
            Height = 399
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ColCount = 8
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstAnalisePorSetorClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Id'
              'Rota'
              'Vlm.Cxa Fechada'
              'Vlm.Fracionado'
              'Unid.Cxa.Fechada'
              'Unid.Fracionadas'
              'Total Volumes'
              'Total Unidades')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
        object TabAnalisePorLoja: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'An'#225'lise por Destinat'#225'rio'
          ImageIndex = 4
          OnShow = TabAnalisePorLojaShow
          object PnlVolumeTotalPorLoja: TPanel
            Left = 310
            Top = 16
            Width = 471
            Height = 44
            CustomHint = BalloonHint1
            BevelOuter = bvLowered
            TabOrder = 0
            object Label61: TLabel
              Left = 7
              Top = 2
              Width = 49
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Pedidos'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotPedido_AnalisePorLoja: TLabel
              Left = 7
              Top = 18
              Width = 47
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label63: TLabel
              Left = 93
              Top = 2
              Width = 105
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Cxa.Fechada'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolumeCxaFechada_AnalisePorLoja: TLabel
              Left = 101
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object LblTotVolumeFracionado_AnalisePorLoja: TLabel
              Left = 235
              Top = 18
              Width = 98
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
            object Label66: TLabel
              Left = 227
              Top = 2
              Width = 103
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Vlm.Fracionados'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label67: TLabel
              Left = 363
              Top = 2
              Width = 88
              Height = 17
              CustomHint = BalloonHint1
              Caption = 'Total Volumes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object LblTotVolume_AnalisePorLoja: TLabel
              Left = 371
              Top = 18
              Width = 82
              Height = 19
              CustomHint = BalloonHint1
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 4227327
              Font.Height = -16
              Font.Name = 'Arial Black'
              Font.Style = []
              ParentFont = False
            end
          end
          object LstAnalisePorLoja: TAdvStringGrid
            Left = 0
            Top = 60
            Width = 1367
            Height = 399
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ColCount = 8
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstAnalisePorSetorClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'C'#243'digo'
              'Destinat'#225'rio'
              'Vlm.Cxa Fechada'
              'Vlm.Fracionado'
              'Unid.Cxa.Fechada'
              'Unid.Fracionadas'
              'Total Volumes'
              'Total Unidades')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ColWidths = (
              74
              78
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
      end
      object GroupBox14: TGroupBox
        Left = 5
        Top = 9
        Width = 167
        Height = 110
        CustomHint = BalloonHint1
        Caption = ' [ Data Pedidos ] '
        TabOrder = 0
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
        object EdtDtPedidoInicial_AnalRua: TJvDateEdit
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
        end
        object EdtDtPedidoFinal_AnalRua: TJvDateEdit
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
        end
      end
      object GbPedidoVolume: TGroupBox
        Left = 171
        Top = 64
        Width = 128
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Volume ] '
        TabOrder = 2
        object Label48: TLabel
          Left = 7
          Top = 23
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object EdtPedidoVolumeId: TEdit
          Left = 24
          Top = 20
          Width = 85
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
          OnKeyPress = EdtPedidoIdKeyPress
        end
      end
      object ChkResumoPorVolume: TCheckBox
        Left = 29
        Top = 178
        Width = 140
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Resumo por Volume'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
        OnClick = ChkResumoPorVolumeClick
      end
      object ChkAnalisePorSetor: TCheckBox
        Left = 201
        Top = 178
        Width = 140
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'An'#225'lise por Setor'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
        OnClick = ChkResumoPorVolumeClick
      end
      object ChkAnalisePorRua: TCheckBox
        Left = 369
        Top = 178
        Width = 140
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'An'#225'lise por Rua'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
        OnClick = ChkResumoPorVolumeClick
      end
      object ChkAnalisePorRota: TCheckBox
        Left = 514
        Top = 178
        Width = 140
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'An'#225'lise por Rota'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 13
        OnClick = ChkResumoPorVolumeClick
      end
      object ChkAnalisePorLoja: TCheckBox
        Left = 667
        Top = 178
        Width = 174
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'An'#225'lise por Destinat'#225'rio'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        OnClick = ChkResumoPorVolumeClick
      end
      object GroupBox15: TGroupBox
        Left = 626
        Top = 64
        Width = 491
        Height = 55
        CustomHint = BalloonHint1
        Caption = ' [ Setor / Zona ] '
        TabOrder = 15
        object Label24: TLabel
          Left = 8
          Top = 22
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblZonaVolume: TLabel
          Left = 111
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
        object EdtZonaId_Volume: TEdit
          Left = 25
          Top = 24
          Width = 56
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
          OnChange = EdtDtPedidoInicial_AnalRuaChange
          OnExit = EdtZonaId_VolumeExit
        end
        object BtnPesqZonaVolume: TBitBtn
          Left = 81
          Top = 24
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
          OnClick = BtnPesqZonaVolumeClick
        end
      end
      object GbVolumeConsulta: TGroupBox
        Left = 924
        Top = 9
        Width = 228
        Height = 166
        CustomHint = BalloonHint1
        Caption = '[ Detalhes ]'
        TabOrder = 9
        object Label27: TLabel
          Left = 40
          Top = 19
          Width = 56
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Total Vol.:'
        end
        object Label28: TLabel
          Left = 39
          Top = 42
          Width = 57
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Pendente:'
        end
        object LblTotVolume: TLabel
          Left = 100
          Top = 19
          Width = 65
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Resgistro: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblTotVolumePendente: TLabel
          Left = 127
          Top = 42
          Width = 38
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Itens: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label31: TLabel
          Left = 38
          Top = 65
          Width = 58
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Expedido:'
        end
        object Label32: TLabel
          Left = 35
          Top = 88
          Width = 61
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Cancelado'
        end
        object LblTotVolumeExpedido: TLabel
          Left = 106
          Top = 65
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Demanda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblTotVolumeCancelado: TLabel
          Left = 122
          Top = 88
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblTotVolumeCanceladoPerc: TLabel
          Left = 177
          Top = 88
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label38: TLabel
          Left = 21
          Top = 113
          Width = 75
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Cxa.Fechada:'
        end
        object LblTotVolumeCxaFechada: TLabel
          Left = 122
          Top = 113
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label40: TLabel
          Left = 4
          Top = 137
          Width = 92
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Cxa.Fracionado:'
        end
        object LblTotVolumeCxaFracionada: TLabel
          Left = 122
          Top = 137
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblTotVolumeCxaFechadaPerc: TLabel
          Left = 177
          Top = 113
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblTotVolumeCxaFracionadaPerc: TLabel
          Left = 177
          Top = 137
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblTotVolumeExpedidoPerc: TLabel
          Left = 176
          Top = 65
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox13: TGroupBox
        Left = 330
        Top = 120
        Width = 167
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Embalagem ]'
        TabOrder = 6
        object CbEmbalagem: TComboBox
          Left = 8
          Top = 20
          Width = 145
          Height = 25
          CustomHint = BalloonHint1
          Style = csDropDownList
          Enabled = False
          ItemIndex = 0
          TabOrder = 0
          Text = '<< Todos >>'
          Items.Strings = (
            '<< Todos >>'
            'Fracionados'
            'Cxa.Fechada')
        end
      end
      object ChkVolumePendente: TCheckBox
        Left = 926
        Top = 181
        Width = 174
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Somente Pendentes'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Roboto'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 16
      end
    end
  end
  inherited PnHeader: TPanel
    Width = 1366
    ExplicitWidth = 1366
    inherited ImgClose: TImage
      Left = 1333
      ExplicitLeft = 1329
    end
    inherited ImgMinimize: TImage
      Left = 1313
      ExplicitLeft = 1309
    end
    inherited PanWin8: TPanel
      Width = 1366
      ExplicitWidth = 1366
      inherited BtnIncluir: TsImage
        Left = 485
        Visible = False
        ExplicitLeft = 485
      end
      inherited BtnExcluir: TsImage
        Left = 576
        Visible = False
        ExplicitLeft = 576
      end
      inherited BtnFechar: TsImage
        Left = 299
        ExplicitLeft = 299
      end
      inherited BtnSalvar: TsImage
        Left = 667
        Visible = False
        ExplicitLeft = 667
      end
      inherited BtnCancelar: TsImage
        Left = 622
        Visible = False
        ExplicitLeft = 622
      end
      inherited BtnEditar: TsImage
        Left = 532
        Visible = False
        ExplicitLeft = 532
      end
      inherited BtnPesquisarStand: TsImage
        Left = 80
        Top = 6
        ExplicitLeft = 80
        ExplicitTop = 6
      end
      inherited BtnImprimirStand: TsImage
        Left = 116
        ExplicitLeft = 116
      end
      inherited BtnExportarStand: TsImage
        Left = 162
        ExplicitLeft = 162
      end
      inherited BtnExportarPDF: TsImage
        Left = 207
        ExplicitLeft = 207
      end
      inherited BtnImportarStand: TsImage
        Left = 253
        ExplicitLeft = 253
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1271
    Top = 539
    ExplicitLeft = 1271
    ExplicitTop = 539
  end
  inherited PnlErro: TPanel
    Top = 746
    Width = 1366
    ExplicitTop = 746
    ExplicitWidth = 1366
    inherited LblMensShowErro: TLabel
      Width = 1366
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 1151
    Top = 118
    ExplicitLeft = 1151
    ExplicitTop = 118
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited BalloonHint1: TBalloonHint
    Left = 727
    Top = 93
  end
  inherited DsPesqGeral: TDataSource
    Left = 193
    Top = 412
  end
  inherited FdMemPesqGeral: TFDMemTable
    Left = 133
    Top = 409
  end
  inherited ImgListSimNao: TImageList
    Left = 792
    Top = 93
    Bitmap = {
      494C010106000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF0000000000000000267EFEFF267EFEFF0000
      000100000000000000000000000000000000F4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF0101020300000000267EFEFF267EFEFF3782
      EFF000000001000000000000000000000000F4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FF267EFEFFF6F7F8FFF6F7F8FFF6F7F8FFF6F7F8FF267EFEFFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF3682F1F2000000013881EAEB267E
      FEFF267EFEFF010101020000000000000000F4EEE6FFF4EEE6FF267EFEFF267E
      FEFFF4EEE6FF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFFF4EE
      E6FF267EFEFF267EFEFFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF0101010200000000267E
      FEFF267EFEFF3682F1F20101010200000000F4EEE6FF267EFEFF267EFEFF267E
      FEFFF4EEE6FF267EFEFFFEFEFEFFFEFEFEFFFEFEFEFFFEFEFEFF267EFEFFF4EE
      E6FF267EFEFF267EFEFF267EFEFFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF3782EFF00000
      00003B7EE2E337619FA0267EFEFF00000000F4EEE6FF267EFEFF267EFEFF267E
      FEFFF4EEE6FF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFFF4EE
      E6FF267EFEFF267EFEFF267EFEFFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF0000
      000100000000267EFEFF267EFEFF00000000F4EEE6FF267EFEFF267EFEFFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FF267EFEFF267EFEFFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF3782EFF0000000000000000000000000F4EEE6FF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFFF4EEE6FF267EFEFF267EFEFFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF2F5183842F51838400000000F4EEE6FF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFFA6C3EFFF267EFEFF267EFEFFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF00000000F4EEE6FF267EFEFF267EFEFF267E
      FEFFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FF267EFEFF267EFEFF267EFEFFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF00000000F4EEE6FF267EFEFF267EFEFF267E
      FEFFF4EEE6FF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFFF4EE
      E6FF267EFEFF267EFEFF267EFEFFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000267EFEFF00000000F4EEE6FFF4EEE6FFDAE0E9FFF4EE
      E6FFF4EEE6FF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFFF4EE
      E6FFDFDEDCFF267EFEFFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000267EFEFF00000000F4EEE6FFF4EEE6FFF4EEE6FF267E
      FEFFF4EEE6FF267EFEFF267EFEFF267EFEFFF4EEE6FFF4EEE6FFF4EEE6FFA6C3
      EFFFA7C4EEFFF4EEE6FFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF00000000F4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FF267EFEFF267EFEFF267EFEFFF4EEE6FFF4EEE6FFA6C3EFFFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF00000000F4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFA6C3EFFFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EE
      E6FFF4EEE6FFF4EEE6FFF4EEE6FFF4EEE6FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFF0000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B1AFACD8D1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003636369E3636369E3636369E3636369E3636369E3636369E3636369E3636
      369E00000000000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF0000000000000000000000003763
      A3A4267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF3763A2A30000000000000000000000000000000000000000000000005657
      59FD575757FF575757FF575757FF575757FF575757FF575757FF575757FF5757
      57FF565759FD000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FF575757FF575757FF575757FF575757FF575757FF575757FF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFFFEFEFEFF3F8BF8FF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FF525B69FF448FFDFF56585AFF4F5E73FF5197FCFF505C6DFF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFFFEFEFEFFFEFEFEFFFEFEFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF00000000267EFEFF267EFEFF00000000267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FF5599FDFF267EFEFF6EA8FDFF74ACFDFF267EFEFF7AAFFBFF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFFFEFEFEFFFEFEFEFF267EFEFFFEFEFEFFFEFEFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF00000000267EFEFF267EFEFF00000000267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FF5F9FFCFF267EFEFF96C0FDFF8EBBFDFF267EFEFF83B4FBFF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFFFEFE
      FEFFFEFEFEFF267EFEFF267EFEFF267EFEFFFEFEFEFFFEFEFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF00000000267EFEFF267EFEFF00000000267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FFF7F7F7FF2A80FEFFB1CFFCFFB9D4FDFF267EFEFF74ABFCFF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFFFEFEFEFFFEFEFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF00000000267EFEFF267EFEFF00000000267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FFC5DAF9FF267EFEFF88B7FDFF9DC4FDFF267EFEFF73ABFBFF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF3A88F8FFFEFEFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF00000000267EFEFF267EFEFF00000000267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FF91BCFAFF267EFEFFA3C7FDFF4792FEFF267EFEFF5D9EFCFF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFFFEFEFEFFFEFE
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF00000000267EFEFF267EFEFF00000000267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FFA4C7FAFF267EFEFFABCBF9FFA3C7FAFF267EFEFF8AB8FBFF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFFFEFE
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF0000000000000000000000000000000000000000000000005757
      57FF575757FF575757FF575757FF575757FF575757FF575757FF575757FF5757
      57FF575757FF000000000000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF000000000000000000000000267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF00000000000000000000000000000000000000003636369E5757
      57FF575757FF575757FF575757FF575757FF575757FF575757FF575757FF5757
      57FF575757FF3636369E0000000000000000D1CFCBFFD1CFCBFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF0000000000000000000000000000
      00000000000000000000267EFEFF267EFEFF267EFEFF267EFEFF000000000000
      0000000000000000000000000000000000000000000000000000000000003636
      369E3636369E3636369E575757FF575757FF575757FF575757FF3636369E3636
      369E3636369E000000000000000000000000B1AFACD8D1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000003636369E3636369E3636369E3636369E000000000000
      00000000000000000000000000000000000000000000D1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CFCBFFD1CF
      CBFFD1CFCBFFD1CFCBFFD1CFCBFF0000000000000000267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267EFEFF267E
      FEFF267EFEFF267EFEFF267EFEFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000818F000000000000
      8087000000000000800300000000000080210000000000008011000000000000
      8009000000000000800700000000000080010000000000008001000000000000
      8001000000000000BFFD000000000000BFFD0000000000008001000000000000
      8001000000000000FFFF00000000000080018001FFFFFFFF00000000FFFFF00F
      3FFC0000E007E0073FFC0000E007E0073FFC0000E007E0073FFC0000E247E007
      3FFC0000E247E0073FFC0000E247E0073FFC0000E247E0073FFC0000E247E007
      3FFC0000E247E0073FFC0000E007E0073FFC0000E007C0033FFC0000FC3FE007
      00000000FFFFFC3F80018001FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object FdMemPesqPedidoResumoAtendimento: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 131
    Top = 469
  end
  object FDGUIxScriptDialog1: TFDGUIxScriptDialog
    Provider = 'Forms'
    Left = 135
    Top = 360
  end
  object FDMemAnalisePorRua: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 337
    Top = 303
    object FDMemAnalisePorRuaZonaId: TIntegerField
      FieldName = 'ZonaId'
    end
    object FDMemAnalisePorRuaZona: TStringField
      FieldName = 'Zona'
      Size = 60
    end
    object FDMemAnalisePorRuaRua: TStringField
      FieldName = 'Rua'
      Size = 2
    end
    object FDMemAnalisePorRuaVolumeCxaFechada: TIntegerField
      FieldName = 'VolumeCxaFechada'
    end
    object FDMemAnalisePorRuaVolumeFracionado: TIntegerField
      FieldName = 'VolumeFracionado'
    end
    object FDMemAnalisePorRuaUnidadeCxaFechada: TIntegerField
      FieldName = 'UnidadeCxaFechada'
    end
    object FDMemAnalisePorRuaUnidadeFracionado: TIntegerField
      FieldName = 'UnidadeFracionado'
    end
    object FDMemAnalisePorRuaTotalVolumes: TIntegerField
      FieldName = 'TotalVolumes'
    end
    object FDMemAnalisePorRuaTotalUnidades: TIntegerField
      FieldName = 'TotalUnidades'
    end
  end
  object FDMemAnalisePorSetor: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 339
    Top = 349
    object IntegerField1: TIntegerField
      FieldName = 'ZonaId'
    end
    object StringField1: TStringField
      FieldName = 'Zona'
      Size = 60
    end
    object IntegerField2: TIntegerField
      FieldName = 'VolumeCxaFechada'
    end
    object IntegerField3: TIntegerField
      FieldName = 'VolumeFracionado'
    end
    object IntegerField4: TIntegerField
      FieldName = 'UnidadeCxaFechada'
    end
    object IntegerField5: TIntegerField
      FieldName = 'UnidadeFracionado'
    end
    object IntegerField6: TIntegerField
      FieldName = 'TotalVolumes'
    end
    object IntegerField7: TIntegerField
      FieldName = 'TotalUnidades'
    end
  end
  object FDMemAnalisePorRota: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 341
    Top = 399
    object FDMemAnalisePorRotaRotaId: TIntegerField
      FieldName = 'RotaId'
    end
    object FDMemAnalisePorRotaRota: TStringField
      FieldName = 'Rota'
      Size = 60
    end
    object IntegerField9: TIntegerField
      FieldName = 'VolumeCxaFechada'
    end
    object IntegerField10: TIntegerField
      FieldName = 'VolumeFracionado'
    end
    object IntegerField11: TIntegerField
      FieldName = 'UnidadeCxaFechada'
    end
    object IntegerField12: TIntegerField
      FieldName = 'UnidadeFracionado'
    end
    object IntegerField13: TIntegerField
      FieldName = 'TotalVolumes'
    end
    object IntegerField14: TIntegerField
      FieldName = 'TotalUnidades'
    end
  end
  object FDMemAnalisePorLoja: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 343
    Top = 451
    object FDMemAnalisePorLojaCodPessoaERP: TIntegerField
      FieldName = 'CodPessoaERP'
    end
    object FDMemAnalisePorLojaRazao: TStringField
      FieldName = 'Razao'
      Size = 100
    end
    object FDMemAnalisePorLojaFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 100
    end
    object IntegerField16: TIntegerField
      FieldName = 'VolumeCxaFechada'
    end
    object IntegerField17: TIntegerField
      FieldName = 'VolumeFracionado'
    end
    object IntegerField18: TIntegerField
      FieldName = 'UnidadeCxaFechada'
    end
    object IntegerField19: TIntegerField
      FieldName = 'UnidadeFracionado'
    end
    object IntegerField20: TIntegerField
      FieldName = 'TotalVolumes'
    end
    object IntegerField21: TIntegerField
      FieldName = 'TotalUnidades'
    end
  end
  object FDMemVolumeConsulta: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 335
    Top = 253
  end
  object FDMemVolumeLotes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 249
    Top = 261
  end
  object FDMemVolumeConsultaLotes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 445
    Top = 253
  end
end
