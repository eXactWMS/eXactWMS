inherited FrmVeiculo: TFrmVeiculo
  Caption = 'FrmVeiculo'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      inherited LstCadastro: TAdvStringGrid
        ColCount = 11
        ColumnHeaders.Strings = (
          'Id'
          'Placa'
          'Cor'
          'Tipo'
          'Marca'
          'Carroceria'
          'Volume'
          'Aproveitamento'
          'Capacidade'
          'Transportadora'
          'Status')
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
            'Id'
            'Placa'
            'Transportadora ID')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      inherited ShCadastro: TShape
        Left = 135
        Top = 470
        ExplicitLeft = 135
        ExplicitTop = 470
      end
      object Label2: TLabel [1]
        Left = 327
        Top = 27
        Width = 71
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Proced'#234'ncia'
      end
      object Label3: TLabel [2]
        Left = 719
        Top = 27
        Width = 26
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Tipo'
      end
      object Label4: TLabel [3]
        Left = 39
        Top = 73
        Width = 37
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Marca'
      end
      object Label5: TLabel [4]
        Left = 352
        Top = 73
        Width = 46
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Modelo'
      end
      object Label6: TLabel [5]
        Left = 641
        Top = 73
        Width = 104
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Ano Fabr/Modelo'
      end
      object Label7: TLabel [6]
        Left = 331
        Top = 119
        Width = 67
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Chassi Tipo'
      end
      object Label8: TLabel [7]
        Left = 656
        Top = 119
        Width = 89
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Chassi N'#250'mero'
      end
      object Label9: TLabel [8]
        Left = 46
        Top = 163
        Width = 30
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Placa'
      end
      object Label10: TLabel [9]
        Left = 15
        Top = 119
        Width = 61
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Carroceria'
      end
      object Label11: TLabel [10]
        Left = 345
        Top = 163
        Width = 53
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Renavam'
      end
      object Label12: TLabel [11]
        Left = 656
        Top = 163
        Width = 89
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Motor N'#250'mero'
      end
      object Label13: TLabel [12]
        Left = 55
        Top = 209
        Width = 21
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Cor'
      end
      object Label14: TLabel [13]
        Left = 327
        Top = 209
        Width = 71
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Combust'#237'vel'
      end
      object Label21: TLabel [14]
        Left = 321
        Top = 323
        Width = 91
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Capacidade(kg)'
      end
      object Label15: TLabel [15]
        Left = 35
        Top = 323
        Width = 47
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Tara(kg)'
      end
      object LblTransportadora: TLabel [16]
        Left = 273
        Top = 430
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
      inherited PnlInfo: TPanel
        Left = 855
        Top = 323
        TabOrder = 24
        ExplicitLeft = 855
        ExplicitTop = 323
      end
      inherited ChkCadastro: TCheckBox
        Left = 82
        Top = 474
        TabOrder = 23
        ExplicitLeft = 82
        ExplicitTop = 474
      end
      object EdtVeiculoId: TLabeledEdit
        Left = 82
        Top = 24
        Width = 111
        Height = 25
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 12
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        MaxLength = 10
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnChange = EdtVeiculoIdChange
        OnExit = EdtVeiculoIdExit
        OnKeyPress = EdtVeiculoIdKeyPress
      end
      object btnPesqVeiculo: TBitBtn
        Left = 191
        Top = 25
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
      end
      object CbProcedencia: TComboBox
        Left = 404
        Top = 24
        Width = 176
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
        Items.Strings = (
          'Importado'
          'Nacional')
      end
      object CbTipo: TComboBox
        Left = 751
        Top = 24
        Width = 176
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Items.Strings = (
          'Furg'#227'o (Fiorino)'
          #190' ou VUC (Ve'#237'culo Urbano de Carga)'
          'Caminh'#227'o Toco ou caminh'#227'o semipesado'
          'Truck ou caminh'#227'o pesado'
          'Bitruck'
          'Carreta com dois eixos at'#233' 18,15m e 33ton.'
          
            'Carreta 3 eixos dois Eixos e semi-reboque triplo at'#233' 18,15m e 42' +
            'ton.'
          'Carreta cavalo trucado tr'#234's eixo at'#233' 18,15m e 45ton.'
          'Bitrem Articulado 7 eixos ate 57 ton.'
          'Rodotrem 9 eixos at'#233' 74 ton.')
      end
      object CbMarca: TComboBox
        Left = 82
        Top = 70
        Width = 176
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
        Items.Strings = (
          'Agrale'
          'Ford '
          'HYUNDAI '
          'IVECO '
          'KIA  '
          'MB  '
          'Renault '
          'Scania '
          'Volks '
          'Volvo '
          'Outros')
      end
      object CbModelo: TComboBox
        Left = 404
        Top = 70
        Width = 176
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Items.Strings = (
          '710 PLUS'
          'Tector 170 E 25'
          'Tector 240 E 25 6X2'
          'Tector 260 E 25 6X4'
          '13 000'
          '13.180 E'
          '13.180 EURO III'
          '13.180'
          '1300 6X2'
          '1317E'
          '15.180 EURO III'
          '15.180E'
          '15.210 4X4'
          '1517E'
          '17.180 Euro III'
          '17.220 Euro III'
          '17.220'
          '17.250 E'
          '19.320 Titan Tractor'
          '19.370 4X2'
          '24.220 Euro III'
          '24.250 E'
          '2423 B'
          '2423 K'
          '2425'
          '2428'
          '25.370'
          '26.220 Euro III'
          '26.260 E'
          '31.260 E'
          '31.260'
          '31.320'
          '31.370'
          '313 CDI'
          '413 CDI'
          '5-140 E Delivery'
          '6000 E- MEC'
          '8.120 EURO III'
          '8.150 DELIVERY'
          '8500 E-MEC'
          '8500 E-TRONIC'
          '9.150 E'
          '9200 E-TRONIC'
          'ACELLO 715 C'
          'ACELLO 915 C'
          'Actros 4144 8X4'
          'ATEGO 1315'
          'ATEGO 1418'
          'ATEGO 1518'
          'ATEGO 1718'
          'ATEGO 1725 4X4'
          'ATEGO 1725'
          'Atego 1728'
          'Axor 1933'
          'Axor 2035 / 2040 / 2044'
          'Axor 2533 6X2'
          'Axor 2540 / 2544 6X2'
          'Axor 2640 / 2644 6X4'
          'Axor 2826'
          'Axor 2831'
          'Axor 3340 / 3344 Basculante'
          'Axor 3340 / 3344 Plataforma'
          'Axor 3340 / 3544'
          'Axor 4140'
          'Axor 4144'
          'BONGO K 2500'
          'BONGO K 2700'
          'Cargo 1717E'
          'Cargo 1722E'
          'Cargo 2422 E'
          'Cargo 2428 E'
          'Cargo 2622 E'
          'Cargo 2628 E'
          'Cargo 4532E Maxion'
          'Cargo 6332 E'
          'CARGO 712'
          'CARGO 815E'
          'Constelallation 17.250'
          'Constelallation 24.250'
          'DAILY 35 S 14'
          'DAILY 40 S 14'
          'DAILY 55 S 16'
          'DAILY 70 C 16'
          'Eurocargo 450E32T Cavallino'
          'Eurocargo Tector 170 E 22'
          'Eurocargo Tector 230 E 24'
          'Eurocargo Tector 250 E 22'
          'F-350 CD EUROMEC'
          'F-350 EUROMEC'
          'F4000 / F4000 4x4'
          'FH 400 4X2 / 6X2 / 6X4'
          'FH 400 4X2 / 6X2 / 6X4'
          'FM 370 4X2 / 6X2'
          'FM 400 4X2 / 6X2 / 6X4'
          'FM 400 6X4 / 8X4'
          'FM 440 6X4 / 8X4'
          'FM 480 6X4 / 8X4'
          'G 380 4X2 / 6X2'
          'G 420 4X2 / 6X2 / 6X4'
          'G 420 6X4'
          'G 420 8X4'
          'G 440 4X2 / 6X2 / 6X4'
          'G 470 4X2 / 6X2 / 6X4'
          'G 470 6X4'
          'G 470 8X4'
          'HD/LD'
          'L 1328'
          'L 1620 6X2'
          'Master'
          'P 230 4X2'
          'P 270 4X2'
          'P 270 6X2'
          'P 310 4X2'
          'P 310 6X4'
          'P 310 8X4'
          'P 340 4X2'
          'P 340 6X4'
          'P 380 6X4'
          'P 420 6X4'
          'P420 8X4'
          'R 420 4X2 / 6X2 / 6X4'
          'R 440 4X2 / 6X2 / 6X4'
          'R 470 4X2 / 6X2 / 6X4'
          'R 500 4X2 / 6X2 / 6X4'
          'Stralis 490 S 38 T'
          'Stralis 490 S 42 T'
          'Stralis 570 S 38 T'
          'Stralis 570 S 42 T'
          'Stralis 740 S 42 TZ'
          'Tector 170E25T'
          'Tranker 380 T 38'
          'Tranker 380 T 42'
          'Tranker 720 S 42 TZ'
          'VM 210 4X2 / 6X2'
          'VM 260 4X2 / 6X2'
          'VM 260 6X4'
          'VM 310 6X4'
          'VM 310'
          'N'#227'o definido')
      end
      object CbAnoFabricacao: TComboBox
        Left = 751
        Top = 70
        Width = 52
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Items.Strings = (
          '1970'
          '1971'
          '1972'
          '1973'
          '1974'
          '1975'
          '1976'
          '1977'
          '1978'
          '1979'
          '1980'
          '1981'
          '1982'
          '1983'
          '1984'
          '1985'
          '1986'
          '1987'
          '1988'
          '1989'
          '1990'
          '1991'
          '1992'
          '1993'
          '1994'
          '1995'
          '1996'
          '1997'
          '1998'
          '1999'
          '2000'
          '2001'
          '2002'
          '2003'
          '2004'
          '2005'
          '2006'
          '2007'
          '2008'
          '2009'
          '2010'
          '2011'
          '2012'
          '2013'
          '2014'
          '2015'
          '2016'
          '2017'
          '2018'
          '2019'
          '2020'
          '2021')
      end
      object CbAnoModelo: TComboBox
        Left = 804
        Top = 70
        Width = 52
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Items.Strings = (
          '1970'
          '1971'
          '1972'
          '1973'
          '1974'
          '1975'
          '1976'
          '1977'
          '1978'
          '1979'
          '1980'
          '1981'
          '1982'
          '1983'
          '1984'
          '1985'
          '1986'
          '1987'
          '1988'
          '1989'
          '1990'
          '1991'
          '1992'
          '1993'
          '1994'
          '1995'
          '1996'
          '1997'
          '1998'
          '1999'
          '2000'
          '2001'
          '2002'
          '2003'
          '2004'
          '2005'
          '2006'
          '2007'
          '2008'
          '2009'
          '2010'
          '2011'
          '2012'
          '2013'
          '2014'
          '2015'
          '2016'
          '2017'
          '2018'
          '2019'
          '2020'
          '2021')
      end
      object CbChassiTipo: TComboBox
        Left = 404
        Top = 116
        Width = 176
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        Items.Strings = (
          'Monobloco'
          'Monobloco Estruturado'
          'T'#250'nel Central'
          'Chassi Longarinas'
          'SubChassi')
      end
      object EdtChassiNumero: TEdit
        Left = 751
        Top = 116
        Width = 176
        Height = 25
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object EdtPlaca: TEdit
        Left = 82
        Top = 160
        Width = 105
        Height = 25
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 11
      end
      object CbCarroceria: TComboBox
        Left = 82
        Top = 116
        Width = 176
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
        Items.Strings = (
          'Aberta - Grade Baixa'
          'Aberta - Grade Alta(Graneleiro)'
          'Fechada - Ba'#250
          'Fechada - Ba'#250' Frigorifico'
          'Fechada - Ba'#250' Lonado(Sider)'
          'Carga - A Granel'
          'Carga - Embaladas'
          'Carga - Especiais')
      end
      object EdtRenavam: TEdit
        Left = 404
        Top = 160
        Width = 176
        Height = 25
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
      end
      object EdtMotoNumero: TEdit
        Left = 751
        Top = 160
        Width = 176
        Height = 25
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
      end
      object CbCor: TComboBox
        Left = 82
        Top = 206
        Width = 105
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        Items.Strings = (
          'Branco'
          'Prata Bari'
          'Preto'
          'Cinza'
          'Vermelho'
          'Azul'
          'Marrom'
          'Verde'
          'Amarelo')
      end
      object CbCombustivel: TComboBox
        Left = 404
        Top = 206
        Width = 105
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        Items.Strings = (
          'Etanol'
          'Diesel'
          'Flex(Gas/Etanol)'
          'Gasolina')
      end
      object GroupBox2: TGroupBox
        Left = 15
        Top = 241
        Width = 1015
        Height = 61
        CustomHint = BalloonHint1
        Caption = ' [ Cubagem ] '
        TabOrder = 16
        object Label16: TLabel
          Left = 51
          Top = 27
          Width = 53
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Altura(m)'
        end
        object Label17: TLabel
          Left = 246
          Top = 27
          Width = 64
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Largura(m)'
        end
        object Label18: TLabel
          Left = 439
          Top = 27
          Width = 99
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Comprimento(m)'
        end
        object Label19: TLabel
          Left = 673
          Top = 29
          Width = 69
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Volume(m3)'
        end
        object Label20: TLabel
          Left = 849
          Top = 27
          Width = 112
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Aproveitamento(%)'
        end
        object EdtAltura: TJvCalcEdit
          Left = 118
          Top = 24
          Width = 54
          Height = 25
          CustomHint = BalloonHint1
          DisplayFormat = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
          OnChange = EdtAlturaChange
        end
        object EdtLargura: TJvCalcEdit
          Left = 321
          Top = 23
          Width = 54
          Height = 25
          CustomHint = BalloonHint1
          DisplayFormat = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = False
          OnChange = EdtAlturaChange
        end
        object EdtComprimento: TJvCalcEdit
          Left = 548
          Top = 23
          Width = 54
          Height = 25
          CustomHint = BalloonHint1
          DisplayFormat = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          OnChange = EdtAlturaChange
        end
        object EdtVolume: TJvCalcEdit
          Left = 752
          Top = 24
          Width = 68
          Height = 25
          CustomHint = BalloonHint1
          TabStop = False
          DecimalPlaces = 0
          DisplayFormat = ',0.00'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = False
        end
        object EdtAproveitamento: TJvCalcEdit
          Left = 966
          Top = 23
          Width = 40
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxValue = 100.000000000000000000
          ParentFont = False
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = False
        end
      end
      object EdtCapacidade: TJvCalcEdit
        Left = 418
        Top = 320
        Width = 91
        Height = 25
        CustomHint = BalloonHint1
        DecimalPlaces = 3
        DisplayFormat = ',0.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ShowButton = False
        TabOrder = 18
        DecimalPlacesAlwaysShown = False
      end
      object EdtTara: TJvCalcEdit
        Left = 82
        Top = 320
        Width = 105
        Height = 25
        CustomHint = BalloonHint1
        DecimalPlaces = 3
        DisplayFormat = ',0.000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ShowButton = False
        TabOrder = 17
        DecimalPlacesAlwaysShown = False
      end
      object ChkRastreado: TCheckBox
        Left = 82
        Top = 364
        Width = 160
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Rastreador/Bloqueador'
        TabOrder = 19
        OnClick = ChkCadastroClick
      end
      object ChkSegurado: TCheckBox
        Left = 82
        Top = 392
        Width = 160
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Segurado'
        TabOrder = 20
        OnClick = ChkCadastroClick
      end
      object EdtTransportadoraId: TLabeledEdit
        Left = 133
        Top = 426
        Width = 111
        Height = 25
        CustomHint = BalloonHint1
        Ctl3D = True
        EditLabel.Width = 106
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Transportadora Id'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        LabelPosition = lpLeft
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 21
        OnExit = EdtTransportadoraIdExit
        OnKeyPress = EdtVeiculoIdKeyPress
        OnKeyUp = EdtTransportadoraIdKeyUp
      end
      object BtnPesqTransportadora: TBitBtn
        Left = 242
        Top = 427
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
          000000000000000000003B80E2E23B80E2E20000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000003D7DDBDB277FFFFF277FFFFF3C7FE1E10000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF3A81E7E7000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00003D7DDBDB277FFFFF277FFFFF277FFFFF3A81E7E70000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF3A81E7E700000000000000000000
          0000000000000000000000000000000000000000000000000000000000003D7D
          DBDB277FFFFF277FFFFF277FFFFF3A81E7E7000000000000000000000000277F
          FFFF277FFFFF0000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000003D7DDBDB277F
          FFFF277FFFFF277FFFFF3A81E7E700000000000000000000000000000000277F
          FFFF277FFFFF000000000000000000000000000000001A2940403C7FE3E32A80
          FEFE277FFFFF277FFFFF2A80FEFE3C7FE1E118263B3B18263B3B277FFFFF277F
          FFFF277FFFFF3B80E2E20000000000000000000000000000000000000000277F
          FFFF277FFFFF0000000000000000000000003B6DB6B6277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF3B80E2E2000000000000000000000000000000000000000000000000277F
          FFFF3B80E2E200000000000000003B6DB6B6277FFFFF277FFFFF3082FAFA355D
          97970F1723230F172323355E99993082FAFA277FFFFF277FFFFF277FFFFF1A29
          4040000000000000000000000000000000000000000000000000000000003B80
          E2E200000000000000001B2B4242277FFFFF277FFFFF3C7EDDDD000000000000
          0000000000000000000000000000000000003C7FDFDF277FFFFF277FFFFF1B2B
          4242000000000000000000000000000000000000000000000000000000000000
          000000000000000000003B80E5E5277FFFFF3182FAFA00000000000000000000
          000000000000000000000000000000000000000000003082FAFA277FFFFF3C7F
          E3E3000000000000000000000000000000000000000000000000000000000000
          000000000000000000002880FFFF277FFFFF355C969600000000000000000000
          00000000000000000000000000000000000000000000355E9999277FFFFF297F
          FEFE000000000000000000000000000000000000000000000000000000000000
          00000000000000000000277FFFFF277FFFFF0F17232300000000000000000000
          0000000000000000000000000000000000000000000010192626277FFFFF277F
          FFFF000000000000000000000000000000000000000000000000000000000000
          00000000000000000000277FFFFF277FFFFF0F17232300000000000000000000
          0000000000000000000000000000000000000000000010192626277FFFFF277F
          FFFF000000000000000000000000000000000000000000000000000000000000
          000000000000000000002980FFFF277FFFFF345B949400000000000000000000
          00000000000000000000000000000000000000000000355D9797277FFFFF2A80
          FEFE000000000000000000000000000000000000000000000000000000000000
          000000000000000000003B80E6E6277FFFFF3183F9F900000000000000000000
          000000000000000000000000000000000000000000003082FAFA277FFFFF3C7F
          E3E3000000000000000000000000000000000000000000000000000000003B80
          E2E200000000000000001C2E4747277FFFFF277FFFFF3D7DDBDB000000000000
          0000000000000000000000000000000000003C7EDDDD277FFFFF277FFFFF1826
          3B3B00000000000000003B80E2E200000000000000000000000000000000277F
          FFFF3B80E2E200000000000000003B6FBBBB277FFFFF277FFFFF3183F9F9345B
          94940D1520200D152020355C96963182FAFA277FFFFF277FFFFF3B6CB4B40000
          0000000000003B80E2E2277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF0000000000000000000000003B6EB8B8277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF3B6CB4B4000000000000
          000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF000000000000000000000000000000001C2D45453B80E5E52980
          FFFF277FFFFF277FFFFF2A80FEFE3B80E4E419273D3D00000000000000000000
          000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF3C7FE1E100000000000000000000
          000000000000000000000000000000000000000000003D7DDBDB277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF3C7FE1E1000000000000
          0000000000000000000000000000000000003D7DDBDB277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 22
        TabStop = False
        OnClick = BtnPesqTransportadoraClick
      end
    end
  end
end
