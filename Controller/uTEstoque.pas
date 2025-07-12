unit uTEstoque;

interface

type   //Enumerated
  TTipoEstoque     = (TipoUndefined = 0, Espera = 1, CrossDocking = 2, Segregado = 3, Producao = 4, Expedicao = 5, Picking = 6, Reserva = 7);
  TOperacaoEstoque = (OperacaoUndefined = 0, Entrada = 1, Saida = 3, Interna = 2);

{  TEstoqueTipo = class
     private
       FCodigo: Integer;
       FNome  : string;
       FTipo  : TTipoEstoque;
     public
       property Codigo: Integer      read FCodigo write FCodigo;
       property Nome  : string       read FNome   write FNome;
       Property Tipo  : TTipoEstoque Read FTipo   Write FTipo;
       class function ListarTipos: OleVariant;
   end;
}

type
  TEstoque = class
    private
       FTipo : TTipoEstoque;
       FOperacaoEstoque : TOperacaoEstoque;
    public
      Property Tipo : TTipoEstoque Read FTipo Write Ftipo;
      class function  ListarEstoque(pCodigoProduto, pLote, pEnderecoInicial, pEnderecoFinal, pCodigoSetor: string): OleVariant;
      class function  ListarLotes(pCodigoProduto: Int64; pCodigoEndereco: Integer): OleVariant;
      class function  PegarEstoqueProduto(pCodigoProduto: Int64; pEndereco: string): Integer;
      class procedure Salvar(pCodigoEndereco, pCodigoLote, pQuantidade, pCodMotSegregado : Integer);
      class procedure SalvarRetorno(pXML: UTF8String); static;
      Class Function PegarEstoqueConsultaColetor(vEndereco : String; vProduto : String) : OleVariant;
      Class Function GetEstoqueByProdEnd(pCdProduto : Int64; pNmEndereco : String) : OleVariant;
      Class Function GetEstoqueExportaERP(pCdProduto : Int64 = 0; pCdSetor : Integer = 0) : OleVariant;
      Class Function GetConsEstDisponivel(pCdEndereco, pCdLote : Integer) : OleVariant; //Estoque Producao + Espera - Reserva
      Class Function SetarTipoEstoque(pPosicao : Integer) : TTipoEstoque;
      //Reservas
      Class Procedure InserirReservaLote(pCdUsuario, pCdEstoqueTipo,pCdEndereco, pCdLote,
                      pQtReservada, pCdReservaMotivo, pCdRegistro : Integer);

  end;


implementation

{ TEstoqueTipo }

uses uDmEstoque, uFuncoes, SysUtils;

{
 class function TEstoqueTipo.ListarTipos: OleVariant;
 begin
   dmEstoque.qryListarEstoqueTipos.Close;
   dmEstoque.qryListarEstoqueTipos.Open;

   Result := dmEstoque.dspListarEstoqueTipos.Data;
 end;
}

class function TEstoque.GetConsEstDisponivel(pCdEndereco,
  pCdLote: Integer): OleVariant;
begin
  With DmEstoque.QryConsEstDisponivel do begin
    Close;
    Parameters.ParamByName('pCdEndereco').Value := pCdEndereco;
    Parameters.ParamByName('pCdLote').Value     := pCdLote;
    Open;
  end;
  Result := DmEstoque.DspConsEstDisponivel.Data;
end;

class function TEstoque.GetEstoqueByProdEnd(pCdProduto: Int64;
  pNmEndereco: String): OleVariant;
begin
  With DmEstoque.QryGetEstoqueByProdEnd do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value  := pCdProduto;
    Parameters.ParamByName('pNmEndereco').Value := pNmEndereco;
    Parameters.ParamByName('pNmEan').Value := pCdProduto.ToString();
    Open;
  End;
  Result := DmEstoque.DspGetEstoqueByProdEnd.Data;
end;

class function TEstoque.GetEstoqueExportaERP(pCdProduto : Int64; pCdSetor : Integer) : OleVariant;
begin
  With DmEstoque.QryEstoqueExpERP do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value := pCdProduto;
    Parameters.ParamByName('pCdSetor').Value    := pCdSetor;
    Open;
  End;
  Result := DmEstoque.DspEstoqueExpERP.Data;
end;

class procedure TEstoque.InserirReservaLote(pCdUsuario, pCdEstoqueTipo,
  pCdEndereco, pCdLote, pQtReservada, pCdReservaMotivo, pCdRegistro: Integer);
begin
  With dmEstoque.qryInserirReservaLote do Begin
    Close;
    Parameters.ParamByName('pCdUsuario').Value       := pCdUsuario;
    Parameters.ParamByName('pCdEstoqueTipo').Value   := pCdEstoqueTipo;
    Parameters.ParamByName('pCdEndereco').Value      := pCdEndereco;
    Parameters.ParamByName('pCdLote').Value          := pCdLote;
    Parameters.ParamByName('pQtReservada').Value     := pQtReservada;
    Parameters.ParamByName('pCdReservaMotivo').Value := pCdReservaMotivo;
    Parameters.ParamByName('pCdRegistro').Value      := pCdRegistro;
    Try
      ExecSql;
    Except
      raise Exception.Create('Ocorreu um erro ao reserva o Lote');
    End;
  End;
