inherited ServiceUsuario: TServiceUsuario
  inherited mtPesquisa: TFDMemTable
    object mtPesquisaUsuarioId: TIntegerField
      FieldName = 'UsuarioId'
    end
    object mtPesquisaNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object mtPesquisaPerfilId: TIntegerField
      FieldName = 'PerfilId'
    end
    object mtPesquisaPerfil: TStringField
      FieldName = 'Perfil'
      Size = 50
    end
    object mtPesquisaStatus: TIntegerField
      FieldName = 'Status'
      OnGetText = mtPesquisaStatusGetText
    end
  end
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
    object mtCadastroUsuarioId: TIntegerField
      FieldName = 'UsuarioId'
    end
    object mtCadastroNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object mtCadastroPerfilId: TIntegerField
      FieldName = 'PerfilId'
    end
    object mtCadastroPerfil: TStringField
      FieldName = 'Perfil'
      Size = 50
    end
    object mtCadastroStatus: TIntegerField
      FieldName = 'Status'
    end
  end
end
