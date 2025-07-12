inherited ServicesVeiculos: TServicesVeiculos
  inherited mtPesquisa: TFDMemTable
    AfterOpen = mtPesquisaAfterOpen
    object mtPesquisaveiculoid: TIntegerField
      FieldName = 'veiculoid'
    end
    object mtPesquisaplaca: TStringField
      FieldName = 'placa'
      Size = 7
    end
    object mtPesquisatipo: TStringField
      FieldName = 'tipo'
      Size = 100
    end
    object mtPesquisamarca: TStringField
      FieldName = 'marca'
      Size = 40
    end
    object mtPesquisamodelo: TStringField
      FieldName = 'modelo'
      Size = 30
    end
    object mtPesquisacor: TStringField
      FieldName = 'cor'
    end
    object mtPesquisatara: TFloatField
      FieldName = 'tarakg'
    end
    object mtPesquisacapacidade: TFloatField
      FieldName = 'capacidade'
    end
    object mtPesquisatransportadoraid: TIntegerField
      FieldName = 'transportadoraid'
    end
    object mtPesquisatransportadora: TStringField
      FieldName = 'transportadora'
      Size = 100
    end
    object mtPesquisastatus: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'status'
      OnGetText = mtPesquisastatusGetText
    end
    object mtPesquisaVolume: TFloatField
      FieldName = 'Volume'
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroveiculoid: TIntegerField
      FieldName = 'veiculoid'
    end
    object mtCadastroplaca: TStringField
      FieldName = 'placa'
      Size = 7
    end
    object mtCadastromarca: TStringField
      FieldName = 'marca'
      Size = 40
    end
    object mtCadastromodelo: TStringField
      FieldName = 'modelo'
      Size = 30
    end
    object mtCadastrocor: TStringField
      FieldName = 'cor'
    end
    object mtCadastrotara: TIntegerField
      FieldName = 'tara'
    end
    object mtCadastrocapacidade: TIntegerField
      FieldName = 'capacidade'
    end
    object mtCadastrotransportadoraid: TIntegerField
      FieldName = 'transportadoraid'
    end
    object mtCadastrotransportadora: TStringField
      FieldName = 'transportadora'
      Size = 100
    end
    object mtCadastrostatus: TIntegerField
      FieldName = 'status'
    end
  end
end