end;

class function TEstoque.ListarEstoque(pCodigoProduto, pLote, pEnderecoInicial, pEnderecoFinal, pCodigoSetor: string): OleVariant;
begin
  ValidarParametroTexto(pCodigoProduto);
  ValidarParametroTexto(pLote);
  ValidarParametroTexto(pEnderecoInicial);
  ValidarParametroTexto(pEnderecoFinal);
  ValidarParametroTexto(pCodigoSetor);

  if (pEnderecoInicial = '%') and (pEnderecoFinal = '%') then
    begin
      pEnderecoInicial := '0';
      pEnderecoFinal   := '999999999999';
    end
  else
    begin
      if (pEnderecoInicial = '%') then
        begin
          pEnderecoInicial := pEnderecoFinal;
        end;

      if (pEnderecoFinal = '%') then
        begin
          pEnderecoFinal := pEnderecoInicial;
        end;
    end;

  DmEstoque.qryListarEstoque.Close;
  DmEstoque.qryListarEstoque.Parameters.ParamByName('pCdProduto').Value         := pCodigoProduto;
  DmEstoque.qryListarEstoque.Parameters.ParamByName('pNmLote').Value            := '%' + pLote + '%';
  DmEstoque.qryListarEstoque.Parameters.ParamByName('pNmEnderecoInicial').Value := pEnderecoInicial;
  DmEstoque.qryListarEstoque.Parameters.ParamByName('pNmEnderecoFinal').Value   := pEnderecoFinal;
  DmEstoque.qryListarEstoque.Parameters.ParamByName('pCdEnderecoSetor').Value   := pCodigoSetor;
  DmEstoque.qryListarEstoque.Open;

  Result := DmEstoque.dspListarEstoque.Data;
end;

class function TEstoque.ListarLotes(pCodigoProduto: Int64; pCodigoEndereco: Integer): OleVariant;
begin
  DmEstoque.qryListarLotes.Close;
  DmEstoque.qryListarLotes.Parameters.ParamByName('pCdProduto').Value  := pCodigoProduto;
  DmEstoque.qryListarLotes.Parameters.ParamByName('pCdEndereco').Value := pCodigoEndereco;
  DmEstoque.qryListarLotes.Open;

  Result := DmEstoque.dspListarLotes.Data;
end;

class function TEstoque.PegarEstoqueConsultaColetor(vEndereco: String;
  vProduto: String): OleVariant;
begin
  With DmEstoque.QryEstoqueConsultaColetor do Begin
    Close;
    if vProduto = '' then
       Parameters.ParamByName('pCdProduto').Value := vProduto
    Else Parameters.ParamByName('pCdProduto').Value := vProduto; //IntToStr(StrToInt64(vProduto));
    Parameters.ParamByname('pEndereco').Value  := vEndereco;
    Open;
    result := DmEstoque.DspEstoqueConsultaColetor.Data;
  End;
end;

class function TEstoque.PegarEstoqueProduto(pCodigoProduto: Int64; pEndereco: string): Integer;
begin
  DmEstoque.qryPegarEstoqueProduto.Close;
  DmEstoque.qryPegarEstoqueProduto.Parameters.ParamByName('pCdProduto').Value  := pCodigoProduto;
  DmEstoque.qryPegarEstoqueProduto.Parameters.ParamByName('pNmEndereco').Value := pEndereco;
  DmEstoque.qryPegarEstoqueProduto.Open;

  Result := DmEstoque.qryPegarEstoqueProduto.FieldByName('qtLote').AsInteger;
end;

class procedure TEstoque.Salvar(pCodigoEndereco, pCodigoLote, pQuantidade, pCodMotSegregado : Integer);
begin
  DmEstoque.qrySalvar.Close;
  DmEstoque.qrySalvar.Parameters.ParamByName('pCdEndereco').Value := pCodigoEndereco;
  DmEstoque.qrySalvar.Parameters.ParamByName('pCdLote').Value     := pCodigoLote;
  DmEstoque.qrySalvar.Parameters.ParamByName('pQtLote').Value     := pQuantidade;
  DmEstoque.qrySalvar.ExecSQL;
end;

//Usando pelo Integrador
Class Procedure TEstoque.SalvarRetorno(pXML: UTF8String);
var
  vlCodigo: string;
begin
//  DmEstoque.qrySalvarRetorno.Connection := dmPrincipal.cntERP;
  DmEstoque.qrySalvarRetorno.Close;
  DmEstoque.qrySalvarRetorno.Parameters.ParamByName('pDados').Value := pXML;
  DmEstoque.qrySalvarRetorno.ExecSQL;
end;

class function TEstoque.SetarTipoEstoque(pPosicao: Integer): TTipoEstoque;
begin
  case pPosicao of
    0: Result := TipoUndefined;
    1: Result := Espera;
    2: Result := CrossDocking;
    4: Result := Producao;
    5: Result := Expedicao;
    6: Result := Picking;
    7: Result := Reserva; //Reposicao
  end;
end;

end.
