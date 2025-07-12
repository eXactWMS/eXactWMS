inherited ServiceCargas: TServiceCargas
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaCargaId: TIntegerField
      FieldName = 'CargaId'
    end
    object mtPesquisaRotaId: TIntegerField
      FieldName = 'RotaId'
    end
    object mtPesquisarota: TStringField
      FieldName = 'rota'
      Size = 60
    end
    object mtPesquisaTransportadoraId: TIntegerField
      FieldName = 'TransportadoraId'
    end
    object mtPesquisaTransportadora: TStringField
      FieldName = 'Transportadora'
      Size = 100
    end
    object mtPesquisaVeiculoId: TIntegerField
      FieldName = 'VeiculoId'
    end
    object mtPesquisaPlaca: TStringField
      FieldName = 'Placa'
      Size = 8
    end
    object mtPesquisaModelo: TStringField
      FieldName = 'Modelo'
      Size = 30
    end
    object mtPesquisaMarca: TStringField
      FieldName = 'Marca'
      Size = 40
    end
    object mtPesquisaCor: TStringField
      FieldName = 'Cor'
    end
    object mtPesquisaMotoristaid: TIntegerField
      FieldName = 'Motoristaid'
    end
    object mtPesquisamotorista: TStringField
      FieldName = 'motorista'
      Size = 100
    end
    object mtPesquisaUsuarioid: TIntegerField
      FieldName = 'Usuarioid'
    end
    object mtPesquisaUsuario: TStringField
      FieldName = 'Usuario'
      Size = 50
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
    object mtPesquisauuid: TStringField
      FieldName = 'uuid'
      Size = 36
    end
    object mtPesquisaProcessoId: TIntegerField
      FieldName = 'ProcessoId'
    end
    object mtPesquisaProcesso: TStringField
      FieldName = 'Processo'
      Size = 30
    end
    object mtPesquisaDtInclusao: TDateField
      FieldName = 'DtInclusao'
    end
    object mtPesquisaHrInclusao: TTimeField
      FieldName = 'HrInclusao'
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
  end
end
