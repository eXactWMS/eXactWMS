inherited FrmRelEspelhoEntrada: TFrmRelEspelhoEntrada
  Caption = 'FrmRelEspelhoEntrada'
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstReport: TAdvStringGrid
        Top = 110
        Height = 414
        ColumnHeaders.Strings = (
          'Id'
          'Cod.Erp'
          'Descri'#231#227'o'
          'Lote'
          'Vencimento'
          'Qtd.Xml'
          'Qdt.Conf.'
          'Qtd.Dev.'
          'Qrd.Segr.')
        ExplicitTop = 110
        ExplicitHeight = 414
      end
      object GroupBox1: TGroupBox
        Left = 907
        Top = 8
        Width = 249
        Height = 77
        CustomHint = BalloonHint1
        Caption = ' [ CheckIn ]'
        TabOrder = 3
        object Label2: TLabel
          Left = 23
          Top = 19
          Width = 48
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dt.Inicial'
        end
        object Label3: TLabel
          Left = 142
          Top = 19
          Width = 42
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dt.Final'
        end
        object EdtDtCheckInIni: TJvDateEdit
          Left = 21
          Top = 38
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtEntradaIdChange
          OnEnter = EdtEntradaIdEnter
          OnExit = EdtDtDoctoIniExit
        end
        object EdtDtCheckInFin: TJvDateEdit
          Left = 142
          Top = 38
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtEntradaIdChange
          OnEnter = EdtEntradaIdEnter
          OnExit = EdtDtDoctoIniExit
        end
      end
      object GroupBox2: TGroupBox
        Left = 21
        Top = 8
        Width = 568
        Height = 77
        CustomHint = BalloonHint1
        Caption = ' [ Entrada ]'
        TabOrder = 4
        object EdtEntradaId: TLabeledEdit
          Left = 9
          Top = 38
          Width = 93
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
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
          OnChange = EdtEntradaIdChange
          OnEnter = EdtEntradaIdEnter
          OnExit = EdtEntradaIdExit
          OnKeyPress = EdtEntradaIdKeyPress
        end
        object EdtDocumentoNr: TLabeledEdit
          Left = 141
          Top = 38
          Width = 89
          Height = 24
          CustomHint = BalloonHint1
          Ctl3D = True
          EditLabel.Width = 67
          EditLabel.Height = 17
          EditLabel.CustomHint = BalloonHint1
          EditLabel.Caption = 'Documento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          OnChange = EdtEntradaIdChange
          OnEnter = EdtEntradaIdEnter
          OnExit = EdtEntradaIdExit
          OnKeyPress = EdtEntradaIdKeyPress
        end
        object EdtRegistroERP: TLabeledEdit
          Left = 263
          Top = 38
          Width = 294
          Height = 24
          CustomHint = BalloonHint1
          Ctl3D = True
          EditLabel.Width = 48
          EditLabel.Height = 17
          EditLabel.CustomHint = BalloonHint1
          EditLabel.Caption = 'Reg.ERP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          OnChange = EdtEntradaIdChange
          OnEnter = EdtEntradaIdEnter
        end
      end
      object GroupBox3: TGroupBox
        Left = 625
        Top = 8
        Width = 249
        Height = 77
        CustomHint = BalloonHint1
        Caption = ' [ Documento ]'
        TabOrder = 5
        object Label4: TLabel
          Left = 23
          Top = 19
          Width = 48
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dt.Inicial'
        end
        object Label5: TLabel
          Left = 142
          Top = 19
          Width = 42
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dt.Final'
        end
        object EdtDtDoctoIni: TJvDateEdit
          Left = 21
          Top = 38
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtEntradaIdChange
          OnEnter = EdtEntradaIdEnter
          OnExit = EdtDtDoctoIniExit
        end
        object EdtDtDoctoFin: TJvDateEdit
          Left = 142
          Top = 38
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtEntradaIdChange
          OnEnter = EdtEntradaIdEnter
          OnExit = EdtDtDoctoIniExit
        end
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 857
    Top = 214
    ExplicitLeft = 857
    ExplicitTop = 214
  end
  inherited PnlErro: TPanel
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 776
    Top = 286
    ExplicitLeft = 776
    ExplicitTop = 286
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
