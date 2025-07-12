inherited FrmDesenhoArmazem: TFrmDesenhoArmazem
  Caption = 'FrmDesenhoArmazem'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
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
      inherited PnlPesquisaCadastro: TPanel
        inherited CbCampoPesq: TComboBox
          Items.Strings = (
            'Id'
            'Descri'#231#227'o')
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      inherited ShCadastro: TShape
        Left = 140
        Top = 157
        ExplicitLeft = 140
        ExplicitTop = 157
      end
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
      inherited ChkCadastro: TCheckBox
        Left = 87
        Top = 161
        ExplicitLeft = 87
        ExplicitTop = 161
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
        TabOrder = 2
        OnEnter = EdtDesenhoArmazemIdEnter
        OnExit = EdtDescricaoExit
      end
      object EdtDesenhoArmazemId: TEdit
        Left = 87
        Top = 38
        Width = 72
        Height = 25
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        OnEnter = EdtDesenhoArmazemIdEnter
        OnExit = EdtDesenhoArmazemIdExit
        OnKeyPress = EdtDesenhoArmazemIdKeyPress
        OnKeyUp = EdtDesenhoArmazemIdKeyUp
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
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 392
    Top = 122
    ExplicitLeft = 392
    ExplicitTop = 122
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
end
