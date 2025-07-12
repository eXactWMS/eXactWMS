inherited ServiceEnderecamentoEstruturas: TServiceEnderecamentoEstruturas
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaEstruturaId: TIntegerField
      FieldName = 'EstruturaId'
    end
    object mtPesquisaDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtPesquisaPickingFixo: TIntegerField
      FieldName = 'PickingFixo'
      OnGetText = mtPesquisaPickingFixoGetText
    end
    object mtPesquisaAltura: TFloatField
      FieldName = 'Altura'
    end
    object mtPesquisaLargura: TFloatField
      FieldName = 'Largura'
    end
    object mtPesquisaComprimento: TFloatField
      FieldName = 'Comprimento'
    end
    object mtPesquisaVolumePadrao: TFloatField
      FieldName = 'VolumePadrao'
    end
    object mtPesquisaCapacidadePadrao: TFloatField
      FieldName = 'CapacidadePadrao'
    end
    object mtPesquisaMascara: TStringField
      FieldName = 'Mascara'
      Size = 14
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroEstruturaId: TIntegerField
      FieldName = 'EstruturaId'
    end
    object mtCadastroDescricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object mtCadastroPickingFixo: TIntegerField
      FieldName = 'PickingFixo'
    end
    object mtCadastroAltura: TFloatField
      FieldName = 'Altura'
    end
    object mtCadastroLargura: TFloatField
      FieldName = 'Largura'
    end
    object mtCadastroComprimento: TFloatField
      FieldName = 'Comprimento'
    end
    object mtCadastroVolumePadrao: TFloatField
      FieldName = 'VolumePadrao'
    end
    object mtCadastroCapacidadePadrao: TFloatField
      FieldName = 'CapacidadePadrao'
    end
    object mtCadastroMascara: TStringField
      FieldName = 'Mascara'
      Size = 14
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
