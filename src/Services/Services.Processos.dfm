inherited ServiceProcessos: TServiceProcessos
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaProcessoId: TIntegerField
      FieldName = 'ProcessoId'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroProcessoId: TIntegerField
      FieldName = 'ProcessoId'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
