inherited ServiceEnderecos: TServiceEnderecos
  inherited mtPesquisa: TFDMemTable
    Left = 72
    object mtPesquisaEnderecoId: TIntegerField
      FieldName = 'EnderecoId'
    end
    object mtPesquisaEndereco: TStringField
      FieldName = 'Endereco'
      Size = 11
    end
    object mtPesquisaEstrutura: TStringField
      FieldName = 'Estrutura'
      Size = 30
    end
    object mtPesquisaRua: TStringField
      FieldName = 'Rua'
      Size = 30
    end
    object mtPesquisaLado: TStringField
      FieldName = 'Lado'
      OnGetText = mtPesquisaLadoGetText
      Size = 1
    end
    object mtPesquisaZona: TStringField
      FieldName = 'Zona'
      Size = 30
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroEnderecoId: TIntegerField
      FieldName = 'EnderecoId'
    end
    object mtCadastroEndereco: TStringField
      FieldName = 'Endereco'
      Size = 11
    end
    object mtCadastroEstrutura: TStringField
      FieldName = 'Estrutura'
      Size = 30
    end
    object mtCadastroRua: TStringField
      FieldName = 'Rua'
      Size = 30
    end
    object mtCadastroLado: TStringField
      FieldName = 'Lado'
      Size = 1
    end
    object mtCadastroZona: TStringField
      FieldName = 'Zona'
      Size = 30
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
