inherited FrmEnderecamentoRuas: TFrmEnderecamentoRuas
  Caption = 'FrmEnderecamentoRuas'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      inherited LstCadastro: TAdvStringGrid
        ColCount = 4
        ColumnHeaders.Strings = (
          'Id'
          'Descri'#231#227'o'
          'Lado'
          'Status')
        ColWidths = (
          74
          118
          74
          74)
      end
    end
    inherited TabPrincipal: TcxTabSheet
      object Label2: TLabel [1]
        Left = 70
        Top = 41
        Width = 11
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Id'
      end
      object Label3: TLabel [2]
        Left = 24
        Top = 103
        Width = 57
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Descri'#231#227'o'
      end
      object Label4: TLabel [3]
        Left = 52
        Top = 163
        Width = 29
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Lado'
      end
      object EdtRuaId: TEdit
        Left = 87
        Top = 38
        Width = 72
        Height = 25
        CustomHint = BalloonHint1
        TabStop = False
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        OnEnter = EdtDescricaoEnter
        OnExit = EdtRuaIdExit
        OnKeyPress = EdtRuaIdKeyPress
        OnKeyUp = EdtRuaIdKeyUp
      end
      object EdtDescricao: TEdit
        Left = 87
        Top = 100
        Width = 380
        Height = 25
        CustomHint = BalloonHint1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 3
        OnEnter = EdtDescricaoEnter
        OnExit = EdtDescricaoExit
      end
      object CbLado: TComboBox
        Left = 87
        Top = 160
        Width = 111
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
        OnEnter = EdtDescricaoEnter
        OnExit = EdtDescricaoExit
        Items.Strings = (
          'Impar'
          'Par'
          #218'nico')
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
end
