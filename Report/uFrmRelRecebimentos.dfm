inherited FrmRelRecebimentos: TFrmRelRecebimentos
  Caption = 'FrmRelRecebimentos'
  ClientHeight = 979
  ClientWidth = 1368
  ExplicitWidth = 1370
  ExplicitHeight = 981
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Width = 1369
    Height = 924
    Properties.ActivePage = TabOcorrencias
    ClientRectBottom = 924
    ClientRectRight = 1369
    inherited TabListagem: TcxTabSheet
      ExplicitWidth = 1369
      ExplicitHeight = 900
      inherited LstCadastro: TAdvStringGrid
        Width = 1349
        Height = 862
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 862
        ExplicitHeight = 862
      end
      inherited PnlPesquisaCadastro: TPanel
        Width = 1369
        ExplicitWidth = 1369
        inherited BtnPesqConsGeral: TsImage
          Left = 810
        end
        inherited LblClearFilter: TLabel
          Left = 845
        end
        inherited LblRegTit: TLabel
          Left = 1049
        end
        inherited LblTotReg: TLabel
          Left = 1185
        end
        inherited EdtConteudoPesq: TLabeledEdit
          Width = 468
          ExplicitWidth = 468
        end
      end
    end
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1369
      ExplicitHeight = 900
      inherited ShCadastro: TShape
        Left = 1091
        ExplicitLeft = 1091
      end
      inherited LblTotRegCaption: TLabel
        Left = 12
        Top = 174
        Width = 109
        Caption = 'Total de Pedido(s):'
        ExplicitLeft = 12
        ExplicitTop = 174
        ExplicitWidth = 109
      end
      inherited LblTotRegistro: TLabel
        Left = 135
        Top = 174
        ExplicitLeft = 135
        ExplicitTop = 174
      end
      object GroupBox7: TGroupBox [3]
        Left = 15
        Top = 116
        Width = 668
        Height = 53
        CustomHint = BalloonHint1
        Caption = '[ Produto ]'
        TabOrder = 3
        object Label12: TLabel
          Left = 9
          Top = 23
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo'
        end
        object LblProduto: TLabel
          Left = 204
          Top = 24
          Width = 442
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
        object EdtCodProduto: TEdit
          Left = 58
          Top = 24
          Width = 115
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
          OnChange = EdtInicioChange
          OnExit = EdtCodProdutoExit
        end
        object BtnPesqProduto: TBitBtn
          Left = 174
          Top = 20
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C006000000000000000000000000000000000000494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524C516347536F4948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524948524948524B5163277FFF277FFF47536F494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
            634948524948524948524948524948524948524948524948524948524948524C
            50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
            277FFF4B51634948524948524948524948524948524948524948524948524948
            524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
            7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
            4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
            73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
            48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
            4948524948524948524C506148536D277FFF4A52684948524948524948524948
            52494852494852494852494852494852494852435475277FFF4C506149485249
            485249485249485249485249485249485249485249485247536E465370494852
            494852494852494852494852494852494852494852494852435476277FFF4554
            724948524948524948524948524948524948524948524948524948524948524C
            5162277FFF435476494852494852494852494852494852494852494852435475
            277FFF4254764948524948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            4852494852435475277FFF277FFF435475494852494852494852494852494852
            494852494852494852494852494852445475277FFF277FFF4454754948524948
            52494852494852494852494852435475277FFF277FFF43547549485249485249
            4852494852494852494852494852494852494852494852494852425478277FFF
            445475494852494852494852494852494852494852435475277FFF4254764948
            5249485249485249485249485249485249485249485249485249485249485244
            5475277FFF277FFF445475494852494852494852494852494852494852494852
            435476277FFF4C50614948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            48524948524948524C5162277FFF455473494852494852494852494852494852
            494852494852494852494852494852455472277FFF4354764948524948524948
            52494852494852494852494852494852494852435475277FFF4C516249485249
            48524948524948524948524948524948524948524C5162277FFF435476494852
            4948524948524948524948524948524948524948524948524948524C5062277F
            FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
            7FFF4B5163494852494852494852494852494852494852494852494852494852
            4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
            6D277FFF277FFF4B516349485249485249485249485249485249485249485249
            48524948524948524948524948524948524948524B5266465370277FFF277FFF
            277FFF277FFF46537049526A4C51624948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524C50624C51634C51634C5062494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852}
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqProdutoClick
        end
      end
      object ChkPedidoPendente: TCheckBox [4]
        Left = 694
        Top = 139
        Width = 143
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Somente Pendentes'
        Enabled = False
        TabOrder = 4
        OnClick = ChkPedidoPendenteClick
      end
      object GroupBox2: TGroupBox [5]
        Left = 508
        Top = 60
        Width = 439
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Processo ]'
        TabOrder = 5
        object Label4: TLabel
          Left = 8
          Top = 24
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblProcesso: TLabel
          Left = 127
          Top = 28
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
        object EdtProcessoId: TEdit
          Left = 26
          Top = 22
          Width = 73
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtInicioChange
          OnExit = EdtProcessoIdExit
        end
        object BtnPesqProcesso: TBitBtn
          Left = 97
          Top = 22
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C006000000000000000000000000000000000000494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524C516347536F4948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524948524948524B5163277FFF277FFF47536F494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
            634948524948524948524948524948524948524948524948524948524948524C
            50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
            277FFF4B51634948524948524948524948524948524948524948524948524948
            524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
            7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
            4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
            73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
            48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
            4948524948524948524C506148536D277FFF4A52684948524948524948524948
            52494852494852494852494852494852494852435475277FFF4C506149485249
            485249485249485249485249485249485249485249485247536E465370494852
            494852494852494852494852494852494852494852494852435476277FFF4554
            724948524948524948524948524948524948524948524948524948524948524C
            5162277FFF435476494852494852494852494852494852494852494852435475
            277FFF4254764948524948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            4852494852435475277FFF277FFF435475494852494852494852494852494852
            494852494852494852494852494852445475277FFF277FFF4454754948524948
            52494852494852494852494852435475277FFF277FFF43547549485249485249
            4852494852494852494852494852494852494852494852494852425478277FFF
            445475494852494852494852494852494852494852435475277FFF4254764948
            5249485249485249485249485249485249485249485249485249485249485244
            5475277FFF277FFF445475494852494852494852494852494852494852494852
            435476277FFF4C50614948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            48524948524948524C5162277FFF455473494852494852494852494852494852
            494852494852494852494852494852455472277FFF4354764948524948524948
            52494852494852494852494852494852494852435475277FFF4C516249485249
            48524948524948524948524948524948524948524C5162277FFF435476494852
            4948524948524948524948524948524948524948524948524948524C5062277F
            FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
            7FFF4B5163494852494852494852494852494852494852494852494852494852
            4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
            6D277FFF277FFF4B516349485249485249485249485249485249485249485249
            48524948524948524948524948524948524948524B5266465370277FFF277FFF
            277FFF277FFF46537049526A4C51624948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524C50624C51634C51634C5062494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852}
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqProcessoClick
        end
      end
      object GroupBox1: TGroupBox [6]
        Left = 15
        Top = 3
        Width = 302
        Height = 57
        CustomHint = BalloonHint1
        Caption = '[ Emiss'#227'o Documento]'
        TabOrder = 6
        TabStop = True
        object Label2: TLabel
          Left = 6
          Top = 23
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label3: TLabel
          Left = 145
          Top = 22
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtInicio: TJvDateEdit
          Left = 44
          Top = 21
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
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
        end
        object EdtTermino: TJvDateEdit
          Left = 198
          Top = 19
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtInicioChange
        end
      end
      object GroupBox4: TGroupBox [7]
        Left = 15
        Top = 60
        Width = 442
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Fornecedor ]'
        TabOrder = 7
        TabStop = True
        object Label9: TLabel
          Left = 8
          Top = 21
          Width = 69
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo ERP'
        end
        object LblFornecedor: TLabel
          Left = 185
          Top = 25
          Width = 250
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
        object EdtFornecedor: TEdit
          Left = 83
          Top = 21
          Width = 73
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtInicioChange
          OnExit = EdtFornecedorExit
        end
        object BtnPesqFornecedor: TBitBtn
          Left = 157
          Top = 19
          Width = 24
          Height = 24
          CustomHint = BalloonHint1
          Glyph.Data = {
            F6060000424DF606000000000000360000002800000018000000180000000100
            180000000000C006000000000000000000000000000000000000494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524C516347536F4948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524948524948524B5163277FFF277FFF47536F494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            524948524948524948524948524C5163277FFF277FFF277FFF4B516349485249
            4852494852494852494852494852494852494852494852494852494852494852
            4948524948524948524948524948524948524C5163277FFF277FFF277FFF4B51
            634948524948524948524948524948524948524948524948524948524948524C
            50614B51644B52664948524B51644C50614948524948524B5163277FFF277FFF
            277FFF4B51634948524948524948524948524948524948524948524948524948
            524C5061445475277FFF277FFF277FFF474C5E277FFF277FFF4354754B526627
            7FFF277FFF277FFF4B5163494852494852494852494852494852494852494852
            4948524948524C5163277FFF277FFF4454734C50624C50614948524C50614554
            73277FFF277FFF277FFF277FFF4C516349485249485249485249485249485249
            48524948524948524948524C5061277FFF277FFF4C5061494852494852494852
            4948524948524948524C506148536D277FFF4A52684948524948524948524948
            52494852494852494852494852494852494852435475277FFF4C506149485249
            485249485249485249485249485249485249485249485247536E465370494852
            494852494852494852494852494852494852494852494852435476277FFF4554
            724948524948524948524948524948524948524948524948524948524948524C
            5162277FFF435476494852494852494852494852494852494852494852435475
            277FFF4254764948524948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            4852494852435475277FFF277FFF435475494852494852494852494852494852
            494852494852494852494852494852445475277FFF277FFF4454754948524948
            52494852494852494852494852435475277FFF277FFF43547549485249485249
            4852494852494852494852494852494852494852494852494852425478277FFF
            445475494852494852494852494852494852494852435475277FFF4254764948
            5249485249485249485249485249485249485249485249485249485249485244
            5475277FFF277FFF445475494852494852494852494852494852494852494852
            435476277FFF4C50614948524948524948524948524948524948524948524948
            52494852494852494852425476277FFF44547549485249485249485249485249
            48524948524948524C5162277FFF455473494852494852494852494852494852
            494852494852494852494852494852455472277FFF4354764948524948524948
            52494852494852494852494852494852494852435475277FFF4C516249485249
            48524948524948524948524948524948524948524C5162277FFF435476494852
            4948524948524948524948524948524948524948524948524948524C5062277F
            FF277FFF4554724948524948524948524948524948524948524B5163277FFF27
            7FFF4B5163494852494852494852494852494852494852494852494852494852
            4948524948524C5062435475277FFF48536D4B51644C51624C50614B51634853
            6D277FFF277FFF4B516349485249485249485249485249485249485249485249
            48524948524948524948524948524948524948524B5266465370277FFF277FFF
            277FFF277FFF46537049526A4C51624948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            48524C50624C51634C51634C5062494852494852494852494852494852494852
            4948524948524948524948524948524948524948524948524948524948524948
            5249485249485249485249485249485249485249485249485249485249485249
            4852494852494852494852494852494852494852494852494852}
          TabOrder = 1
          TabStop = False
          OnClick = BtnPesqFornecedorClick
        end
      end
      object GroupBox6: TGroupBox [8]
        Left = 626
        Top = 3
        Width = 320
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Entrada ]'
        TabOrder = 8
        TabStop = True
        object Label11: TLabel
          Left = 8
          Top = 21
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object Label10: TLabel
          Left = 143
          Top = 23
          Width = 54
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Docto Nr'
        end
        object EdtPedidoId: TEdit
          Left = 25
          Top = 19
          Width = 84
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtInicioChange
          OnExit = EdtPedidoIdExit
        end
        object EdtDocumentoNr: TEdit
          Left = 203
          Top = 19
          Width = 104
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnChange = EdtInicioChange
        end
      end
      inherited PnlInfo: TPanel
        Top = 714
        ExplicitTop = 714
      end
      inherited ChkCadastro: TCheckBox
        Left = 1038
        ExplicitLeft = 1038
      end
      inherited LstReport: TAdvStringGrid
        Left = 863
        Top = 138
        Width = 417
        Height = 145
        Align = alNone
        Visible = False
        ExplicitLeft = 863
        ExplicitTop = 138
        ExplicitWidth = 417
        ExplicitHeight = 145
      end
      object PgcPedidos: TcxPageControl
        Left = 8
        Top = 197
        Width = 1352
        Height = 690
        CustomHint = BalloonHint1
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 9
        Properties.ActivePage = TabResumo
        Properties.CustomButtons.Buttons = <>
        Properties.Style = 9
        ClientRectBottom = 690
        ClientRectRight = 1352
        ClientRectTop = 24
        object TabPedidos: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Pedidos'
          ImageIndex = 0
          object LstPedidosAdv: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 1352
            Height = 666
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alClient
            ColCount = 22
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            HoverRowCells = [hcNormal, hcSelected]
            OnClickCell = LstPedidosAdvClickCell
            OnDblClickCell = LstPedidosAdvDblClickCell
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Pedido'
              'Data'
              'Operacao'
              'C'#243'digo'
              'Raz'#227'o'
              'DocumentoNr'
              'Processo'
              'Dt.Processo'
              'Itens'
              'Qtd.Xml'
              'Qtd.CheckIn'
              'Qtd.Devol.'
              'Qtd.Segreg.'
              'Picking'
              'Recebido'
              'CheckIn In'#237'cio'
              'CheckIn Final'
              'Fechamento'
              'Id Usu.'
              'Usu'#225'rio'
              'Integra'#231#227'o  ERP.'
              'Hr.Trabalhada(s)')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ExplicitLeft = -3
            ExplicitWidth = 1140
            ExplicitHeight = 290
            ColWidths = (
              74
              78
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
        object TabResumo: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'CheckIn'
          ImageIndex = 2
          object LstPedidoResumoAdv: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 1352
            Height = 666
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alClient
            ColCount = 17
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            HoverRowCells = [hcNormal, hcSelected]
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 16117735
            CellNode.ShowTree = False
            ColumnHeaders.Strings = (
              'Entrada'
              'CodProduto'
              'Descri'#231#227'o]'
              'Picking'
              'Zona'
              'Lote'
              'Vencimento'
              'Qtd.Xml'
              'Qtd.CheckIn'
              'Devolvida'
              'Segregada'
              'Conferente'
              'Dt.Confer.'
              'Hr.Confer.'
              'Autorizador do Lote'
              'Terminal'
              'Causa')
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ExplicitLeft = -1
            ExplicitWidth = 1140
            ExplicitHeight = 280
            ColWidths = (
              74
              78
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
        object TabEspelho: TcxTabSheet
          CustomHint = BalloonHint1
          Caption = 'Espelho'
          ImageIndex = 2
          object LstEspelho: TAdvStringGrid
            Left = 0
            Top = 0
            Width = 1352
            Height = 666
            Cursor = crDefault
            CustomHint = BalloonHint1
            Align = alClient
            ColCount = 9
            DefaultColWidth = 74
            DefaultRowHeight = 25
            DrawingStyle = gdsClassic
            RowCount = 25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
            HoverRowCells = [hcNormal, hcSelected]
            OnGetEditorType = LstCadastroGetEditorType
            OnGetEditorProp = LstCadastroGetEditorProp
            HintColor = 5080903
            ActiveCellShow = True
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'MS Sans Serif'
            ActiveCellFont.Style = []
            ActiveCellColor = 5080903
            Bands.Active = True
            Bands.PrimaryColor = 15523534
            CellNode.ShowTree = False
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
            ControlLook.FixedGradientHoverFrom = 13619409
            ControlLook.FixedGradientHoverTo = 12502728
            ControlLook.FixedGradientHoverMirrorFrom = 12502728
            ControlLook.FixedGradientHoverMirrorTo = 11254975
            ControlLook.FixedGradientDownFrom = 8816520
            ControlLook.FixedGradientDownTo = 7568510
            ControlLook.FixedGradientDownMirrorFrom = 7568510
            ControlLook.FixedGradientDownMirrorTo = 6452086
            ControlLook.FixedGradientDownBorder = 14007466
            ControlLook.ControlStyle = csClassic
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDown.TextChecked = 'Checked'
            FilterDropDown.TextUnChecked = 'Unchecked'
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedColWidth = 74
            FixedRowHeight = 25
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clBlack
            FixedFont.Height = -11
            FixedFont.Name = 'MS Sans Serif'
            FixedFont.Style = []
            FloatFormat = '%.2f'
            GridImages = ImgListSimNao
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            Look = glListView
            Lookup = True
            MouseActions.DirectEdit = True
            Multilinecells = True
            Navigation.AdvanceOnEnter = True
            Navigation.AdvanceInsert = True
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'MS Sans Serif'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'MS Sans Serif'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'MS Sans Serif'
            PrintSettings.FooterFont.Style = []
            PrintSettings.Borders = pbNoborder
            PrintSettings.Centered = False
            PrintSettings.PageNumSep = '/'
            RowIndicator.Data = {
              36090000424D3609000000000000360000002800000018000000180000000100
              2000000000000009000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
              FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000277FFFFF277F
              FFFF277FFFFF000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              000000000000000000000000000000000000000000000000000000000000277F
              FFFF00000000000000000000000000000000000000000000000000000000277F
              FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000}
            ScrollWidth = 16
            SearchFooter.Color = clBtnFace
            SearchFooter.FindNextCaption = 'Find &next'
            SearchFooter.FindPrevCaption = 'Find &previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SearchFooter.ResultFormat = '(%d of %d)'
            SelectionColor = clHighlight
            SelectionTextColor = clHighlightText
            SortSettings.DefaultFormat = ssAutomatic
            SortSettings.HeaderColorTo = 16579058
            SortSettings.HeaderMirrorColor = 16380385
            SortSettings.HeaderMirrorColorTo = 16182488
            Version = '8.4.2.2'
            WordWrap = False
            ExplicitWidth = 1140
            ExplicitHeight = 290
            ColWidths = (
              74
              118
              74
              74
              74
              74
              74
              74
              74)
            RowHeights = (
              24
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25
              25)
          end
        end
      end
      object GroupBox3: TGroupBox
        Left = 948
        Top = 17
        Width = 217
        Height = 120
        CustomHint = BalloonHint1
        Caption = '[ Detalhes ]'
        TabOrder = 10
        Visible = False
        object Label5: TLabel
          Left = 17
          Top = 19
          Width = 62
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Resgistro: '
        end
        object Label6: TLabel
          Left = 45
          Top = 42
          Width = 34
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Itens: '
        end
        object LblRegistro: TLabel
          Left = 78
          Top = 19
          Width = 65
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Resgistro: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblItens: TLabel
          Left = 103
          Top = 42
          Width = 38
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Itens: '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 16
          Top = 65
          Width = 63
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Demanda: '
        end
        object Label8: TLabel
          Left = 38
          Top = 88
          Width = 41
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Perda: '
        end
        object LblDemanda: TLabel
          Left = 82
          Top = 65
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'Demanda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblPerda: TLabel
          Left = 98
          Top = 88
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object LblPercPerda: TLabel
          Left = 145
          Top = 88
          Width = 43
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'TPerda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object GroupBox10: TGroupBox
        Left = 314
        Top = 3
        Width = 313
        Height = 57
        CustomHint = BalloonHint1
        Caption = '[ Finaliza'#231#227'o ]'
        TabOrder = 11
        TabStop = True
        object Label17: TLabel
          Left = 8
          Top = 21
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label18: TLabel
          Left = 151
          Top = 22
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtFinalizacaoInicio: TJvDateEdit
          Left = 44
          Top = 21
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
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
        end
        object EdtFinalizacaoTermino: TJvDateEdit
          Left = 204
          Top = 21
          Width = 95
          Height = 24
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtInicioChange
        end
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitWidth = 1369
      ExplicitHeight = 900
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitWidth = 1369
      ExplicitHeight = 900
      inherited DbgImporta: TDBGrid
        Width = 1369
        Height = 696
      end
    end
    object TabOcorrencias: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Ocorr'#234'ncias no Recebimento'
      ImageIndex = 4
      OnShow = TabOcorrenciasShow
      ExplicitWidth = 1157
      ExplicitHeight = 524
      object Label19: TLabel
        Left = 4
        Top = 100
        Width = 127
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Total de Ocor'#234'ncia(s):'
      end
      object LblTotalOcorrencia: TLabel
        Left = 127
        Top = 100
        Width = 54
        Height = 17
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object GroupBox5: TGroupBox
        Left = 21
        Top = 8
        Width = 568
        Height = 77
        CustomHint = BalloonHint1
        Caption = ' [ Entrada ]'
        TabOrder = 0
        object EdtEntradaId: TLabeledEdit
          Left = 13
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
          MaxLength = 10
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnChange = EdtEntradaIdChange
          OnExit = EdtEntradaIdExit
        end
        object EdtDocumentoOcorrencia: TLabeledEdit
          Left = 141
          Top = 38
          Width = 89
          Height = 24
          CustomHint = BalloonHint1
          Ctl3D = True
          EditLabel.Width = 86
          EditLabel.Height = 17
          EditLabel.CustomHint = BalloonHint1
          EditLabel.Caption = 'Documento Nr'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 15
          ParentCtl3D = False
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnChange = EdtEntradaIdChange
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
          ReadOnly = True
          TabOrder = 2
          OnChange = EdtEntradaIdChange
        end
      end
      object GroupBox8: TGroupBox
        Left = 625
        Top = 8
        Width = 249
        Height = 77
        CustomHint = BalloonHint1
        Caption = ' [ Documento ]'
        TabOrder = 1
        object Label13: TLabel
          Left = 23
          Top = 19
          Width = 48
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dt.Inicial'
        end
        object Label14: TLabel
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
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtEntradaIdChange
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
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtEntradaIdChange
        end
      end
      object GroupBox9: TGroupBox
        Left = 907
        Top = 8
        Width = 249
        Height = 77
        CustomHint = BalloonHint1
        Caption = ' [ CheckIn ]'
        TabOrder = 2
        object Label15: TLabel
          Left = 23
          Top = 19
          Width = 48
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Dt.Inicial'
        end
        object Label16: TLabel
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
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 0
          OnChange = EdtEntradaIdChange
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
          ReadOnly = True
          ShowNullDate = False
          TabOrder = 1
          OnChange = EdtEntradaIdChange
        end
      end
      object LstOcorrencias: TAdvStringGrid
        Left = 0
        Top = 120
        Width = 1369
        Height = 780
        Cursor = crDefault
        CustomHint = BalloonHint1
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 12
        DefaultColWidth = 74
        DefaultRowHeight = 25
        DrawingStyle = gdsClassic
        RowCount = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 3
        HoverRowCells = [hcNormal, hcSelected]
        OnGetEditorType = LstCadastroGetEditorType
        OnGetEditorProp = LstCadastroGetEditorProp
        HintColor = 5080903
        ActiveCellShow = True
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'MS Sans Serif'
        ActiveCellFont.Style = []
        ActiveCellColor = 5080903
        Bands.Active = True
        Bands.PrimaryColor = 15523534
        CellNode.ShowTree = False
        ColumnHeaders.Strings = (
          'Pedido Id'
          'Docto Nr'
          'Data'
          'Cod.Erp'
          'Descri'#231#227'o'
          'Lote'
          'Vencimento'
          'Qtd.Xml'
          'Qdt.Conf.'
          'Qtd.Dev.'
          'Qrd.Segr.'
          'Motivo')
        ControlLook.FixedGradientHoverFrom = 13619409
        ControlLook.FixedGradientHoverTo = 12502728
        ControlLook.FixedGradientHoverMirrorFrom = 12502728
        ControlLook.FixedGradientHoverMirrorTo = 11254975
        ControlLook.FixedGradientDownFrom = 8816520
        ControlLook.FixedGradientDownTo = 7568510
        ControlLook.FixedGradientDownMirrorFrom = 7568510
        ControlLook.FixedGradientDownMirrorTo = 6452086
        ControlLook.FixedGradientDownBorder = 14007466
        ControlLook.ControlStyle = csClassic
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDown.TextChecked = 'Checked'
        FilterDropDown.TextUnChecked = 'Unchecked'
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedColWidth = 74
        FixedRowHeight = 25
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clBlack
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
        FloatFormat = '%.2f'
        GridImages = ImgListSimNao
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        Look = glListView
        Lookup = True
        MouseActions.DirectEdit = True
        Multilinecells = True
        Navigation.AdvanceOnEnter = True
        Navigation.AdvanceInsert = True
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'MS Sans Serif'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'MS Sans Serif'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'MS Sans Serif'
        PrintSettings.FooterFont.Style = []
        PrintSettings.Borders = pbNoborder
        PrintSettings.Centered = False
        PrintSettings.PageNumSep = '/'
        RowIndicator.Data = {
          36090000424D3609000000000000360000002800000018000000180000000100
          2000000000000009000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000277F
          FFFF00000000000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF00000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF0000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF277FFFFF000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          000000000000277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277FFFFF277F
          FFFF277FFFFF277FFFFF277FFFFF00000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF277FFFFF0000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000277FFFFF277F
          FFFF277FFFFF000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000000000277F
          FFFF00000000000000000000000000000000000000000000000000000000277F
          FFFF277FFFFF277FFFFF277FFFFF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000277FFFFF277FFFFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ScrollWidth = 16
        SearchFooter.Color = clBtnFace
        SearchFooter.FindNextCaption = 'Find &next'
        SearchFooter.FindPrevCaption = 'Find &previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SearchFooter.ResultFormat = '(%d of %d)'
        SelectionColor = clHighlight
        SelectionTextColor = clHighlightText
        SortSettings.DefaultFormat = ssAutomatic
        SortSettings.HeaderColorTo = 16579058
        SortSettings.HeaderMirrorColor = 16380385
        SortSettings.HeaderMirrorColorTo = 16182488
        Version = '8.4.2.2'
        WordWrap = False
        ExplicitWidth = 1157
        ExplicitHeight = 404
        ColWidths = (
          74
          118
          74
          74
          74
          74
          74
          74
          74
          74
          74
          74)
        RowHeights = (
          24
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25
          25)
      end
    end
  end
  inherited PnHeader: TPanel
    Width = 1368
    inherited ImgClose: TImage
      Left = 1335
    end
    inherited ImgMinimize: TImage
      Left = 1315
    end
    inherited PanWin8: TPanel
      Width = 1368
      inherited BtnPesquisarStand: TsImage
        Top = 6
        ExplicitTop = 6
      end
      inherited BtnImprimirStand: TsImage
        Left = 118
        Top = 6
        ExplicitLeft = 118
        ExplicitTop = 6
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 1075
    Top = 321
    ExplicitLeft = 863
    ExplicitTop = 321
  end
  inherited PnlErro: TPanel
    Top = 957
    Width = 1368
    inherited LblMensShowErro: TLabel
      Width = 1368
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 969
    Top = 378
    ExplicitLeft = 969
    ExplicitTop = 378
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  inherited OpenPictureDialog1: TOpenPictureDialog
    Left = 1016
    Top = 58
  end
  inherited FdMemPesqGeral: TFDMemTable
    object FdMemPesqGeralPedidoId: TIntegerField
      FieldName = 'PedidoId'
    end
    object FdMemPesqGeralOperacaoTipo: TStringField
      FieldName = 'OperacaoTipo'
      Size = 30
    end
    object FdMemPesqGeralPessoaId: TIntegerField
      FieldName = 'PessoaId'
    end
    object FdMemPesqGeralCodPessoaERP: TIntegerField
      FieldName = 'CodPessoaERP'
    end
    object FdMemPesqGeralRazao: TStringField
      FieldName = 'Razao'
      Size = 100
    end
    object FdMemPesqGeralFantasia: TStringField
      FieldName = 'Fantasia'
      Size = 100
    end
    object FdMemPesqGeralDocumentoNr: TStringField
      FieldName = 'DocumentoNr'
    end
    object FdMemPesqGeralDocumentoData: TDateField
      FieldName = 'DocumentoData'
    end
    object FdMemPesqGeralEtapa: TStringField
      FieldName = 'Etapa'
      Size = 30
    end
    object FdMemPesqGeralProcessoId: TIntegerField
      FieldName = 'ProcessoId'
    end
    object FdMemPesqGeralDtProcesso: TDateField
      FieldName = 'DtProcesso'
    end
    object FdMemPesqGeralItens: TIntegerField
      FieldName = 'Itens'
    end
    object FdMemPesqGeralQtdXml: TIntegerField
      FieldName = 'QtdXml'
    end
    object FdMemPesqGeralQtdCheckIn: TIntegerField
      FieldName = 'QtdCheckIn'
    end
    object FdMemPesqGeralQtdDevolvida: TIntegerField
      FieldName = 'QtdDevolvida'
    end
    object FdMemPesqGeralQtdSegregada: TIntegerField
      FieldName = 'QtdSegregada'
    end
    object FdMemPesqGeralPicking: TIntegerField
      FieldName = 'Picking'
    end
    object FdMemPesqGeralRecebido: TStringField
      FieldName = 'Recebido'
    end
    object FdMemPesqGeralDtinclusao: TDateField
      FieldName = 'Dtinclusao'
    end
    object FdMemPesqGeralHrInclusao: TStringField
      FieldName = 'HrInclusao'
      Size = 12
    end
    object FdMemPesqGeralArmazemId: TIntegerField
      FieldName = 'ArmazemId'
    end
    object FdMemPesqGeralStatus: TIntegerField
      FieldName = 'Status'
    end
    object FdMemPesqGeralcheckinini: TStringField
      FieldName = 'checkinini'
    end
    object FdMemPesqGeralcheckinfin: TStringField
      FieldName = 'checkinfin'
    end
    object FdMemPesqGeraldtfinalizacao: TDateField
      FieldName = 'dtfinalizacao'
    end
    object FdMemPesqGeralhrfinalizacao: TStringField
      FieldName = 'hrfinalizacao'
      Size = 12
    end
    object FdMemPesqGeralDevolvido: TStringField
      FieldName = 'Devolvido'
    end
    object FdMemPesqGeralUsuarioId: TIntegerField
      FieldName = 'UsuarioId'
    end
    object FdMemPesqGeralNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object FdMemPesqGeralhoratrabalhada: TStringField
      FieldName = 'horatrabalhada'
      Size = 11
    end
  end
  inherited FdMemImportaCSV: TFDMemTable
    AfterClose = nil
  end
  inherited frxDBDataset1: TfrxDBDataset
    Left = 388
  end
  inherited frxReport1: TfrxReport
    ReportOptions.CreateDate = 45399.768113425890000000
    ReportOptions.LastChange = 45800.666962094910000000
    ScriptText.Strings = (
      'procedure PageHeader1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  if (<Line#> Mod 2) then Begin'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := $00EBEBEB;'
      '  End'
      '  else Begin'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := ClNone;'
      '  End;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 388
    Top = 337
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
        Value = Null
      end
      item
        Name = 'vVersao'
        Value = Null
      end
      item
        Name = 'vUsuario'
        Value = Null
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 256
      inherited PageHeader1: TfrxPageHeader
        Width = 1046.929810000000000000
        inherited Shape1: TfrxShapeView
          Width = 1039.370078740160000000
        end
        inherited Memo1: TfrxMemoView
          Left = 326.929345000000000000
        end
        inherited Memo2: TfrxMemoView
          Left = 326.929345000000000000
          Memo.UTF8W = (
            'Recebimentos')
        end
        inherited SysMemo1: TfrxSysMemoView
          Left = 944.882500000000000000
        end
        inherited SysMemo3: TfrxSysMemoView
          Left = 944.882500000000000000
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        Width = 1046.929810000000000000
        inherited Line2: TfrxLineView
          Left = -0.000002440000000000
          Width = 1039.370078740160000000
        end
        inherited Memo4: TfrxMemoView
          Left = 7.559060000000000000
          Width = 64.252010000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Id')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Documento')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 181.417440000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Data')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 283.464750000000000000
          Width = 321.260050000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Destinat'#225'rio')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 612.283860000000000000
          Width = 105.826840000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Etapa')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 725.669760000000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qt.Xml')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 805.039890000000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qt.Checkin')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 884.410020000000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qt.Devol.')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 963.780150000000000000
          Width = 71.811023620000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qt.Segr.')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 294.803340000000000000
        Width = 1046.929810000000000000
        inherited Line1: TfrxLineView
          Width = 1039.370078740160000000
        end
        inherited Lblusuario: TfrxMemoView
          Left = 377.953000000000000000
        end
        inherited vUsuario: TfrxMemoView
          Left = 442.205010000000000000
          Width = 351.496290000000000000
        end
        inherited SysMemo2: TfrxSysMemoView
          Left = 944.882500000000000000
        end
      end
      inherited MasterData1: TfrxMasterData
        Width = 1046.929810000000000000
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 34.015770000000000000
          Top = 18.897650000000000000
          Width = 680.314960630000000000
          Visible = False
        end
        object frxDBDataset1PedidoId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 7.559011180000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataField = 'OperacaoTipo'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."OperacaoTipo"]')
        end
        object frxDBDataset1DocumentoNr: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 79.370130000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'DocumentoNr'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."DocumentoNr"]')
        end
        object frxDBDataset1DocumentoData: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 181.417440000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataField = 'DocumentoData'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."DocumentoData"]')
        end
        object frxDBDataset1CodPessoaERP: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 283.464750000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'CodPessoaERP'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."CodPessoaERP"]')
        end
        object frxDBDataset1Fantasia: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 370.393940000000000000
          Width = 347.716760000000000000
          Height = 18.897650000000000000
          DataField = 'Fantasia'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Fantasia"]')
        end
        object frxDBDataset1QtdXml: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 725.669760000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataField = 'QtdXml'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdXml"]')
        end
        object frxDBDataset1QtdCheckIn: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 805.039890000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataField = 'QtdCheckIn'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdCheckIn"]')
        end
        object frxDBDataset1QtdDevolvida: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 884.410020000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataField = 'QtdDevolvida'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdDevolvida"]')
        end
        object frxDBDataset1QtdSegregada: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 963.780150000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          DataField = 'QtdSegregada'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdSegregada"]')
        end
      end
      object ReportSummary1: TfrxReportSummary
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 249.448980000000000000
        Width = 1046.929810000000000000
        object SysMemo4: TfrxSysMemoView
          AllowVectorExport = True
          Left = 725.669760000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."QtdXml">,MasterData1)]')
          ParentFont = False
        end
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 525.354670000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL ------>')
        end
        object SysMemo5: TfrxSysMemoView
          AllowVectorExport = True
          Left = 805.039890000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."QtdCheckIn">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo6: TfrxSysMemoView
          AllowVectorExport = True
          Left = 884.410020000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."QtdDevolvida">,MasterData1)]')
          ParentFont = False
        end
        object SysMemo7: TfrxSysMemoView
          AllowVectorExport = True
          Left = 963.780150000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<frxDBDataset1."QtdSegregada">,MasterData1)]')
          ParentFont = False
        end
      end
    end
  end
  object FDMemEspelho: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 477
    Top = 273
  end
  object FDMemResumoCheckIn: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 471
    Top = 347
  end
  object FDMemOcorrencias: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 285
    Top = 269
  end
end
