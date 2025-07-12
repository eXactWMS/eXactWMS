unit uTLote;

interface

uses uTProduto, uTHistorico, System.Classes;

type
  TLote = class
    private
      FCodigo: Integer;
      FLote: string;
      FLoteAntigo : string;
      FDataFabricacao: TDateTime;
      FDataVencimento: TDateTime;
      FCodigoProduto: Int64;
      FProduto: TProduto;

      function  getProduto: TProduto;
      procedure setProduto(pProduto: TProduto);
      procedure ValidarDados;
    public
      property Codigo: Integer            read FCodigo          write FCodigo;
      property Lote: string               read FLote            write FLote;
      property LoteAntigo : string        read FLoteAntigo      write FLoteAntigo;
      property DataFabricacao: TDateTime  read FDataFabricacao  write FDataFabricacao;
      property DataVencimento: TDateTime  read FDataVencimento  write FDataVencimento;
      property Produto: TProduto          read getProduto       write setProduto;

      destructor Destroy; override;

      class function ListarLotes(pCodigoProduto: Int64): OleVariant;
      Class Function PegarLoteEspera(pCdProduto : string) : OleVariant;
      class function PegarLote(pCodigo: Integer): TLote; overload;
      class function PegarLote(pCodigoProduto: Int64; pLote: string): TLote; overload;
      class function Pesquisar(pCodigoProduto: Int64; pLote, pDataVencimento: string): OleVariant;
      class function RelatorioEstoqueGeral(pProduto, pLote: string): OleVariant;
      Class Procedure SalvarCorrecao(vCodigo : TStringList);
      procedure Alterar;
      procedure Salvar;
  end;

implementation

uses uDmLote, SysUtils, DBClient, uFuncoes, System.Variants, DB;

{ TLote }

procedure TLote.Alterar;
var
  vlCodigo: Integer;
begin
  vlCodigo := FCodigo;

  ValidarDados;

  if (vlCodigo <> FCodigo) then
    begin
      FCodigo := vlCodigo;

      raise Exception.Create('Alteração inválida!' + #13 +
                             'Existe outro Lote cadastrado com essa descrição');
    end;

  Salvar;
end;

destructor TLote.Destroy;
begin
  FreeAndNil(FProduto);

  inherited;
end;

function TLote.getProduto: TProduto;
begin
  if (Assigned(FProduto) = False) and (FCodigoProduto > 0) then
    begin
      setProduto(TProduto.PegarProduto(IntToStr(FCodigoProduto)));
    end;

  Result := FProduto;
end;

class function TLote.ListarLotes(pCodigoProduto: Int64): OleVariant;
begin
  Result := TProduto.ListarLotes(pCodigoProduto);
end;

class function TLote.PegarLote(pCodigo: Integer): TLote;
var
  vlLote: TLote;
begin
  dmLote.qryPegarLoteCodigo.Close;
  dmLote.qryPegarLoteCodigo.Parameters.ParamByName('pCdLote').Value := pCodigo;
  dmLote.qryPegarLoteCodigo.Open;

  if (dmLote.qryPegarLoteCodigo.IsEmpty = True) then
    begin
      raise Exception.Create('Lote não encontrado!');
    end;

  vlLote := TLote.Create;

  try
    vlLote.FCodigo         := dmLote.qryPegarLoteCodigo.FieldByName('cdLote').AsInteger;
    vlLote.FLote           := dmLote.qryPegarLoteCodigo.FieldByName('nmLote').AsString;
    vlLote.FLoteAntigo     := '';
    vlLote.FDataFabricacao := dmLote.qryPegarLoteCodigo.FieldByName('dtFabricacao').AsDateTime;
    vlLote.FDataVencimento := dmLote.qryPegarLoteCodigo.FieldByName('dtVencimento').AsDateTime;

    vlLote.FCodigoProduto := dmLote.qryPegarLoteCodigo.FieldByName('cdProduto').AsLargeInt;

    Result := vlLote;
  except
    on e: Exception do
      begin
        FreeAndNil(vlLote);

        raise Exception.Create(e.Message);
      end;
  end;
