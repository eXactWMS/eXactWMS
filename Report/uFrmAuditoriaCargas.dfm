inherited FrmAuditoriaCargas: TFrmAuditoriaCargas
  Caption = 'FrmAuditoriaCargas'
  ClientHeight = 910
  ClientWidth = 1427
  ExplicitWidth = 1429
  ExplicitHeight = 912
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1428
    Height = 855
    ExplicitWidth = 1428
    ExplicitHeight = 855
    ClientRectBottom = 855
    ClientRectRight = 1428
    inherited TabListagem: TcxTabSheet
      ExplicitWidth = 1428
      ExplicitHeight = 831
      inherited LstCadastro: TAdvStringGrid
        Width = 1408
        Height = 793
        ExplicitWidth = 1408
        ExplicitHeight = 793
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 793
        ExplicitHeight = 793
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1428
        ExplicitWidth = 1428
        inherited BtnPesqConsGeral: TsImage
          Left = 869
          ExplicitLeft = 869
        end
        inherited LblClearFilter: TLabel
          Left = 904
          ExplicitLeft = 904
        end
        inherited LblRegTit: TLabel
          Left = 1108
          ExplicitLeft = 1108
        end
        inherited LblTotReg: TLabel
          Left = 1244
          ExplicitLeft = 1244
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 527
          ExplicitWidth = 527
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1428
      ExplicitHeight = 831
      inherited LblTotRegCaption: TLabel
        Left = 12
        Top = 152
        ExplicitLeft = 12
        ExplicitTop = 152
      end
      inherited LblTotRegistro: TLabel
        Left = 135
        Top = 152
        ExplicitLeft = 135
        ExplicitTop = 152
      end
      object Label30: TLabel [3]
        Left = 12
        Top = 26
        Width = 50
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Carga Id'
      end
      object LblCargaAC: TLabel [4]
        Left = 140
        Top = 27
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
      object Label32: TLabel [5]
        Left = 426
        Top = 27
        Width = 42
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Rota Id'
      end
      object LblRotaAC: TLabel [6]
        Left = 534
        Top = 27
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
      object Label33: TLabel [7]
        Left = 965
        Top = 26
        Width = 51
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Dt.Carga'
      end
      object LblCubagemAC: TLabel [8]
        Left = 490
        Top = 152
        Width = 91
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Cubagem Total:'
      end
      object LblCubagemTotalAC: TLabel [9]
        Left = 590
        Top = 152
        Width = 7
        Height = 17
        CustomHint = BalloonHint1
        BiDiMode = bdLeftToRight
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      inherited PnlInfo: TPanel
        Top = 645
        ExplicitTop = 645
      end
      inherited LstReport: TAdvStringGrid
        Top = 175
        Width = 1428
        Height = 656
        ColCount = 14
        ColumnHeaders.Strings = (
          'Pedido'
          'Volume'
          'Embalagem'
          'C'#243'digo'
          'Descri'#231#227'o'
          'Qtd.Suprida'
          'Alt.(cm)'
          'Larg.(cm)'
          'Compr.(cm)'
          'Volume(cm)'
          'Vlm.Total(cm)'
          'Vlm.Total(m3)'
          'PesoTotal(g)'
          'PesoTotal(kg)')
        ExplicitTop = 175
        ExplicitWidth = 1428
        ExplicitHeight = 656
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
      object EdtCargaIdAC: TJvCalcEdit
        Left = 68
        Top = 20
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
        TabOrder = 3
        DecimalPlacesAlwaysShown = False
        OnChange = EdtCargaIdACChange
        OnExit = EdtCargaIdACExit
      end
      object BitBtn4: TBitBtn
        Left = 185
        Top = 20
        Width = 29
        Height = 29
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
        Visible = False
        OnClick = BitBtn4Click
      end
      object EdtRotaIdAC: TJvCalcEdit
        Left = 474
        Top = 20
        Width = 53
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
      object EdtDtCargaAC: TJvDateEdit
        Left = 1022
        Top = 22
        Width = 115
        Height = 27
        CustomHint = BalloonHint1
        TabStop = False
        CheckOnExit = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ShowNullDate = False
        TabOrder = 6
      end
      object GroupBox4: TGroupBox
        Left = 18
        Top = 64
        Width = 1126
        Height = 74
        CustomHint = BalloonHint1
        Caption = ' [ Transporte ] '
        TabOrder = 7
        object Label23: TLabel
          Left = 8
          Top = 24
          Width = 106
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Transportadora Id'
        end
        object LblTransportadoraAC: TLabel
          Left = 120
          Top = 55
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
        object Label25: TLabel
          Left = 400
          Top = 24
          Width = 56
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Ve'#237'culo Id'
        end
        object LblVeiculoAC: TLabel
          Left = 465
          Top = 53
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
        object Label27: TLabel
          Left = 771
          Top = 24
          Width = 72
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Motorista Id'
        end
        object LblMotoristaAC: TLabel
          Left = 849
          Top = 55
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
        object LblVeiculoCapacidadeAC: TLabel
          Left = 558
          Top = 26
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
        object EdtTransportadoraIdAC: TJvCalcEdit
          Left = 120
          Top = 20
          Width = 86
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
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
        end
        object EdtMotoristaIdAC: TJvCalcEdit
          Left = 849
          Top = 20
          Width = 86
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
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
        end
        object EdtVeiculoIdAC: TEdit
          Left = 462
          Top = 18
          Width = 90
          Height = 29
          CustomHint = BalloonHint1
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitWidth = 1428
      ExplicitHeight = 831
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitWidth = 1428
      ExplicitHeight = 831
      inherited DbgImporta: TDBGrid
        Width = 1428
        Height = 627
      end
    end
  end
  inherited PnHeader: TPanel
    Width = 1427
    ExplicitWidth = 1427
    inherited ImgClose: TImage
      Left = 1394
      ExplicitLeft = 1394
    end
    inherited ImgMinimize: TImage
      Left = 1374
      ExplicitLeft = 1374
    end
    inherited PanWin8: TPanel
      Width = 1427
      ExplicitWidth = 1427
      inherited BtnFechar: TsImage
        Left = 245
        ExplicitLeft = 245
      end
      inherited BtnPesquisarStand: TsImage
        Left = 505
        Visible = False
        ExplicitLeft = 505
      end
      inherited BtnImprimirStand: TsImage
        Left = 62
        ExplicitLeft = 62
      end
      inherited BtnExportarStand: TsImage
        Left = 108
        ExplicitLeft = 108
      end
      inherited BtnExportarPDF: TsImage
        Left = 153
        ExplicitLeft = 153
      end
      inherited BtnImportarStand: TsImage
        Left = 199
        ExplicitLeft = 199
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1219
    ExplicitLeft = 1219
  end
  inherited PnlErro: TPanel
    Top = 888
    Width = 1427
    ExplicitTop = 888
    ExplicitWidth = 1427
    inherited LblMensShowErro: TLabel
      Width = 1427
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 915
    Top = 292
    ExplicitLeft = 915
    ExplicitTop = 292
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
