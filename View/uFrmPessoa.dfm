inherited FrmPessoa: TFrmPessoa
  Caption = ''
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      inherited LstCadastro: TAdvStringGrid
        ColCount = 8
        ColumnHeaders.Strings = (
          'Id'
          'C'#243'digo'
          'Raz'#227'o Social'
          'Fantasia'
          'Cnpj/Cpf'
          'Email'
          'Home Page'
          'Status')
        ColWidths = (
          74
          118
          74
          74
          74
          74
          74
          74)
      end
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          OnKeyPress = CbCampoPesqKeyPress
          Items.Strings = (
            'Id'
            'C'#243'digo ERP'
            'Raz'#227'o Social'
            'Fantasia')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      object Label2: TLabel [0]
        Left = 567
        Top = 10
        Width = 26
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Tipo'
        Visible = False
      end
      inherited ShCadastro: TShape
        Left = 757
        Top = 175
        ExplicitLeft = 757
        ExplicitTop = 175
      end
      object LblRota: TLabel [2]
        Left = 156
        Top = 174
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
      object LblTransportadora: TLabel [3]
        Left = 382
        Top = 174
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
        Visible = False
      end
      object LblShelfLife: TLabel [4]
        Left = 28
        Top = 173
        Width = 53
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Shelf-Life'
      end
      object LblShelfLifeMeses: TLabel [5]
        Left = 136
        Top = 172
        Width = 46
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'M'#234's(es)'
      end
      object CbTipoPessoa: TComboBox [6]
        Left = 596
        Top = 10
        Width = 211
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
        Visible = False
        OnEnter = EdtHomePageEnter
        OnExit = EdtHomePageExit
        Items.Strings = (
          'Cliente'
          'Fornecedor')
      end
      object PgcEndereco: TcxPageControl [7]
        Left = 11
        Top = 215
        Width = 1168
        Height = 152
        CustomHint = BalloonHint1
        ParentBackground = False
        TabOrder = 13
        TabStop = False
        Properties.ActivePage = TbEndereco
        Properties.CustomButtons.Buttons = <>
        Properties.Style = 9
        ClientRectBottom = 152
        ClientRectRight = 1168
        ClientRectTop = 24
        object TbEndereco: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Endere'#231'o Principal'
          ImageIndex = 0
          object Label6: TLabel
            Left = 23
            Top = 17
            Width = 31
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'C.E.P.'
          end
          object Label7: TLabel
            Left = 25
            Top = 91
            Width = 35
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Bairro'
          end
          object Label8: TLabel
            Left = 206
            Top = 17
            Width = 55
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Endere'#231'o'
          end
          object Label9: TLabel
            Left = 339
            Top = 91
            Width = 41
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Cidade'
          end
          object Label10: TLabel
            Left = 659
            Top = 91
            Width = 15
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'UF'
          end
          object Label11: TLabel
            Left = 678
            Top = 17
            Width = 48
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'N'#250'mero'
          end
          object Label12: TLabel
            Left = 853
            Top = 17
            Width = 82
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Complemento'
          end
          object Label13: TLabel
            Left = 981
            Top = 91
            Width = 73
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'C'#243'digo IBGE'
          end
          object Label76: TLabel
            Left = 5
            Top = 54
            Width = 99
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Ponto Refer'#234'ncia'
          end
          object EdtCep: TEdit
            Left = 66
            Top = 14
            Width = 75
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 8
            ParentFont = False
            TabOrder = 0
            OnExit = EdtCepExit
            OnKeyPress = EdtCepKeyPress
          end
          object EdtEndereco: TEdit
            Left = 265
            Top = 14
            Width = 373
            Height = 25
            CustomHint = BalloonHint1
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 80
            ParentFont = False
            TabOrder = 1
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
          end
          object EdtNumEndereco: TEdit
            Left = 728
            Top = 14
            Width = 59
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 2
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
          end
          object EdtComplEnde: TEdit
            Left = 941
            Top = 14
            Width = 193
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 50
            ParentFont = False
            TabOrder = 3
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
          end
          object EdtPontoReferencia: TEdit
            Left = 112
            Top = 51
            Width = 1022
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 4
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
          end
          object EdtBairro: TEdit
            Left = 66
            Top = 88
            Width = 189
            Height = 25
            CustomHint = BalloonHint1
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 5
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
          end
          object EdtCidade: TEdit
            Left = 382
            Top = 88
            Width = 256
            Height = 25
            CustomHint = BalloonHint1
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 6
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
          end
          object CbUf: TComboBox
            Left = 678
            Top = 88
            Width = 45
            Height = 22
            CustomHint = BalloonHint1
            Style = csOwnerDrawFixed
            CharCase = ecUpperCase
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
            OnChange = CbUfChange
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
            Items.Strings = (
              'AC'
              'AM'
              'AP'
              'BA'
              'CE'
              'DF'
              'GO'
              'MA'
              'MG'
              'MT'
              'MS'
              'PA'
              'PB'
              'PI'
              'PR'
              'RJ'
              'RS'
              'SC'
              'SP'
              'TO')
          end
          object EdtEstado: TEdit
            Left = 728
            Top = 88
            Width = 140
            Height = 25
            CustomHint = BalloonHint1
            BevelOuter = bvSpace
            Color = clMoneyGreen
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnExit = EdtHomePageExit
          end
          object EdtCodIbge: TEdit
            Left = 1061
            Top = 88
            Width = 73
            Height = 25
            CustomHint = BalloonHint1
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 7
            ParentFont = False
            TabOrder = 9
            OnEnter = EdtHomePageEnter
            OnExit = EdtHomePageExit
          end
          object BtnPesqCep: TBitBtn
            Left = 141
            Top = 14
            Width = 24
            Height = 24
            Hint = 'Consultar Cep Online'
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
            ParentShowHint = False
            ShowHint = True
            TabOrder = 10
            TabStop = False
            OnClick = BtnPesqCepClick
          end
        end
        object TbEndCobranca: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Endere'#231'o de Cobran'#231'a'
          ImageIndex = 1
          object Label14: TLabel
            Left = 21
            Top = 12
            Width = 31
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'C.E.P.'
          end
          object Label15: TLabel
            Left = 200
            Top = 12
            Width = 55
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Endere'#231'o'
          end
          object Label16: TLabel
            Left = 529
            Top = 12
            Width = 48
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'N'#250'mero'
          end
          object Label17: TLabel
            Left = 691
            Top = 12
            Width = 82
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Complemento'
          end
          object Label18: TLabel
            Left = 24
            Top = 90
            Width = 35
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Bairro'
          end
          object Label19: TLabel
            Left = 282
            Top = 90
            Width = 41
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Cidade'
          end
          object Label20: TLabel
            Left = 562
            Top = 90
            Width = 15
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'UF'
          end
          object Label21: TLabel
            Left = 828
            Top = 90
            Width = 73
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'C'#243'digo IBGE'
          end
          object Label77: TLabel
            Left = 3
            Top = 54
            Width = 99
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'Ponto Refer'#234'ncia'
          end
          object EdtCepCob: TEdit
            Left = 64
            Top = 12
            Width = 101
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 9
            ParentFont = False
            TabOrder = 0
            OnExit = EdtCepCobExit
            OnKeyPress = EdtCepCobKeyPress
          end
          object EdtEnderecoCob: TEdit
            Left = 263
            Top = 12
            Width = 248
            Height = 25
            CustomHint = BalloonHint1
            Color = clMoneyGreen
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 40
            ParentFont = False
            TabOrder = 1
            OnExit = EdtHomePageExit
          end
          object EdtNumEndeCob: TEdit
            Left = 582
            Top = 12
            Width = 59
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 2
            OnExit = EdtHomePageExit
            OnKeyPress = EdtNumEndeCobKeyPress
          end
          object EdtComplEndeCob: TEdit
            Left = 779
            Top = 12
            Width = 193
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 50
            ParentFont = False
            TabOrder = 3
            OnExit = EdtHomePageExit
          end
          object EdtPontoReferenciaCob: TEdit
            Left = 111
            Top = 49
            Width = 862
            Height = 25
            CustomHint = BalloonHint1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 100
            ParentFont = False
            TabOrder = 4
            OnExit = EdtHomePageExit
          end
          object EdtBairroCob: TEdit
            Left = 61
            Top = 87
            Width = 199
            Height = 25
            CustomHint = BalloonHint1
            Color = clMoneyGreen
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 5
            OnExit = EdtHomePageExit
          end
          object EdtCidadeCob: TEdit
            Left = 324
            Top = 87
            Width = 189
            Height = 25
            CustomHint = BalloonHint1
            Color = clMoneyGreen
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 30
            ParentFont = False
            TabOrder = 6
            OnExit = EdtHomePageExit
          end
          object CbUfCob: TComboBox
            Left = 580
            Top = 87
            Width = 45
            Height = 22
            CustomHint = BalloonHint1
            Style = csOwnerDrawFixed
            CharCase = ecUpperCase
            Color = clMoneyGreen
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 7
            OnChange = CbUfCobChange
            OnExit = EdtHomePageExit
            Items.Strings = (
              'AC'
              'AM'
              'AP'
              'BA'
              'CE'
              'DF'
              'GO'
              'MA'
              'MG'
              'MT'
              'MS'
              'PA'
              'PB'
              'PI'
              'PR'
              'RJ'
              'RS'
              'SC'
              'SP'
              'TO')
          end
          object EdtEstadoCob: TEdit
            Left = 627
            Top = 87
            Width = 140
            Height = 25
            CustomHint = BalloonHint1
            BevelOuter = bvSpace
            Color = clMoneyGreen
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnExit = EdtHomePageExit
          end
          object EdtCodIbgeCob: TEdit
            Left = 904
            Top = 87
            Width = 68
            Height = 25
            CustomHint = BalloonHint1
            Color = clMoneyGreen
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            MaxLength = 7
            ParentFont = False
            TabOrder = 9
            OnExit = EdtHomePageExit
            OnKeyPress = EdtCodIbgeCobKeyPress
          end
        end
      end
      object EdtCNPJCPF: TLabeledEdit [8]
        Left = 89
        Top = 93
        Width = 166
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        Ctl3D = True
        EditLabel.Width = 77
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'C.N.P.J./C.P.F.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 5
        OnEnter = EdtHomePageEnter
        OnExit = EdtCNPJCPFExit
        OnKeyPress = EdtFoneKeyPress
      end
      object EdtID: TLabeledEdit [9]
        Left = 348
        Top = 8
        Width = 117
        Height = 24
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 16
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'ID '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Visible = False
        OnChange = EdtIDChange
        OnEnter = EdtHomePageEnter
        OnExit = EdtIDExit
        OnKeyPress = EdtIDKeyPress
      end
      object edtCodigoErp: TLabeledEdit [10]
        Left = 89
        Top = 8
        Width = 117
        Height = 24
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 47
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'C'#243'digo '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        OnChange = EdtIDChange
        OnEnter = EdtHomePageEnter
        OnExit = edtCodigoErpExit
        OnKeyPress = EdtIDKeyPress
      end
      object EdtFone: TLabeledEdit [11]
        Left = 596
        Top = 93
        Width = 211
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        Ctl3D = True
        EditLabel.Width = 28
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Fone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 6
        OnEnter = EdtHomePageEnter
        OnExit = EdtHomePageExit
        OnKeyPress = EdtFoneKeyPress
      end
      object GroupBox2: TGroupBox [12]
        Left = 11
        Top = 367
        Width = 1168
        Height = 116
        CustomHint = BalloonHint1
        Caption = '  Telefones de Contato   '
        TabOrder = 14
        object Label23: TLabel
          Left = 13
          Top = 15
          Width = 26
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Tipo'
        end
        object Label25: TLabel
          Left = 148
          Top = 15
          Width = 49
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Telefone'
        end
        object Label26: TLabel
          Left = 265
          Top = 15
          Width = 46
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Contato'
        end
        object Label27: TLabel
          Left = 585
          Top = 15
          Width = 190
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dados Adicionais / Observa'#231#245'es'
        end
        object CbTpFone1: TComboBox
          Left = 13
          Top = 34
          Width = 101
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnExit = EdtHomePageExit
          Items.Strings = (
            ''
            'Fixo'
            'Fixo(Recado)'
            'Celular'
            'Fax')
        end
        object CbTpFone2: TComboBox
          Left = 13
          Top = 59
          Width = 101
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnExit = EdtHomePageExit
          Items.Strings = (
            ''
            'Fixo'
            'Fixo(Recado)'
            'Celular'
            'Fax')
        end
        object CbTpFone3: TComboBox
          Left = 13
          Top = 85
          Width = 101
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnExit = EdtHomePageExit
          Items.Strings = (
            ''
            'Fixo'
            'Fixo(Recado)'
            'Celular'
            'Fax')
        end
        object EdtFone1: TEdit
          Left = 149
          Top = 33
          Width = 95
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 11
          ParentFont = False
          TabOrder = 1
          OnExit = EdtHomePageExit
          OnKeyPress = EdtCepKeyPress
        end
        object EdtFone2: TEdit
          Left = 149
          Top = 59
          Width = 95
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 11
          ParentFont = False
          TabOrder = 5
          OnExit = EdtHomePageExit
          OnKeyPress = EdtCepKeyPress
        end
        object EdtFone3: TEdit
          Left = 149
          Top = 85
          Width = 95
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 11
          ParentFont = False
          TabOrder = 9
          OnExit = EdtHomePageExit
          OnKeyPress = EdtCepKeyPress
        end
        object EdtContato3: TEdit
          Left = 265
          Top = 85
          Width = 300
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 10
          OnExit = EdtHomePageExit
        end
        object EdtContato2: TEdit
          Left = 265
          Top = 59
          Width = 300
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 6
          OnExit = EdtHomePageExit
        end
        object EdtContato1: TEdit
          Left = 265
          Top = 33
          Width = 300
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 2
          OnExit = EdtHomePageExit
        end
        object EdtObs1: TEdit
          Left = 585
          Top = 33
          Width = 470
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 3
          OnExit = EdtHomePageExit
        end
        object EdtObs2: TEdit
          Left = 585
          Top = 59
          Width = 470
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 7
          OnExit = EdtHomePageExit
        end
        object EdtObs3: TEdit
          Left = 585
          Top = 85
          Width = 470
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 100
          ParentFont = False
          TabOrder = 11
          OnExit = EdtHomePageExit
        end
      end
      object EdtRazao: TLabeledEdit [13]
        Left = 89
        Top = 52
        Width = 408
        Height = 24
        CustomHint = BalloonHint1
        CharCase = ecUpperCase
        Ctl3D = True
        EditLabel.Width = 74
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Raz'#227'o Social'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnEnter = EdtHomePageEnter
        OnExit = EdtHomePageExit
      end
      object EdtHomePage: TLabeledEdit [14]
        Left = 598
        Top = 134
        Width = 410
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        Ctl3D = True
        EditLabel.Width = 68
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Home Page'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 8
        OnEnter = EdtHomePageEnter
        OnExit = EdtHomePageExit
      end
      object EdtFantasia: TLabeledEdit [15]
        Left = 596
        Top = 52
        Width = 410
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        CharCase = ecUpperCase
        Ctl3D = True
        EditLabel.Width = 47
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Fantasia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 4
        OnEnter = EdtHomePageEnter
        OnExit = EdtHomePageExit
      end
      object EdtEmail: TLabeledEdit [16]
        Left = 89
        Top = 134
        Width = 408
        Height = 24
        CustomHint = BalloonHint1
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
        OnEnter = EdtHomePageEnter
        OnExit = EdtHomePageExit
      end
      inherited PnlInfo: TPanel
        Left = 818
        Top = 370
        TabOrder = 15
        ExplicitLeft = 818
        ExplicitTop = 370
      end
      inherited ChkCadastro: TCheckBox
        Left = 704
        Top = 179
        TabOrder = 12
        ExplicitLeft = 704
        ExplicitTop = 179
      end
      object EdtRotaId: TLabeledEdit
        Left = 89
        Top = 171
        Width = 37
        Height = 25
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 27
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Rota'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 9
        OnExit = EdtRotaIdExit
        OnKeyPress = EdtIDKeyPress
      end
      object BtnPesqRota: TBitBtn
        Left = 126
        Top = 171
        Width = 24
        Height = 24
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
        TabOrder = 11
        TabStop = False
        OnClick = BtnPesqRotaClick
      end
      object EdtTransportadoraid: TLabeledEdit
        Left = 315
        Top = 171
        Width = 37
        Height = 25
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 91
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Transportadora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 10
        Visible = False
        OnExit = EdtTransportadoraidExit
        OnKeyPress = EdtIDKeyPress
      end
      object BtnTransportadoraPesq: TBitBtn
        Left = 352
        Top = 171
        Width = 24
        Height = 24
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
        TabOrder = 16
        TabStop = False
        Visible = False
        OnClick = BtnTransportadoraPesqClick
      end
      object EdtShelfLife: TEdit
        Left = 89
        Top = 171
        Width = 43
        Height = 25
        CustomHint = BalloonHint1
        TabOrder = 17
        OnKeyPress = EdtIDKeyPress
      end
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnImportarStand: TsImage
        Left = 487
        Top = -1
        ExplicitLeft = 487
        ExplicitTop = -1
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1023
    Top = 77
    ExplicitLeft = 1023
    ExplicitTop = 77
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 589
    Top = 231
    ExplicitLeft = 589
    ExplicitTop = 231
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    Top = 268
    object FdMemPesqGeralId: TIntegerField
      FieldName = 'Id'
    end
    object FdMemPesqGeralCodPessoa: TIntegerField
      FieldName = 'CodPessoa'
    end
    object FdMemPesqGeralRazao: TStringField
      FieldName = 'Razao'
      Size = 100
    end
    object FdMemPesqGeralFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 100
    end
    object FdMemPesqGeralPessoaTipoID: TIntegerField
      FieldName = 'PessoaTipoID'
    end
    object FdMemPesqGeralPessoaTipoDescricao: TStringField
      FieldName = 'PessoaTipoDescricao'
      Size = 30
    end
    object FdMemPesqGeralCnpjCpf: TStringField
      FieldName = 'CnpjCpf'
      Size = 14
    end
    object FdMemPesqGeralEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object FdMemPesqGeralHomePage: TStringField
      FieldName = 'HomePage'
      Size = 100
    end
    object FdMemPesqGeralStatus: TIntegerField
      FieldName = 'Status'
    end
  end
  inherited FdMemImportaCSV: TFDMemTable
    Left = 311
    Top = 318
  end
end
