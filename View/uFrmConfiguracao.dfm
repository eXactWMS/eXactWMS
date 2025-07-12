inherited FrmConfiguracao: TFrmConfiguracao
  Caption = 'FrmConfiguracao'
  ClientHeight = 681
  ExplicitHeight = 683
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Top = 63
    Height = 626
    Properties.ActivePage = TabProdutividade
    ExplicitTop = 63
    ExplicitHeight = 626
    ClientRectBottom = 626
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 602
      inherited LstCadastro: TAdvStringGrid
        Height = 564
        ExplicitHeight = 564
      end
      inherited AdvGridLookupBar1: TAdvGridLookupBar
        Height = 564
        ExplicitHeight = 564
      end
    end
    inherited TabPrincipal: TcxTabSheet
      Caption = 'Sistema'
      ExplicitHeight = 602
      inherited ShCadastro: TShape
        Left = 796
        Top = 15
        Visible = False
        ExplicitLeft = 796
        ExplicitTop = 15
      end
      object Label57: TLabel [1]
        Left = 857
        Top = 479
        Width = 221
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Carga Em Tr'#226'nsito p'#243's Carregamento'
      end
      inherited PnlInfo: TPanel
        Left = -2
        Top = 557
        ExplicitLeft = -2
        ExplicitTop = 557
      end
      inherited ChkCadastro: TCheckBox
        Left = 743
        Top = 19
        Visible = False
        ExplicitLeft = 743
        ExplicitTop = 19
      end
      object GroupBox1: TGroupBox
        Left = 21
        Top = 13
        Width = 222
        Height = 144
        CustomHint = BalloonHint1
        Caption = ' [ Permiss'#227'o de Cadastro ] '
        TabOrder = 2
        object Label3: TLabel
          Left = 50
          Top = 83
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Produto'
        end
        object Label4: TLabel
          Left = 55
          Top = 26
          Width = 39
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Cliente'
        end
        object Label5: TLabel
          Left = 29
          Top = 55
          Width = 67
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Fornecedor'
        end
        object Label6: TLabel
          Left = 24
          Top = 113
          Width = 71
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Xml Entrada'
        end
        object CbCadProduto: TComboBox
          Left = 101
          Top = 80
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbCadCliente: TComboBox
          Left = 101
          Top = 23
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbCadFornecedor: TComboBox
          Left = 101
          Top = 51
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbCadXmlEntrada: TComboBox
          Left = 101
          Top = 110
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
      end
      object GroupBox2: TGroupBox
        Left = 252
        Top = 13
        Width = 270
        Height = 144
        CustomHint = BalloonHint1
        Caption = ' [ Bloqueio de Opera'#231#227'o ] '
        TabOrder = 3
        object Label7: TLabel
          Left = 52
          Top = 26
          Width = 124
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Entrada por Validade'
        end
        object Label8: TLabel
          Left = 64
          Top = 54
          Width = 111
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Sa'#237'da por Validade'
        end
        object Label9: TLabel
          Left = 49
          Top = 83
          Width = 126
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Status do Fornecedor'
        end
        object Label10: TLabel
          Left = 46
          Top = 113
          Width = 127
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Status do Cliente/Loja'
        end
        object CbBloqEntrValidade: TComboBox
          Left = 184
          Top = 23
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbBloqSaidaValidade: TComboBox
          Left = 184
          Top = 51
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbBloqStatusFornecedor: TComboBox
          Left = 184
          Top = 80
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbBloqStatusCliente: TComboBox
          Left = 184
          Top = 110
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
      end
      object GroupBox3: TGroupBox
        Left = 528
        Top = 13
        Width = 619
        Height = 177
        CustomHint = BalloonHint1
        Caption = ' [ Valida'#231#245'es ] '
        TabOrder = 4
        object Label16: TLabel
          Left = 78
          Top = 30
          Width = 92
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'CheckIn de Item'
        end
        object Label20: TLabel
          Left = 101
          Top = 105
          Width = 69
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Pr'#233' Vencido'
        end
        object Label21: TLabel
          Left = 228
          Top = 104
          Width = 45
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'mes(es)'
        end
        object Label25: TLabel
          Left = 32
          Top = 69
          Width = 137
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Rastreabilidade Padr'#227'o'
        end
        object Label26: TLabel
          Left = 11
          Top = 140
          Width = 159
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Endere'#231'ar Produto Entrada'
        end
        object Label32: TLabel
          Left = 316
          Top = 67
          Width = 104
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Autorizar Alt. Lote'
        end
        object Label35: TLabel
          Left = 305
          Top = 140
          Width = 174
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Cubagem Produto na Entrada'
        end
        object Label53: TLabel
          Left = 316
          Top = 105
          Width = 215
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Bloquear Picking c/Estoque em Pallet'
        end
        object Label58: TLabel
          Left = 308
          Top = 30
          Width = 239
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Buscar Produto na Stage p/ Atendimento'
        end
        object CbCheckInItem: TComboBox
          Left = 176
          Top = 27
          Width = 118
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Items.Strings = (
            'Adicionar'
            #218'ltimo Lan'#231'amento')
        end
        object CbPreVencido: TComboBox
          Left = 176
          Top = 102
          Width = 46
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          TabStop = False
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12')
        end
        object CbCadRastroIdProdNovo: TComboBox
          Left = 175
          Top = 65
          Width = 118
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TabStop = False
          Items.Strings = (
            '<<Selecione>>'
            'Sem Rastro'
            'Vencimento'
            'Lotes')
        end
        object CbEnderecarProdutoEntrada: TComboBox
          Left = 176
          Top = 138
          Width = 117
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim - Obrigat'#243'rio'
            'Sim - Facultativo')
        end
        object CbAutorizarAltLote: TComboBox
          Left = 428
          Top = 65
          Width = 183
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 3
          ParentFont = False
          TabOrder = 3
          TabStop = False
          Text = 'Autoriza'#231#227'o p/ Prod.SNGPC'
          Items.Strings = (
            'N'#227'o'
            'Somente Autoriza'#231#227'o'
            'Autoriza'#231#227'o Por Setor'
            'Autoriza'#231#227'o p/ Prod.SNGPC')
        end
        object CbCubagemProdutoEntrada: TComboBox
          Left = 484
          Top = 138
          Width = 127
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim - Obrigat'#243'rio'
            'Sim - Facultativo')
        end
        object CbMudarPickingEstoquePallet: TComboBox
          Left = 540
          Top = 102
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          TabStop = False
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbBuscarStage: TComboBox
          Left = 553
          Top = 27
          Width = 57
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 1
          ParentFont = False
          TabOrder = 1
          TabStop = False
          Text = 'Sim'
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
      end
      object GroupBox6: TGroupBox
        Left = 21
        Top = 158
        Width = 501
        Height = 279
        CustomHint = BalloonHint1
        Caption = ' [ Volumes - Separa'#231#227'o/CheckOut ] '
        TabOrder = 5
        object Label22: TLabel
          Left = 13
          Top = 20
          Width = 150
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Exigir registro do Apanhe'
        end
        object Label23: TLabel
          Left = 267
          Top = 20
          Width = 139
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Separa'#231#227'o Consolidada'
        end
        object Label24: TLabel
          Left = 258
          Top = 50
          Width = 146
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Etiq Vol.Extra Autom'#225'tico'
        end
        object Label33: TLabel
          Left = 13
          Top = 80
          Width = 151
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Beepar Produto Individual'
        end
        object Label34: TLabel
          Left = 7
          Top = 109
          Width = 156
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Identifcar Caixa no Apanhe'
        end
        object EdtBeepIndividualQtdMinima: TLabel
          Left = 313
          Top = 80
          Width = 93
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Limite Unidades'
        end
        object Label36: TLabel
          Left = 280
          Top = 257
          Width = 126
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Corte Supervisionado'
        end
        object Label37: TLabel
          Left = 17
          Top = 139
          Width = 146
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Usar Lacre de Seguran'#231'a'
        end
        object Label46: TLabel
          Left = 253
          Top = 139
          Width = 94
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Etiqueta Volume'
        end
        object Label48: TLabel
          Left = 168
          Top = 172
          Width = 239
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Cxa.Fechada na Expedi'#231#227'o p'#243's CheckOut'
        end
        object Label49: TLabel
          Left = 27
          Top = 50
          Width = 137
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Permitir C'#243'digo Interno'
        end
        object Label50: TLabel
          Left = 14
          Top = 228
          Width = 149
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Checkout: Conferir Cortes'
        end
        object Label51: TLabel
          Left = 270
          Top = 228
          Width = 137
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Reconferir p/Expedi'#231#227'o'
        end
        object Label54: TLabel
          Left = 21
          Top = 257
          Width = 142
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Auditar Volume c/Cortes'
        end
        object Label55: TLabel
          Left = 271
          Top = 109
          Width = 136
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Omitir Unid Etq.Volume'
        end
        object Label56: TLabel
          Left = 169
          Top = 198
          Width = 238
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Fracionado na Expedi'#231#227'o P'#243's Separa'#231#227'o'
        end
        object CbRegApanhe: TComboBox
          Left = 170
          Top = 18
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbApanheConsolidado: TComboBox
          Left = 413
          Top = 18
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbPrinterEtqVolumeExtraAuto: TComboBox
          Left = 413
          Top = 47
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbBeepProdIndividual: TComboBox
          Left = 170
          Top = 77
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbIdentCaixaApanhe: TComboBox
          Left = 169
          Top = 106
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object EdtBeepIndividualLimiteUnid: TEdit
          Left = 414
          Top = 77
          Width = 70
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnKeyPress = EdtEnderecoSegregadoIdKeyPress
        end
        object CbCorteSupervisionado: TComboBox
          Left = 412
          Top = 253
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbLacreSeguranca: TComboBox
          Left = 169
          Top = 136
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbModeloEtqVolume: TComboBox
          Left = 354
          Top = 136
          Width = 130
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          Items.Strings = (
            '8 x 10 S/Endere'#231'o'
            '8 x 10 C/Endere'#231'o'
            '8 x 10 C/Destaque'
            '5 x 10')
        end
        object CbVolCxaFechadaExpedicao: TComboBox
          Left = 413
          Top = 166
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbSeparacaoCodigoInterno: TComboBox
          Left = 170
          Top = 47
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbReconferirCorteReconferencia: TComboBox
          Left = 169
          Top = 225
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbExigirReconferenciaToExpedicao: TComboBox
          Left = 413
          Top = 225
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbVolumeAuditoria: TComboBox
          Left = 169
          Top = 252
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbOmitirUnidEtqVolume: TComboBox
          Left = 413
          Top = 106
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
        object CbVolCxaFracionadaExpedicao: TComboBox
          Left = 413
          Top = 195
          Width = 71
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          Items.Strings = (
            'N'#227'o'
            'Sim')
        end
      end
      object GroupBox7: TGroupBox
        Left = 528
        Top = 196
        Width = 619
        Height = 61
        CustomHint = BalloonHint1
        Caption = ' [ Shelf life ] '
        TabOrder = 6
        object Label27: TLabel
          Left = 27
          Top = 29
          Width = 76
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Recebimento'
        end
        object Label28: TLabel
          Left = 160
          Top = 29
          Width = 45
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'mes(es)'
        end
        object Label29: TLabel
          Left = 346
          Top = 26
          Width = 60
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Expedi'#231#227'o'
        end
        object Label30: TLabel
          Left = 464
          Top = 29
          Width = 45
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'mes(es)'
        end
        object CbShelflifeRecebimento: TComboBox
          Left = 108
          Top = 24
          Width = 46
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12')
        end
        object CbShelflifeExpedicao: TComboBox
          Left = 412
          Top = 24
          Width = 46
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12')
        end
      end
      object GroupBox8: TGroupBox
        Left = 528
        Top = 261
        Width = 619
        Height = 86
        CustomHint = BalloonHint1
        Caption = ' [ Tag Produtos - Entrada ] '
        TabOrder = 7
        object RbTagProduto0: TRadioButton
          Left = 11
          Top = 28
          Width = 113
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'N'#227'o utilizar'
          TabOrder = 0
        end
        object RbTagProduto2: TRadioButton
          Left = 11
          Top = 56
          Width = 217
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Utilizar para Zona(s) Espec'#237'fica(s)'
          TabOrder = 1
        end
        object RbTagProduto3: TRadioButton
          Left = 304
          Top = 56
          Width = 265
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Utilizar para Produtos Espec'#237'ficos(SNGPC)'
          TabOrder = 2
        end
        object RbTagProduto1: TRadioButton
          Left = 304
          Top = 28
          Width = 217
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Utilizar para Todos'
          TabOrder = 3
        end
      end
      object GroupBox9: TGroupBox
        Left = 21
        Top = 436
        Width = 211
        Height = 63
        CustomHint = BalloonHint1
        Caption = ' [ Segregado ]'
        TabOrder = 8
        object Label31: TLabel
          Left = 20
          Top = 28
          Width = 101
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Endere'#231'o Padr'#227'o'
        end
        object EdtEnderecoSegregadoId: TEdit
          Left = 127
          Top = 24
          Width = 70
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnKeyPress = EdtEnderecoSegregadoIdKeyPress
        end
      end
      object GroupBox10: TGroupBox
        Left = 528
        Top = 348
        Width = 323
        Height = 151
        CustomHint = BalloonHint1
        Caption = ' [ Invent'#225'rio ]'
        TabOrder = 11
        object Label52: TLabel
          Left = 13
          Top = 119
          Width = 81
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Ajuste Padr'#227'o'
        end
        object ChkInventarioForcarMaxContagem: TCheckBox
          Left = 11
          Top = 28
          Width = 282
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Considerar Estoque como Contagem Inicial'
          TabOrder = 0
        end
        object ChkInventarioDivergenciaSegregado: TCheckBox
          Left = 11
          Top = 58
          Width = 305
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Diverg'#234'ncia de Estoque - enviar para Segregado'
          TabOrder = 1
        end
        object ChkIntegrarAjusteERP: TCheckBox
          Left = 11
          Top = 89
          Width = 316
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Integrar Ajustes com ERP'
          TabOrder = 2
        end
        object CbInventarioAJustePadrao: TComboBox
          Left = 100
          Top = 116
          Width = 139
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 2
          ParentFont = False
          TabOrder = 3
          TabStop = False
          Text = 'Tempor'#225'rio'
          Items.Strings = (
            'N'#227'o Definido'
            'Definitivo'
            'Tempor'#225'rio')
        end
      end
      object GroupBox11: TGroupBox
        Left = 241
        Top = 436
        Width = 281
        Height = 63
        CustomHint = BalloonHint1
        Caption = ' [ Identifica'#231#227'o do CD ]'
        TabOrder = 10
        object EdtIdentificacaoCD: TEdit
          Left = 11
          Top = 24
          Width = 252
          Height = 25
          CustomHint = BalloonHint1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          TabOrder = 0
          OnKeyPress = EdtEnderecoSegregadoIdKeyPress
        end
      end
      object GbReposicao: TGroupBox
        Left = 857
        Top = 348
        Width = 290
        Height = 123
        CustomHint = BalloonHint1
        Caption = ' [ Reposi'#231#227'o ]'
        TabOrder = 12
        object ChkReposicaoColetor: TCheckBox
          Left = 11
          Top = 30
          Width = 270
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Utilizar Coletor de Dados para coleta'
          TabOrder = 0
        end
        object ChkReposicaoAutomatica: TCheckBox
          Left = 11
          Top = 64
          Width = 270
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Gerar Autom'#225'tica - Ap'#243's Cubagem'
          TabOrder = 1
        end
        object ChkReposicaoColetaParaPicking: TCheckBox
          Left = 10
          Top = 100
          Width = 270
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Enviar Coleta Direto para Picking'
          TabOrder = 2
        end
      end
      object GroupBox12: TGroupBox
        Left = 241
        Top = 502
        Width = 281
        Height = 63
        CustomHint = BalloonHint1
        Caption = ' [ Stage Default ]'
        TabOrder = 9
        object Label38: TLabel
          Left = 11
          Top = 28
          Width = 42
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Padr'#227'o'
        end
        object Label47: TLabel
          Left = 143
          Top = 28
          Width = 41
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'SNGPC'
        end
        object EdtEnderecoIdStage: TEdit
          Left = 59
          Top = 24
          Width = 70
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnKeyPress = EdtEnderecoSegregadoIdKeyPress
        end
        object EdtEnderecoIdStageSNGPC: TEdit
          Left = 191
          Top = 24
          Width = 72
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyPress = EdtEnderecoSegregadoIdKeyPress
        end
      end
      object GroupBox13: TGroupBox
        Left = 21
        Top = 502
        Width = 211
        Height = 63
        CustomHint = BalloonHint1
        Caption = ' [ Cancelamento na Expedi'#231#227'o ] '
        TabOrder = 15
        object Label39: TLabel
          Left = 20
          Top = 28
          Width = 101
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Endere'#231'o Padr'#227'o'
        end
        object EdtEnderecoIdVolumeExpedidoCancelado: TEdit
          Left = 127
          Top = 24
          Width = 70
          Height = 25
          CustomHint = BalloonHint1
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnExit = EdtEnderecoIdVolumeExpedidoCanceladoExit
          OnKeyPress = EdtEnderecoSegregadoIdKeyPress
        end
      end
      object GroupBox14: TGroupBox
        Left = 528
        Top = 502
        Width = 323
        Height = 63
        CustomHint = BalloonHint1
        Caption = ' [ Tag Volumes ] '
        TabOrder = 14
        object Label40: TLabel
          Left = 9
          Top = 29
          Width = 125
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Ordem de Impress'#227'o'
        end
        object Label42: TLabel
          Left = 346
          Top = 26
          Width = 60
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Expedi'#231#227'o'
        end
        object Label43: TLabel
          Left = 464
          Top = 29
          Width = 45
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'mes(es)'
        end
        object CbTagVolumeOrdem: TComboBox
          Left = 136
          Top = 26
          Width = 182
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Items.Strings = (
            'Pedido'
            'Endere'#231'o + Rota + Loja'
            'Endere'#231'o + Rota +  Produto'
            'Rota + Loja')
        end
        object ComboBox2: TComboBox
          Left = 412
          Top = 24
          Width = 46
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12')
        end
      end
      object GbReCheckOut: TGroupBox
        Left = 854
        Top = 505
        Width = 293
        Height = 61
        CustomHint = BalloonHint1
        Caption = ' [ Re-CheckOut ] '
        TabOrder = 16
        object Label41: TLabel
          Left = 11
          Top = 29
          Width = 112
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Exigir novo usu'#225'rio'
        end
        object Label44: TLabel
          Left = 346
          Top = 26
          Width = 60
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Expedi'#231#227'o'
        end
        object Label45: TLabel
          Left = 464
          Top = 29
          Width = 45
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'mes(es)'
        end
        object CbReCheckOutUsuario: TComboBox
          Left = 130
          Top = 26
          Width = 67
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemIndex = 1
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Text = 'Sim'
          Items.Strings = (
            'N'#227'o'
            'Sim'
            '')
        end
        object ComboBox3: TComboBox
          Left = 412
          Top = 24
          Width = 46
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
          Items.Strings = (
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            '10'
            '11'
            '12')
        end
      end
      object CbCargaEmTransito: TComboBox
        Left = 1084
        Top = 477
        Width = 63
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        TabStop = False
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
    end
    inherited TbFrameWeb: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 602
    end
    inherited TabimportacaoCSV: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 602
      inherited DbgImporta: TDBGrid
        Height = 398
      end
    end
    object TabImpressora: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Impressora'
      ImageIndex = 2
      OnShow = TabImpressoraShow
      object GroupBox4: TGroupBox
        Left = 22
        Top = 14
        Width = 267
        Height = 117
        CustomHint = BalloonHint1
        Caption = ' [ Impressora C'#243'd.Barras ] '
        TabOrder = 0
        object Label13: TLabel
          Left = 12
          Top = 32
          Width = 64
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Linguagem'
        end
        object Label17: TLabel
          Left = 45
          Top = 74
          Width = 31
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Porta'
        end
        object CbModeloPrinterCodBar: TComboBox
          Left = 84
          Top = 31
          Width = 173
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
        end
        object CbPortaPrinterCodBar: TComboBox
          Left = 84
          Top = 72
          Width = 173
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
        end
      end
      object GroupBox5: TGroupBox
        Left = 22
        Top = 146
        Width = 267
        Height = 61
        CustomHint = BalloonHint1
        Caption = ' [ Impressora Gerencial ]  '
        TabOrder = 1
        object Label18: TLabel
          Left = 12
          Top = 63
          Width = 64
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Linguagem'
          Visible = False
        end
        object Label19: TLabel
          Left = 45
          Top = 30
          Width = 31
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Porta'
        end
        object CbModeloPrinterGerencial: TComboBox
          Left = 84
          Top = 62
          Width = 173
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = False
          Visible = False
        end
        object CbPortaPrinterGerencial: TComboBox
          Left = 84
          Top = 28
          Width = 173
          Height = 22
          CustomHint = BalloonHint1
          Style = csOwnerDrawFixed
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TabStop = False
        end
      end
    end
    object TabIntegracao: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Integra'#231#227'o'
      ImageIndex = 3
      object Label2: TLabel
        Left = 79
        Top = 27
        Width = 97
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Balan'#231'a Precis'#227'o'
      end
      object Label11: TLabel
        Left = 42
        Top = 66
        Width = 138
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Esteira Desvio por Rota'
      end
      object Label12: TLabel
        Left = 40
        Top = 106
        Width = 139
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Esteira Desvio Auditoria'
      end
      object Label14: TLabel
        Left = 51
        Top = 144
        Width = 126
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Ativar Picking By Light'
      end
      object Label15: TLabel
        Left = 47
        Top = 179
        Width = 129
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Ativar Picking By Voice'
      end
      object LblTipoDesvio: TLabel
        Left = 267
        Top = 106
        Width = 88
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Tipo de Desvio'
      end
      object LblModeloPickingByLight: TLabel
        Left = 310
        Top = 144
        Width = 46
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Modelo'
      end
      object LblModeloPickingByVoice: TLabel
        Left = 310
        Top = 179
        Width = 46
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Modelo'
      end
      object CbIntPickingByVoice: TComboBox
        Left = 181
        Top = 176
        Width = 71
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
        OnClick = CbIntDesvioAuditoriaClick
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
      object CbIntPickingByLight: TComboBox
        Left = 181
        Top = 141
        Width = 71
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = CbIntDesvioAuditoriaClick
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
      object CbIntDesvioAuditoria: TComboBox
        Left = 181
        Top = 103
        Width = 71
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
        OnClick = CbIntDesvioAuditoriaClick
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
      object CbIntDesvioRota: TComboBox
        Left = 181
        Top = 63
        Width = 71
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TabStop = False
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
      object CbIntBalancaPrecisao: TComboBox
        Left = 181
        Top = 24
        Width = 71
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        TabStop = False
        Items.Strings = (
          'N'#227'o'
          'Sim')
      end
      object CbIntPickingByVoiceModelo: TComboBox
        Left = 358
        Top = 176
        Width = 212
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        TabStop = False
      end
      object CbIntPickingByLightModelo: TComboBox
        Left = 358
        Top = 141
        Width = 212
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        TabStop = False
      end
      object CbIntDesvioAuditoriaTipo: TComboBox
        Left = 358
        Top = 103
        Width = 89
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        TabStop = False
        Items.Strings = (
          'Aleat'#243'rio'
          'Manual')
      end
    end
    object TabProdutividade: TcxTabSheet
      CustomHint = BalloonHint1
      Caption = 'Produtividade'
      ImageIndex = 6
      object GroupBox15: TGroupBox
        Left = 12
        Top = 8
        Width = 335
        Height = 399
        CustomHint = BalloonHint1
        Caption = ' [ Produtividade Homem Hora / Unidades por Hora ] '
        TabOrder = 0
        object Label59: TLabel
          Left = 60
          Top = 94
          Width = 84
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Armazenagem'
        end
        object Label60: TLabel
          Left = 179
          Top = 75
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label61: TLabel
          Left = 230
          Top = 75
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label62: TLabel
          Left = 82
          Top = 144
          Width = 62
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Separa'#231#227'o'
        end
        object Label63: TLabel
          Left = 230
          Top = 125
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label64: TLabel
          Left = 179
          Top = 125
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label65: TLabel
          Left = 20
          Top = 198
          Width = 124
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'CheckOut Fracionado'
        end
        object Label66: TLabel
          Left = 230
          Top = 179
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label67: TLabel
          Left = 179
          Top = 179
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label68: TLabel
          Left = 13
          Top = 252
          Width = 131
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'CheckOut Cxa.Fechada'
        end
        object Label69: TLabel
          Left = 179
          Top = 233
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label70: TLabel
          Left = 230
          Top = 233
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label71: TLabel
          Left = 84
          Top = 304
          Width = 60
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Expedi'#231#227'o'
        end
        object Label72: TLabel
          Left = 179
          Top = 285
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label73: TLabel
          Left = 230
          Top = 285
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label74: TLabel
          Left = 42
          Top = 356
          Width = 102
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Reposi'#231#227'o Coleta'
        end
        object Label75: TLabel
          Left = 179
          Top = 337
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label76: TLabel
          Left = 230
          Top = 337
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object Label77: TLabel
          Left = 60
          Top = 43
          Width = 76
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Recebimento'
        end
        object Label78: TLabel
          Left = 179
          Top = 24
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Meta'
        end
        object Label79: TLabel
          Left = 230
          Top = 24
          Width = 59
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Toler'#226'ncia'
        end
        object EdtArmanenagemMeta: TJvCalcEdit
          Left = 150
          Top = 91
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '#0'
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
        end
        object EdtArmanenagemTolerancia: TJvCalcEdit
          Left = 230
          Top = 91
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = False
        end
        object EdtSeparacaoFracionadoMeta: TJvCalcEdit
          Left = 150
          Top = 141
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = False
        end
        object EdtSeparacaoFracionadoTolerancia: TJvCalcEdit
          Left = 230
          Top = 141
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 5
          DecimalPlacesAlwaysShown = False
        end
        object EdtCheckOutFracionadoMeta: TJvCalcEdit
          Left = 150
          Top = 195
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 6
          DecimalPlacesAlwaysShown = False
        end
        object EdtCheckOutFracionadoTolerancia: TJvCalcEdit
          Left = 230
          Top = 195
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 7
          DecimalPlacesAlwaysShown = False
        end
        object EdtCheckOutCxaFechadaMeta: TJvCalcEdit
          Left = 150
          Top = 249
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 8
          DecimalPlacesAlwaysShown = False
        end
        object EdtCheckOutCxaFechadaTolerancia: TJvCalcEdit
          Left = 230
          Top = 249
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 9
          DecimalPlacesAlwaysShown = False
        end
        object EdtExpedicaoTolerancia: TJvCalcEdit
          Left = 230
          Top = 301
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 11
          DecimalPlacesAlwaysShown = False
        end
        object EdtExpedicaoMeta: TJvCalcEdit
          Left = 150
          Top = 301
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 10
          DecimalPlacesAlwaysShown = False
        end
        object EdtReposicaoColetaMeta: TJvCalcEdit
          Left = 150
          Top = 353
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 12
          DecimalPlacesAlwaysShown = False
        end
        object EdtReposicaoColetaTolerancia: TJvCalcEdit
          Left = 230
          Top = 353
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 13
          DecimalPlacesAlwaysShown = False
        end
        object EdtCheckInMeta: TJvCalcEdit
          Left = 150
          Top = 40
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '#0'
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
        end
        object EdtCheckInTolerancia: TJvCalcEdit
          Left = 230
          Top = 40
          Width = 59
          Height = 25
          CustomHint = BalloonHint1
          DecimalPlaces = 0
          DisplayFormat = '0'
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = False
        end
      end
    end
  end
  inherited PnHeader: TPanel
    inherited PanWin8: TPanel
      inherited BtnIncluir: TsImage
        Left = 581
        Visible = False
        ExplicitLeft = 581
      end
      inherited BtnExcluir: TsImage
        Left = 628
        Visible = False
        ExplicitLeft = 628
      end
      inherited BtnFechar: TsImage
        Left = 435
        ExplicitLeft = 435
      end
      inherited BtnSalvar: TsImage
        Left = 161
        ExplicitLeft = 161
      end
      inherited BtnCancelar: TsImage
        Left = 116
        ExplicitLeft = 116
      end
      inherited BtnEditar: TsImage
        Left = 68
        ExplicitLeft = 68
      end
      inherited BtnPesquisarStand: TsImage
        Left = 207
        ExplicitLeft = 207
      end
      inherited BtnImprimirStand: TsImage
        Left = 252
        ExplicitLeft = 252
      end
      inherited BtnExportarStand: TsImage
        Left = 298
        ExplicitLeft = 298
      end
      inherited BtnExportarPDF: TsImage
        Left = 343
        ExplicitLeft = 343
      end
      inherited BtnImportarStand: TsImage
        Left = 389
        ExplicitLeft = 389
      end
    end
  end
  inherited PnlImgObjeto: TPanel
    Left = 874
    Top = -103
    ExplicitLeft = 874
    ExplicitTop = -103
  end
  inherited PnlErro: TPanel
    Top = 659
    ExplicitTop = 659
    inherited LblMensShowErro: TLabel
      Width = 1156
      Height = 22
    end
  end
  inherited PnlConfigPrinter: TPanel
    Left = 730
    Top = -102
    ExplicitLeft = 730
    ExplicitTop = -102
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
  object ACBrETQ: TACBrETQ
    Porta = 'LPT1'
    Ativo = False
    Left = 400
    Top = 48
  end
end
