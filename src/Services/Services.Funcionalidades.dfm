inherited ServiceFuncionalidade: TServiceFuncionalidade
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaFuncionalidadeId: TIntegerField
      FieldName = 'FuncionalidadeId'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroFuncionalidadeId: TIntegerField
      FieldName = 'FuncionalidadeId'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
