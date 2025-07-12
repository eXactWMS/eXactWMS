inherited FrmRelAnaliseRessuprimento: TFrmRelAnaliseRessuprimento
  Caption = 'FrmRelAnaliseRessuprimento'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited ShCadastro: TShape
        Visible = True
      end
      object Label12: TLabel [3]
        Left = 498
        Top = 144
        Width = 70
        Height = 17
        CustomHint = BalloonHint1
        Caption = '%Produ'#231#227'o:'
      end
      object Shape1: TShape [4]
        Left = 576
        Top = 144
        Width = 20
        Height = 20
        CustomHint = BalloonHint1
        Pen.Color = clWhite
      end
      object Label14: TLabel [5]
        Left = 600
        Top = 144
        Width = 90
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'N'#227'o produzido'
      end
      object Shape2: TShape [6]
        Left = 707
        Top = 144
        Width = 20
        Height = 20
        CustomHint = BalloonHint1
        Brush.Color = clRed
        Pen.Color = clRed
      end
      object Label15: TLabel [7]
        Left = 733
        Top = 144
        Width = 38
        Height = 17
        CustomHint = BalloonHint1
        Caption = '< 90%'
      end
      object Label16: TLabel [8]
        Left = 813
        Top = 144
        Width = 47
        Height = 17
        CustomHint = BalloonHint1
        Caption = '>= 90%'
      end
      object Shape3: TShape [9]
        Left = 787
        Top = 144
        Width = 20
        Height = 20
        CustomHint = BalloonHint1
        Brush.Color = clYellow
        Pen.Color = clYellow
      end
      object Label17: TLabel [10]
        Left = 901
        Top = 144
        Width = 32
        Height = 17
        CustomHint = BalloonHint1
        Caption = '100%'
      end
      object Shape4: TShape [11]
        Left = 875
        Top = 144
        Width = 20
        Height = 20
        CustomHint = BalloonHint1
        Brush.Color = clGreen
        Pen.Color = clGreen
      end
      object Label18: TLabel [12]
        Left = 299
        Top = 144
        Width = 30
        Height = 17
        Hint = 'Ind'#237'ce de Atendimento Perfeito'
        CustomHint = BalloonHint1
        Caption = 'I.A.P.:'
        ParentShowHint = False
        ShowHint = True
      end
      object LblTotIAP: TLabel [13]
        Left = 353
        Top = 144
        Width = 36
        Height = 17
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        Caption = '0,00%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      inherited ChkCadastro: TCheckBox
        Visible = True
      end
      inherited LstReport: TAdvStringGrid
        Top = 164
        Height = 360
        ColCount = 12
        ColumnHeaders.Strings = (
          'Reg'
          'C'#243'd.ERP'
          'Raz'#227'o'
          'Rota'
          'Demanda'
          'Recebido'
          'Cubagem'
          'Apanhe'
          'CheckOut'
          'Expedi'#231#227'o'
          'Cancelado'
          '% Prod')
        ExplicitTop = 164
        ExplicitHeight = 360
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
          74)
      end
      object GroupBox1: TGroupBox
        Left = 9
        Top = 3
        Width = 332
        Height = 55
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
          Left = 169
          Top = 22
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
          Left = 222
          Top = 21
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
      object GroupBox5: TGroupBox
        Left = 339
        Top = 3
        Width = 298
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Rota ]'
        TabOrder = 4
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
          Left = 23
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
          OnClick = BtnPesqRotaClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 636
        Top = 3
        Width = 509
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Destinat'#225'rio ]'
        TabOrder = 5
        TabStop = True
        object Label9: TLabel
          Left = 8
          Top = 21
          Width = 69
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo ERP'
        end
        object LblDestinatario: TLabel
          Left = 185
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
          Left = 82
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
        end
        object BtnPesqCliente: TBitBtn
          Left = 155
          Top = 19
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
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqClienteClick
        end
      end
      object GbAnalise: TGroupBox
        Left = 9
        Top = 48
        Width = 331
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Tipo de An'#225'lise ]'
        TabOrder = 7
        object RbAnalisePedido: TRadioButton
          Left = 22
          Top = 24
          Width = 70
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Pedidos'
          Enabled = False
          TabOrder = 0
          OnClick = RbAnalisePedidoClick
        end
        object RbAnaliseVolumes: TRadioButton
          Left = 128
          Top = 24
          Width = 70
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Volumes'
          Enabled = False
          TabOrder = 1
          OnClick = RbAnalisePedidoClick
        end
        object RbAnalisaVolumeZonas: TRadioButton
          Left = 234
          Top = 24
          Width = 70
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Volumes'
          Enabled = False
          TabOrder = 2
          Visible = False
          OnClick = RbAnalisePedidoClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 9
        Top = 95
        Width = 1136
        Height = 47
        CustomHint = BalloonHint1
        Caption = '[ Totalizadores ]'
        TabOrder = 6
        object Label5: TLabel
          Left = 17
          Top = 19
          Width = 56
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Registro: '
        end
        object LblRegistro: TLabel
          Left = 76
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
        object Label4: TLabel
          Left = 177
          Top = 19
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Demanda:'
        end
        object LblDemanda: TLabel
          Left = 225
          Top = 19
          Width = 78
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'LblDemanda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblCubagem: TLabel
          Left = 383
          Top = 19
          Width = 77
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'LblCubagem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 334
          Top = 19
          Width = 71
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Processado:'
        end
        object Label6: TLabel
          Left = 496
          Top = 19
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Apanhe:'
        end
        object LblApanhe: TLabel
          Left = 546
          Top = 19
          Width = 66
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'LblApanhe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Labelchekcou: TLabel
          Left = 648
          Top = 19
          Width = 56
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Checkout:'
        end
        object LblCheckout: TLabel
          Left = 696
          Top = 19
          Width = 76
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'LblCheckout'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblExpedicao: TLabel
          Left = 849
          Top = 19
          Width = 81
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'LblExpedicao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 798
          Top = 19
          Width = 63
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Expedi'#231#227'o:'
        end
        object Label8: TLabel
          Left = 964
          Top = 19
          Width = 64
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Cancelado:'
        end
        object LblCancelado: TLabel
          Left = 1016
          Top = 19
          Width = 82
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'LblCancelado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GbZona: TGroupBox
        Left = 330
        Top = 49
        Width = 389
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Zona ]'
        TabOrder = 8
        Visible = False
        object Label10: TLabel
          Left = 9
          Top = 25
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblZona: TLabel
          Left = 100
          Top = 26
          Width = 273
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
        object EdtZonaId: TEdit
          Left = 25
          Top = 22
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
          OnEnter = EdtZonaIdEnter
          OnExit = EdtZonaIdExit
        end
        object BtnPesqZona: TBitBtn
          Left = 70
          Top = 22
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
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqZonaClick
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
  inherited PnlImgObjeto: TPanel
    Left = 1020
    Top = 186
    ExplicitLeft = 1020
    ExplicitTop = 186
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 404
    Top = 325
    ExplicitLeft = 404
    ExplicitTop = 325
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralPessoaid: TIntegerField
      FieldName = 'Pessoaid'
    end
    object FdMemPesqGeralCodPessoaERP: TIntegerField
      FieldName = 'CodPessoaERP'
    end
    object FdMemPesqGeralRazao: TStringField
      FieldName = 'Razao'
      Size = 100
    end
    object FdMemPesqGeralRota: TStringField
      FieldName = 'Rota'
      Size = 60
    end
    object FdMemPesqGeralDemanda: TIntegerField
      FieldName = 'Demanda'
    end
    object FdMemPesqGeralRecebido: TIntegerField
      FieldName = 'Recebido'
    end
    object FdMemPesqGeralCubagem: TIntegerField
      FieldName = 'Cubagem'
    end
    object FdMemPesqGeralApanhe: TIntegerField
      FieldName = 'Apanhe'
    end
    object FdMemPesqGeralCheckOut: TIntegerField
      FieldName = 'CheckOut'
    end
    object FdMemPesqGeralExpedicao: TIntegerField
      FieldName = 'Expedicao'
    end
    object FdMemPesqGeralCancelado: TIntegerField
      FieldName = 'Cancelado'
    end
    object FdMemPesqGeralMedProducao: TFloatField
      FieldName = 'MedProducao'
    end
    object FdMemPesqGeralFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 100
    end
  end
  inherited frxReport1: TfrxReport
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
  end
end
