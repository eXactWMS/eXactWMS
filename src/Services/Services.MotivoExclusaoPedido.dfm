inherited ServiceMotivoExclusaoPedido: TServiceMotivoExclusaoPedido
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaMotivoId: TIntegerField
      FieldName = 'MotivoId'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroMotivoId: TIntegerField
      FieldName = 'MotivoId'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtCadastroStatusGetText
    end
  end
end
