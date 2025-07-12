inherited ServiceProdutos: TServiceProdutos
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaIdProduto: TIntegerField
      FieldName = 'IdProduto'
    end
    object mtPesquisaCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 80
    end
    object mtPesquisaUnidadeSecundariaSigla: TStringField
      FieldName = 'UnidadeSecundariaSigla'
      Size = 10
    end
    object mtPesquisaFatorConversao: TIntegerField
      FieldName = 'FatorConversao'
    end
    object mtPesquisaEnderecoDescricao: TStringField
      FieldName = 'EnderecoDescricao'
      Size = 11
    end
    object mtPesquisaRastroDescricao: TStringField
      FieldName = 'RastroDescricao'
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroIdProduto: TIntegerField
      FieldName = 'IdProduto'
    end
    object mtCadastroCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 80
    end
    object mtCadastroUnidadeSecundariaSigla: TStringField
      FieldName = 'UnidadeSecundariaSigla'
      Size = 10
    end
    object mtCadastroFatorConversao: TIntegerField
      FieldName = 'FatorConversao'
    end
    object mtCadastroEnderecoDescricao: TStringField
      FieldName = 'EnderecoDescricao'
      Size = 11
    end
    object mtCadastroRastroDescricao: TStringField
      FieldName = 'RastroDescricao'
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
