inherited ServiceEnderecamentoZonas: TServiceEnderecamentoZonas
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaZonaId: TIntegerField
      FieldName = 'ZonaId'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtPesquisaEstoqueTipoId: TIntegerField
      FieldName = 'EstoqueTipoId'
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
    object mtPesquisaEstoqueTipo: TStringField
      FieldName = 'EstoqueTipo'
      Size = 30
    end
  end
  inherited mtCadastro: TFDMemTable
    BeforeInsert = mtCadastroBeforeInsert
    object mtCadastroZonaId: TIntegerField
      FieldName = 'ZonaId'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtCadastroEstoqueTipoId: TIntegerField
      FieldName = 'EstoqueTipoId'
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
    object mtCadastroEstoqueTipo: TStringField
      FieldName = 'EstoqueTipo'
      Size = 30
    end
  end
end
