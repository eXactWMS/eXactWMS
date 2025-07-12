inherited FrmLaboratorio: TFrmLaboratorio
  Caption = 'FrmLaboratorio'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      inherited LstCadastro: TAdvStringGrid
        RowIndicator.Data = {
          76020000424D760200000000000036000000280000000C0000000C0000000100
          2000000000004002000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000277FFF40000000000000000000000000277FFF40277F
          FFFF277FFF400000000000000000000000000000000000000000277FFFFF277F
          FFBF0000000000000000277FFF80277FFFFF277FFF7F0000000000000000277F
          FFBF277FFFFF277FFFFF277FFFFF277FFFFF277FFFBF00000000277FFF80277F
          FFFF277FFF7F0000000000000000277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFBF277FFF80277FFFFF277FFF7F0000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFBF277FFF80277F
          FFFF277FFF7F0000000000000000277FFFBF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFBF00000000277FFF80277FFFFF277FFF7F00000000000000000000
          00000000000000000000277FFFFF277FFFBF0000000000000000277FFF80277F
          FFFF277FFF7F0000000000000000000000000000000000000000277FFF400000
          00000000000000000000277FFF40277FFFFF277FFF4000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          ItemIndex = 0
          Text = 'Id'
          Items.Strings = (
            'Id'
            'Nome')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      inherited ShCadastro: TShape
        Left = 132
        Top = 235
        ExplicitLeft = 132
        ExplicitTop = 235
      end
      inherited PnlInfo: TPanel
        TabOrder = 5
      end
      inherited ChkCadastro: TCheckBox
        Left = 79
        Top = 239
        TabOrder = 6
        ExplicitLeft = 79
        ExplicitTop = 239
      end
      object EdtHomePage: TLabeledEdit
        Left = 79
        Top = 189
        Width = 584
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
        TabOrder = 4
        OnEnter = edtCodigoEnter
        OnExit = EdtNomeExit
      end
      object EdtEmail: TLabeledEdit
        Left = 79
        Top = 132
        Width = 584
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
        TabOrder = 3
        OnEnter = edtCodigoEnter
        OnExit = EdtNomeExit
      end
      object EdtFone: TLabeledEdit
        Left = 487
        Top = 76
        Width = 176
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
        TabOrder = 2
        OnEnter = edtCodigoEnter
        OnExit = EdtNomeExit
        OnKeyPress = EdtFoneKeyPress
      end
      object EdtNome: TLabeledEdit
        Left = 79
        Top = 76
        Width = 358
        Height = 24
        CustomHint = BalloonHint1
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
        TabOrder = 1
        OnEnter = edtCodigoEnter
        OnExit = EdtNomeExit
      end
      object edtCodigo: TLabeledEdit
        Left = 79
        Top = 25
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
        ParentCtl3D = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnChange = edtCodigoChange
        OnEnter = edtCodigoEnter
        OnExit = edtCodigoExit
        OnKeyPress = edtCodigoKeyPress
      end
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnExcluir: TsImage
        Left = 163
        ExplicitLeft = 163
      end
      inherited BtnImportarStand: TsImage
        Left = 485
        Top = 5
        ExplicitLeft = 485
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
    Left = 338
    Top = 283
    ExplicitLeft = 338
    ExplicitTop = 283
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited BalloonHint1: TBalloonHint
    Left = 560
    Top = 113
  end
  inherited FdMemPesqGeral: TFDMemTable
    Left = 275
    Top = 330
    object FdMemPesqGeralidlaboratorio: TIntegerField
      FieldName = 'idlaboratorio'
    end
    object FdMemPesqGeralNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object FdMemPesqGeralFone: TStringField
      FieldName = 'Fone'
      Size = 11
    end
    object FdMemPesqGeralEmail: TStringField
      FieldName = 'Email'
      Size = 100
    end
    object FdMemPesqGeralhomepage: TStringField
      FieldName = 'homepage'
      Size = 100
    end
    object FdMemPesqGeralStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
