inherited ServiceLaboratorios: TServiceLaboratorios
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaidlaboratorio: TIntegerField
      FieldName = 'idlaboratorio'
    end
    object mtPesquisacoderp: TIntegerField
      FieldName = 'coderp'
    end
    object mtPesquisanome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object mtPesquisafone: TStringField
      FieldName = 'fone'
      Size = 11
    end
    object mtPesquisaemail: TStringField
      FieldName = 'email'
      Size = 100
    end
    object mtPesquisahomepage: TStringField
      FieldName = 'homepage'
      Size = 100
    end
    object mtPesquisastatus: TIntegerField
      FieldName = 'status'
      OnGetText = mtPesquisastatusGetText
    end
    object mtPesquisauuid: TStringField
      FieldName = 'uuid'
      Size = 36
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    Left = 148
    object mtCadastroidlaboratorio: TIntegerField
      FieldName = 'idlaboratorio'
    end
    object mtCadastrocoderp: TIntegerField
      FieldName = 'coderp'
    end
    object mtCadastronome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object mtCadastrofone: TStringField
      FieldName = 'fone'
      Size = 11
    end
    object mtCadastroemail: TStringField
      FieldName = 'email'
      Size = 100
    end
    object mtCadastrohomepage: TStringField
      FieldName = 'homepage'
      Size = 100
    end
    object mtCadastrostatus: TIntegerField
      FieldName = 'status'
    end
    object mtCadastrouuid: TStringField
      FieldName = 'uuid'
      Size = 36
    end
  end
end
