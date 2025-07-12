inherited ServicePedidos: TServicePedidos
  inherited mtCadastro: TFDMemTable
    AfterInsert = mtCadastroAfterInsert
  end
end
