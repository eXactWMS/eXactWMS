inherited ServicePerfil: TServicePerfil
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaPerfilId: TIntegerField
      FieldName = 'PerfilId'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object mtPesquisaData: TDateField
      FieldName = 'Data'
    end
    object mtPesquisaHora: TTimeField
      FieldName = 'Hora'
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    Left = 146
    object mtCadastroPerfilId: TIntegerField
      FieldName = 'PerfilId'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 50
    end
    object mtCadastroData: TDateField
      FieldName = 'Data'
    end
    object mtCadastrohora: TTimeField
      FieldName = 'hora'
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
