inherited frmConfigurarEstacao: TfrmConfigurarEstacao
  Caption = 'Configurar Esta'#231#227'o'
  ClientHeight = 142
  ClientWidth = 164
  ExplicitWidth = 180
  ExplicitHeight = 181
  PixelsPerInch = 96
  TextHeight = 16
  object edtPorta: TLabeledEdit [0]
    Left = 8
    Top = 110
    Width = 148
    Height = 24
    Anchors = [akLeft, akRight, akBottom]
    CharCase = ecUpperCase
    Ctl3D = True
    EditLabel.Width = 30
    EditLabel.Height = 16
    EditLabel.Caption = 'Porta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
  end
  object rdgImpressora: TRadioGroup [1]
    Left = 8
    Top = 8
    Width = 148
    Height = 77
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Impressora'
    Ctl3D = False
    Items.Strings = (
      'DataMax'
      'Zebra - EPL2'
      'Zebra - ZPL2')
    ParentCtl3D = False
    TabOrder = 2
  end
  inherited PnlMenuFormStand: TPanel
    Top = 90
    Width = 164
  end
end