end;

class function TLote.PegarLote(pCodigoProduto: Int64; pLote: string): TLote;
var
  vlLote: TLote;
begin
  dmLote.qryPegarLoteDescricao.Close;
  dmLote.qryPegarLoteDescricao.Parameters.ParamByName('pCdProduto').Value := pCodigoProduto;
  dmLote.qryPegarLoteDescricao.Parameters.ParamByName('pNmLote').Value    := pLote;
  dmLote.qryPegarLoteDescricao.Open;

  if (dmLote.qryPegarLoteDescricao.IsEmpty = True) then
    begin
      raise Exception.Create('Lote não encontrado!');
    end;

  vlLote := TLote.Create;

  try
    vlLote.FCodigo         := dmLote.qryPegarLoteDescricao.FieldByName('cdLote').AsInteger;
    vlLote.FLote           := dmLote.qryPegarLoteDescricao.FieldByName('nmLote').AsString;
    vlLote.FLoteAntigo     := '';
    vlLote.FDataFabricacao := dmLote.qryPegarLoteDescricao.FieldByName('dtFabricacao').AsDateTime;
    vlLote.FDataVencimento := dmLote.qryPegarLoteDescricao.FieldByName('dtVencimento').AsDateTime;

    vlLote.FCodigoProduto := dmLote.qryPegarLoteDescricao.FieldByName('cdProduto').AsLargeInt;

    Result := vlLote;
  except
    on e: Exception do
      begin
        FreeAndNil(vlLote);

        raise Exception.Create(e.Message);
      end;
  end;
end;

class function TLote.PegarLoteEspera(pCdProduto: string): OleVariant;
begin
  With DmLote.QryPegarLoteEspera do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value := pCdProduto;
    Open;
    Result := DmLote.DspPegarLoteEspera.Data;
  End;
end;

class function TLote.Pesquisar(pCodigoProduto: Int64; pLote, pDataVencimento: string): OleVariant;
begin
  if (pCodigoProduto <= 0) then
    begin
      raise Exception.Create('Código do Produto inválido!');
    end;

  pLote := RemoverEspacos(pLote);

  if (Trim(pLote) = '') then
    begin
      pLote := '%';
    end;

  if (RemoverCaracteres(pDataVencimento) = '') then
    begin
      pDataVencimento := '%';
    end
  else
    begin
      try
        pDataVencimento := FormatDateTime('yyyy-mm-dd', StrToDate(pDataVencimento));
      except
        raise Exception.Create('Data de Vencimento inválida!');
      end;
    end;

  dmLote.qryPesquisar.Close;
  dmLote.qryPesquisar.Parameters.ParamByName('pCdProduto').Value    := pCodigoProduto;
  dmLote.qryPesquisar.Parameters.ParamByName('pNmLote').Value       := pLote;
  dmLote.qryPesquisar.Parameters.ParamByName('pDtVencimento').Value := pDataVencimento;
  dmLote.qryPesquisar.Open;

  Result := dmLote.dspPesquisar.Data;
end;

class function TLote.RelatorioEstoqueGeral(pProduto, pLote: string): OleVariant;
begin
  ValidarParametroTexto(pProduto);
  ValidarParametroTexto(pLote);

  dmLote.qryRelatorioEstoqueGeral.Close;
  dmLote.qryRelatorioEstoqueGeral.Parameters.ParamByName('pCdProduto').Value := pProduto;
  dmLote.qryRelatorioEstoqueGeral.Parameters.ParamByName('pNmLote').Value    := '%' + pLote + '%';
  dmLote.qryRelatorioEstoqueGeral.Open;

  Result := dmLote.dspRelatorioEstoqueGeral.Data;
end;

procedure TLote.Salvar;
var
  vlTransacaoInterna: Boolean;
