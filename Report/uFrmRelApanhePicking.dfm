inherited FrmRelApanhePicking: TFrmRelApanhePicking
  Caption = 'FrmRelApanhePicking'
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  inherited PgcBase: TcxPageControl
    inherited TabPrincipal: TcxTabSheet
      ExplicitTop = 24
      ExplicitWidth = 1157
      ExplicitHeight = 524
      inherited LstReport: TAdvStringGrid
        Top = 160
        Height = 364
        ColumnHeaders.Strings = (
          'CodProduto'
          'Descri'#231#227'o'
          'FatorConversao'#9
          'Endere'#231'o'
          'Lote'
          'Demanda'
          'Suprida'
          'Estoque'
          'Apanhe')
        ExplicitTop = 160
        ExplicitHeight = 364
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 12
        Width = 167
        Height = 110
        CustomHint = BalloonHint1
        Caption = '[ Per'#237'odo ]'
        TabOrder = 3
        TabStop = True
        object Label2: TLabel
          Left = 22
          Top = 21
          Width = 30
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'In'#237'cio'
        end
        object Label3: TLabel
          Left = 5
          Top = 76
          Width = 47
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'T'#233'rmino'
        end
        object EdtInicio: TJvDateEdit
          Left = 58
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
          TabOrder = 0
          OnChange = EdtInicioChange
        end
        object EdtTermino: TJvDateEdit
          Left = 58
          Top = 75
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
        end
      end
      object GroupBox5: TGroupBox
        Left = 197
        Top = 67
        Width = 570
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Rota ]'
        TabOrder = 4
        object Label13: TLabel
          Left = 7
          Top = 23
          Width = 11
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'Id'
        end
        object LblRota: TLabel
          Left = 100
          Top = 26
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
          OnChange = EdtDestinatarioChange
          OnExit = EdtRotaIdExit
        end
        object BtnPesqRota: TBitBtn
          Left = 70
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
          OnClick = BtnPesqRotaClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 197
        Top = 12
        Width = 570
        Height = 55
        CustomHint = BalloonHint1
        Caption = '[ Destinat'#225'rio ]'
        TabOrder = 5
        TabStop = True
        object Label9: TLabel
          Left = 8
          Top = 21
          Width = 69
          Height = 17
          CustomHint = BalloonHint1
          Caption = 'C'#243'digo ERP'
        end
        object LblDestinatario: TLabel
          Left = 187
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
          Left = 83
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
          OnExit = EdtDestinatarioExit
        end
        object BtnPesqCliente: TBitBtn
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
          OnClick = BtnPesqClienteClick
        end
      end
      object ChkReposicao: TCheckBox
        Left = 8
        Top = 128
        Width = 141
        Height = 17
        CustomHint = BalloonHint1
        Caption = 'Somente Reposi'#231#227'o'
        Enabled = False
        TabOrder = 6
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
  inherited FdMemPesqGeral: TFDMemTable
    Active = True
    OnCalcFields = FdMemPesqGeralCalcFields
    object FdMemPesqGeralProdutoId: TIntegerField
      FieldName = 'ProdutoId'
    end
    object FdMemPesqGeralCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object FdMemPesqGeralDescricao: TStringField
      FieldName = 'Descricao'
      Size = 80
    end
    object FdMemPesqGeralFatorConversao: TStringField
      FieldName = 'FatorConversao'
      Size = 30
    end
    object FdMemPesqGeralEndereco: TStringField
      FieldName = 'Endereco'
      Size = 11
    end
    object FdMemPesqGeralMascara: TStringField
      FieldName = 'Mascara'
      Size = 14
    end
    object FdMemPesqGeralDescrLote: TStringField
      FieldName = 'DescrLote'
      Size = 30
    end
    object FdMemPesqGeralDemanda: TIntegerField
      FieldName = 'Demanda'
    end
    object FdMemPesqGeralQtdSuprida: TIntegerField
      FieldName = 'QtdSuprida'
    end
    object FdMemPesqGeralDisponivel: TIntegerField
      FieldName = 'Disponivel'
    end
    object FdMemPesqGeralApanhe: TIntegerField
      FieldName = 'Apanhe'
    end
    object FdMemPesqGeralEnderecoFormatado: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'EnderecoFormatado'
    end
  end
  inherited frxReport1: TfrxReport
    ReportOptions.LastChange = 44804.000925972220000000
    ScriptText.Strings = (
      ''
      
        'procedure MasterData1OnBeforePrint_inherited(Sender: TfrxCompone' +
        'nt);'
      'begin'
      '  if (<Line#> Mod 2) then Begin'
      '     //frxDBDataset1CodProduto.Color := ClNone;'
      '     //frxDBDataset1Descricao.Color := ClNone;'
      '     //frxDBDataset1Endereco.Color := ClNone;'
      '     //frxDBDataset1Quantidade.Color := ClNone;'
      '     //frxDBDataset1EanPrincipal.Color := ClNone;'
      '     //frxDBDataset1Usuario.Color := ClNone;'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := ClNone;'
      '  End'
      '  else Begin'
      '     //frxDBDataset1CodProduto.Color := $00EBEBEB;'
      '     //frxDBDataset1Descricao.Color := $00EBEBEB;'
      '     //frxDBDataset1Endereco.Color := $00EBEBEB;'
      '     //frxDBDataset1Quantidade.Color := $00EBEBEB;'
      '     //frxDBDataset1EanPrincipal.Color := $00EBEBEB;'
      '     //frxDBDataset1Usuario.Color := $00EBEBEB;'
      '    // MasterData1.Fill.BackColor := $00EBEBEB;'
      '     TfrxBrushFill(MasterData1.Fill).BackColor := $00EBEBEB;'
      '  End;'
      '                    '
      'end;'
      ''
      'Begin'
      ''
      'end.')
    Left = 382
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
      end
      item
        Name = 'vFiltro'
        Value = Null
      end>
    Style = <>
    inherited Page1: TfrxReportPage
      inherited PageHeader1: TfrxPageHeader
        Height = 68.031540000000000000
        inherited Shape1: TfrxShapeView
          Height = 64.252010000000000000
        end
        inherited Memo2: TfrxMemoView
          Memo.UTF8W = (
            'Apanhe Picking')
        end
        inherited Picture1: TfrxPictureView
          Left = 7.559060000000000000
        end
        object MmFiltro: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Left = 47.244125000000000000
          Top = 45.354360000000000000
          Width = 623.622450000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'Filtro')
          ParentFont = False
        end
      end
      inherited ColumnHeader1: TfrxColumnHeader
        Top = 109.606370000000000000
        inherited Memo4: TfrxMemoView
          Left = 3.779530000000000000
          Width = 52.913420000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Id')
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 60.472480000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'C'#243'd.Erp')
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 124.724490000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Descri'#231#227'o')
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 396.850650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          Memo.UTF8W = (
            'Endere'#231'o')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 495.118430000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Demanda')
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 563.149970000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Qtd.Suprida')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 642.520100000000000000
          Width = 68.031500940000000000
          Height = 18.897650000000000000
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            'Dispon'#237'vel')
        end
      end
      inherited PageFooter1: TfrxPageFooter
        Top = 275.905690000000000000
      end
      inherited MasterData1: TfrxMasterData
        Top = 192.756030000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint_inherited'
        inherited frxDBDataset1Background: TfrxMemoView
          Align = baNone
          Left = 631.181510000000000000
          Top = 15.118120000000000000
          Width = 49.133841180000000000
          Height = 18.897650000000000000
          Visible = False
          HAlign = haRight
          Highlight.Condition = ' <frxDBDataset1."Disponivel"> < <frxDBDataset1."QtdSuprida">'
          Highlight.Fill.BackColor = clRed
          Memo.UTF8W = (
            '[frxDBDataset1."Disponivel"]')
          WordWrap = False
        end
        object frxDBDataset1CodProduto: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 60.472480000000000000
          Width = 60.472480000000000000
          Height = 18.897650000000000000
          DataField = 'CodProduto'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."CodProduto"]')
        end
        object frxDBDataset1Descricao: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 124.724490000000000000
          Width = 268.346630000000000000
          Height = 18.897650000000000000
          DataField = 'Descricao'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Descricao"]')
        end
        object frxDBDataset1Quantidade: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 396.850650000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."EnderecoFormatado"]')
        end
        object frxDBDataset1Embalagem: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 495.118430000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."Demanda"]')
        end
        object frxDBDataset1Estoque: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 642.520100000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          DataField = 'Disponivel'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = clRed
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '(<frxDBDataset1."Disponivel"> < <frxDBDataset1."QtdSuprida">)'
          Highlight.FillType = ftBrush
          Highlight.Fill.ForeColor = clRed
          Highlight.Frame.Typ = []
          Memo.UTF8W = (
            '[frxDBDataset1."Disponivel"]')
        end
        object frxDBDataset1ProdutoId: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 52.913390710000000000
          Height = 18.897650000000000000
          DataField = 'ProdutoId'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."ProdutoId"]')
        end
        object frxDBDataset1QtdSuprida: TfrxMemoView
          IndexTag = 1
          AllowVectorExport = True
          Left = 563.149970000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          DataField = 'QtdSuprida'
          DataSet = frxDBDataset1
          DataSetName = 'frxDBDataset1'
          Frame.Typ = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QtdSuprida"]')
        end
      end
    end
  end
end
