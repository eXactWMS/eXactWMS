inherited ServiceRotas: TServiceRotas
  inherited mtPesquisa: TFDMemTable
    object mtPesquisarotaid: TIntegerField
      FieldName = 'rotaid'
    end
    object mtPesquisadescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object mtPesquisagooglemaps: TStringField
      FieldName = 'googlemaps'
      Size = 120
    end
    object mtPesquisalatitude: TStringField
      FieldName = 'latitude'
      Size = 30
    end
    object mtPesquisalongitude: TStringField
      FieldName = 'longitude'
      Size = 30
    end
    object mtPesquisadtincluscao: TDateField
      FieldName = 'dtincluscao'
      OnGetText = mtPesquisadtincluscaoGetText
    end
    object mtPesquisahrinclusao: TIntegerField
      FieldName = 'hrinclusao'
    end
    object mtPesquisastatus: TIntegerField
      FieldName = 'status'
      OnGetText = mtPesquisastatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastrorotaid: TIntegerField
      FieldName = 'rotaid'
    end
    object mtCadastrodescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object mtCadastrogooglemaps: TStringField
      FieldName = 'googlemaps'
      Size = 120
    end
    object mtCadastrolatitude: TStringField
      FieldName = 'latitude'
      Size = 30
    end
    object mtCadastrolongitude: TStringField
      FieldName = 'longitude'
      Size = 30
    end
    object mtCadastrodtinclusao: TIntegerField
      FieldName = 'dtinclusao'
    end
    object mtCadastrohrinclusao: TIntegerField
      FieldName = 'hrinclusao'
    end
    object mtCadastrostatus: TIntegerField
      FieldName = 'status'
    end
  end
end
