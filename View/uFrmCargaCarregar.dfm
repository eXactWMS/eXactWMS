inherited FrmCargaCarregar: TFrmCargaCarregar
  Caption = 'FrmCargaCarregar'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstCadastro: TAdvStringGrid
        ColCount = 11
        ColumnHeaders.Strings = (
          'CargaId'
          'Data'
          'Rota'
          'Transportadora'
          'Placa'
          'Modelo'
          'Marca'
          'Cor'
          'Motorista'
          'Usu'#225'rio'
          'Processo')
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
          74)
      end
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Carga Id'
            'Data Carga'
            'Rota'
            'Transportadora'
            'Ve'#237'culo Id'
            'Ve'#237'culo Placa'
            'Motorista'
            'Processo')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited ShCadastro: TShape
        Left = 738
        Top = 18
        Visible = False
        ExplicitLeft = 738
        ExplicitTop = 18
      end
      object Label2: TLabel [1]
        Left = 38
        Top = 23
        Width = 50
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Carga Id'
      end
      object Label3: TLabel [2]
        Left = 12
        Top = 82
        Width = 76
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Loja / Cliente'
      end
      object Label4: TLabel [3]
        Left = 746
        Top = 83
        Width = 41
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Ordem'
      end
      object Label7: TLabel [4]
        Left = 474
        Top = 23
        Width = 43
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Volume'
      end
      object GProcCarregamento: TGauge [5]
        Left = 796
        Top = 22
        Width = 286
        Height = 23
        CustomHint = BalloonHint1
        ForeColor = 4227327
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 16117735
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        Progress = 0
        ShowHint = False
      end
      object Label16: TLabel [6]
        Left = 796
        Top = 3
        Width = 95
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Carga Completa'
      end
      object Label13: TLabel [7]
        Left = 190
        Top = 23
        Width = 56
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Processo:'
      end
      object LblProcesso: TLabel [8]
        Left = 252
        Top = 23
        Width = 12
        Height = 16
        CustomHint = BalloonHint1
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      inherited PnlInfo: TPanel
        TabOrder = 6
      end
      inherited ChkCadastro: TCheckBox
        Left = 685
        Top = 22
        TabOrder = 7
        Visible = False
        ExplicitLeft = 685
        ExplicitTop = 22
      end
      object EdtCargaId: TJvCalcEdit
        Left = 94
        Top = 16
        Width = 62
        Height = 29
        CustomHint = BalloonHint1
        DecimalPlaces = 0
        DisplayFormat = '#'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ShowButton = False
        TabOrder = 0
        DecimalPlacesAlwaysShown = False
        OnExit = EdtCargaIdExit
        OnKeyPress = EdtCargaIdKeyPress
      end
      object BitBtn1: TBitBtn
        Left = 155
        Top = 16
        Width = 29
        Height = 29
        CustomHint = BalloonHint1
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C006000000000000000000000000000000000000494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524C516347536F4948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          48524948524948524B5163277FFF277FFF47536F494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
          4852494852494852494852494852494852494852494852494852494852494852
          4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
          634948524948524948524948524948524948524948524948524948524948524C
          50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
          277FFF4B51634948524948524948524948524948524948524948524948524948
          524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
          7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
          4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
          73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
          48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
          4948524948524948524C506148536D277FFF4A52684948524948524948524948
          52494852494852494852494852494852494852435475277FFF4C506149485249
          485249485249485249485249485249485249485249485247536E465370494852
          494852494852494852494852494852494852494852494852435476277FFF4554
          724948524948524948524948524948524948524948524948524948524948524C
          5162277FFF435476494852494852494852494852494852494852494852435475
          277FFF4254764948524948524948524948524948524948524948524948524948
          52494852494852494852425476277FFF44547549485249485249485249485249
          4852494852435475277FFF277FFF435475494852494852494852494852494852
          494852494852494852494852494852445475277FFF277FFF4454754948524948
          52494852494852494852494852435475277FFF277FFF43547549485249485249
          4852494852494852494852494852494852494852494852494852425478277FFF
          445475494852494852494852494852494852494852435475277FFF4254764948
          5249485249485249485249485249485249485249485249485249485249485244
          5475277FFF277FFF445475494852494852494852494852494852494852494852
          435476277FFF4C50614948524948524948524948524948524948524948524948
          52494852494852494852425476277FFF44547549485249485249485249485249
          48524948524948524C5162277FFF455473494852494852494852494852494852
          494852494852494852494852494852455472277FFF4354764948524948524948
          52494852494852494852494852494852494852435475277FFF4C516249485249
          48524948524948524948524948524948524948524C5162277FFF435476494852
          4948524948524948524948524948524948524948524948524948524C5062277F
          FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
          7FFF4B5163494852494852494852494852494852494852494852494852494852
          4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
          6D277FFF277FFF4B516349485249485249485249485249485249485249485249
          48524948524948524948524948524948524948524B5266465370277FFF277FFF
          277FFF277FFF46537049526A4C51624948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          48524C50624C51634C51634C5062494852494852494852494852494852494852
          4948524948524948524948524948524948524948524948524948524948524948
          5249485249485249485249485249485249485249485249485249485249485249
          4852494852494852494852494852494852494852494852494852}
        TabOrder = 1
        TabStop = False
      end
      object JvCalcEdit2: TJvCalcEdit
        Left = 796
        Top = 76
        Width = 62
        Height = 29
        CustomHint = BalloonHint1
        TabStop = False
        DecimalPlaces = 0
        DisplayFormat = '#'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ShowButton = False
        TabOrder = 5
        DecimalPlacesAlwaysShown = False
      end
      object PnlGridBottom: TPanel
        Left = 0
        Top = 116
        Width = 1157
        Height = 408
        CustomHint = BalloonHint1
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Enabled = False
        TabOrder = 8
        object PnlCliente: TPanel
          Left = 578
          Top = 1
          Width = 578
          Height = 406
          CustomHint = BalloonHint1
          Align = alRight
          Color = 4803922
          ParentBackground = False
          TabOrder = 0
          DesignSize = (
            578
            406)
          object Label5: TLabel
            Left = 8
            Top = 8
            Width = 57
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Loja Atual'
          end
          object Label6: TLabel
            Left = 282
            Top = 8
            Width = 75
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Pr'#243'xima Loja'
          end
          object EdtPessoaCarregamento: TEdit
            Left = 71
            Top = 5
            Width = 198
            Height = 25
            CustomHint = BalloonHint1
            TabStop = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object EdtProxPessoaCarregamento: TEdit
            Left = 364
            Top = 5
            Width = 210
            Height = 25
            CustomHint = BalloonHint1
            TabStop = False
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object LstAdvClientes: TAdvStringGrid
            Left = 1
            Top = 31
            Width = 576
            Height = 374
            Cursor = crDefault
            CustomHint = BalloonHint1
            TabStop = False
            Align = alBottom
            Anchors = [akLeft, akTop, akRight, akBottom]
            ColCount = 4
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 2
            ActiveRowColor = 15135200
            HoverRowColor = 15658717
            HoverRowCells = [hcNormal, hcSelected]
            OnRowChanging = LstCadastroRowChanging
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
              'Raz'#227'o'
              'Pedidos'
              'Ordem'
              'Id')
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
              74)
            RowHeights = (
              24
              25)
          end
        end
        object LstAdvPedidos: TAdvStringGrid
          Left = 1
          Top = 1
          Width = 577
          Height = 406
          Cursor = crDefault
          CustomHint = BalloonHint1
          TabStop = False
          Align = alClient
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
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
          ActiveRowColor = 15135200
          HoverRowColor = 15658717
          HoverRowCells = [hcNormal, hcSelected]
          OnRowChanging = LstCadastroRowChanging
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
            'Pedido'
            'Vol.Cxa.Fechada'
            'Vol.Fracionado'
            'Qtd.Volumes'
            'Conferidos'
            'PessoaId')
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
            25)
        end
      end
      object EdtVolumeId: TJvCalcEdit
        Left = 527
        Top = 16
        Width = 122
        Height = 29
        CustomHint = BalloonHint1
        DecimalPlaces = 0
        DisplayFormat = '#'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ShowButton = False
        TabOrder = 2
        DecimalPlacesAlwaysShown = False
        OnExit = EdtCargaIdExit
        OnKeyPress = EdtVolumeIdKeyPress
      end
      object EdtPessoaId: TJvCalcEdit
        Left = 93
        Top = 75
        Width = 62
        Height = 29
        CustomHint = BalloonHint1
        TabStop = False
        DecimalPlaces = 0
        DisplayFormat = '#'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ShowButton = False
        TabOrder = 3
        DecimalPlacesAlwaysShown = False
      end
      object EdtRazao: TEdit
        Left = 155
        Top = 75
        Width = 494
        Height = 29
        CustomHint = BalloonHint1
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
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
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnIncluir: TsImage
        Left = 139
        Visible = False
        ExplicitLeft = 139
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
        Left = 321
        Visible = False
        ExplicitLeft = 321
      end
      inherited BtnCancelar: TsImage
        Left = 276
        Visible = False
        ExplicitLeft = 276
      end
      inherited BtnEditar: TsImage
        Left = 186
        Visible = False
        ExplicitLeft = 186
      end
      inherited BtnPesquisarStand: TsImage
        Left = 367
        Visible = False
        ExplicitLeft = 367
      end
      inherited BtnImprimirStand: TsImage
        Left = 412
        Visible = False
        ExplicitLeft = 412
      end
      inherited BtnExportarStand: TsImage
        Left = 458
        Visible = False
        ExplicitLeft = 458
      end
      inherited BtnExportarPDF: TsImage
        Left = 503
        Visible = False
        ExplicitLeft = 503
      end
      inherited BtnImportarStand: TsImage
        Left = 549
        Visible = False
        ExplicitLeft = 549
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1009
    Top = 349
    ExplicitLeft = 1009
    ExplicitTop = 349
  end
  inherited TmFrameWeb: TTimer
    Left = 584
    Top = 138
  end
  object FdMemClientes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 426
    Top = 332
  end
end
