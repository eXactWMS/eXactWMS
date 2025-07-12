inherited ServicePessoas: TServicePessoas
  inherited mtPesquisa: TFDMemTable
    object mtPesquisapessoaid: TIntegerField
      FieldName = 'pessoaid'
    end
    object mtPesquisacodpessoaerp: TIntegerField
      FieldName = 'codpessoaerp'
    end
    object mtPesquisarazao: TStringField
      FieldName = 'razao'
      Size = 100
    end
    object mtPesquisafantasia: TStringField
      FieldName = 'fantasia'
      Size = 100
    end
    object mtPesquisacnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object mtPesquisaemail: TStringField
      FieldName = 'email'
      Size = 100
    end
    object mtPesquisarotaid: TIntegerField
      FieldName = 'rotaid'
    end
    object mtPesquisarota: TStringField
      FieldName = 'rota'
      Size = 60
    end
    object mtPesquisastatus: TIntegerField
      FieldName = 'status'
      OnGetText = mtPesquisastatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastropessoaid: TIntegerField
      FieldName = 'pessoaid'
    end
    object mtCadastrocodpessoaerp: TIntegerField
      FieldName = 'codpessoaerp'
    end
    object mtCadastrorazao: TStringField
      FieldName = 'razao'
      Size = 100
    end
    object mtCadastrofantasia: TStringField
      FieldName = 'fantasia'
      Size = 100
    end
    object mtCadastrocnpj: TStringField
      FieldName = 'cnpj'
      Size = 14
    end
    object mtCadastroemail: TStringField
      FieldName = 'email'
      Size = 100
    end
    object mtCadastrorotaid: TIntegerField
      FieldName = 'rotaid'
    end
    object mtCadastrorota: TStringField
      FieldName = 'rota'
      Size = 60
    end
    object mtCadastrostatus: TIntegerField
      FieldName = 'status'
    end
  end
end
