inherited FrmDashRotaProducao: TFrmDashRotaProducao
  Caption = 'FrmDashRotaProducao'
  ClientHeight = 720
  StyleElements = [seFont, seClient, seBorder]
  ExplicitHeight = 722
  TextHeight = 17
  inherited LblPaginacao: TLabel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited SpPaginacao: TJvSpinEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited PgcBase: TcxPageControl
    Height = 665
    ExplicitHeight = 665
    ClientRectBottom = 665
    inherited TabListagem: TcxTabSheet
      ExplicitHeight = 641
      inherited LstCadastro: TAdvStringGrid
        Height = 603
        ExplicitHeight = 603
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 603
        ExplicitHeight = 603
        TMSStyle = 8
      end
      inherited PnlPesquisaCadastro: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited Label1: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited LblClearFilter: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited LblRegTit: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited LblTotReg: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited CbCampoPesq: TComboBox
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited EdtConteudoPesq: TLabeledEdit
          StyleElements = [seFont, seClient, seBorder]
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitHeight = 641
      inherited LblTotRegCaption: TLabel
        Left = 222
        Top = 460
        Visible = False
        StyleElements = [seFont, seClient, seBorder]
        ExplicitLeft = 222
        ExplicitTop = 460
      end
      inherited LblTotRegistro: TLabel
        Left = 345
        Top = 460
        Visible = False
        StyleElements = [seFont, seClient, seBorder]
        ExplicitLeft = 345
        ExplicitTop = 460
      end
      inherited PnlInfo: TPanel
        Top = 555
        Height = 84
        StyleElements = [seFont, seClient, seBorder]
        ExplicitTop = 555
        ExplicitHeight = 84
        inherited LblInfo02: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited LblInfo10: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited LblInfo08: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited LblInfo11: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited LblInfo12: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
      end
      inherited LstReport: TAdvStringGrid
        Top = 398
        Height = 126
        Align = alNone
        Visible = False
        ExplicitTop = 398
        ExplicitHeight = 126
      end
      object PnlGrafico: TPanel
        Left = 0
        Top = 76
        Width = 1157
        Height = 565
        CustomHint = BalloonHint1
        Align = alClient
        Caption = 'PnlGrafico'
        TabOrder = 3
        object WebBrowser1: TWebBrowser
          Left = 351
          Top = 1
          Width = 805
          Height = 563
          CustomHint = FrmEntrada.BalloonHint1
          Align = alClient
          TabOrder = 0
          ExplicitTop = 2
          ControlData = {
            4C00000033530000303A00000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E126208000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
        object PnlCard: TPanel
          Left = 1
          Top = 1
          Width = 350
          Height = 563
          CustomHint = BalloonHint1
          Align = alLeft
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          TabOrder = 1
          object WebBrowser2: TWebBrowser
            Left = 1
            Top = 1
            Width = 348
            Height = 561
            CustomHint = FrmEntrada.BalloonHint1
            Align = alClient
            TabOrder = 0
            ExplicitLeft = 2
            ControlData = {
              4C000000F8230000FB3900000000000000000000000000000000000000000000
              000000004C000000000000000000000001000000E0D057007335CF11AE690800
              2B2E126208000000000000004C0000000114020000000000C000000000000046
              8000000000000000000000000000000000000000000000000000000000000000
              00000000000000000100000000000000000000000000000000000000}
          end
        end
      end
      object PnlTopFilter: TPanel
        Left = 0
        Top = 0
        Width = 1157
        Height = 76
        CustomHint = BalloonHint1
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 4
        object GroupBox14: TGroupBox
          Left = 5
          Top = 9
          Width = 345
          Height = 59
          CustomHint = BalloonHint1
          Caption = ' [ Data Pedidos ] '
          TabOrder = 0
          TabStop = True
          object Label45: TLabel
            Left = 22
            Top = 25
            Width = 30
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'In'#237'cio'
          end
          object Label46: TLabel
            Left = 189
            Top = 24
            Width = 47
            Height = 17
            CustomHint = BalloonHint1
            Caption = 'T'#233'rmino'
          end
          object EdtDtPedidoInicial: TJvDateEdit
            Left = 58
            Top = 23
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
          end
          object EdtDtPedidoFinal: TJvDateEdit
            Left = 242
            Top = 23
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
          end
        end
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 641
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 641
      inherited LblArqImport: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited LblAguardeImportacaoCSV: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited LblImportaCSV: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited DbgImporta: TDBGrid
        Height = 437
      end
      inherited EdtFileIimport: TEdit
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited MmImporta: TMemo
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited PnHeader: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited LblForm: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited PanWin8: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited EdtPesq: TLabeledEdit
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited PnlBotImgObjeto: TPanel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited PnlErro: TPanel
    Top = 698
    StyleElements = [seFont, seClient, seBorder]
    ExplicitTop = 698
    inherited LblMensShowErro: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 659
    Top = 82
    StyleElements = [seFont, seClient, seBorder]
    ExplicitLeft = 659
    ExplicitTop = 82
    inherited LblLanguagePrinter: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited LblPortConfigPrinter: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited LblAlertaConfigPrinter: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited CbModeloConfigPrinter: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited CbPortaConfigPrinter: TComboBox
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited Panel7: TPanel
      StyleElements = [seFont, seClient, seBorder]
      inherited LblTitConfigPrinter: TLabel
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    Left = 41
    Top = 395
    object FdMemPesqGeralRota: TStringField
      FieldName = 'Rota'
      Size = 30
    end
    object FdMemPesqGeralDemanda: TStringField
      FieldName = 'Demanda'
      Size = 60
    end
    object FdMemPesqGeralProducao: TStringField
      FieldName = 'Producao'
      Size = 60
    end
  end
  inherited TmImportacaoCSV: TTimer
    Left = 381
    Top = 197
  end
  inherited frxDBDataset1: TfrxDBDataset
    Left = 382
    Top = 391
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
    Watermarks = <>
  end
  object WebCharts1: TWebCharts
    Left = 522
    Top = 210
  end
  object FdMemDashBoard01Unidades: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 231
    Top = 202
    object FdMemDashBoard01UnidadesLabel: TStringField
      FieldName = 'Label'
      Size = 30
    end
    object FdMemDashBoard01UnidadesValue: TIntegerField
      FieldName = 'Value'
    end
    object FdMemDashBoard01UnidadesRGB: TStringField
      FieldName = 'RGB'
      Size = 15
    end
  end
  object FdMemDashBoard02Unidades: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 225
    Top = 254
    object StringField1: TStringField
      FieldName = 'Label'
      Size = 30
    end
    object IntegerField1: TIntegerField
      FieldName = 'Value'
    end
    object StringField2: TStringField
      FieldName = 'RGB'
      Size = 15
    end
  end
  object FdMemDashBoard03Unidades: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 229
    Top = 316
    object StringField3: TStringField
      FieldName = 'Label'
      Size = 30
    end
    object IntegerField2: TIntegerField
      FieldName = 'Value'
    end
    object StringField4: TStringField
      FieldName = 'RGB'
      Size = 15
    end
  end
  object FdMemDashBoard01Volumes: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 29
    Top = 188
    object StringField5: TStringField
      FieldName = 'Label'
      Size = 30
    end
    object IntegerField3: TIntegerField
      FieldName = 'Value'
    end
    object StringField6: TStringField
      FieldName = 'RGB'
      Size = 15
    end
  end
  object FdMemDashBoard02Volumes: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 27
    Top = 242
    object StringField7: TStringField
      FieldName = 'Label'
      Size = 30
    end
    object IntegerField4: TIntegerField
      FieldName = 'Value'
    end
    object StringField8: TStringField
      FieldName = 'RGB'
      Size = 15
    end
  end
  object FdMemDashBoard03Volumes: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 31
    Top = 304
    object StringField9: TStringField
      FieldName = 'Label'
      Size = 30
    end
    object IntegerField5: TIntegerField
      FieldName = 'Value'
    end
    object StringField10: TStringField
      FieldName = 'RGB'
      Size = 15
    end
  end
end
