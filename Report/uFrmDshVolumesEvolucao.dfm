inherited FrmDshVolumesEvolucao: TFrmDshVolumesEvolucao
  Caption = 'FrmDshVolumesEvolucao'
  ClientWidth = 1224
  ExplicitWidth = 1226
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1225
    ExplicitWidth = 1225
    ClientRectRight = 1225
    inherited TabListagem: TcxTabSheet
      ExplicitWidth = 1225
      inherited LstCadastro: TAdvStringGrid
        Width = 1205
        ExplicitWidth = 1205
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1225
        ExplicitWidth = 1225
        inherited BtnPesqConsGeral: TsImage
          Left = 666
          ExplicitLeft = 666
        end
        inherited LblClearFilter: TLabel
          Left = 701
          ExplicitLeft = 701
        end
        inherited LblRegTit: TLabel
          Left = 905
          ExplicitLeft = 905
        end
        inherited LblTotReg: TLabel
          Left = 1041
          ExplicitLeft = 1041
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 324
          ExplicitWidth = 324
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1225
      ExplicitHeight = 524
      inherited LblTotRegCaption: TLabel
        Left = 8
        Top = 186
        Visible = False
        ExplicitLeft = 8
        ExplicitTop = 186
      end
      inherited LblTotRegistro: TLabel
        Left = 131
        Top = 186
        Visible = False
        ExplicitLeft = 131
        ExplicitTop = 186
      end
      object Label40: TLabel [3]
        Left = 335
        Top = 56
        Width = 90
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Tipo da An'#225'lise'
        Visible = False
      end
      object Label3: TLabel [4]
        Left = 499
        Top = 56
        Width = 66
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Atualiza'#231#227'o'
        Visible = False
      end
      inherited PnlInfo: TPanel
        TabOrder = 6
      end
      inherited ChkCadastro: TCheckBox
        TabOrder = 8
      end
      inherited LstReport: TAdvStringGrid
        Top = 254
        Width = 1225
        Height = 270
        TabOrder = 7
        Visible = False
        ExplicitTop = 254
        ExplicitWidth = 1225
        ExplicitHeight = 270
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 3
        Width = 171
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Pedidos ]'
        TabOrder = 0
        TabStop = True
        object Label2: TLabel
          Left = 22
          Top = 21
          Width = 27
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Data'
        end
        object EdtInicio: TJvDateEdit
          Left = 58
          Top = 19
          Width = 105
          Height = 24
          CustomHint = BalloonHint1
          CheckOnExit = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtInicioChange
          OnEnter = EdtInicioEnter
          OnExit = EdtInicioExit
        end
      end
      object GroupBox5: TGroupBox
        Left = 177
        Top = 3
        Width = 324
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Rota ]'
        TabOrder = 1
        object Label13: TLabel
          Left = 7
          Top = 23
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblRota: TLabel
          Left = 96
          Top = 24
          Width = 161
          Height = 16
          CustomHint = BalloonHint1
          AutoSize = False
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object EdtRotaId: TEdit
          Left = 24
          Top = 20
          Width = 45
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtRotaIdChange
          OnEnter = EdtInicioEnter
          OnExit = EdtRotaIdExit
          OnKeyPress = EdtRotaIdKeyPress
        end
        object BtnPesqRota: TBitBtn
          Left = 68
          Top = 20
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
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqRotaClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 499
        Top = 3
        Width = 426
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Destinat'#225'rio ]'
        TabOrder = 2
        TabStop = True
        object Label9: TLabel
          Left = 8
          Top = 21
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblDestinatario: TLabel
          Left = 159
          Top = 25
          Width = 12
          Height = 16
          CustomHint = BalloonHint1
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object EdtDestinatario: TEdit
          Left = 57
          Top = 19
          Width = 73
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtDestinatarioChange
          OnEnter = EdtInicioEnter
          OnExit = EdtDestinatarioExit
          OnKeyPress = EdtRotaIdKeyPress
        end
        object BtnPesqCliente: TBitBtn
          Left = 129
          Top = 19
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
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqClienteClick
        end
      end
      object GroupBox3: TGroupBox
        Left = 9
        Top = 103
        Width = 1177
        Height = 142
        CustomHint = BalloonHint1
        Caption = '[ Totalizadores ]'
        TabOrder = 9
        object PnlPendente: TPanel
          Left = 10
          Top = 25
          Width = 150
          Height = 108
          CustomHint = BalloonHint1
          Color = 11184895
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object Label4: TLabel
            Left = 1
            Top = 1
            Width = 148
            Height = 19
            CustomHint = BalloonHint1
            Align = alTop
            Alignment = taCenter
            Caption = 'Pendentes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 75
          end
          object LblPendente: TLabel
            Left = 4
            Top = 25
            Width = 148
            Height = 55
            CustomHint = BalloonHint1
            Alignment = taCenter
            AutoSize = False
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -48
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label18: TLabel
            Left = 130
            Top = 4
            Width = 16
            Height = 15
            CustomHint = BalloonHint1
            Caption = '(B)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4227327
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PgrCubagem: TGauge
            Left = 1
            Top = 89
            Width = 148
            Height = 18
            CustomHint = BalloonHint1
            Align = alBottom
            BackColor = 16117735
            BorderStyle = bsNone
            ForeColor = 33023
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Progress = 0
            ExplicitTop = 92
          end
        end
        object PnlApanhe: TPanel
          Left = 170
          Top = 25
          Width = 150
          Height = 108
          CustomHint = BalloonHint1
          Color = 11184895
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          object Label7: TLabel
            Left = 1
            Top = 1
            Width = 148
            Height = 19
            CustomHint = BalloonHint1
            Align = alTop
            Alignment = taCenter
            Caption = 'Separa'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 77
          end
          object LblApanhe: TLabel
            Left = 4
            Top = 25
            Width = 140
            Height = 55
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            CustomHint = BalloonHint1
            Alignment = taCenter
            AutoSize = False
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -48
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label19: TLabel
            Left = 128
            Top = 4
            Width = 15
            Height = 15
            CustomHint = BalloonHint1
            Caption = '(C)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4227327
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PgrApanhe: TGauge
            Left = 1
            Top = 89
            Width = 148
            Height = 18
            CustomHint = BalloonHint1
            Align = alBottom
            BackColor = 16117735
            BorderStyle = bsNone
            ForeColor = 33023
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Progress = 0
            ExplicitTop = 92
          end
        end
        object PnlCheckOut: TPanel
          Left = 331
          Top = 25
          Width = 150
          Height = 108
          CustomHint = BalloonHint1
          Color = 12320767
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
          object Label6: TLabel
            Left = 1
            Top = 1
            Width = 148
            Height = 19
            CustomHint = BalloonHint1
            Align = alTop
            Alignment = taCenter
            Caption = 'CheckOut'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 70
          end
          object LblCheckOut: TLabel
            Left = 4
            Top = 25
            Width = 140
            Height = 55
            CustomHint = BalloonHint1
            Alignment = taCenter
            AutoSize = False
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -48
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label20: TLabel
            Left = 126
            Top = 4
            Width = 17
            Height = 15
            CustomHint = BalloonHint1
            Caption = '(D)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4227327
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PgrCheckOut: TGauge
            Left = 1
            Top = 89
            Width = 148
            Height = 18
            CustomHint = BalloonHint1
            Align = alBottom
            BackColor = 16117735
            BorderStyle = bsNone
            ForeColor = 33023
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Progress = 0
            ExplicitTop = 92
          end
        end
        object PnlExpedicao: TPanel
          Left = 492
          Top = 25
          Width = 150
          Height = 108
          CustomHint = BalloonHint1
          Color = 6077044
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
          object Label15: TLabel
            Left = 1
            Top = 1
            Width = 148
            Height = 19
            CustomHint = BalloonHint1
            Align = alTop
            Alignment = taCenter
            Caption = 'Expedi'#231#227'o'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 73
          end
          object LblExpedicao: TLabel
            Left = 4
            Top = 25
            Width = 146
            Height = 55
            CustomHint = BalloonHint1
            Alignment = taCenter
            AutoSize = False
            Caption = '0'
            Color = 6077044
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -48
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentColor = False
            ParentFont = False
          end
          object Label21: TLabel
            Left = 130
            Top = 4
            Width = 14
            Height = 15
            CustomHint = BalloonHint1
            Caption = '(E)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4227327
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PgrExpedicao: TGauge
            Left = 1
            Top = 89
            Width = 148
            Height = 18
            CustomHint = BalloonHint1
            Align = alBottom
            BackColor = 16117735
            BorderStyle = bsNone
            ForeColor = 33023
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Progress = 0
            ExplicitTop = 92
          end
        end
        object PnlCortes: TPanel
          Left = 814
          Top = 25
          Width = 150
          Height = 108
          CustomHint = BalloonHint1
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
          object Label11: TLabel
            Left = 1
            Top = 1
            Width = 148
            Height = 19
            CustomHint = BalloonHint1
            Align = alTop
            Alignment = taCenter
            Caption = 'Cortes'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 47
          end
          object LblCortes: TLabel
            Left = 4
            Top = 25
            Width = 140
            Height = 55
            CustomHint = BalloonHint1
            Alignment = taCenter
            AutoSize = False
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -48
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label23: TLabel
            Left = 126
            Top = 4
            Width = 17
            Height = 15
            CustomHint = BalloonHint1
            Caption = '(G)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4227327
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PgrCortes: TGauge
            Left = 1
            Top = 89
            Width = 148
            Height = 18
            CustomHint = BalloonHint1
            Align = alBottom
            BackColor = 16117735
            BorderStyle = bsNone
            ForeColor = 33023
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Progress = 0
            ExplicitTop = 92
          end
        end
        object PnlCancelado: TPanel
          Left = 653
          Top = 25
          Width = 150
          Height = 108
          CustomHint = BalloonHint1
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
          object Label16: TLabel
            Left = 1
            Top = 1
            Width = 148
            Height = 19
            CustomHint = BalloonHint1
            Align = alTop
            Alignment = taCenter
            Caption = 'Cancelado'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 75
          end
          object LblCancelado: TLabel
            Left = 4
            Top = 25
            Width = 140
            Height = 55
            CustomHint = BalloonHint1
            Alignment = taCenter
            AutoSize = False
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -48
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label22: TLabel
            Left = 132
            Top = 4
            Width = 14
            Height = 15
            CustomHint = BalloonHint1
            Caption = '(F)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4227327
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object PgrCancelado: TGauge
            Left = 1
            Top = 89
            Width = 148
            Height = 18
            CustomHint = BalloonHint1
            Align = alBottom
            BackColor = 16117735
            BorderStyle = bsNone
            ForeColor = 33023
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
            Progress = 0
            ExplicitTop = 92
          end
        end
        object PnlEficiencia: TPanel
          Left = 979
          Top = 27
          Width = 184
          Height = 108
          CustomHint = BalloonHint1
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
          object Label8: TLabel
            Left = 1
            Top = 1
            Width = 182
            Height = 19
            CustomHint = BalloonHint1
            Align = alTop
            Alignment = taCenter
            Caption = 'Efici'#234'ncia    '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 85
          end
          object LblEficiencia: TLabel
            Left = 1
            Top = 26
            Width = 178
            Height = 55
            CustomHint = BalloonHint1
            Alignment = taCenter
            AutoSize = False
            Caption = '0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -48
            Font.Name = 'Roboto'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label24: TLabel
            Left = 146
            Top = 4
            Width = 28
            Height = 15
            CustomHint = BalloonHint1
            Caption = '(E/H)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4227327
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
      object CbTipoAnalise: TComboBox
        Left = 335
        Top = 79
        Width = 112
        Height = 25
        CustomHint = BalloonHint1
        Style = csDropDownList
        Enabled = False
        ItemIndex = 0
        TabOrder = 4
        Text = 'Por Volume(s)'
        Visible = False
        Items.Strings = (
          'Por Volume(s)'
          'Por Unidade(s)')
      end
      object GroupBox2: TGroupBox
        Left = 10
        Top = 49
        Width = 293
        Height = 52
        CustomHint = BalloonHint1
        Caption = '[ Setor / Zona ]'
        TabOrder = 3
        object Label41: TLabel
          Left = 7
          Top = 23
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblZona: TLabel
          Left = 96
          Top = 24
          Width = 189
          Height = 16
          CustomHint = BalloonHint1
          AutoSize = False
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object EdtZonaId: TEdit
          Left = 23
          Top = 20
          Width = 45
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtZonaIdChange
          OnEnter = EdtInicioEnter
          OnExit = EdtZonaIdExit
          OnKeyPress = EdtRotaIdKeyPress
        end
        object BtnPesqZona: TBitBtn
          Left = 66
          Top = 20
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
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqZonaClick
        end
      end
      object CbAtualizacao: TComboBox
        Left = 499
        Top = 76
        Width = 112
        Height = 25
        CustomHint = BalloonHint1
        Style = csDropDownList
        Enabled = False
        ItemIndex = 1
        TabOrder = 5
        Text = '  3 Minutos'
        Visible = False
        Items.Strings = (
          '  1 Minuto '
          '  3 Minutos'
          '  5 Minutos'
          '10 Minutos'
          '15 Minutos'
          '30 Minutos')
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitWidth = 1225
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitWidth = 1225
      inherited DbgImporta: TDBGrid
        Width = 1225
      end
    end
  end
  inherited PnHeader: TPanel
    Width = 1224
    ExplicitWidth = 1224
    inherited ImgClose: TImage
      Left = 1191
      ExplicitLeft = 1191
    end
    inherited ImgMinimize: TImage
      Left = 1171
      ExplicitLeft = 1171
    end
    inherited PanWin8: TPanel
      Width = 1224
      ExplicitWidth = 1224
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 786
    Top = 298
    ExplicitLeft = 786
    ExplicitTop = 298
  end
  inherited PnlErro: TPanel
    Width = 1224
    ExplicitWidth = 1224
    inherited LblMensShowErro: TLabel
      Width = 1224
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 683
    Top = 370
    ExplicitLeft = 683
    ExplicitTop = 370
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
