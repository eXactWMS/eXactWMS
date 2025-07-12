inherited FrmPessoaTipo: TFrmPessoaTipo
  Caption = 'FrmPessoaTipo'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      inherited LstCadastro: TAdvStringGrid
        ColCount = 3
        ColumnHeaders.Strings = (
          'Id'
          'Descri'#231#227'o'
          'Status')
        ColWidths = (
          74
          118
          74)
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
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
        Top = 172
        ExplicitLeft = 132
        ExplicitTop = 172
      end
      inherited PnlInfo: TPanel
        TabOrder = 4
      end
      inherited ChkCadastro: TCheckBox
        Left = 79
        Top = 176
        TabOrder = 3
        ExplicitLeft = 79
        ExplicitTop = 176
      end
      object edtCodigo: TLabeledEdit
        Left = 79
        Top = 25
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
        OnExit = edtCodigoExit
        OnKeyPress = edtCodigoKeyPress
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
      end
      object CbPessoaTipo: TComboBox
        Left = 79
        Top = 77
        Width = 145
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        TabOrder = 1
        Items.Strings = (
          'Cliente'
          'Fornecedor'
          'Colaborador')
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 127
      Height = 21
    end
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralId: TIntegerField
      FieldName = 'Id'
    end
    object FdMemPesqGeralIdPessoaTipo: TIntegerField
      FieldName = 'IdPessoaTipo'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object FdMemPesqGeralStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
