inherited FrmUsuario: TFrmUsuario
  Caption = 'FrmUsuario'
  ClientHeight = 817
  ClientWidth = 1252
  OnDestroy = FormDestroy
  ExplicitWidth = 1254
  ExplicitHeight = 819
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1253
    Height = 762
    Properties.ActivePage = TabListagem
    ClientRectBottom = 762
    ClientRectRight = 1253
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1253
      ExplicitHeight = 738
      inherited LstCadastro: TAdvStringGrid
        Width = 1233
        Height = 700
        ColCount = 10
        ColumnHeaders.Strings = (
          'Id'
          'Login'
          'Nome'
          'Perfil'
          'Expira(dias)'
          'Email'
          'Dt.Altera'#231#227'o'
          'Hr.Altera'#231#227'o'
          'Status'
          'Conectado')
        ExplicitWidth = 1233
        ExplicitHeight = 700
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
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 700
        ExplicitHeight = 700
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1253
        ExplicitWidth = 1253
        inherited BtnPesqConsGeral: TsImage
          Left = 694
        end
        inherited LblClearFilter: TLabel
          Left = 729
          Top = 12
          ExplicitTop = 12
        end
        inherited LblRegTit: TLabel
          Left = 989
          Top = 12
          ExplicitLeft = 893
          ExplicitTop = 12
        end
        inherited LblTotReg: TLabel
          Left = 1123
          ExplicitLeft = 1027
        end
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Id'
            'Login'
            'Nome')
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 352
          ExplicitWidth = 352
        end
        object ChkSomenteAtivo: TCheckBox
          Left = 824
          Top = 10
          Width = 109
          Height = 17
          CustomHint = BalloonHint1
          Anchors = [akTop, akRight]
          Caption = 'Somente Ativo'
          Checked = True
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          State = cbChecked
          TabOrder = 2
          OnClick = ChkSomenteAtivoClick
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      object Label2: TLabel [0]
        Left = 39
        Top = 121
        Width = 35
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Senha'
      end
      object Label22: TLabel [1]
        Left = 526
        Top = 121
        Width = 101
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Senha Expira em '
      end
      object Label3: TLabel [2]
        Left = 672
        Top = 121
        Width = 29
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Dias '
      end
      inherited ShCadastro: TShape
        Left = 132
        Top = 241
        ExplicitLeft = 132
        ExplicitTop = 241
      end
      object LblPerfil: TLabel [4]
        Left = 160
        Top = 215
        Width = 12
        Height = 16
        CustomHint = BalloonHint1
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel [5]
        Left = 45
        Top = 214
        Width = 29
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Perfil'
      end
      object ShpConectado: TShape [6]
        Left = 509
        Top = 241
        Width = 24
        Height = 24
        CustomHint = BalloonHint1
        Brush.Color = clRed
        Pen.Color = clRed
        Shape = stCircle
      end
      object LblDetalheConectado: TLabel [7]
        Left = 543
        Top = 244
        Width = 9
        Height = 17
        CustomHint = BalloonHint1
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      inherited PnlInfo: TPanel
        Top = 552
      end
      inherited ChkCadastro: TCheckBox
        Left = 79
        Top = 245
        TabOrder = 8
        ExplicitLeft = 79
        ExplicitTop = 245
      end
      object edtCodigo: TLabeledEdit
        Left = 79
        Top = 24
        Width = 117
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
        MaxLength = 10
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        OnChange = edtCodigoChange
        OnEnter = edtCodigoEnter
        OnExit = edtCodigoExit
        OnKeyPress = edtCodigoKeyPress
      end
      object EdtLogin: TLabeledEdit
        Left = 316
        Top = 24
        Width = 306
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        Ctl3D = True
        EditLabel.Width = 32
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Login'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 2
        OnEnter = edtCodigoEnter
        OnExit = EdtLoginExit
        ExplicitWidth = 210
      end
      object EdtNome: TLabeledEdit
        Left = 79
        Top = 71
        Width = 419
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Ctl3D = True
        EditLabel.Width = 36
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnEnter = edtCodigoEnter
        OnExit = EdtNomeExit
        ExplicitWidth = 323
      end
      object EdtSenha: TEdit
        Left = 80
        Top = 118
        Width = 117
        Height = 24
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        ParentShowHint = False
        PasswordChar = '#'
        ShowHint = True
        TabOrder = 4
        TextHint = 'M'#225'x 6 Char'
        OnChange = EdtSenhaChange
        OnEnter = edtCodigoEnter
        OnExit = EdtNomeExit
        OnKeyDown = EdtSenhaKeyDown
      end
      object ChkSenhaPadrao: TCheckBox
        Left = 316
        Top = 122
        Width = 110
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Senha Padr'#227'o'
        TabOrder = 5
      end
      object EdtDiasSenhaValida: TJvCalcEdit
        Left = 633
        Top = 118
        Width = 37
        Height = 24
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ShowButton = False
        TabOrder = 6
        Value = 30.000000000000000000
        DecimalPlacesAlwaysShown = False
        OnEnter = edtCodigoEnter
        OnExit = edtCodigoExit
      end
      object EdtEmail: TLabeledEdit
        Left = 79
        Top = 165
        Width = 419
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        Ctl3D = True
        EditLabel.Width = 31
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 7
        OnEnter = edtCodigoEnter
        OnExit = EdtNomeExit
        ExplicitWidth = 323
      end
      object Panel1: TPanel
        Left = 412
        Top = 154
        Width = 302
        Height = 45
        CustomHint = BalloonHint1
        BevelOuter = bvNone
        Enabled = False
        ParentBackground = False
        TabOrder = 9
        DesignSize = (
          302
          45)
        object Label5: TLabel
          Left = 276
          Top = 12
          Width = 7
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'h'
        end
        object Label4: TLabel
          Left = 12
          Top = 14
          Width = 96
          Height = 17
          CustomHint = BalloonHint1
          Caption = #218'ltima Altera'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object EdtDtUltimaAlteracaoSenha: TJvDateEdit
          Left = 114
          Top = 10
          Width = 96
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 0
          OnEnter = edtCodigoEnter
          OnExit = edtCodigoExit
        end
        object EdtHrUltimaAlteracaoSenha: TLabeledEdit
          Left = 236
          Top = 10
          Width = 38
          Height = 24
          CustomHint = BalloonHint1
          Anchors = [akLeft, akTop, akRight]
          Ctl3D = True
          EditLabel.Width = 17
          EditLabel.Height = 17
          EditLabel.CustomHint = BalloonHint1
          EditLabel.Caption = #224's '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          LabelPosition = lpLeft
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          OnEnter = edtCodigoEnter
          OnExit = edtCodigoExit
        end
      end
      object BtnPesqPerfil: TBitBtn
        Left = 130
        Top = 209
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
        TabOrder = 10
        TabStop = False
        OnClick = BtnPesqPerfilClick
      end
      object EdtPerfilId: TEdit
        Left = 79
        Top = 209
        Width = 52
        Height = 24
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 11
        OnChange = EdtPerfilIdChange
        OnEnter = edtCodigoEnter
        OnExit = EdtPerfilIdExit
        OnKeyDown = EdtPerfilIdKeyDown
        OnKeyPress = EdtPerfilIdKeyPress
      end
      object GbControleAcesso: TGroupBox
        Left = 0
        Top = 271
        Width = 1253
        Height = 467
        CustomHint = BalloonHint1
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = ' [ Controle de Acesso ] '
        TabOrder = 12
        ExplicitWidth = 1157
        ExplicitHeight = 253
        object Bevel1: TBevel
          Left = 413
          Top = 41
          Width = 80
          Height = 424
          CustomHint = BalloonHint1
          Align = alLeft
          ExplicitHeight = 210
        end
        object Panel2: TPanel
          Left = 2
          Top = 19
          Width = 1249
          Height = 22
          CustomHint = BalloonHint1
          Align = alTop
          BevelOuter = bvNone
          Color = 16117735
          ParentBackground = False
          TabOrder = 0
          ExplicitWidth = 1153
          object Label7: TLabel
            Left = 96
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
            Left = 526
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
          Width = 411
          Height = 424
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
          OnClick = LstTopicoAcessoClick
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
          ExplicitHeight = 210
          ColWidths = (
            74
            118
            74)
          RowHeights = (
            24
            25)
        end
        object LstFuncionalidadeAcesso: TAdvStringGrid
          Left = 493
          Top = 41
          Width = 494
          Height = 424
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
          TabOrder = 2
          OnClick = LstFuncionalidadeAcessoClick
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
          ExplicitHeight = 210
          ColWidths = (
            74
            118
            74)
          RowHeights = (
            24
            25)
        end
      end
      object DBGrid1: TDBGrid
        Left = 600
        Top = 71
        Width = 639
        Height = 205
        CustomHint = BalloonHint1
        DataSource = DsPesqGeral
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Visible = False
      end
      object CheckBox1: TCheckBox
        Left = 424
        Top = 215
        Width = 265
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Caption = 'Participar do eXact Message'
        TabOrder = 14
        OnClick = ChkCadastroClick
      end
      object ChkConectado: TCheckBox
        Left = 424
        Top = 245
        Width = 81
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Caption = 'Conectado'
        TabOrder = 15
        OnClick = ChkConectadoClick
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1253
      ExplicitHeight = 738
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1253
      ExplicitHeight = 738
      inherited DbgImporta: TDBGrid
        Width = 1253
        Height = 534
        OnDrawColumnCell = DbgImportaDrawColumnCell
      end
    end
    object TabUsuarioConectado: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Usu'#225'rio(s) Conectado(s)'
      ImageIndex = 4
      OnExit = TabUsuarioConectadoExit
      OnShow = TabUsuarioConectadoShow
      object LstUsuarioConectado: TAdvStringGrid
        Left = 0
        Top = 0
        Width = 1253
        Height = 738
        Cursor = crDefault
        CustomHint = BalloonHint1
        Align = alClient
        ColCount = 7
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
        TabOrder = 0
        OnClick = LstCadastroClick
        ActiveRowColor = 15135200
        HoverRowColor = 15658717
        HoverRowCells = [hcNormal, hcSelected]
        OnRowChanging = LstCadastroRowChanging
        OnClickCell = LstCadastroClickCell
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
        Bands.PrimaryColor = 16117735
        BackGround.ColorTo = 15663069
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          'Id'
          'Usu'#225'rio(Id)'
          'Usu'#225'rio'
          'Data'
          'Hora'
          'Terminal'
          'Vers'#227'o')
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
        ExplicitHeight = 524
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
          25)
      end
    end
  end
  inherited PnHeader: TPanel
    Width = 1252
    inherited ImgClose: TImage
      Left = 1219
    end
    inherited ImgMinimize: TImage
      Left = 1199
    end
    inherited PanWin8: TPanel
      Width = 1252
      inherited BtnPesquisarStand: TsImage
        Top = 6
        ExplicitTop = 6
      end
      inherited BtnExportarStand: TsImage
        Top = 6
        ExplicitTop = 6
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1046
    Top = 121
    ExplicitLeft = 950
    ExplicitTop = 121
  end
  inherited PnlErro: TPanel
    Top = 795
    Width = 1252
    inherited LblMensShowErro: TLabel
      Width = 1252
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 891
    Top = 248
    ExplicitLeft = 891
    ExplicitTop = 248
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited DsPesqGeral: TDataSource
    Left = 711
    Top = 382
  end
  inherited FdMemPesqGeral: TFDMemTable
    Left = 709
    Top = 325
  end
  inherited el1: TAdvEditEditLink
    Left = 826
    Top = 180
  end
  inherited el2: TColorComboEditLink
    Left = 826
    Top = 212
  end
  inherited el3: TMemoEditLink
    Left = 826
    Top = 244
  end
  inherited el5: TCheckEditLink
    Left = 826
    Top = 276
  end
  inherited el4: TMoneyEditLink
    Left = 826
    Top = 308
  end
  inherited el6: TImagePickerEditLink
    Left = 826
    Top = 340
  end
  object BalloonHint2: TBalloonHint
    Left = 180
    Top = 352
  end
  object FdMemUsuarioConectado: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 333
    Top = 265
  end
  object DsUsuarioConectado: TDataSource
    AutoEdit = False
    DataSet = FdMemUsuarioConectado
    Left = 336
    Top = 320
  end
end
