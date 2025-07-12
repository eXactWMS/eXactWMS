inherited FrmRelListaInventario: TFrmRelListaInventario
  Caption = 'FrmRelListaInventario'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited ShCadastro: TShape
        Left = 490
        Top = 107
        ExplicitLeft = 490
        ExplicitTop = 107
      end
      inherited LblTotRegCaption: TLabel
        Top = 123
        ExplicitTop = 123
      end
      inherited LblTotRegistro: TLabel
        Top = 123
        ExplicitTop = 123
      end
      object Label3: TLabel [3]
        Left = 479
        Top = 32
        Width = 75
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Data Cria'#231#227'o'
      end
      object Label2: TLabel [4]
        Left = 682
        Top = 32
        Width = 94
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Data Finaliza'#231#227'o'
      end
      object Label5: TLabel [5]
        Left = 724
        Top = 127
        Width = 287
        Height = 13
        CustomHint = BalloonHint1
        Anchors = [akTop, akRight]
        Caption = 'Duplo click no Id do Grid abaixo para detalhes do invent'#225'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsItalic]
        ParentFont = False
      end
      inherited PnlInfo: TPanel
        TabOrder = 7
      end
      inherited ChkCadastro: TCheckBox
        Left = 428
        Top = 111
        TabOrder = 8
        ExplicitLeft = 428
        ExplicitTop = 111
      end
      inherited LstReport: TAdvStringGrid
        Left = 782
        Top = 358
        Width = 375
        Height = 166
        TabStop = False
        Align = alNone
        ColCount = 14
        TabOrder = 6
        ColumnHeaders.Strings = (
          'Id'
          'Tipo'
          'Motivo'
          'Processo Atual'
          'Dt.Libera'#231#227'o'
          'Ajuste'
          'Gerado'
          'Respons'#225'vel'
          'Ini.Contagem'
          'Ter.Contagem'
          'Cancelado'
          'Respons'#225'vel'
          'Apura'#231#227'o'
          'Respons'#225'vell')
        ExplicitLeft = 782
        ExplicitTop = 358
        ExplicitWidth = 375
        ExplicitHeight = 166
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
          74)
      end
      object EdtDataCriacao: TJvDateEdit
        Left = 560
        Top = 29
        Width = 95
        Height = 25
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowNullDate = False
        TabOrder = 1
        OnChange = EdtDataCriacaoChange
      end
      object RbInventarioTipo: TRadioGroup
        Left = 15
        Top = 9
        Width = 442
        Height = 51
        CustomHint = BalloonHint1
        Caption = '[ Tipo de Contagem ]'
        Columns = 3
        Enabled = False
        ItemIndex = 2
        Items.Strings = (
          'Por Endere'#231'o'
          'Por Produto'
          'Todos')
        TabOrder = 0
        TabStop = True
        OnClick = RbInventarioTipoClick
      end
      object ChkSomentePendente: TCheckBox
        Left = 903
        Top = 33
        Width = 137
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Somente Pendentes'
        Enabled = False
        TabOrder = 3
        OnClick = ChkSomentePendenteClick
      end
      object GroupBox2: TGroupBox
        Left = 15
        Top = 62
        Width = 442
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Processo ]'
        TabOrder = 4
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
          OnChange = EdtProcessoIdChange
          OnExit = EdtProcessoIdExit
          OnKeyPress = EdtProcessoIdKeyPress
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
      object EdtDataCriacaoFinal: TJvDateEdit
        Left = 782
        Top = 29
        Width = 95
        Height = 25
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowNullDate = False
        TabOrder = 2
        OnChange = EdtDataCriacaoChange
      end
      object GroupBox7: TGroupBox
        Left = 457
        Top = 62
        Width = 578
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
          Left = 163
          Top = 23
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
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtCodProdutoChange
          OnExit = EdtCodProdutoExit
          OnKeyPress = EdtProcessoIdKeyPress
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
      object PgcListaInventario: TcxPageControl
        Left = 0
        Top = 146
        Width = 1157
        Height = 378
        CustomHint = BalloonHint1
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 9
        Properties.ActivePage = TabAjuste
        Properties.CustomButtons.Buttons = <>
        Properties.Style = 9
        OnChange = PgcListaInventarioChange
        ClientRectBottom = 378
        ClientRectRight = 1157
        ClientRectTop = 24
        object TabListaInventario: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Lista de Invent'#225'rios'
          ImageIndex = 0
          OnShow = TabListaInventarioShow
          object LstListaInventario: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 1157
            Height = 354
            Cursor = crDefault
            CustomHint = BalloonHint1
            TabStop = False
            Align = alClient
            ColCount = 14
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
            OnClickCell = LstListaInventarioClickCell
            OnDblClickCell = LstListaInventarioDblClickCell
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
              'Id'
              'Tipo'
              'Motivo'
              'Processo Atual'
              'Dt.Libera'#231#227'o'
              'Ajuste'
              'Gerado'
              'Respons'#225'vel'
              'Ini.Contagem'
              'Ter.Contagem'
              'Cancelado'
              'Respons'#225'vel'
              'Apura'#231#227'o'
              'Respons'#225'vell')
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
        object TabAcompanhamentoContagem: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Acompanhamento de Contagem'
          ImageIndex = 1
          OnShow = TabAcompanhamentoContagemShow
          object PnlEnderecoContagem: TPanel
            Left = 0
            Top = 0
            Width = 503
            Height = 354
            CustomHint = BalloonHint1
            Align = alLeft
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object PnlEnderecoContagemTit: TPanel
              Left = 0
              Top = 0
              Width = 503
              Height = 25
              CustomHint = BalloonHint1
              Align = alTop
              BevelOuter = bvNone
              ParentBackground = False
              TabOrder = 0
              object PnlPnlTitEndContDivergente: TPanel
                Left = 100
                Top = 0
                Width = 100
                Height = 25
                CustomHint = BalloonHint1
                Align = alLeft
                Caption = 'Diverg'#234'ncia'
                Color = 3095017
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentBackground = False
                ParentFont = False
                TabOrder = 0
              end
              object PnlPnlTitEndContEmContagem: TPanel
                Left = 200
                Top = 0
                Width = 100
                Height = 25
                CustomHint = BalloonHint1
                Align = alLeft
                Caption = 'Em Contagem'
                Color = 6350309
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentBackground = False
                ParentFont = False
                TabOrder = 1
              end
              object PnlPnlTitEndContConcluido: TPanel
                Left = 0
                Top = 0
                Width = 100
                Height = 25
                CustomHint = BalloonHint1
                Align = alLeft
                Caption = 'Conclu'#237'do'
                Color = 3324210
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Segoe UI'
                Font.Style = []
                ParentBackground = False
                ParentFont = False
                TabOrder = 2
              end
              object EdtPesqEndereco: TSearchBox
                Left = 306
                Top = 0
                Width = 197
                Height = 25
                CustomHint = BalloonHint1
                TabOrder = 3
                OnInvokeSearch = EdtPesqEnderecoInvokeSearch
              end
            end
            object LstEnderecoContagem: TAdvStringGrid
              Left = 0
              Top = 25
              Width = 503
              Height = 329
              Cursor = crDefault
              CustomHint = BalloonHint1
              Align = alClient
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
              OnClick = LstEnderecoContagemClick
              ActiveRowColor = 15135200
              HoverRowColor = 15658717
              HoverRowCells = [hcNormal, hcSelected]
              OnRowChanging = LstCadastroRowChanging
              OnClickCell = LstEnderecoContagemClickCell
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
                'Endere'#231'o'
                'Estrutura'
                'Zona')
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
              ColWidths = (
                74
                118
                74)
              RowHeights = (
                24
                25)
            end
          end
          object PnlContagemAjuste: TPanel
            Left = 501
            Top = 0
            Width = 656
            Height = 354
            CustomHint = BalloonHint1
            Align = alRight
            Anchors = [akLeft, akTop, akRight, akBottom]
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 1
            object PnlDetalheAjuste: TPanel
              Left = 0
              Top = 0
              Width = 656
              Height = 247
              CustomHint = BalloonHint1
              Align = alTop
              BevelOuter = bvNone
              Color = clRed
              ParentBackground = False
              TabOrder = 0
              object LstDetalheAjuste: TAdvStringGrid
                Left = 0
                Top = 96
                Width = 656
                Height = 151
                Cursor = crDefault
                CustomHint = BalloonHint1
                Align = alClient
                BevelInner = bvLowered
                BevelOuter = bvNone
                ColCount = 9
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
                OnClick = LstDetalheAjusteClick
                ActiveRowColor = 15135200
                HoverRowColor = 15658717
                HoverRowCells = [hcNormal, hcSelected]
                OnRowChanging = LstCadastroRowChanging
                OnClickCell = LstDetalheAjusteClickCell
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
                  'Item'
                  'C'#243'digo'
                  'Descri'#231#227'o'
                  'Lote'
                  'Vencimento'
                  'Est.Inicial'
                  'Contagem'
                  'Ajuste'
                  'Status')
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
                ColWidths = (
                  74
                  118
                  74
                  74
                  74
                  74
                  74
                  74
                  74)
                RowHeights = (
                  24
                  25)
              end
              object PnlTopAjuste: TPanel
                Left = 0
                Top = 0
                Width = 656
                Height = 96
                CustomHint = BalloonHint1
                Align = alTop
                Anchors = [akLeft, akTop, akRight, akBottom]
                BevelOuter = bvNone
                ParentBackground = False
                TabOrder = 1
                object LblEnderecoContagem: TLabel
                  Left = 25
                  Top = 20
                  Width = 55
                  Height = 17
                  CustomHint = BalloonHint1
                  Alignment = taRightJustify
                  Caption = 'Endere'#231'o'
                end
                object Label16: TLabel
                  Left = 12
                  Top = 63
                  Width = 68
                  Height = 17
                  CustomHint = BalloonHint1
                  Caption = 'Estoq.Inicial'
                end
                object Label15: TLabel
                  Left = 396
                  Top = 20
                  Width = 35
                  Height = 17
                  CustomHint = BalloonHint1
                  Caption = 'Status'
                end
                object Label17: TLabel
                  Left = 233
                  Top = 63
                  Width = 60
                  Height = 17
                  CustomHint = BalloonHint1
                  Caption = 'Contagem'
                end
                object Label18: TLabel
                  Left = 397
                  Top = 63
                  Width = 35
                  Height = 17
                  CustomHint = BalloonHint1
                  Caption = 'Ajuste'
                end
                object Label19: TLabel
                  Left = 544
                  Top = 63
                  Width = 34
                  Height = 17
                  CustomHint = BalloonHint1
                  Caption = 'Saldo'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object Label20: TLabel
                  Left = 0
                  Top = 0
                  Width = 656
                  Height = 17
                  CustomHint = BalloonHint1
                  Align = alTop
                  Alignment = taCenter
                  Caption = 'Detalhes do Ajuste'
                  Color = clBtnFace
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  ParentColor = False
                  ParentFont = False
                  ExplicitWidth = 117
                end
                object LblLote: TLabel
                  Left = 270
                  Top = 20
                  Width = 25
                  Height = 17
                  CustomHint = BalloonHint1
                  Caption = 'Lote'
                end
                object LblProdutoContagem: TLabel
                  Left = 160
                  Top = 20
                  Width = 11
                  Height = 17
                  CustomHint = BalloonHint1
                  Caption = '%'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 4227327
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  ParentFont = False
                end
                object EdtEnderecoContagem: TEdit
                  Left = 86
                  Top = 16
                  Width = 70
                  Height = 25
                  CustomHint = BalloonHint1
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                end
                object EdtEstoqueInicial: TEdit
                  Left = 86
                  Top = 59
                  Width = 115
                  Height = 25
                  CustomHint = BalloonHint1
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 1
                end
                object EdtContagem: TEdit
                  Left = 301
                  Top = 60
                  Width = 69
                  Height = 25
                  CustomHint = BalloonHint1
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 2
                end
                object CbEnderecoStatus: TComboBox
                  Left = 437
                  Top = 16
                  Width = 112
                  Height = 25
                  CustomHint = BalloonHint1
                  TabOrder = 3
                  Items.Strings = (
                    'Iniciado'
                    'Em Contagem'
                    'Conclu'#237'do')
                end
                object EdtSaldo: TEdit
                  Left = 586
                  Top = 59
                  Width = 65
                  Height = 25
                  CustomHint = BalloonHint1
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = [fsBold]
                  ParentFont = False
                  TabOrder = 4
                end
                object EdtAjuste: TEdit
                  Left = 438
                  Top = 59
                  Width = 65
                  Height = 25
                  CustomHint = BalloonHint1
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 5
                end
                object EdtLote: TEdit
                  Left = 301
                  Top = 16
                  Width = 89
                  Height = 25
                  CustomHint = BalloonHint1
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 6
                end
              end
            end
            object PnlResumoContagem: TPanel
              Left = 0
              Top = 247
              Width = 656
              Height = 107
              CustomHint = BalloonHint1
              Align = alClient
              ParentBackground = False
              TabOrder = 1
              object Label21: TLabel
                Left = 1
                Top = 1
                Width = 654
                Height = 17
                CustomHint = BalloonHint1
                Align = alTop
                Alignment = taCenter
                Caption = 'Resumo da Contagem do item '
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Segoe UI'
                Font.Style = [fsBold]
                ParentFont = False
                ExplicitWidth = 191
              end
              object LstContagemLote: TAdvStringGrid
                Left = 1
                Top = 18
                Width = 654
                Height = 88
                Cursor = crDefault
                CustomHint = BalloonHint1
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
                TabOrder = 0
                OnClick = LstCadastroClick
                ActiveRowColor = 15135200
                HoverRowColor = 15658717
                HoverRowCells = [hcNormal, hcSelected]
                OnRowChanging = LstCadastroRowChanging
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
                  'Id Cont.'
                  'Qtde'
                  'Esta'#231#227'o'
                  'Data'
                  'Hora'
                  'Usu'#225'rio')
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
          end
        end
        object TabAjuste: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Apura'#231#227'o - Ajustes'
          ImageIndex = 2
          object LstAjusteRelatorio: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 1157
            Height = 354
            Cursor = crDefault
            CustomHint = BalloonHint1
            TabStop = False
            Align = alClient
            ColCount = 15
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
              'Id'
              'CodProd'
              'Descri'#231#227'o'
              'Picking'
              'Zona Pick'
              'Lote'
              'Qtd.Cont.'
              'Ajuste'
              'End.Contagem'
              'Zona Contagem'
              'Integra'#231#227'o'
              'Dt.Criacao'
              'Hr.Criacao'
              'Dt.Apura'#231#227'o'
              'Hr.Apura'#231#227'o')
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
            ExplicitWidth = 1156
            ExplicitHeight = 319
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
      object ChkExportarApuracaoGeral: TCheckBox
        Left = 357
        Top = 123
        Width = 238
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Exportar Apura'#231#227'o de Toda a Lista'
        Enabled = False
        TabOrder = 10
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 858
    Top = 289
    ExplicitLeft = 858
    ExplicitTop = 289
  end
  inherited PnlConfigPrinter: TPanel
    Left = 949
    Top = 362
    ExplicitLeft = 949
    ExplicitTop = 362
  end
  inherited FdMemPesqGeral: TFDMemTable
    Left = 385
    Top = 279
  end
  inherited frxDBDataset1: TfrxDBDataset
    DataSet = FDMemRelatorioLista
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 45796.733356701400000000
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
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      inherited PageHeader1: TfrxPageHeader
        Width = 1046.929810000000000000
        inherited Shape1: TfrxShapeView
          Width = 1039.370078740157000000
        end
        inherited Memo1: TfrxMemoView
          Left = 326.929345000000000000
        end
        inherited Memo2: TfrxMemoView
          Left = 326.929345000000000000
          Memo.UTF8W = (
            'Lista de Invent'#225'rios')
        end
        inherited SysMemo1: TfrxSysMemoView
          Left = 944.882500000000000000
        end
        inherited SysMemo3: TfrxSysMemoView
          Left = 944.882500000000000000
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        Width = 1046.929810000000000000
        inherited Line2: TfrxLineView
          Left = -0.000002440000000000
          Width = 1039.370078740157000000
        end
        inherited Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Id')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 64.252010000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Tipo')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 154.960730000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Processo')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Ajuste')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 438.425480000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Inicio Contagem')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 566.929500000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'T'#233'rm.Contagem')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 695.433520000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Apura'#231#227'o')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 823.937540000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Respons'#225'vel Finaliza'#231#227'o')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Width = 1046.929810000000000000
        inherited Line1: TfrxLineView
          Width = 1039.370078740157000000
        end
        inherited Lblusuario: TfrxMemoView
          Left = 313.700990000000000000
        end
        inherited vUsuario: TfrxMemoView
          Left = 377.953000000000000000
        end
        inherited SysMemo2: TfrxSysMemoView
          Left = 925.984850000000000000
        end
      end
      inherited MasterData1: TfrxMasterData
        Width = 1046.929810000000000000
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 638.740570000000000000
          Top = 15.118120000000000000
          Width = 60.472480000000000000
          Visible = False
          Memo.UTF8W = (
            '')
        end
        object frxDBDataset1InventarioId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          DataField = 'InventarioId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."InventarioId"]')
        end
        object frxDBDataset1Tipo: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 64.252010000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataField = 'Tipo'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Tipo"]')
        end
        object frxDBDataset1Processo: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 154.960730000000000000
          Width = 170.078850000000000000
          Height = 18.897650000000000000
          DataField = 'Processo'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Processo"]')
        end
        object frxDBDataset1Ajuste: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 328.819110000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DataField = 'Ajuste'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Ajuste"]')
        end
        object frxDBDataset1MinContagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 438.425480000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'MinContagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."MinContagem"]')
        end
        object frxDBDataset1MaxContagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 566.929500000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'MaxContagem'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."MaxContagem"]')
        end
        object frxDBDataset1Apurado: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 695.433520000000000000
          Width = 124.724490000000000000
          Height = 18.897650000000000000
          DataField = 'Apurado'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Apurado"]')
        end
        object frxDBDataset1UsuarioApuracao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 823.937540000000000000
          Width = 200.314967950000000000
          Height = 18.897650000000000000
          DataField = 'UsuarioApuracao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."UsuarioApuracao"]')
        end
      end
    end
  end
  object FDMemEndereco: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 233
    Top = 309
    object FDMemEnderecoAtivo: TIntegerField
      FieldName = 'Ativo'
    end
    object FDMemEnderecoEnderecoId: TIntegerField
      FieldName = 'EnderecoId'
    end
    object FDMemEnderecoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object FDMemEnderecoEstrutura: TStringField
      FieldName = 'Estrutura'
      Size = 30
    end
    object FDMemEnderecoMascara: TStringField
      FieldName = 'Mascara'
      Size = 14
    end
    object FDMemEnderecoZona: TStringField
      FieldName = 'Zona'
      Size = 30
    end
    object FDMemEnderecoStatus: TStringField
      FieldName = 'Status'
      Size = 1
    end
  end
  object FDMemProdutoDisponivel: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 231
    Top = 365
    object FDMemProdutoDisponivelProdutoId: TIntegerField
      FieldName = 'ProdutoId'
    end
    object FDMemProdutoDisponivelCodigoERP: TIntegerField
      FieldName = 'CodigoERP'
    end
    object FDMemProdutoDisponivelDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FDMemProdutoDisponivelPicking: TStringField
      FieldName = 'Picking'
      Size = 11
    end
    object FDMemProdutoDisponivelmascara: TStringField
      FieldName = 'mascara'
      Size = 11
    end
    object FDMemProdutoDisponivelZona: TStringField
      FieldName = 'Zona'
      Size = 30
    end
    object FDMemProdutoDisponivelSngpc: TIntegerField
      FieldName = 'Sngpc'
    end
    object FDMemProdutoDisponivelStatus: TStringField
      FieldName = 'Status'
      Size = 1
    end
  end
  object FdMemLoteInventariado: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 231
    Top = 423
    object FdMemLoteInventariadoItemId: TIntegerField
      FieldName = 'ItemId'
    end
    object FdMemLoteInventariadoInventarioId: TIntegerField
      FieldName = 'InventarioId'
    end
    object FdMemLoteInventariadoEnderecoId: TIntegerField
      FieldName = 'EnderecoId'
    end
    object FdMemLoteInventariadoEndereco: TStringField
      FieldName = 'Endereco'
      Size = 11
    end
    object FdMemLoteInventariadoProdutoId: TIntegerField
      FieldName = 'ProdutoId'
    end
    object FdMemLoteInventariadoCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object FdMemLoteInventariadoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FdMemLoteInventariadoLoteId: TIntegerField
      FieldName = 'LoteId'
    end
    object FdMemLoteInventariadoDescrLote: TStringField
      FieldName = 'DescrLote'
      Size = 30
    end
    object FdMemLoteInventariadoFabricacao: TDateField
      FieldName = 'Fabricacao'
    end
    object FdMemLoteInventariadoVencimento: TDateField
      FieldName = 'Vencimento'
    end
    object FdMemLoteInventariadoEstoqueInicial: TIntegerField
      FieldName = 'EstoqueInicial'
    end
    object FdMemLoteInventariadoContagemId: TIntegerField
      FieldName = 'ContagemId'
    end
    object FdMemLoteInventariadoQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object FdMemLoteInventariadoQtdContagem: TIntegerField
      FieldName = 'QtdContagem'
    end
    object FdMemLoteInventariadoStatus: TStringField
      FieldName = 'Status'
      Size = 1
    end
    object FdMemLoteInventariadoAutomatico: TIntegerField
      FieldName = 'Automatico'
    end
  end
  object FdMemAjusteRelatorio: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 481
    Top = 283
  end
  object FDMemRelatorioLista: TFDMemTable
    AfterClose = FdMemPesqGeralAfterClose
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 223
    Top = 495
    object IntegerField1: TIntegerField
      FieldName = 'InventarioId'
    end
    object IntegerField2: TIntegerField
      FieldName = 'InventarioTipoId'
    end
    object StringField1: TStringField
      FieldName = 'Tipo'
    end
    object StringField2: TStringField
      FieldName = 'Motivo'
      Size = 250
    end
    object IntegerField3: TIntegerField
      FieldName = 'TipoAjuste'
    end
    object StringField3: TStringField
      FieldName = 'Ajuste'
    end
    object IntegerField4: TIntegerField
      FieldName = 'ProcessoId'
    end
    object StringField4: TStringField
      FieldName = 'Processo'
      Size = 30
    end
    object DateField1: TDateField
      FieldName = 'DataCriacao'
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'Gerado'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'Horario'
    end
    object StringField5: TStringField
      FieldName = 'UsuarioGerador'
      Size = 50
    end
    object StringField6: TStringField
      FieldName = 'Usuario'
      Size = 50
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'MinContagem'
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'MaxContagem'
    end
    object DateTimeField5: TDateTimeField
      FieldName = 'Cancelado'
    end
    object StringField7: TStringField
      FieldName = 'UsuarioCancelamento'
      Size = 50
    end
    object DateTimeField6: TDateTimeField
      FieldName = 'Apurado'
    end
    object DateField2: TDateField
      FieldName = 'DataFechamento'
    end
    object TimeField1: TTimeField
      FieldName = 'HoraFechamento'
    end
    object StringField8: TStringField
      FieldName = 'UsuarioApuracao'
      Size = 50
    end
    object IntegerField5: TIntegerField
      FieldName = 'SaldoInicial'
    end
    object IntegerField6: TIntegerField
      FieldName = 'TotalEnderecoBloqueado'
    end
    object IntegerField7: TIntegerField
      FieldName = 'TotalProdutoBloqueado'
    end
  end
end
