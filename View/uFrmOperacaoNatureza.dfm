inherited FrmOperacaoNatureza: TFrmOperacaoNatureza
  Caption = 'Tipo das Opera'#231#245'es'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
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
        Top = 174
        Visible = False
        ExplicitLeft = 132
        ExplicitTop = 174
      end
      inherited PnlInfo: TPanel
        TabOrder = 3
      end
      inherited ChkCadastro: TCheckBox
        Left = 79
        Top = 178
        TabOrder = 4
        Visible = False
        ExplicitLeft = 79
        ExplicitTop = 178
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
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralId: TIntegerField
      FieldName = 'Id'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
    end
    object FdMemPesqGeralTipo: TStringField
      FieldName = 'Tipo'
      Size = 1
    end
  end
end
