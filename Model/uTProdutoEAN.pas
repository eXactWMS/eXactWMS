unit uTProdutoEAN;

interface

type
  TProdutoEAN = class
    private
      FCodigo: Integer;
      FCodigoProduto: Int64;
      FEAN: string;
      FPrincipal: Boolean;
      FQuantidade: Integer;

      procedure ValidarDados;
    public
      property Codigo: Integer        read FCodigo        write FCodigo;
      property CodigoProduto: Int64   read FCodigoProduto write FCodigoProduto;
      property EAN: string            read FEAN           write FEAN;
      property Principal: Boolean     read FPrincipal     write FPrincipal;
      property Quantidade: Integer    read FQuantidade    write FQuantidade;

      class procedure Excluir(pCodigo: Integer);
      class function  ListarEANs(pCodigoProduto: Int64): OleVariant;

      procedure Salvar;
  end;

implementation

uses uDmProdutoEAN, uFuncoes, SysUtils, uTProduto;

{ TProdutoEAN }

class procedure TProdutoEAN.Excluir(pCodigo: Integer);
begin
  dmProdutoEAN.qryExcluir.Close;
  dmProdutoEAN.qryExcluir.Parameters.ParamByName('pCdEAN').Value := pCodigo;
  dmProdutoEAN.qryExcluir.ExecSQL;
end;

class function TProdutoEAN.ListarEANs(pCodigoProduto: Int64): OleVariant;
begin
  dmProdutoEAN.qryListarEANs.Close;
  dmProdutoEAN.qryListarEANs.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmProdutoEAN.qryListarEANs.Open;

  Result := dmProdutoEAN.dspListarEANs.Data;
end;

procedure TProdutoEAN.Salvar;
begin
  ValidarDados;

  dmProdutoEAN.qrySalvar.Close;
  dmProdutoEAN.qrySalvar.Parameters.ParamByName('pCdEAN').Value     := FCodigo;
  dmProdutoEAN.qrySalvar.Parameters.ParamByName('pCdProduto').Value := FCodigoProduto;
  dmProdutoEAN.qrySalvar.Parameters.ParamByName('pNmEAN').Value     := FEAN;
  dmProdutoEAN.qrySalvar.Parameters.ParamByName('pPrincipal').Value := Ord(FPrincipal);
  dmProdutoEAN.qrySalvar.Parameters.ParamByName('pQtEAN').Value     := FQuantidade;
  dmProdutoEAN.qrySalvar.ExecSQL;
end;

procedure TProdutoEAN.ValidarDados;
var
  vlProduto: TProduto;
begin
  if (FCodigo < 0) then
    begin
      raise Exception.Create('Código EAN inválido!');
    end;

  FEAN := RemoverEspacos(FEAN);

  if (FEAN = '') then
  	begin
      raise Exception.Create('Informe o EAN do produto!');
  	end;

  if (FQuantidade <= 0) then
    begin
      raise Exception.Create('Quantidade vinculada ao EAN inválida!');
    end;

  try
    vlProduto := TProduto.PegarProduto(FEAN);
  except
  end;

  if (Assigned(vlProduto) = True) then
    begin
      try
        if (FCodigoProduto <> vlProduto.Codigo) then
          begin
            raise Exception.Create('O EAN informado está vinculado a outro produto.' + #13 + #13 +
                                   'Código: ' + IntToStr(vlProduto.Codigo) + #13 +
                                   'Produto: ' + vlProduto.Nome);
          end
        else
          begin
            dmProdutoEAN.qryPesquisar.Close;
            dmProdutoEAN.qryPesquisar.Parameters.ParamByName('pNmEAN').Value := FEAN;
            dmProdutoEAN.qryPesquisar.Open;

            if (FCodigo <> dmProdutoEAN.qryPesquisar.FieldByName('cdEAN').AsInteger) then
              begin
                raise Exception.Create('Código EAN já cadastrado para este produto!');
              end;
          end;
      finally
        FreeAndNil(vlProduto);
      end;
    end;
end;

end.
