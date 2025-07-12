inherited FrmExpedicao: TFrmExpedicao
  Caption = 'FrmExpedicao'
  ClientHeight = 761
  ClientWidth = 1197
  OnDestroy = FormDestroy
  ExplicitWidth = 1199
  ExplicitHeight = 763
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1198
    Height = 706
    Properties.ActivePage = TabPrincipal
    ExplicitWidth = 1198
    ExplicitHeight = 706
    ClientRectBottom = 706
    ClientRectRight = 1198
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1198
      ExplicitHeight = 682
      inherited LstCadastro: TAdvStringGrid
        Width = 1178
        Height = 644
        ColCount = 4
        ColumnHeaders.Strings = (
          'Pedido Id'
          'Volume Id'
          'Embalagem'
          'Processo')
        ExplicitWidth = 1178
        ExplicitHeight = 644
        ColWidths = (
          74
          118
          74
          74)
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 644
        ExplicitHeight = 644
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1198
        ExplicitWidth = 1198
        inherited BtnPesqConsGeral: TsImage
          Left = 639
          ExplicitLeft = 639
        end
        inherited LblClearFilter: TLabel
          Left = 674
          ExplicitLeft = 674
        end
        inherited LblRegTit: TLabel
          Left = 878
          ExplicitLeft = 878
        end
        inherited LblTotReg: TLabel
          Left = 1014
          ExplicitLeft = 1014
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 297
          ExplicitWidth = 297
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitWidth = 1198
      ExplicitHeight = 682
      inherited ShCadastro: TShape
        Left = 497
        Top = 410
        Visible = False
        ExplicitLeft = 497
        ExplicitTop = 410
      end
      object Label2: TLabel [1]
        Left = 25
        Top = 28
        Width = 59
        Height = 21
        CustomHint = BalloonHint1
        Caption = 'Volume'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      inherited PnlInfo: TPanel
        Left = 110
        Top = 630
        ExplicitLeft = 110
        ExplicitTop = 630
      end
      inherited ChkCadastro: TCheckBox
        Left = 444
        Top = 414
        Visible = False
        ExplicitLeft = 444
        ExplicitTop = 414
      end
      object EdtVolumeId: TJvCalcEdit
        Left = 90
        Top = 23
        Width = 121
        Height = 29
        CustomHint = BalloonHint1
        DecimalPlaces = 0
        DisplayFormat = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        ShowButton = False
        TabOrder = 2
        DecimalPlacesAlwaysShown = False
        OnEnter = EdtVolumeIdEnter
        OnExit = EdtVolumeIdExit
        OnKeyUp = EdtVolumeIdKeyUp
      end
      object Panel1: TPanel
        Left = 25
        Top = 73
        Width = 533
        Height = 398
        CustomHint = BalloonHint1
        Enabled = False
        ParentBackground = False
        ParentColor = True
        TabOrder = 3
        object Label3: TLabel
          Left = 23
          Top = 32
          Width = 47
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Pedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 391
          Top = 32
          Width = 32
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Data'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 23
          Top = 107
          Width = 84
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Destinat'#225'rio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 23
          Top = 184
          Width = 32
          Height = 21
          CustomHint = BalloonHint1
          Caption = 'Rota'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 163
          Top = 267
          Width = 202
          Height = 30
          CustomHint = BalloonHint1
          Caption = 'Ordem Carregamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object LblOrdem: TLabel
          Left = 187
          Top = 307
          Width = 147
          Height = 65
          CustomHint = BalloonHint1
          Alignment = taCenter
          AutoSize = False
          Caption = 'Ordem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -48
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 1
          Top = 1
          Width = 531
          Height = 21
          CustomHint = BalloonHint1
          Align = alTop
          Alignment = taCenter
          Caption = #218'ltimo Volume Expedido'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 1993170
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 171
        end
        object EdtPedidoId: TEdit
          Left = 23
          Top = 55
          Width = 121
          Height = 29
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object EdtDocumentoData: TEdit
          Left = 391
          Top = 55
          Width = 121
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object EdtDestino: TEdit
          Left = 23
          Top = 130
          Width = 490
          Height = 33
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object EdtRota: TEdit
          Left = 23
          Top = 207
          Width = 490
          Height = 29
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object PnlVolumeCorte: TPanel
          Left = 180
          Top = 54
          Width = 185
          Height = 29
          CustomHint = BalloonHint1
          Caption = 'Volume C/Cortes'
          Color = clRed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
          Visible = False
        end
      end
      object PnlLateral: TPanel
        Left = 563
        Top = 0
        Width = 635
        Height = 682
        CustomHint = BalloonHint1
        Align = alRight
        Alignment = taRightJustify
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelInner = bvRaised
        BevelOuter = bvNone
        TabOrder = 4
        object LstASGExpedicao: TAdvStringGrid
          Left = 1
          Top = 110
          Width = 633
          Height = 571
          Cursor = crDefault
          CustomHint = BalloonHint1
          TabStop = False
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          ColCount = 6
          DefaultColWidth = 74
          DefaultRowHeight = 25
          DrawingStyle = gdsClassic
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
          ActiveRowColor = 15135200
          HoverRowColor = 15658717
          HoverRowCells = [hcNormal, hcSelected]
          OnRowChanging = LstCadastroRowChanging
          OnClickCell = LstASGExpedicaoClickCell
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
          BackGround.ColorTo = 15663069
          CellNode.ShowTree = False
          ColumnHeaders.Strings = (
            'Pedido Id'
            'Volume Id'
            'Data'
            'Embalagem'
            'Processo'
            'Destinat'#225'rio')
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
          ProgressAppearance.Level1ColorTo = clMaroon
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
            118
            74
            74
            74
            74)
          RowHeights = (
            24
            24)
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 5
          Width = 541
          Height = 55
          CustomHint = BalloonHint1
          Caption = '[ Destinat'#225'rio ]'
          TabOrder = 1
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
            OnChange = EdtDestinatarioChange
            OnExit = EdtDestinatarioExit
            OnKeyPress = EdtDestinatarioKeyPress
          end
          object BtnPesqCliente: TBitBtn
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
        object GroupBox5: TGroupBox
          Left = 8
          Top = 49
          Width = 541
          Height = 55
          CustomHint = BalloonHint1
          Caption = '[ Rota ]'
          TabOrder = 2
          object Label13: TLabel
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
            OnChange = EdtDestinatarioChange
            OnExit = EdtRotaIdExit
            OnKeyPress = EdtDestinatarioKeyPress
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
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1198
      ExplicitHeight = 682
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1198
      ExplicitHeight = 682
      inherited DbgImporta: TDBGrid
        Width = 1198
        Height = 478
      end
    end
  end
  inherited PnHeader: TPanel
    Width = 1197
    ExplicitWidth = 1197
    inherited ImgClose: TImage
      Left = 1164
      ExplicitLeft = 1164
    end
    inherited ImgMinimize: TImage
      Left = 1144
      ExplicitLeft = 1144
    end
    inherited PanWin8: TPanel
      Width = 1197
      ExplicitWidth = 1197
      inherited BtnIncluir: TsImage
        Left = 141
        Visible = False
        ExplicitLeft = 141
      end
      inherited BtnExcluir: TsImage
        Left = 232
        Visible = False
        ExplicitLeft = 232
      end
      inherited BtnFechar: TsImage
        Left = 73
        ExplicitLeft = 73
      end
      inherited BtnSalvar: TsImage
        Left = 323
        Visible = False
        ExplicitLeft = 323
      end
      inherited BtnCancelar: TsImage
        Left = 278
        Visible = False
        ExplicitLeft = 278
      end
      inherited BtnEditar: TsImage
        Left = 188
        Visible = False
        ExplicitLeft = 188
      end
      inherited BtnPesquisarStand: TsImage
        Left = 369
        Visible = False
        ExplicitLeft = 369
      end
      inherited BtnImprimirStand: TsImage
        Left = 414
        Visible = False
        ExplicitLeft = 414
      end
      inherited BtnExportarStand: TsImage
        Left = 460
        Visible = False
        ExplicitLeft = 460
      end
      inherited BtnExportarPDF: TsImage
        Left = 505
        Visible = False
        ExplicitLeft = 505
      end
      inherited BtnImportarStand: TsImage
        Left = 551
        Visible = False
        ExplicitLeft = 551
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1001
    Top = 231
    ExplicitLeft = 1001
    ExplicitTop = 231
  end
  inherited PnlErro: TPanel
    Top = 739
    Width = 1197
    ExplicitTop = 739
    ExplicitWidth = 1197
    inherited LblMensShowErro: TLabel
      Width = 1197
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 613
    Top = 294
    ExplicitLeft = 613
    ExplicitTop = 294
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited TmFrameWeb: TTimer
    Left = 298
    Top = 98
  end
end