begin
  ValidarDados;

  vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação

  try
    if (dmLote.qrySalvar.Connection.InTransaction = False) then
      begin
        vlTransacaoInterna := True;

        dmLote.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
        dmLote.qrySalvar.Connection.BeginTrans;
      end;

    dmLote.qrySalvar.Close;
    dmLote.qrySalvar.Parameters.ParamByName('pCdProduto').Value    := FCodigoProduto;
    dmLote.qrySalvar.Parameters.ParamByName('pCdLote').Value       := FCodigo;
    dmLote.qrySalvar.Parameters.ParamByName('pNmLote').Value       := Trim(FLote);
    if Trim(FLoteAntigo) = '' then
       FLoteAntigo := Flote;
    dmLote.qrySalvar.Parameters.ParamByName('pNmLoteAntigo').Value := Trim(FLoteAntigo);
    dmLote.qrySalvar.Parameters.ParamByName('pDtFabricacao').Value := FormatDateTime('yyyy-mm-dd', FDataFabricacao);
    dmLote.qrySalvar.Parameters.ParamByName('pDtVencimento').Value := FormatDateTime('yyyy-mm-dd', FDataVencimento);
    dmLote.qrySalvar.Open;
    FCodigo := dmLote.qrySalvar.FieldByName('cdLote').AsInteger;

       if (vlTransacaoInterna = True) then
      begin
        dmLote.qrySalvar.Connection.CommitTrans;
      end;
  except on e: Exception do
    begin
      if (vlTransacaoInterna = True) then
        begin
          dmLote.qrySalvar.Connection.RollbackTrans;
        end;

      raise Exception.Create(e.Message);
    end;
  end;
end;

Class procedure TLote.SalvarCorrecao(vCodigo: TStringList);
begin
  With DmLote.qrySalvar do Begin
    Close;
    Sql.Clear;
    Sql := VCodigo;
    Try
      ExecSql;
    Except
      raise Exception.Create('Não foi possível realizar a correção. Ocorreu um erro.');
    End;
  End;
end;

procedure TLote.setProduto(pProduto: TProduto);
begin
  FreeAndNil(FProduto);

  FProduto := pProduto;

  if (Assigned(FProduto) = True) then
    begin
      FCodigoProduto := FProduto.Codigo;
    end
  else
    begin
      FCodigoProduto := 0;
    end;
end;

procedure TLote.ValidarDados;
var
  vlLotes: TClientDataSet;
begin
  if (FCodigo < 0) then
    begin
      raise Exception.Create('Código do Lote inválido!');
    end;

  FLote := RemoverEspacos(FLote);

  if (FLote = '') then
    begin
      raise Exception.Create('Informe o Número do Lote!');
    end;

  if (FDataFabricacao >= FDataVencimento) then
    begin
      raise Exception.Create('A Data de Fabricação deve ser menor que a Data de Vencimento!');
    end;

  if (FDataFabricacao > Now) then
    begin
      raise Exception.Create('A Data de Fabricação não pode ser maior que a Data Atual!');
    end;

  if (Assigned(FProduto) = False) then
    begin
      raise Exception.Create('Informe o Produto ao qual este Lote pertence!');
    end
  else
    begin
      case FProduto.Controle.Codigo of
        2, 3: // Controle por Vencimento (2) ou por Entrada (3)
          begin
//Trecho desativado em 07/02/2019 - Problema de sincronismo nas tabelas de Estoque
//            FLote := FormatDateTime('yymmdd', FDataVencimento);
          end;
      end;

      vlLotes := TClientDataSet.Create(nil);

      try
        vlLotes.Data := TProduto.ListarLotes(FProduto.Codigo);

        if (vlLotes.Locate('nmLote', FLote, []) = True) then
          begin
            FCodigo := vlLotes.FieldByName('cdLote').AsInteger;
          end;
      finally
        FreeAndNil(vlLotes);
      end;
    end;
end;

end.
