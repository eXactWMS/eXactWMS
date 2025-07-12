inherited frmParametrosCadastrar: TfrmParametrosCadastrar
  Caption = 'Par'#226'metros'
  ClientHeight = 412
  ClientWidth = 564
  ExplicitWidth = 580
  ExplicitHeight = 451
  PixelsPerInch = 96
  TextHeight = 16
  object lstGrupos: TListBox [0]
    Left = 8
    Top = 8
    Width = 119
    Height = 396
    Anchors = [akLeft, akTop, akBottom]
    Ctl3D = True
    Items.Strings = (
      'Cross Docking'
      'Entrada'
      'Expedi'#231#227'o'
      'Sa'#237'da'
      'Sistema - Geral')
    ParentCtl3D = False
    TabOrder = 2
    OnClick = lstGruposClick
  end
  object pgcParametros: TPageControl [1]
    Left = 133
    Top = 8
    Width = 423
    Height = 396
    ActivePage = pgSaida
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    TabStop = False
    object pgEntrada: TTabSheet
      Caption = 'pgEntrada'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        415
        386)
      object chkPermitirAlterarTipo: TCheckBox
        Left = 12
        Top = 12
        Width = 181
        Height = 17
        Caption = 'Permitir Alterar Tipo de Entrada'
        TabOrder = 0
        OnClick = chkPermitirAlterarTipoClick
      end
      object edtEntradaValidadeMinimaPadrao: TLabeledEdit
        Left = 12
        Top = 41
        Width = 43
        Height = 21
        BiDiMode = bdRightToLeft
        EditLabel.Width = 189
        EditLabel.Height = 16
        EditLabel.BiDiMode = bdLeftToRight
        EditLabel.Caption = 'Validade M'#237'nima Padr'#227'o (meses)'
        EditLabel.ParentBiDiMode = False
        LabelPosition = lpRight
        LabelSpacing = 6
        ParentBiDiMode = False
        TabOrder = 1
        OnChange = edtEntradaValidadeMinimaPadraoChange
        OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
      end
      object GroupBox1: TGroupBox
        Left = 12
        Top = 122
        Width = 389
        Height = 119
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Indicadores'
        TabOrder = 2
        object grpEficiencia: TGroupBox
          Left = 20
          Top = 17
          Width = 132
          Height = 88
          Caption = 'Efici'#234'ncia'
          TabOrder = 0
          object edtEntradaIndicadoresEficienciaMeta: TLabeledEdit
            Left = 12
            Top = 25
            Width = 43
            Height = 21
            BiDiMode = bdRightToLeft
            Color = 8454016
            EditLabel.Width = 54
            EditLabel.Height = 16
            EditLabel.BiDiMode = bdLeftToRight
            EditLabel.Caption = 'Meta (%)'
            EditLabel.ParentBiDiMode = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            LabelPosition = lpRight
            LabelSpacing = 6
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            StyleElements = [seFont, seBorder]
            OnChange = edtEntradaIndicadoresEficienciaMetaChange
            OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
          end
          object edtEntradaIndicadoresEficienciaAceitavel: TLabeledEdit
            Left = 12
            Top = 52
            Width = 43
            Height = 21
            BiDiMode = bdRightToLeft
            Color = 8454143
            EditLabel.Width = 77
            EditLabel.Height = 16
            EditLabel.BiDiMode = bdLeftToRight
            EditLabel.Caption = 'Aceit'#225'vel (%)'
            EditLabel.ParentBiDiMode = False
            LabelPosition = lpRight
            LabelSpacing = 6
            ParentBiDiMode = False
            TabOrder = 1
            StyleElements = [seFont, seBorder]
            OnChange = edtEntradaIndicadoresEficienciaAceitavelChange
            OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
          end
        end
      end
      object EdtAnoVencProdCtrlEntr: TLabeledEdit
        Left = 12
        Top = 77
        Width = 43
        Height = 21
        BiDiMode = bdRightToLeft
        EditLabel.Width = 338
        EditLabel.Height = 16
        EditLabel.BiDiMode = bdLeftToRight
        EditLabel.Caption = 'Validade em Anos para Produtos com Controle por Entrada'
        EditLabel.ParentBiDiMode = False
        LabelPosition = lpRight
        LabelSpacing = 6
        ParentBiDiMode = False
        TabOrder = 3
        OnChange = EdtAnoVencProdCtrlEntrChange
        OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
      end
    end
    object pgSaida: TTabSheet
      Caption = 'Sa'#237'da'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        415
        386)
      object lblTipoSeparacao: TLabel
        Left = 181
        Top = 198
        Width = 108
        Height = 16
        Caption = 'Tipo de Separa'#231#227'o'
      end
      object lblTipoIdentificacaoVolume: TLabel
        Left = 12
        Top = 198
        Width = 184
        Height = 16
        Caption = 'Tipo de Identifica'#231#227'o do Volume'
      end
      object Label1: TLabel
        Left = 284
        Top = 198
        Width = 135
        Height = 16
        Caption = 'Ordenar Separa'#231#227'o por'
      end
      object Bevel1: TBevel
        Left = 10
        Top = 122
        Width = 265
        Height = 50
      end
      object Label2: TLabel
        Left = 328
        Top = 136
        Width = 55
        Height = 16
        Caption = '(Desktop)'
      end
      object chkExibirDadosCliente: TCheckBox
        Left = 12
        Top = 31
        Width = 141
        Height = 17
        Caption = 'Exibir Dados do Cliente'
        TabOrder = 1
        OnClick = chkExibirDadosClienteClick
      end
      object chkHabilitarConferenciaCaixaFechadaDesktop: TCheckBox
        Left = 12
        Top = 77
        Width = 269
        Height = 17
        Caption = 'Habilitar Confer'#234'ncia de Caixa Fechada no Desktop'
        TabOrder = 3
        OnClick = chkHabilitarConferenciaCaixaFechadaDesktopClick
      end
      object edtSaidaEficienciaMinima: TLabeledEdit
        Left = 12
        Top = 250
        Width = 43
        Height = 24
        BiDiMode = bdRightToLeft
        EditLabel.Width = 124
        EditLabel.Height = 16
        EditLabel.BiDiMode = bdLeftToRight
        EditLabel.Caption = 'Efici'#234'ncia M'#237'nima (%)'
        EditLabel.ParentBiDiMode = False
        LabelPosition = lpRight
        LabelSpacing = 6
        ParentBiDiMode = False
        TabOrder = 8
        OnChange = edtSaidaEficienciaMinimaChange
        OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
      end
      object GroupBox3: TGroupBox
        Left = 12
        Top = 278
        Width = 389
        Height = 108
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Indicadores'
        TabOrder = 10
        object GroupBox4: TGroupBox
          Left = 7
          Top = 15
          Width = 196
          Height = 88
          Caption = 'Produtividade da Confer'#234'ncia'
          TabOrder = 0
          object edtSaidaIndicadoresProdutividadeMeta: TLabeledEdit
            Left = 12
            Top = 25
            Width = 65
            Height = 21
            BiDiMode = bdRightToLeft
            Color = 8454016
            EditLabel.Width = 98
            EditLabel.Height = 16
            EditLabel.BiDiMode = bdLeftToRight
            EditLabel.Caption = 'Meta (und./hora)'
            EditLabel.ParentBiDiMode = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            LabelPosition = lpRight
            LabelSpacing = 6
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 0
            StyleElements = [seFont, seBorder]
            OnChange = edtSaidaIndicadoresProdutividadeMetaChange
            OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
          end
          object edtSaidaIndicadoresProdutividadeAceitavel: TLabeledEdit
            Left = 12
            Top = 52
            Width = 65
            Height = 24
            BiDiMode = bdRightToLeft
            Color = 8454143
            EditLabel.Width = 124
            EditLabel.Height = 16
            EditLabel.BiDiMode = bdLeftToRight
            EditLabel.Caption = 'Aceit'#225'vel (unid./hora)'
            EditLabel.ParentBiDiMode = False
            LabelPosition = lpRight
            LabelSpacing = 6
            ParentBiDiMode = False
            TabOrder = 1
            StyleElements = [seFont, seBorder]
            OnChange = edtSaidaIndicadoresProdutividadeAceitavelChange
            OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
          end
        end
      end
      object chkExibirEstoquePendenciaConferencia: TCheckBox
        Left = 12
        Top = 54
        Width = 237
        Height = 17
        Caption = 'Exibir Estoque na Pend'#234'ncia da Confer'#234'ncia'
        TabOrder = 2
        OnClick = chkExibirEstoquePendenciaConferenciaClick
      end
      object chkBuscarAreaEspera: TCheckBox
        Left = 12
        Top = 9
        Width = 197
        Height = 17
        Caption = 'Buscar Produtos na '#193'rea de Espera'
        TabOrder = 0
        OnClick = chkBuscarAreaEsperaClick
      end
      object cbbTipoSeparacao: TComboBox
        Left = 181
        Top = 214
        Width = 89
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 6
        Text = 'Picking'
        OnClick = cbbTipoSeparacaoClick
        Items.Strings = (
          'Picking'
          'Pallet')
      end
      object chkImprimirQuebraLote: TCheckBox
        Left = 12
        Top = 99
        Width = 209
        Height = 17
        Caption = 'Imprimir Relat'#243'rio de Quebra de Lote'
        TabOrder = 4
        OnClick = chkImprimirQuebraLoteClick
      end
      object cbbTipoIdentificacaoVolume: TComboBox
        Left = 12
        Top = 214
        Width = 152
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 5
        Text = 'Etiqueta'
        OnClick = cbbTipoIdentificacaoVolumeClick
        Items.Strings = (
          'Etiqueta'
          'Papel')
      end
      object cbbOrdemSeparacao: TComboBox
        Left = 284
        Top = 214
        Width = 113
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 7
        Text = 'Pedido'
        OnClick = cbbOrdemSeparacaoClick
        Items.Strings = (
          'Pedido'
          'Esta'#231#227'o')
      end
      object edtSaidaValidadeMinimaPadrao: TLabeledEdit
        Left = 181
        Top = 250
        Width = 43
        Height = 24
        BiDiMode = bdRightToLeft
        EditLabel.Width = 189
        EditLabel.Height = 16
        EditLabel.BiDiMode = bdLeftToRight
        EditLabel.Caption = 'Validade M'#237'nima Padr'#227'o (meses)'
        EditLabel.ParentBiDiMode = False
        LabelPosition = lpRight
        LabelSpacing = 6
        ParentBiDiMode = False
        TabOrder = 9
        OnChange = edtSaidaValidadeMinimaPadraoChange
        OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
      end
      object ChkSeparacaoColetor: TCheckBox
        Left = 12
        Top = 122
        Width = 127
        Height = 17
        Caption = 'Separa'#231#227'o Coletor'
        TabOrder = 11
        OnClick = ChkSeparacaoColetorClick
      end
      object ChkSeparacaoConferencia: TCheckBox
        Left = 284
        Top = 122
        Width = 129
        Height = 17
        Hint = 'Confer'#234'ncia na Separa'#231#227'o Sem Uso de CheckOut'
        Caption = 'Separa'#231#227'o/Confer'#234'ncia'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
        OnClick = ChkSeparacaoConferenciaClick
      end
      object ChksaiRegistrarSeparacao: TCheckBox
        Left = 12
        Top = 175
        Width = 193
        Height = 17
        Caption = 'Finalizar Separa'#231#227'o p/ Confer'#234'ncia'
        TabOrder = 13
        OnClick = ChksaiRegistrarSeparacaoClick
      end
      object ChkSeparacaoConferenciaColetor: TCheckBox
        Left = 28
        Top = 138
        Width = 147
        Height = 17
        Caption = 'Confer'#234'ncia Autom'#225'tica'
        TabOrder = 15
        OnClick = ChkSeparacaoConferenciaColetorClick
      end
      object ChkForcarBeepConferencia: TCheckBox
        Left = 28
        Top = 156
        Width = 159
        Height = 17
        Caption = 'For'#231'ar Beep Individual p/ at'#233
        TabOrder = 16
        OnClick = ChkForcarBeepConferenciaClick
      end
      object EdtSkuBeep: TLabeledEdit
        Left = 193
        Top = 154
        Width = 43
        Height = 24
        BiDiMode = bdRightToLeft
        EditLabel.Width = 34
        EditLabel.Height = 16
        EditLabel.BiDiMode = bdLeftToRight
        EditLabel.Caption = 'Sku'#180's'
        EditLabel.ParentBiDiMode = False
        LabelPosition = lpRight
        LabelSpacing = 6
        ParentBiDiMode = False
        TabOrder = 14
        OnChange = EdtSkuBeepChange
        OnKeyPress = edtEntradaValidadeMinimaPadraoKeyPress
      end
    end
    object pgExpedicao: TTabSheet
      Caption = 'Expedi'#231#227'o'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblTipoConferencia: TLabel
        Left = 12
        Top = 35
        Width = 115
        Height = 16
        Caption = 'Tipo de Confer'#234'ncia'
      end
      object chkHabilitarConferenciaManual: TCheckBox
        Left = 12
        Top = 12
        Width = 165
        Height = 17
        Caption = 'Habilitar Confer'#234'ncia Manual'
        TabOrder = 0
        OnClick = chkHabilitarConferenciaManualClick
      end
      object cbbTipoConferencia: TComboBox
        Left = 12
        Top = 51
        Width = 117
        Height = 22
        Style = csOwnerDrawFixed
        ItemIndex = 0
        TabOrder = 1
        Text = 'Por Cliente'
        OnClick = cbbTipoConferenciaClick
        Items.Strings = (
          'Por Cliente'
          'Por Sa'#237'da')
      end
      object chkHabilitarRegistroEntregaManual: TCheckBox
        Left = 12
        Top = 92
        Width = 205
        Height = 17
        Caption = 'Habilitar Registro de Entrega Manual'
        TabOrder = 2
        OnClick = chkHabilitarRegistroEntregaManualClick
      end
      object chkPermitirDigitacaoColetor: TCheckBox
        Left = 12
        Top = 115
        Width = 165
        Height = 17
        Caption = 'Permitir Digita'#231#227'o no Coletor'
        TabOrder = 3
        OnClick = chkPermitirDigitacaoColetorClick
      end
    end
    object pgCrossDocking: TTabSheet
      Caption = 'pgCrossDocking'
      ImageIndex = 3
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object chkConferirSeparacao: TCheckBox
        Left = 12
        Top = 12
        Width = 133
        Height = 17
        Caption = 'Conferir a Separa'#231#227'o'
        TabOrder = 0
        OnClick = chkConferirSeparacaoClick
      end
    end
    object TabSistema: TTabSheet
      Caption = 'Sistema - Geral'
      ImageIndex = 4
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object ChkInvExMotivoDiv: TCheckBox
        Left = 14
        Top = 48
        Width = 227
        Height = 17
        Caption = 'Invent'#225'tio - Exigir Motivo da Diverg'#234'ncia'
        TabOrder = 0
        OnClick = ChkInvExMotivoDivClick
      end
      object ChkArmazenagemVisualizarEstoque: TCheckBox
        Left = 14
        Top = 18
        Width = 299
        Height = 17
        Caption = 'Coletor Armazenagem: Visualizar Estoque'
        TabOrder = 1
        OnClick = ChkArmazenagemVisualizarEstoqueClick
      end
      object ChkReposicaoColetor: TCheckBox
        Left = 14
        Top = 78
        Width = 299
        Height = 17
        Caption = 'Reposi'#231#227'o Coletor'
        TabOrder = 2
        OnClick = ChkReposicaoColetorClick
      end
    end
  end
  inherited PnlMenuFormStand: TPanel
    Top = 360
    Width = 564
    ExplicitTop = 360
    ExplicitWidth = 564
  end
  inherited JvComputerInfoEx1: TJvComputerInfoEx
    Left = 434
    Top = 30
  end
end
