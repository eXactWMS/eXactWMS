inherited ServiceDesenhoArmazem: TServiceDesenhoArmazem
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaId: TIntegerField
      FieldName = 'Id'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    Left = 146
    object mtCadastroid: TIntegerField
      FieldName = 'id'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtCadastroStatusGetText
    end
  end
end
