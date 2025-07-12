inherited FrmAuditoriaSaidaPorProduto: TFrmAuditoriaSaidaPorProduto
  Caption = 'Sa'#237'da por Produto'
  ClientHeight = 960
  ClientWidth = 1390
  ExplicitWidth = 1392
  ExplicitHeight = 962
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1391
    Height = 905
    ClientRectBottom = 905
    ClientRectRight = 1391
    inherited TabListagem: TcxTabSheet
      ExplicitWidth = 1391
      ExplicitHeight = 881
      inherited LstCadastro: TAdvStringGrid
        Width = 1371
        Height = 843
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 843
        ExplicitHeight = 843
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1391
        ExplicitWidth = 1391
        inherited BtnPesqConsGeral: TsImage
          Left = 832
        end
        inherited LblClearFilter: TLabel
          Left = 867
        end
        inherited LblRegTit: TLabel
          Left = 1071
        end
        inherited LblTotReg: TLabel
          Left = 1207
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 490
          ExplicitWidth = 490
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1391
      ExplicitHeight = 881
      inherited LblTotRegCaption: TLabel
        Left = 9
        Top = 119
        ExplicitLeft = 9
        ExplicitTop = 119
      end
      inherited LblTotRegistro: TLabel
        Left = 132
        Top = 119
        ExplicitLeft = 132
        ExplicitTop = 119
      end
      object Label4: TLabel [3]
        Left = 593
        Top = 119
        Width = 81
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Qtde Suprida:'
      end
      object LblQtdSuprida: TLabel [4]
        Left = 716
        Top = 119
        Width = 54
        Height = 17
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited PnlInfo: TPanel
        Top = 695
        ExplicitTop = 695
      end
      inherited LstReport: TAdvStringGrid
        Top = 138
        Width = 1391
        Height = 743
        ColCount = 10
        ColumnHeaders.Strings = (
          'Data'
          'C'#243'd.Dest.'
          'Destinat'#225'rio'
          'Pedido'
          'Ressuprimento'
          'Processo'
          'C'#243'd.Prod'
          'Descri'#231#227'o'
          'Endere'#231'o'
          'Qtd.Suprida')
        ExplicitTop = 138
        ExplicitWidth = 1391
        ExplicitHeight = 743
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
        object LstLotesAuditoria: TAdvStringGrid
          Left = 873
          Top = 0
          Width = 514
          Height = 739
          Cursor = crDefault
          CustomHint = BalloonHint1
          Align = alRight
          ColCount = 7
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
          TabOrder = 4
          HoverRowCells = [hcNormal, hcSelected]
          OnDblClickCell = LstCadastroDblClickCell
          OnGetEditorType = LstCadastroGetEditorType
          OnGetEditorProp = LstCadastroGetEditorProp
          HintColor = 5080903
          ActiveCellShow = True
          ActiveCellFont.Charset = DEFAULT_CHARSET
          ActiveCellFont.Color = clWindowText
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'MS Sans Serif'
          ActiveCellFont.Style = []
          ActiveCellColor = 5080903
          Bands.Active = True
          Bands.PrimaryColor = 15523534
          CellNode.ShowTree = False
          ColumnHeaders.Strings = (
            'Volume'
            'Embalagem'
            'Lote'
            'Vencimento'
            'Qtd.Suprida'
            'Endere'#231'o'
            'Processo')
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
          ExplicitLeft = 856
          ExplicitHeight = 722
          ColWidths = (
            74
            118
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
      object GroupBox1: TGroupBox
        Left = 9
        Top = 3
        Width = 167
        Height = 110
        CustomHint = BalloonHint1
        Caption = '[ Per'#237'odo ]'
        TabOrder = 3
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
        Width = 483
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Pedido ]'
        TabOrder = 4
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
          Width = 87
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Ressuprimento'
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
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtInicioChange
          OnExit = EdtPedidoIdExit
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object EdtRessuprimento: TEdit
          Left = 237
          Top = 19
          Width = 104
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnChange = EdtInicioChange
          OnExit = EdtPedidoIdExit
          OnKeyPress = EdtPedidoIdKeyPress
        end
      end
      object GroupBox7: TGroupBox
        Left = 174
        Top = 58
        Width = 574
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Produto ]'
        TabOrder = 5
        object Label12: TLabel
          Left = 9
          Top = 23
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblProduto: TLabel
          Left = 184
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
          Left = 56
          Top = 20
          Width = 97
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
          OnExit = EdtCodProdutoExit
          OnKeyPress = EdtPedidoIdKeyPress
        end
        object BtnPesqProduto: TBitBtn
          Left = 154
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
      object GbLote: TGroupBox
        Left = 748
        Top = 58
        Width = 255
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Lote ]'
        TabOrder = 6
        TabStop = True
        object LblLote: TLabel
          Left = 6
          Top = 21
          Width = 57
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Descri'#231#227'o'
        end
        object EdtDescrLote: TEdit
          Left = 69
          Top = 19
          Width = 176
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
      ExplicitWidth = 1391
      ExplicitHeight = 881
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitWidth = 1391
      ExplicitHeight = 881
      inherited DbgImporta: TDBGrid
        Width = 1391
        Height = 677
      end
    end
    object TabBalanceamento: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Balanceamento'
      ImageIndex = 4
      OnShow = TabBalanceamentoShow
      ExplicitWidth = 1157
      ExplicitHeight = 524
      object Label7: TLabel
        Left = 11
        Top = 97
        Width = 117
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Total de Registro(s):'
      end
      object LblTotRegistroBalanceamento: TLabel
        Left = 134
        Top = 97
        Width = 54
        Height = 17
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox2: TGroupBox
        Left = 11
        Top = 5
        Width = 466
        Height = 78
        CustomHint = BalloonHint1
        Caption = '[ Per'#237'odo ]'
        TabOrder = 0
        TabStop = True
        object Label5: TLabel
          Left = 18
          Top = 41
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label6: TLabel
          Left = 273
          Top = 41
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtDtInicioBalanceamento: TJvDateEdit
          Left = 54
          Top = 39
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
        object EdtDtTerminoBalanceamento: TJvDateEdit
          Left = 326
          Top = 39
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
      object LstBalanceamento: TAdvStringGrid
        Left = 0
        Top = 120
        Width = 1391
        Height = 761
        Cursor = crDefault
        CustomHint = BalloonHint1
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 6
        DefaultColWidth = 74
        DefaultRowHeight = 25
        DrawingStyle = gdsClassic
        RowCount = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        HoverRowCells = [hcNormal, hcSelected]
        OnClickCell = LstBalanceamentoClickCell
        OnGetEditorType = LstCadastroGetEditorType
        OnGetEditorProp = LstCadastroGetEditorProp
        HintColor = 5080903
        ActiveCellShow = True
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = []
        ActiveCellColor = 5080903
        Bands.Active = True
        Bands.PrimaryColor = 15523534
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          'C'#243'd.Produto'
          'Descri'#231#227'o'
          'Picking'
          'Zona/Setor'
          'Curva'
          'Qtd.Suprida')
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
        ExplicitWidth = 1157
        ExplicitHeight = 404
        ColWidths = (
          74
          118
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
      object GroupBox15: TGroupBox
        Left = 475
        Top = 5
        Width = 618
        Height = 78
        CustomHint = BalloonHint1
        Caption = ' [ Setor / Zona ] '
        TabOrder = 2
        object Label24: TLabel
          Left = 14
          Top = 41
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblZona: TLabel
          Left = 117
          Top = 41
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
        object EdtZonaId: TEdit
          Left = 31
          Top = 39
          Width = 56
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnExit = EdtZonaIdExit
        end
        object BtnPesqZonaVolume: TBitBtn
          Left = 87
          Top = 39
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
    end
  end
  inherited PnHeader: TPanel
    Width = 1390
    inherited ImgClose: TImage
      Left = 1357
    end
    inherited ImgMinimize: TImage
      Left = 1337
    end
    inherited PanWin8: TPanel
      Width = 1390
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1146
    Top = -19
    ExplicitLeft = 912
    ExplicitTop = -19
  end
  inherited PnlErro: TPanel
    Top = 938
    Width = 1390
    inherited LblMensShowErro: TLabel
      Width = 1390
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 823
    Top = 292
    ExplicitLeft = 823
    ExplicitTop = 292
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited TmFrameWeb: TTimer
    Left = 16
    Top = 276
  end
  inherited FdMemPesqGeral: TFDMemTable
    OnCalcFields = FdMemPesqGeralCalcFields
    object FdMemPesqGeralData: TDateField
      FieldName = 'Data'
    end
    object FdMemPesqGeralCodPessoaERP: TIntegerField
      FieldName = 'CodPessoaERP'
    end
    object FdMemPesqGeralFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 100
    end
    object FdMemPesqGeralPedidoId: TIntegerField
      FieldName = 'PedidoId'
    end
    object FdMemPesqGeralRessuprimento: TStringField
      FieldName = 'Ressuprimento'
    end
    object FdMemPesqGeralProcesso: TStringField
      FieldName = 'Processo'
      Size = 30
    end
    object FdMemPesqGeralCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FdMemPesqGeralDescrLote: TStringField
      FieldName = 'DescrLote'
      Size = 30
    end
    object FdMemPesqGeralVencimento: TDateField
      FieldName = 'Vencimento'
    end
    object FdMemPesqGeralEndereco: TStringField
      FieldName = 'Endereco'
      Size = 11
    end
    object FdMemPesqGeralEnderecoFormatado: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'EnderecoFormatado'
      Size = 14
    end
    object FdMemPesqGeralPedidoVolumeId: TIntegerField
      FieldName = 'PedidoVolumeId'
    end
    object FdMemPesqGeralQtdSuprida: TIntegerField
      FieldName = 'QtdSuprida'
    end
    object FdMemPesqGeralMascara: TStringField
      FieldName = 'Mascara'
      Size = 14
    end
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 44854.971482766200000000
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
        Value = ''
      end
      item
        Name = 'vVersao'
        Value = ''
      end
      item
        Name = 'vUsuario'
        Value = ''
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        Height = 64.252010000000000000
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            'Auditoria - Sa'#237'da por Produto')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 45.354360000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Produto:')
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 75.590600000000000000
          Top = 45.354360000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataField = 'CodProduto'
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
            '[frxDBDataset1."CodProduto"]')
          ParentFont = False
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 132.283550000000000000
          Top = 45.354360000000000000
          Width = 548.031850000000000000
          Height = 18.897650000000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
          ParentFont = False
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 60.472480000000000000
          Width = 710.551640000000000000
          Color = clBlack
          Frame.Typ = [ftTop]
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        Top = 105.826840000000000000
        inherited Line2: TfrxLineView
          Left = -0.000002440000000000
        end
        inherited Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Width = 64.252010000000000000
          HAlign = haCenter
          Memo.UTF8W = (
            'Data')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 71.811070000000000000
          Width = 132.283550000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Destinat'#225'rio')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 279.685220000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Pedido')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Ressupr.')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 385.512060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Lote')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 468.661720000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Vencto')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 540.472790000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 627.401980000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Volume')
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 680.315400000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtde')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 313.700990000000000000
      end
      inherited MasterData1: TfrxMasterData
        Top = 188.976500000000000000
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 661.417750000000000000
          Top = 7.559060000000000000
          Width = 56.692950000000000000
          Visible = False
        end
        object frxDBDataset1Data: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = -0.000000000000000210
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataField = 'Data'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Data"]')
        end
        object frxDBDataset1Fantasia: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 71.811070000000000000
          Width = 204.094620000000000000
          Height = 18.897650000000000000
          DataField = 'Fantasia'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Fantasia"]')
        end
        object frxDBDataset1PedidoId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 279.685220000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          DataField = 'PedidoId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."PedidoId"]')
        end
        object frxDBDataset1Ressuprimento: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataField = 'Ressuprimento'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Ressuprimento"]')
        end
        object frxDBDataset1DescrLote: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 385.512060000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'DescrLote'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."DescrLote"]')
        end
        object frxDBDataset1Vencimento: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 468.661720000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataField = 'Vencimento'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Vencimento"]')
        end
        object frxDBDataset1EnderecoFormatado: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 540.472790000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          DataField = 'EnderecoFormatado'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."EnderecoFormatado"]')
        end
        object frxDBDataset1PedidoVolumeId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 627.401980000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          DataField = 'PedidoVolumeId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."PedidoVolumeId"]')
        end
        object frxDBDataset1QtdSuprida: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 680.315400000000000000
          Width = 34.015745590000000000
          Height = 18.897650000000000000
          DataField = 'QtdSuprida'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdSuprida"]')
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 234.330860000000000000
        Width = 718.110700000000000000
        object SysMemo6: TfrxSysMemoView
          AllowVectorExport = True
          Left = 283.464750000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData1)]')
          ParentFont = False
        end
        object SysMemo5: TfrxSysMemoView
          AllowVectorExport = True
          Left = 627.401980000000000000
          Width = 49.133890000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[COUNT(MasterData1)]')
          ParentFont = False
        end
        object SysMemo4: TfrxSysMemoView
          AllowVectorExport = True
          Left = 680.315400000000000000
          Width = 34.015770000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."QtdSuprida">,MasterData1,2)]')
          ParentFont = False
        end
      end
    end
  end
  object FDMemBalanceamento: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 256
    Top = 278
  end
end
