inherited FrmEnderecamentoZonas: TFrmEnderecamentoZonas
  Caption = 'FrmEnderecamentoZonas'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    Properties.ActivePage = TabPrincipal
    inherited TabListagem: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstCadastro: TAdvStringGrid
        ColumnHeaders.Strings = (
          'Id'
          'Descri'#231#227'o'
          'Estrutura'
          'Estoque Tipo'
          'Rastro'
          'Lote Repo.'
          'Sep.Cons.'
          'Sngpc'
          'Audit'#225'vel')
      end
    end
    inherited TabPrincipal: TcxTabSheet
      inherited ShCadastro: TShape
        Left = 79
        Top = 322
        Visible = False
        ExplicitLeft = 79
        ExplicitTop = 322
      end
      object Label2: TLabel [1]
        Left = 90
        Top = 43
        Width = 11
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Id'
      end
      object Label3: TLabel [2]
        Left = 44
        Top = 105
        Width = 57
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Descri'#231#227'o'
      end
      object lblEndereco: TLabel [3]
        Left = 49
        Top = 161
        Width = 52
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Estrutura'
      end
      object LblEstrutura: TLabel [4]
        Left = 182
        Top = 162
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
      object Label4: TLabel [5]
        Left = 334
        Top = 161
        Width = 77
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Estoque Tipo'
      end
      object Label23: TLabel [6]
        Left = 10
        Top = 215
        Width = 91
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Rastreabilidade'
      end
      object Label40: TLabel [7]
        Left = 286
        Top = 215
        Width = 125
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Ordem de Impress'#227'o'
      end
      object Label5: TLabel [8]
        Left = 714
        Top = 105
        Width = 28
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Sigla'
      end
      object Label6: TLabel [9]
        Left = 644
        Top = 161
        Width = 98
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Picking Din'#226'mico'
      end
      inherited PnlInfo: TPanel
        Left = -4
        Top = 414
        TabOrder = 13
        ExplicitLeft = -4
        ExplicitTop = 414
      end
      inherited ChkCadastro: TCheckBox
        Left = 24
        Top = 327
        TabOrder = 12
        ExplicitLeft = 24
        ExplicitTop = 327
      end
      object EdtZonaId: TEdit
        Left = 107
        Top = 40
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
        TabOrder = 0
        OnExit = EdtZonaIdExit
        OnKeyPress = EdtZonaIdKeyPress
        OnKeyUp = EdtZonaIdKeyUp
      end
      object EdtDescricao: TEdit
        Left = 107
        Top = 102
        Width = 492
        Height = 25
        CustomHint = BalloonHint1
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 1
      end
      object EdtEstruturaId: TEdit
        Left = 107
        Top = 158
        Width = 46
        Height = 25
        CustomHint = BalloonHint1
        Alignment = taRightJustify
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = EdtEstruturaIdChange
        OnExit = EdtEstruturaIdExit
        OnKeyPress = EdtZonaIdKeyPress
      end
      object BtnPesqEstrutura: TBitBtn
        Left = 153
        Top = 159
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
        TabOrder = 14
        TabStop = False
        OnClick = BtnPesqEstruturaClick
      end
      object CbEstoqueTipo: TComboBox
        Left = 417
        Top = 158
        Width = 182
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
        Items.Strings = (
          'Stage - Armazenagem'
          'Crossdocking'
          'Segregado'
          'Producao'
          'Expedicao'
          'Reserva')
      end
      object CbRastroTipo: TComboBox
        Left = 107
        Top = 212
        Width = 146
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Items.Strings = (
          'Cliente'
          'Fornecedor')
      end
      object ChkLoteReposicao: TCheckBox
        Left = 24
        Top = 264
        Width = 242
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Solicitar Lote na Separa'#231#227'o/Reposi'#231#227'o de Picking'
        TabOrder = 8
      end
      object ChkSeparacaoConsolidada: TCheckBox
        Left = 24
        Top = 295
        Width = 308
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Separa'#231#227'o Consolidada(CheckOut Autom'#225'tico)'
        TabOrder = 10
      end
      object ChkProdutoSngpc: TCheckBox
        Left = 417
        Top = 264
        Width = 308
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Produtos SNGPC'
        TabOrder = 9
      end
      object CbTagVolumeOrdem: TComboBox
        Left = 417
        Top = 213
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
        TabOrder = 7
        TabStop = False
        Items.Strings = (
          'Pedido'
          'Endere'#231'o + Rota + Loja'
          'Endere'#231'o + Rota +  Produto')
      end
      object EdtSigla: TEdit
        Left = 751
        Top = 102
        Width = 124
        Height = 25
        CustomHint = BalloonHint1
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 2
      end
      object CbPickingDinamico: TComboBox
        Left = 751
        Top = 158
        Width = 124
        Height = 22
        CustomHint = BalloonHint1
        Style = csOwnerDrawFixed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Items.Strings = (
          'N'#227'o'
          'Sim'
          '')
      end
      object ChkAuditavel: TCheckBox
        Left = 417
        Top = 295
        Width = 155
        Height = 17
        CustomHint = BalloonHint1
        TabStop = False
        Caption = 'Audit'#225'vel na Entrega'
        TabOrder = 11
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
    Left = 720
    Top = 362
    ExplicitLeft = 720
    ExplicitTop = 362
    inherited Panel7: TPanel
      inherited LblTitConfigPrinter: TLabel
        Width = 313
      end
    end
  end
end
