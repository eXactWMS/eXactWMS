inherited FrmPerfil: TFrmPerfil
  Caption = 'FrmPerfil'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstCadastro: TAdvStringGrid
        ColCount = 5
        ColumnHeaders.Strings = (
          'Id'
          'Descri'#231#227'o'
          'Status'
          'Dt.Cadastro'
          'Hr.Cadastro')
        ColWidths = (
          74
          118
          74
          74
          74)
      end
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Id'
            'Descri'#231#227'o')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      inherited ShCadastro: TShape
        Left = 137
        Top = 124
        ExplicitLeft = 137
        ExplicitTop = 124
      end
      inherited ChkCadastro: TCheckBox
        Left = 84
        Top = 128
        ExplicitLeft = 84
        ExplicitTop = 128
      end
      object EdtPerfilId: TLabeledEdit
        Left = 84
        Top = 24
        Width = 111
        Height = 24
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 11
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Id'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        OnChange = EdtPerfilIdChange
        OnEnter = EdtPerfilIdEnter
        OnExit = EdtPerfilIdExit
        OnKeyPress = EdtPerfilIdKeyPress
      end
      object edtDescricao: TLabeledEdit
        Left = 84
        Top = 76
        Width = 457
        Height = 25
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 57
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Descri'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnEnter = EdtPerfilIdEnter
        OnExit = edtDescricaoExit
      end
      object btnPesquisar: TBitBtn
        Left = 195
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
        TabOrder = 4
        TabStop = False
      end
      object GbControleAcesso: TGroupBox
        Left = 0
        Top = 164
        Width = 1157
        Height = 360
        CustomHint = BalloonHint1
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' [ Controle de Acesso ] '
        TabOrder = 5
        DesignSize = (
          1157
          360)
        object Panel2: TPanel
          Left = 2
          Top = 19
          Width = 1153
          Height = 22
          CustomHint = BalloonHint1
          Align = alTop
          BevelOuter = bvNone
          Color = 16117735
          ParentBackground = False
          TabOrder = 0
          object Label7: TLabel
            Left = 156
            Top = 2
            Width = 47
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'T'#243'picos'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 644
            Top = 2
            Width = 100
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Funcionalidades'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object LstTopicoAcesso: TAdvStringGrid
          Left = 2
          Top = 41
          Width = 447
          Height = 317
          Cursor = crDefault
          CustomHint = BalloonHint1
          Align = alLeft
          ColCount = 3
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
          OnClickCell = LstTopicoAcessoClickCell
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
            'Id'
            'T'#243'pico'
            'Acesso')
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
            74)
          RowHeights = (
            24
            25)
        end
        object LstFuncionalidadeAcesso: TAdvStringGrid
          Left = 474
          Top = 41
          Width = 597
          Height = 317
          Cursor = crDefault
          CustomHint = BalloonHint1
          Anchors = [akLeft, akTop, akBottom]
          ColCount = 3
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
          OnClickCell = LstFuncionalidadeAcessoClickCell
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
            'Id'
            'Funcionalidade'
            'Acesso')
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
            74)
          RowHeights = (
            24
            25)
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
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnSalvar: TsImage
        Top = 5
        ExplicitTop = 5
      end
    end
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Top = 84
    ExplicitTop = 84
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  object FdMemFuncionalidadesAcesso: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 289
    Top = 197
  end
end
