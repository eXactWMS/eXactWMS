inherited FrmRelDshCheckOut: TFrmRelDshCheckOut
  Caption = 'FrmRelDshCheckOut'
  ExplicitLeft = -399
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LblTotRegCaption: TLabel
        Top = 160
        ExplicitTop = 160
      end
      inherited LblTotRegistro: TLabel
        Top = 160
        ExplicitTop = 160
      end
      object Label4: TLabel [3]
        Left = 309
        Top = 160
        Width = 58
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Pedido(s):'
      end
      object LblTPedido: TLabel [4]
        Left = 372
        Top = 160
        Width = 45
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
      object Label6: TLabel [5]
        Left = 431
        Top = 160
        Width = 60
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Volume(s):'
      end
      object LblTVolume: TLabel [6]
        Left = 496
        Top = 160
        Width = 45
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
      object Label8: TLabel [7]
        Left = 557
        Top = 160
        Width = 66
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Unidade(s):'
      end
      object LblTUnidade: TLabel [8]
        Left = 626
        Top = 160
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
        TabOrder = 4
      end
      inherited ChkCadastro: TCheckBox
        TabOrder = 5
      end
      inherited LstReport: TAdvStringGrid
        Top = 180
        Height = 344
        TabStop = False
        ColCount = 12
        FixedCols = 2
        TabOrder = 3
        ColumnHeaders.Strings = (
          'Data'
          'Embalagem'
          'Id'
          'Usu'#225'rio'
          'Pedido(s)'
          'Volume(s)'
          'Unidade(s)'
          'In'#237'cio'
          'T'#233'rmino'
          'Hr.Trabalhada'
          'Volume/Hora'
          'Unid/Hora')
        ExplicitTop = 180
        ExplicitHeight = 344
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
        Left = 190
        Top = 15
        Width = 184
        Height = 134
        CustomHint = BalloonHint1
        Caption = '[ Per'#237'odo da Produ'#231#227'o ]'
        TabOrder = 1
        object Label2: TLabel
          Left = 27
          Top = 35
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label3: TLabel
          Left = 10
          Top = 82
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtInicioProducao: TJvDateEdit
          Left = 63
          Top = 33
          Width = 110
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
          OnChange = EdtInicioProducaoChange
        end
        object EdtTerminoProducao: TJvDateEdit
          Left = 63
          Top = 81
          Width = 110
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
          OnChange = EdtInicioProducaoChange
        end
      end
      object GroupBox6: TGroupBox
        Left = 528
        Top = 15
        Width = 557
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Usu'#225'rio ]'
        TabOrder = 2
        object Label11: TLabel
          Left = 40
          Top = 21
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object Lblusuario: TLabel
          Left = 146
          Top = 23
          Width = 279
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
        object EdtUsuarioId: TEdit
          Left = 57
          Top = 19
          Width = 58
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
          OnChange = EdtInicioProducaoChange
          OnExit = EdtUsuarioIdExit
        end
        object BtnPesqUsuario: TBitBtn
          Left = 116
          Top = 18
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
          OnClick = BtnPesqUsuarioClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 528
        Top = 69
        Width = 556
        Height = 80
        CustomHint = BalloonHint1
        Caption = '[ Ind'#237'ces de Produtividade ]'
        Enabled = False
        TabOrder = 6
        TabStop = True
        object Bevel2: TBevel
          Left = 286
          Top = 25
          Width = 271
          Height = 56
          CustomHint = BalloonHint1
        end
        object Bevel1: TBevel
          Left = 7
          Top = 25
          Width = 280
          Height = 54
          CustomHint = BalloonHint1
        end
        object Label7: TLabel
          Left = 19
          Top = 44
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label9: TLabel
          Left = 142
          Top = 44
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label5: TLabel
          Left = 303
          Top = 44
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label10: TLabel
          Left = 416
          Top = 44
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label12: TLabel
          Left = 87
          Top = 16
          Width = 79
          Height = 17
          CustomHint = BalloonHint1
          Caption = ' Fracionados '
          Transparent = False
        end
        object Label13: TLabel
          Left = 367
          Top = 16
          Width = 84
          Height = 17
          CustomHint = BalloonHint1
          Caption = ' Cxa. Fechada '
          Transparent = False
        end
        object EdtMetaFracionado: TEdit
          Left = 58
          Top = 40
          Width = 56
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          Text = '0'
        end
        object EdtToleranciaFracionado: TEdit
          Left = 210
          Top = 40
          Width = 56
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          Text = '0'
        end
        object EdtMetaCxaFechada: TEdit
          Left = 342
          Top = 40
          Width = 56
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          Text = '0'
        end
        object EdtToleranciaCxaFechada: TEdit
          Left = 484
          Top = 40
          Width = 56
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          Text = '0'
        end
      end
      object GroupBox4: TGroupBox
        Left = 8
        Top = 15
        Width = 184
        Height = 134
        CustomHint = BalloonHint1
        Caption = '[ Per'#237'odo Pedido ]'
        TabOrder = 0
        TabStop = True
        object Label14: TLabel
          Left = 27
          Top = 35
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label15: TLabel
          Left = 10
          Top = 82
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtInicioPedido: TJvDateEdit
          Left = 63
          Top = 33
          Width = 110
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
          OnChange = EdtInicioProducaoChange
        end
        object EdtTerminoPedido: TJvDateEdit
          Left = 63
          Top = 81
          Width = 110
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
          OnChange = EdtInicioProducaoChange
        end
      end
      object RgEmbalagem: TRadioGroup
        Left = 372
        Top = 15
        Width = 157
        Height = 82
        CustomHint = BalloonHint1
        Caption = ' [ Embalagem ] '
        Enabled = False
        Items.Strings = (
          'Cxa. Fechada'
          'Cxa. Fracionada')
        TabOrder = 7
        OnClick = RgEmbalagemClick
      end
      object GroupBox2: TGroupBox
        Left = 371
        Top = 94
        Width = 158
        Height = 55
        CustomHint = BalloonHint1
        TabOrder = 8
        object ChkRecheckOut: TCheckBox
          Left = 9
          Top = 22
          Width = 152
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Analisar Re-CheckOut'
          Enabled = False
          TabOrder = 0
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
    Left = 1001
    Top = -14
    ExplicitLeft = 1001
    ExplicitTop = -14
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 855
    Top = 329
    ExplicitLeft = 855
    ExplicitTop = 329
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
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
