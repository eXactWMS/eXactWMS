inherited FrmSegregadoCausa: TFrmSegregadoCausa
  Caption = 'FrmSegregadoCausa'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabListagem
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
        Top = 143
        ExplicitTop = 143
      end
      inherited ChkCadastro: TCheckBox
        Top = 147
        ExplicitTop = 147
      end
      object EdtSegregadoCausaId: TLabeledEdit
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
        TabOrder = 2
        OnChange = EdtSegregadoCausaIdChange
        OnEnter = EdtSegregadoCausaIdEnter
        OnExit = EdtSegregadoCausaIdExit
        OnKeyPress = EdtSegregadoCausaIdKeyPress
      end
      object EdtDescricao: TLabeledEdit
        Left = 79
        Top = 86
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
        MaxLength = 80
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnEnter = EdtSegregadoCausaIdEnter
        OnExit = EdtDescricaoExit
      end
      object btnPesquisar: TBitBtn
        Left = 197
        Top = 24
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
        TabOrder = 4
        TabStop = False
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
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
end
