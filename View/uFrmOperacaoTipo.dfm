inherited FrmOperacaoTipo: TFrmOperacaoTipo
  Caption = 'Naureza da Opera'#231#227'o'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
    end
    inherited TabPrincipal: TcxTabSheet
      object Label2: TLabel [0]
        Left = 48
        Top = 80
        Width = 26
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Tipo'
      end
      inherited ShCadastro: TShape
        Left = 132
        Top = 179
        ExplicitLeft = 132
        ExplicitTop = 179
      end
      inherited PnlInfo: TPanel
        TabOrder = 4
      end
      inherited ChkCadastro: TCheckBox
        Left = 79
        Top = 183
        TabOrder = 3
        ExplicitLeft = 79
        ExplicitTop = 183
      end
      object edtCodigo: TLabeledEdit
        Left = 79
        Top = 24
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
        TabOrder = 0
        OnChange = edtCodigoChange
        OnEnter = edtCodigoEnter
        OnExit = edtCodigoExit
        OnKeyPress = edtCodigoKeyPress
      end
      object CbOperacaoTipo: TComboBox
        Left = 79
        Top = 77
        Width = 145
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        TabOrder = 1
        OnClick = CbOperacaoTipoClick
        OnEnter = edtCodigoEnter
        Items.Strings = (
          'Cliente'
          'Fornecedor'
          'Colaborador')
      end
      object EdtDescricao: TLabeledEdit
        Left = 79
        Top = 128
        Width = 323
        Height = 24
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight]
        Ctl3D = True
        EditLabel.Width = 57
        EditLabel.Height = 17
        EditLabel.CustomHint = BalloonHint1
        EditLabel.Caption = 'Descri'#231#227'o'
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
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralId: TIntegerField
      FieldName = 'Id'
    end
    object FdMemPesqGeralDescriccao: TStringField
      FieldName = 'Descriccao'
    end
    object FdMemPesqGeralTipoOperacaoId: TIntegerField
      FieldName = 'TipoOperacaoId'
    end
    object FdMemPesqGeralStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
