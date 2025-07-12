inherited ServiceUnidades: TServiceUnidades
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaId: TIntegerField
      FieldName = 'Id'
    end
    object mtPesquisaSigla: TStringField
      FieldName = 'Sigla'
      Size = 10
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
end
