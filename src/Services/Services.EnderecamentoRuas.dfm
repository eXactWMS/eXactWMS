inherited ServiceEnderecamentoRuas: TServiceEnderecamentoRuas
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaRuaId: TIntegerField
      FieldName = 'RuaId'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtPesquisaLado: TStringField
      FieldName = 'Lado'
      Size = 1
    end
    object mtPesquisaOrdem: TIntegerField
      FieldName = 'Ordem'
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroRuaId: TIntegerField
      FieldName = 'RuaId'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtCadastroLado: TStringField
      FieldName = 'Lado'
      Size = 1
    end
    object mtCadastroOrdem: TIntegerField
      FieldName = 'Ordem'
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
