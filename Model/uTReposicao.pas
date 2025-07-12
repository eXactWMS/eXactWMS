unit uTReposicao;

interface

uses Dialogs, uTMovtoEstoque, uTHistorico, System.Variants, uTEstoque;

type
  TTipoColeta = (Manual, Coletor);

  TLoteReposicao = Class
   Private
     FCdProduto     : Int64;
     FCdLote        : Integer;
     FEstoqueTipo   : TTipoEstoque;
     FCdEndOrigem   : Integer;
     FNmEndOrigem   : String;
     FCdEndDestino  : Integer;
     FNmEndDestino  : String;
     FCdUsuario     : Integer;
     FQuantidade    : Integer;
   Public
     Constructor Create(cCdProduto : Int64 = 0; cCdLote : Integer = 0; cEstoqueTipo : TTipoEstoque = TipoUndefined;
                        cCdEndOrigem : Integer = 0; cNmEndOrigem : String = '';
                        cCdEndDestino : Integer= 0; cNmEndDestino : String = '';
                        cCdSuario : Integer = 0; cQuantidade : Integer = 0);
   Published
     Property CdProduto    : Int64        Read FCdProduto    Write FCdProduto;
     Property CdLote       : Integer      Read FCdLote       Write FCdLote;
     Property EstoqueTipo  : TTipoEstoque Read FEstoqueTipo  Write FEstoqueTipo;
     Property CdEndOrigem  : Integer      Read FCdEndOrigem  Write FCdEndOrigem;
     Property NmEndOrigem  : String       Read FNmEndOrigem  Write FNmEndOrigem;
     Property CdEndDestino : Integer      Read FCdEndDestino Write FCdEndDestino;
     Property NmEndDestino : String       Read FNmEndDestino Write FNmEndDestino;
     Property CdUsuario    : Integer      Read FCdUsuario    Write FCdUsuario;
     Property Quantidade   : Integer      Read FQuantidade   Write FQuantidade;
  End;

  TArrayListaLoteReposicao = Array Of TLoteReposicao;

  TListaLoteReposicao = Class
  private
    FItems: TArrayListaLoteReposicao;
    procedure SetItems(const Value: TArrayListaLoteReposicao);
    Published
      Property Items : TArrayListaLoteReposicao read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TLoteReposicao) : Integer;
  End;

  TReposicaoStatus = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function PegarStatus(pCodigo: Integer): TReposicaoStatus;
    Class Function ListaStatus : OleVariant;
  end;

  TReposicaoTipo = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer  read FCodigo  write FCodigo;
    property Nome: string     read FNome    write FNome;

    class function ListarTipos: OleVariant;
    class function PegarTipo(pCodigo: Integer): TReposicaoTipo;
  end;

  TReposicao = class
  private
    FCodigo: Integer;
    FData: TDateTime;
    FTipo: TReposicaoTipo;
    FStatus: TReposicaoStatus;
    FCdUsuario     : Integer;
    FCdProduto     : Int64;
    FCdEndereco    : Integer;
    FDtSaida       : TDateTime;
    FCodigoTipo: Integer;
    FCodigoStatus: Integer;
    FLstLoteReposicao : TListaLoteReposicao;
    FTipoColeta    : TTipoColeta;
    vQtAtendida   : Integer;
    vProdAtendido : String;

    function getStatus: TReposicaoStatus;
    function getTipo: TReposicaoTipo;

    procedure setStatus(pStatus: TReposicaoStatus);
    procedure setTipo(pTipo: TReposicaoTipo);

    procedure AtualizarQuantidadeAtendida;
    Procedure AtualizarColeta(pCdEndereco, pCdLote, pQtReposta : Integer);
    procedure LimparLotes;
    function  ReposicaoCapacidade(pEndInicial, pEndFinal: string): OleVariant;
    function  ReposicaoDiaria(pData, pEndInicial, pEndFinal: string): OleVariant;
    procedure SalvarProdutos(pProdutos: OleVariant);
  public
    property Codigo: Integer            read FCodigo    write FCodigo;
    property Data: TDateTime            read FData      write FData;
    property Tipo: TReposicaoTipo       read getTipo    write setTipo;
    property Status: TReposicaoStatus   read getStatus  write setStatus;
    Property CdUsuario    : Integer     Read FCdUsuario    Write FCdUsuario;
    Property CdProduto    : Int64       Read FCdProduto    Write FCdProduto;
    Property CdEndereco   : Integer     Read FCdEndereco   Write FCdEndereco;
    Property DtSaida      : TDateTime   Read FDtSaida      Write FDtSaida;
    Property TipoColeta   : TTipoColeta Read FTipoColeta Write FTipoColeta;
    Property LstLoteReposicao : TListaLoteReposicao   Read FLstLoteReposicao Write FLstLoteReposicao;
    destructor Destroy; override;

    class function PegarReposicao(pCodigo: string): TReposicao;
    class function Pesquisar(pData, pCodProduto, pEndereco: string): OleVariant;

    procedure AlterarStatus(pCodigoStatus: Integer);
    Procedure BlockReposicao(pCdUsuario : Integer; pCdProduto : Int64; pCdEndereco, pColetaParcial : Integer);
    procedure Cancelar(pHistorico: THistorico);
    procedure ExcluirLote(pCodigo: Integer);
    procedure Finalizar(pLotes: OleVariant; pHistorico: THistorico);
    Procedure FinalizarColeta(pHistorico : THistorico);
    Procedure EnderecoColetaGerar(pTipo: Integer; pData, pEndInicial, pEndFinal : String);
    function  EnderecoColeta(pTipo: Integer; pData, pEndInicial, pEndFinal, pFiltro : string): OleVariant;
    function  InserirProdutos(pTipo: Integer; pData, pEndInicial, pEndFinal: string): OleVariant;
    procedure InserirLote(pTipoEstoque, pCodOrigem, pCodDestino, pCodLote, pQuantidade, pCodUsuario: Integer; ObjHistorico : THistorico = Nil);
    function  ListarLotes: OleVariant;
    function  ListarRelPallet(Coletor : Boolean = False) : OleVariant;
    Function  ListarItemReposicaoPalletColetor : OleVariant;
    Class Procedure MoveReservaToPicking(ObjMovimentacao : TMovimentacao);
    Procedure MovimentarColetaItem(ObjLoteReposicao : TLoteReposicao);
    function  RelatorioProdutos: OleVariant;
    function  RelatorioEstoque: OleVariant;
    procedure Salvar(pProdutos: OleVariant; vgHistorico: THistorico);
    Procedure SalvarItemReposicaoColetor(ObjLoteReposicao : TLoteReposicao);
    //pCdProduto : Int64; pCdLote, pEstoqueTipo : Integer; pCdEndOrigem, pCdEndDestino,pCdSuario, pQuantidade : Integer);
    class function PesquisarConferencia(pData,
      pCodReposicao: string): OleVariant; static;
    function ListarConferenciaSetor: OleVariant;
    function ListarConferenciaPorCodigo: OleVariant;
    Class Function ListarReposicao(pStatus : Integer) : OleVariant;
    Class Function ListarReposicaoItens(pCdReposicao : Integer) : OleVariant;
    Class Function ReposicaoItensColetor : OleVariant;
    class function ReposicaoLoteEndeColetor: OleVariant;
    Class Procedure SalvarColetaProduto(PCdReposicao : Integer; pData, pEndInicial, pEndFinal, pFiltro : String);
    Class Function RelReposicaoAnalise(pCdReposicao, pStatus : Integer; pCdProduto :Int64; pDataInicial, pDataFinal : String; pTipoColeta : Integer; pCdUsuario : Integer) : OleVariant;
    Class Function RelReposicaoColeta(pCdReposicao : Integer) : OleVariant;
    Class Function RelTransfPicking(pFiltro : String)  : OleVariant;
    Class Function RelRepoMovimentacao(pData : String; pCdReposicao, pCdUsuario : Integer; pCdProduto : Int64; pFiltro : String) : OleVariant;
  end;

implementation

{ TReposicao }

uses uFuncoes, uDmReposicao, System.SysUtils, Data.DB, Datasnap.DBClient, uTConfig;

procedure TReposicao.AlterarStatus(pCodigoStatus: Integer);
begin
  FreeAndNil(FStatus);

  dmReposicao.qryAlterarStatus.Close;
  dmReposicao.qryAlterarStatus.Parameters.ParamByName('pCdReposicao').Value       := Self.Codigo;
  dmReposicao.qryAlterarStatus.Parameters.ParamByName('pCdReposicaoStatus').Value := pCodigoStatus;
  dmReposicao.qryAlterarStatus.ExecSQL;

  Self.FCodigoStatus := pCodigoStatus;
end;

procedure TReposicao.AtualizarColeta(pCdEndereco, pCdLote, pQtReposta: Integer);
begin
  dmReposicao.qryAtualizarColeta.Close;
  dmReposicao.qryAtualizarColeta.Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
  dmReposicao.qryAtualizarColeta.Parameters.ParamByName('pCdEndereco').Value := pCdEndereco;
  dmReposicao.qryAtualizarColeta.Parameters.ParamByName('pCdLote').Value := pCdLote;
  dmReposicao.qryAtualizarColeta.Parameters.ParamByName('pQtReposta').Value := pQtReposta;
  dmReposicao.qryAtualizarColeta.ExecSQL;
end;

procedure TReposicao.AtualizarQuantidadeAtendida;
begin
  dmReposicao.qryAtualizarQuantidadeAtendida.Close;
  dmReposicao.qryAtualizarQuantidadeAtendida.Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
  dmReposicao.qryAtualizarQuantidadeAtendida.ExecSQL;
end;

procedure TReposicao.BlockReposicao(pCdUsuario : Integer; pCdProduto: Int64; pCdEndereco, pColetaParcial: Integer);
begin
  With DmReposicao.BlockReposicao do Begin
    Close;
    Parameters.ParamByName('pCdReposicao').Value := self.FCodigo;
    Parameters.paramByName('pCdUsuario').Value   := pCdusuario;
    Parameters.ParamByName('pCdProduto').Value   := pCdProduto;
    Parameters.ParamByName('pCdEndereco').value  := pCdEndereco;
    Parameters.ParamByName('pColetaParcial').Value := pColetaParcial;
    ExecSql;
  End;
end;

procedure TReposicao.Cancelar(pHistorico: THistorico);
var
  vlCodigoStatus: Integer;
begin
  dmReposicao.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
  dmReposicao.qryAlterarStatus.Connection.BeginTrans;

  try
    vlCodigoStatus := Self.FCodigoStatus;
    
    AlterarStatus(4); // 4 = Cancelado
    LimparLotes;
    AtualizarQuantidadeAtendida;

    pHistorico.CodigoFuncao   := 60; // Reposicao - Cadastrar
    pHistorico.CodigoRegistro := Self.Codigo;
    pHistorico.Observacao     := 'Cancelamento da Reposição';
    pHistorico.Salvar;

    dmReposicao.qryAlterarStatus.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmReposicao.qryAlterarStatus.Connection.RollbackTrans;

      Self.FCodigoStatus := vlCodigoStatus;

      raise Exception.Create(e.Message);
    end;
  end;
end;

destructor TReposicao.Destroy;
begin
  FreeAndNil(FTipo);
  FreeAndNil(FStatus);

  inherited;
end;

function TReposicao.EnderecoColeta(pTipo: Integer; pData, pEndInicial,
  pEndFinal, pFiltro : string): OleVariant;
var vlData: TDateTime;
begin
  vlData := ValidarData(pData, 'Data');
  //mudar apenas para aplicação do Filtro de Coleta
  With dmReposicao.QryRepoEndColeta do Begin
     Close;
     if pFiltro<>'' then
        Sql.Strings[5] := 'And '+pFiltro
     Else Sql.Strings[5] := '';
     Open;
     Result := dmReposicao.DspRepoEndColeta.Data;
  End;
end;

Procedure TReposicao.EnderecoColetaGerar(pTipo: Integer; pData, pEndInicial,
  pEndFinal : String);
var vlData: TDateTime;
    vProduto : Int64;
    vQtRep   : Integer;
begin
  vlData := ValidarData(pData, 'Data');
  //mudar apenas para aplicação do Filtro de Coleta
  With dmReposicao.QryRepoEndColetaGerar do Begin
     Close;
     Parameters.ParamByName('pData').Value            := FormatDateTime('yyyy-mm-dd', vlData);
     Parameters.ParamByName('pEnderecoInicial').Value := pEndInicial;
     Parameters.ParamByName('pEnderecoFinal').Value   := pEndFinal + '99999';
     Try
       Open;
       vProduto := 0;
       vQtRep   := 0;
       while Not Eof do Begin
         if vProduto <> FieldByName('CdProduto').AsLargeInt then Begin
            vProduto := FieldByName('CdProduto').AsLargeInt;
            vQtRep   := FieldByName('QtSolicitada').Value;
         End;

         if (vQtRep>0) and (vQtRep <= FieldByName('QtSolicitada').Value) then Begin
            DmReposicao.QryRepoEndColetaAtualizar.Close;
            DmReposicao.QryRepoEndColetaAtualizar.Parameters.ParamByName('pCdLote').Value := FieldByName('CdLote').Value;
            DmReposicao.QryRepoEndColetaAtualizar.Parameters.ParamByName('pCdEndereco').Value := FieldByName('CdEndereco').Value;
            if FieldByName('QtLote').Value >= vQtRep then Begin
               DmReposicao.QryRepoEndColetaAtualizar.Parameters.ParamByName('pQtRepo').Value := vQtRep;
               vQtRep := 0;
            End
            else Begin
               DmReposicao.QryRepoEndColetaAtualizar.Parameters.ParamByName('pQtRepo').Value := FieldByName('QtLote').Value;
               vQtRep := vQtRep - FieldByName('QtLote').Value;
            End;
            DmReposicao.QryRepoEndColetaAtualizar.ExecSQL;
         End;
         Next;
       End;
     Except
        raise Exception.Create('Ocorreu um erro ao criar EndereçospPara Coleta!!');
     End;
  End;
end;

procedure TReposicao.ExcluirLote(pCodigo: Integer);
begin
  dmReposicao.qryExcluirLote.Connection.Execute('SET NOCOUNT ON;');
  dmReposicao.qryExcluirLote.Connection.BeginTrans;

  try
    dmReposicao.qryExcluirLote.Close;
    dmReposicao.qryExcluirLote.Parameters.ParamByName('pCdReposicaoLote').Value := pCodigo;
    dmReposicao.qryExcluirLote.ExecSQL;

    AtualizarQuantidadeAtendida;

    dmReposicao.qryExcluirLote.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmReposicao.qryExcluirLote.Connection.RollbackTrans;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TReposicao.Finalizar(pLotes: OleVariant; pHistorico: THistorico);
var
  vlLotes: TClientDataSet;
  vlCodigoStatus: Integer;
  vlMovimentacao: TMovimentacao;
begin
  vlLotes := TClientDataSet.Create(nil);
  
  try
    vlLotes.Close;
    vlLotes.Data := pLotes;

    vlLotes.Filter   := '(qtAtendida > 0)';
    vlLotes.Filtered := True;

    if (vlLotes.IsEmpty = True) then
      begin
        raise Exception.Create('Operação inválida!' + sLineBreak +
                               'Nenhum item desta Reposição foi movimentado.');
      end;

    dmReposicao.qryAlterarStatus.Connection.Execute('SET NOCOUNT ON;');
    dmReposicao.qryAlterarStatus.Connection.BeginTrans;

    try     
      vlLotes.Filter := '(qtReposta > 0)';

      vlLotes.First;
      while (vlLotes.Eof = False) do
        begin
          vlMovimentacao := TMovimentacao.Create;

          try
            vlMovimentacao.Codigo               := 0;
            vlMovimentacao.CodigoUsuario        := vlLotes.FieldByName('cdUsuario').AsInteger;
            vlMovimentacao.CodigoLote           := vlLotes.FieldByName('cdLote').AsInteger;
            vlMovimentacao.EstoqueOrigem        := TEstoque.SetarTipoEstoque(vlLotes.FieldByName('cdEstoqueTipo').AsInteger);
            vlMovimentacao.CodigoEnderecoOrigem := vlLotes.FieldByName('cdEnderecoOrigem').AsInteger;

            case vlMovimentacao.EstoqueOrigem of
              Espera: vlMovimentacao.Origem := 'Área de Espera'; // 1 = Área de Espera
              Producao: vlMovimentacao.Origem := 'Endereço nº: ' + AplicarMascara(vlLotes.FieldByName('nmEnderecoOrigem').AsString, vlLotes.FieldByName('MascaraPallet').AsString); // 4 = Produção
            end;

            vlMovimentacao.EstoqueDestino := Producao; // 4 = Produção
            vlMovimentacao.CodigoEnderecoDestino := vlLotes.FieldByName('cdEnderecoDestino').AsInteger;
            vlMovimentacao.Destino               := 'Endereço nº: ' + AplicarMascara(vlLotes.FieldByName('nmEnderecoDestino').AsString, vlLotes.FieldByName('MascaraPicking').AsString);
            vlMovimentacao.QtdMovimentada        := vlLotes.FieldByName('qtReposta').AsInteger;
            vlMovimentacao.OperacaoEstoque       := Interna; // 2 = Interna
            vlMovimentacao.Salvar;
          finally
            FreeAndNil(vlMovimentacao);
          end;

          vlLotes.Next;
        end;

      vlCodigoStatus := Self.FCodigoStatus;

      AlterarStatus(3); // 3 = Finalizado

      pHistorico.CodigoFuncao   := 60; // 60 = Reposição - Cadastrar
      pHistorico.CodigoRegistro := Self.Codigo;
      pHistorico.Observacao     := 'Reposição Finalizada';
      pHistorico.Salvar;

      dmReposicao.qryAlterarStatus.Connection.CommitTrans;
    except on e: Exception do
      begin
        dmReposicao.qryAlterarStatus.Connection.RollbackTrans;

        Self.FCodigoStatus := vlCodigoStatus;

        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(vlLotes);
  end;
end;

procedure TReposicao.FinalizarColeta(pHistorico: THistorico);
begin
  AlterarStatus(3); // 3 = Finalizado

  pHistorico.CodigoFuncao   := 60; // 60 = Reposição - Cadastrar
  pHistorico.CodigoRegistro := Self.Codigo;
  pHistorico.Observacao     := 'Finalização de Coleta('+Self.Codigo.ToString()+') para Reposição de Picking';
  pHistorico.Salvar;
end;

function TReposicao.getStatus: TReposicaoStatus;
begin
  if (Assigned(FStatus) = False) and (FCodigoStatus > 0) then
    begin
      setStatus(TReposicaoStatus.PegarStatus(FCodigoStatus));
    end;

  Result := FStatus;
end;

function TReposicao.getTipo: TReposicaoTipo;
begin
  if (Assigned(FTipo) = False) and (FCodigoTipo > 0) then
    begin
      setTipo(TReposicaoTipo.PegarTipo(FCodigoTipo));
    end;

  Result := FTipo;
end;

procedure TReposicao.InserirLote(pTipoEstoque, pCodOrigem, pCodDestino, pCodLote, pQuantidade, pCodUsuario: Integer; ObjHistorico : THistorico = Nil);
var
  vlCodigoStatus: Integer;
begin
  if (pQuantidade <= 0) then
    begin
      raise Exception.Create('Operação inválida!' + sLineBreak +
                             'A Quantidade deve ser maior que zero.');
    end;

  vlCodigoStatus := Self.FCodigoStatus;

  dmReposicao.qryInserirLote.Connection.Execute('SET NOCOUNT ON;');
  dmReposicao.qryInserirLote.Connection.BeginTrans;

  try
    if (Self.FCodigoStatus = 1) then
      begin
        AlterarStatus(2); // 2 = Em Andamento
      end;

    dmReposicao.qryInserirLote.Close;
    dmReposicao.qryInserirLote.Parameters.ParamByName('pCdReposicao').Value       := Self.Codigo;
    dmReposicao.qryInserirLote.Parameters.ParamByName('pCdLote').Value            := pCodLote;
    dmReposicao.qryInserirLote.Parameters.ParamByName('pCdEstoqueTipo').Value     := pTipoEstoque;
    dmReposicao.qryInserirLote.Parameters.ParamByName('pCdEnderecoOrigem').Value  := pCodOrigem;
    dmReposicao.qryInserirLote.Parameters.ParamByName('pCdEnderecoDestino').Value := pCodDestino;
    dmReposicao.qryInserirLote.Parameters.ParamByName('pQtReposta').Value         := pQuantidade;
    dmReposicao.qryInserirLote.Parameters.ParamByName('pCdUsuario').Value         := pCodUsuario;
    dmReposicao.qryInserirLote.ExecSQL; //Quando Ativado Coleta por Coleta será disparado Trigger no Banco para Reserva de Lote
//    MovimentarColetaItem(ObjHistorico);
    //Reservar Lote para Reposição de Picking
    If Self.TipoColeta = Coletor then Begin
       TEstoque.InserirReservaLote(pCodUsuario, 7, pCodOrigem, pCodLote, pQuantidade, 2, 0);
       AtualizarColeta(pCodOrigem, pCodLote, pQuantidade);
    End;
    AtualizarQuantidadeAtendida;

    dmReposicao.qryInserirLote.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmReposicao.qryInserirLote.Connection.RollbackTrans;

      Self.FCodigoStatus := vlCodigoStatus;

      raise Exception.Create(e.Message);
    end;
  end;
end;

function TReposicao.InserirProdutos(pTipo: Integer; pData, pEndInicial, pEndFinal: string): OleVariant;
begin
  case pTipo of
    1: Result := ReposicaoDiaria(pData, pEndInicial, pEndFinal); // 1 = Reposição Diária
    2: Result := ReposicaoCapacidade(pEndInicial, pEndFinal);    // 2 = Reposição por Capacidade
  end;
end;

procedure TReposicao.LimparLotes;
begin
  dmReposicao.qryLimparLotes.Close;
  dmReposicao.qryLimparLotes.Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
  dmReposicao.qryLimparLotes.ExecSQL;
end;

function TReposicao.ListarLotes: OleVariant;
begin
  dmReposicao.qryListarLotes.Close;
  dmReposicao.qryListarLotes.Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
  dmReposicao.qryListarLotes.Open;

  Result := dmReposicao.dspListarLotes.Data;
end;

function TReposicao.ListarConferenciaSetor: OleVariant;
begin
  dmReposicao.QryConferenciaSetor.Close;
  dmReposicao.QryConferenciaSetor.Parameters.ParamByName('pCodReposicao').Value := Self.Codigo;
  dmReposicao.QryConferenciaSetor.Open;

  Result := dmReposicao.DspConferenciaSetor.Data;
end;

function TReposicao.ListarItemReposicaoPalletColetor: OleVariant;
begin
  With dmReposicao.QryItemRepPalletColetor do Begin
     Close;
     Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
     Open;
     First;
     Result := dmReposicao.DspItemRepPalletColetor.Data;
  End;
end;

function TReposicao.ListarConferenciaPorCodigo: OleVariant;
begin
  dmReposicao.QryConferenciaRepPorCodigo.Close;
  dmReposicao.QryConferenciaRepPorCodigo.Parameters.ParamByName('pCodReposicao').Value := Self.Codigo;
  dmReposicao.QryConferenciaRepPorCodigo.Open;

  Result := dmReposicao.DspConferenciaRepPorCodigo.Data;
end;

function TReposicao.ListarRelPallet(Coletor : Boolean = False) : OleVariant;
begin
  if Not Coletor then Begin
     dmReposicao.QryRelatorioPallet.Close;
     dmReposicao.QryRelatorioPallet.Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
     dmReposicao.QryRelatorioPallet.Open;
     dmReposicao.QryRelatorioPallet.First;
     Result := dmReposicao.DspRelatorioPallet.Data;
  End
  Else With dmReposicao.QryRepPalletColetor do Begin //Gerar a Coleta da Reposição no Coletor
     Close;
     Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
     Open;
     First;
     Result := dmReposicao.DspRepPalletColetor.Data;

  End;
{  While Not (dmReposicao.QryRelatorioPallet.Eof) do Begin
    if vProdAtendido <> dmReposicao.QryRelatorioPallet.FieldByName('CdProduto').AsString then Begin
       vProdAtendido := dmReposicao.QryRelatorioPallet.FieldByName('CdProduto').AsString;
       vQtAtendida   := 0;
    End;
    if vQtAtendida < dmReposicao.QryRelatorioPallet.FieldByName('QtSolicitada').Value then Begin
       dmReposicao.QryRelatorioPallet.Edit;
       if dmReposicao.QryRelatorioPallet.FieldByName('QtLote').Value >= (dmReposicao.QryRelatorioPallet.FieldByName('QtSolicitada').Value-vQtAtendida) then
          dmReposicao.QryRelatorioPallet.FieldByName('QtAtendida').Value := (dmReposicao.QryRelatorioPallet.FieldByName('QtSolicitada').Value-vQtAtendida)
       else dmReposicao.QryRelatorioPallet.FieldByName('QtAtendida').Value := dmReposicao.QryRelatorioPallet.FieldByName('QtLote').Value;
       vQtAtendida := vQtAtendida + dmReposicao.QryRelatorioPallet.FieldByName('QtAtendida').Value;
    End
    Else dmReposicao.QryRelatorioPallet.delete;
    dmReposicao.QryRelatorioPallet.Next;
  End;
}
end;

Class Function TReposicao.ListarReposicao(pStatus : Integer): OleVariant;
begin
  DmReposicao.QryListarReposicao.Close;
  DmReposicao.QryListarReposicao.Parameters.ParamByName('pStatus').Value := pStatus;
  DmReposicao.QryListarReposicao.Open;
  Result := DmReposicao.DspListarReposicao.Data;
end;

class function TReposicao.ListarReposicaoItens(
  pCdReposicao: Integer): OleVariant;
begin
//Funcao Substituida por ListarItemReposicaoPalletColetor
//  DmReposicao.QryListarReposicaoItens.Close;
//  DmReposicao.QryListarReposicaoItens.Parameters.ParamByName('pCdReposicao').Value := pCdReposicao;
//  DmReposicao.QryListarReposicaoItens.Open;
//  Result := DmReposicao.DspListarReposicaoItens.Data;
end;

Class procedure TReposicao.MoveReservaToPicking(ObjMovimentacao : TMovimentacao);
//Mover de TbEstoqueReserva Motivo 2 para Picking
begin
  //Eliminar esta funcao
end;

procedure TReposicao.MovimentarColetaItem(ObjLoteReposicao : TLoteReposicao);
Var vlMovimentacao : TMovimentacao;
Begin
  vlMovimentacao := TMovimentacao.Create;
  try
    vlMovimentacao.Codigo               := 0;
    vlMovimentacao.CodigoUsuario        := ObjLoteReposicao.CdUsuario;
    vlMovimentacao.CodigoLote           := ObjLoteReposicao.CdLote;
    vlMovimentacao.EstoqueOrigem        := ObjLoteReposicao.EstoqueTipo;
    vlMovimentacao.CodigoEnderecoOrigem := ObjLoteReposicao.CdEndOrigem;
    case vlMovimentacao.EstoqueOrigem of
      Espera: vlMovimentacao.Origem := 'Área de Espera'; // 1 = Área de Espera
      Producao: vlMovimentacao.Origem := 'Endereço nº: ' + AplicarMascara(ObjLoteReposicao.NmEndOrigem , TConfig.PegarParametro('endMascaraPallet')); // 4 = Produção
    end;

    vlMovimentacao.EstoqueDestino        := Reserva; // 7 = Reposição de FlowRack
    vlMovimentacao.CodigoEnderecoDestino := ObjLoteReposicao.CdEndDestino;
    vlMovimentacao.Destino               := 'Área Reposição FlowRack. Endereço nº: ' + AplicarMascara(ObjLoteReposicao.nmEndDestino, TConfig.PegarParametro('endMascaraPicking'));
    vlMovimentacao.QtdMovimentada        := ObjLoteReposicao.Quantidade;
    vlMovimentacao.OperacaoEstoque       := Interna; // 2 = Interna
    vlMovimentacao.Salvar;
  finally
    FreeAndNil(vlMovimentacao);
  end;
end;

class function TReposicao.PegarReposicao(pCodigo: string): TReposicao;
var
  vlCodigo: Integer;
  vlReposicao: TReposicao;
begin
  try
    vlCodigo := StrToInt(pCodigo);
  except
    raise Exception.Create('Código da Reposição inválido!');
  end;

  dmReposicao.qryPegar.Close;
  dmReposicao.qryPegar.Parameters.ParamByName('pCdReposicao').Value := vlCodigo;
  dmReposicao.qryPegar.Open;

  if (dmReposicao.qryPegar.IsEmpty = True) then
    begin
      raise Exception.Create('Código da Reposição não encontrado!');
    end;

  vlReposicao        := TReposicao.Create;
  vlReposicao.Codigo := dmReposicao.qryPegar.FieldByName('cdReposicao').AsInteger;
  vlReposicao.Data   := dmReposicao.qryPegar.FieldByName('dtReposicao').AsDateTime;

  vlReposicao.FCodigoTipo   := dmReposicao.qryPegar.FieldByName('cdReposicaoTipo').AsInteger;
  vlReposicao.FCodigoStatus := dmReposicao.qryPegar.FieldByName('cdReposicaoStatus').AsInteger;
  vlReposicao.FCdUsuario    := dmReposicao.qryPegar.FieldByName('CdUsuario').AsInteger;
  vlReposicao.FCdProduto    := dmReposicao.qryPegar.FieldByName('CdProduto').AsLargeInt;
  vlReposicao.FCdEndereco   := dmReposicao.qryPegar.FieldByName('CdEndereco').AsInteger;
  vlReposicao.FDtSaida      := dmReposicao.qryPegar.FieldByName('DtSaida').AsDateTime;
  if dmReposicao.qryPegar.FieldByName('TipoColeta').AsInteger = 0 then
     vlReposicao.FTipoColeta := Manual
  Else vlReposicao.FTipoColeta := Coletor;
  Result := vlReposicao;
end;

class function TReposicao.Pesquisar(pData, pCodProduto, pEndereco: string): OleVariant;
begin
  pEndereco := RemoverCaracteres(pEndereco);

  ValidarParametroTexto(pData);
  ValidarParametroTexto(pCodProduto);
  ValidarParametroTexto(pEndereco);

  if (pData <> '%') then
    begin
      pData := FormatDateTime('yyyy-mm-dd', ValidarData(pData, 'Data'));
    end;

  dmReposicao.qryPesquisar.Close;
  dmReposicao.qryPesquisar.Parameters.ParamByName('pDtReposicao').Value := pData;
  dmReposicao.qryPesquisar.Parameters.ParamByName('pCdProduto').Value   := pCodProduto;
  dmReposicao.qryPesquisar.Parameters.ParamByName('pNmEndereco').Value  := pEndereco;
  dmReposicao.qryPesquisar.Open;

  Result := dmReposicao.dspPesquisar.Data;
end;

class function TReposicao.PesquisarConferencia(pData, pCodReposicao: string): OleVariant;
begin
  pCodReposicao := RemoverCaracteres(pCodReposicao);
  if pData = '' then pData := '01/01/1900';

//  ValidarParametroTexto(pData);
//  ValidarParametroTexto(pCodReposicao);

  if (pData <> '') then
    begin
      pData := FormatDateTime('yyyy-mm-dd', ValidarData(pData, 'Data'));
    end;

  dmReposicao.qryPesquisarConferencia.Close;
  dmReposicao.qryPesquisarConferencia.Parameters.ParamByName('pDtReposicao').Value := pData;
  dmReposicao.qryPesquisarConferencia.Parameters.ParamByName('pCdReposicao').Value := StrToIntDef(pCodReposicao, 0);
  dmReposicao.qryPesquisarConferencia.Open;

  Result := dmReposicao.dspPesquisarConferencia.Data;
end;

function TReposicao.RelatorioEstoque: OleVariant;
begin
  dmReposicao.qryRelatorioEstoque.Close;
  dmReposicao.qryRelatorioEstoque.Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
  dmReposicao.qryRelatorioEstoque.Open;

  Result := dmReposicao.dspRelatorioEstoque.Data;
end;

function TReposicao.RelatorioProdutos: OleVariant;
begin
  dmReposicao.qryRelatorioProdutos.Close;
  dmReposicao.qryRelatorioProdutos.Parameters.ParamByName('pCdReposicao').Value := Self.Codigo;
  dmReposicao.qryRelatorioProdutos.Open;

  Result := dmReposicao.dspRelatorioProdutos.Data;
end;

class function TReposicao.RelRepoMovimentacao(pData: String; pCdReposicao,
  pCdUsuario: Integer; pCdProduto: Int64; pFiltro : String): OleVariant;
begin
  With dmReposicao.QryRepoMovimentacao do Begin
    Close;
    if pFiltro <> '' then Begin
       Sql.Strings[9] := ' and '+pFiltro;
//       Sql.Strings[15] := ' and '+pFiltro;
//       Sql.Strings[28] := ' And '+pFiltro;
    End;
    if (pData = '') or (pData = '  /  /    ') then Parameters.ParamByName('pData').Value := Null
    Else Parameters.ParamByName('pData').Value   := FormatDateTime('YYYY-MM-DD', StrToDate(pData));
    Parameters.ParamByName('pCdReposicao').Value := pCdReposicao;
    Parameters.ParamByName('pCdUsuario').Value   := pCdUsuario;
    Parameters.ParamByName('pCdProduto').Value   := pCdProduto;
    Open;
  End;
  Result := DmReposicao.DspRepoMovimentaca.Data;
end;

class function TReposicao.RelReposicaoAnalise(pCdReposicao, pStatus : Integer;
      pCdProduto :Int64; pDataInicial, pDataFinal : String; pTipoColeta : Integer; pCdUsuario : Integer): OleVariant;
begin
  with DmReposicao.QryRepoRelAnalise do Begin
    Close;
    Parameters.ParamByName('pCdReposicao').Value := pCdReposicao;
    Parameters.ParamByName('pStatus').Value      := pStatus;
    Parameters.ParamByName('pCdProduto').Value   := pCdProduto;
    Parameters.ParamByName('pDataInicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDataInicial));
    Parameters.ParamByName('pDataFinal').Value   := FormatDateTime('YYYY-MM-DD', StrToDate(pDataFinal));
    Parameters.ParamByName('pTipoColeta').Value  := pTipoColeta;
    Parameters.ParamByName('pCdUsuario').Value   := pCdUsuario;
    Open
  End;
  Result := dmReposicao.DspRepoRelAnalise.Data;
end;

class function TReposicao.RelReposicaoColeta(pCdReposicao: Integer): OleVariant;
begin
  With dmReposicao.QryRelRepoColeta do Begin
    Close;
    Parameters.ParamByName('pCdReposicao').Value := pCdReposicao;
    Open;
  End;
  Result := dmReposicao.dspRelRepoColeta.Data;
end;

class function TReposicao.RelTransfPicking(pFiltro : String) : OleVariant;
begin
  With DmReposicao.QryRelTransfPicking do Begin
   Close;
   if pFiltro <> '' then Begin
      Sql.Strings[6]  := ' And '+pFiltro;
      Sql.Strings[15] := ' And '+pFiltro;
   End;
   Open;
  End;
  Result := DmReposicao.DspRelTransfPicking.Data;
end;

function TReposicao.ReposicaoCapacidade(pEndInicial, pEndFinal: string): OleVariant;
begin
  dmReposicao.qryReposicaoCapacidade.Close;
  dmReposicao.qryReposicaoCapacidade.Parameters.ParamByName('pEnderecoInicial').Value := pEndInicial;
  dmReposicao.qryReposicaoCapacidade.Parameters.ParamByName('pEnderecoFinal').Value   := pEndFinal + '99999';
  dmReposicao.qryReposicaoCapacidade.Open;

  Result := dmReposicao.dspReposicaoCapacidade.Data;
end;

function TReposicao.ReposicaoDiaria(pData, pEndInicial,pEndFinal: string): OleVariant;
var
  vlData: TDateTime;
begin
  vlData := ValidarData(pData, 'Data');
  if TConfig.PegarParametro('ReposicaoColetor') = '1' then With dmReposicao.QryReposicaoDiariaPorColetor do Begin
     Close;
     Parameters.ParamByName('pData').Value            := FormatDateTime('yyyy-mm-dd', vlData);
     Parameters.ParamByName('pEnderecoInicial').Value := pEndInicial;
     Parameters.ParamByName('pEnderecoFinal').Value   := pEndFinal + '99999';
     Open;
     Result := dmReposicao.DspReposicaoDiariaPorColetor.Data;
  End
  Else With dmReposicao.qryReposicaoDiaria do Begin
    Close;
    Parameters.ParamByName('pData').Value            := FormatDateTime('yyyy-mm-dd', vlData);
    Parameters.ParamByName('pEnderecoInicial').Value := pEndInicial;
    Parameters.ParamByName('pEnderecoFinal').Value   := pEndFinal + '99999';
    Open;
    Result := dmReposicao.dspReposicaoDiaria.Data;
  End;
end;

class function TReposicao.ReposicaoItensColetor: OleVariant;
begin
  DmReposicao.QryReposicaoItensColetor.Close;
  DmReposicao.QryReposicaoItensColetor.Open;
  Result := DmReposicao.DspReposicaoItensColetor.Data;
end;

class function TReposicao.ReposicaoLoteEndeColetor : OleVariant;
begin
  DmReposicao.QryReposicaoLoteEndeColetor.Close;
  DmReposicao.QryReposicaoLoteEndeColetor.Open;
  Result := DmReposicao.DspReposicaoLoteEndeColetor.Data;
end;

procedure TReposicao.Salvar(pProdutos: OleVariant; vgHistorico: THistorico);
begin
  dmReposicao.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
  dmReposicao.qrySalvar.Connection.BeginTrans;

  try
    dmReposicao.qrySalvar.Close;
    dmReposicao.qrySalvar.Parameters.ParamByName('pCdReposicaoTipo').Value := Self.Tipo.Codigo;
    dmReposicao.qrySalvar.Parameters.ParamByName('pDtReposicao').Value     := FormatDateTime('yyyy-mm-dd hh:mm:ss', Self.Data);
    DmReposicao.qrySalvar.Parameters.ParamByName('pTipoColeta').Value      := Self.TipoColeta;
    dmReposicao.qrySalvar.Parameters.ParamByName('pDtSaida').Value         := FormatDateTime('yyyy-mm-dd', Self.DtSaida);
    dmReposicao.qrySalvar.Open;

    Self.Codigo := dmReposicao.qrySalvar.FieldByName('cdReposicao').AsInteger;

    SalvarProdutos(pProdutos);

    vgHistorico.CodigoRegistro := Self.Codigo;
    vgHistorico.Observacao     := 'Cadastro de nova Reposição';
    vgHistorico.Salvar;

    dmReposicao.qrySalvar.Connection.CommitTrans;
  except on e: Exception do
    begin
      dmReposicao.qrySalvar.Connection.RollbackTrans;

      Self.Codigo := 0;

      raise Exception.Create(e.Message);
    end;
  end;
end;

Class procedure TReposicao.SalvarColetaProduto(PCdReposicao : Integer; pData, pEndInicial, pEndFinal, pFiltro : String);
var vlData: TDateTime;
begin
  vlData := ValidarData(pData, 'Data');
  with dmReposicao.QrySalvarColetaProduto do Begin
    Close;
    Parameters.ParamByName('pCdReposicao').Value := pCdReposicao;
    if pFiltro <> '' then Begin
       Sql.Strings[3] := 'And '+pFiltro;
       Sql.Strings[7] := 'And '+pFiltro;
    End
    Else Begin
       Sql.Strings[3] := '';
       Sql.Strings[7] := '';
    End;
//    Parameters.ParamByName('pData').Value            := FormatDateTime('yyyy-mm-dd', vlData);
//    Parameters.ParamByName('pEnderecoInicial').Value := pEndInicial;
//    Parameters.ParamByName('pEnderecoFinal').Value   := pEndFinal + '99999';
//    Parameters.ParamByName('pCdReposicao').Value := pCdReposicao;
    ExecSQL;
  End;
end;

procedure TReposicao.SalvarItemReposicaoColetor(ObjLoteReposicao : TLoteReposicao);
//(pCdProduto : Int64; pCdLote, pEstoqueTipo : Integer; pCdEndOrigem, pCdEndDestino,pCdSuario, pQuantidade : Integer);
begin
  Self.LstLoteReposicao.Add(ObjLoteReposicao);
  //pCdProduto, pCdLote, pEstoqueTipo, pCdEndOrigem, pCdEndDestino, pCdSuario, pQuantidade);
end;

procedure TReposicao.SalvarProdutos(pProdutos: OleVariant);
var
  vlProdutos: TClientDataSet;
begin
  vlProdutos := TClientDataSet.Create(nil);

  try
    vlProdutos.Close;
    vlProdutos.Data := pProdutos;

    if (vlProdutos.IsEmpty = True) then
      begin
        raise Exception.Create('Nenhum produto foi informado!');
      end;

    vlProdutos.First;
    while (vlProdutos.Eof = False) do
      begin
        dmReposicao.qrySalvarProduto.Close;
        dmReposicao.qrySalvarProduto.Parameters.ParamByName('pCdReposicao').Value  := Self.Codigo;
        dmReposicao.qrySalvarProduto.Parameters.ParamByName('pCdProduto').Value    := vlProdutos.FieldByName('cdProduto').AsLargeInt;
        dmReposicao.qrySalvarProduto.Parameters.ParamByName('pQtSolicitada').Value := vlProdutos.FieldByName('qtReposicao').AsInteger;
        dmReposicao.qrySalvarProduto.ExecSQL;

        vlProdutos.Next;
      end;
  finally
    FreeAndNil(vlProdutos);
  end;
end;

procedure TReposicao.setStatus(pStatus: TReposicaoStatus);
begin
  FreeAndNil(FStatus);

  FStatus := pStatus;

  if (Assigned(FStatus) = True) then
    begin
      FCodigoStatus := FStatus.Codigo;
    end
  else
    begin
      FCodigoStatus := 0;
    end;
end;

procedure TReposicao.setTipo(pTipo: TReposicaoTipo);
begin
  FreeAndNil(FTipo);

  FTipo := pTipo;

  if (Assigned(FTipo) = True) then
    begin
      FCodigoTipo := FTipo.Codigo;
    end
  else
    begin
      FCodigoTipo := 0;
    end;
end;

{ TLoteReposicao }

{ TListaLoteReposicao }

function TListaLoteReposicao.Add(Item: TLoteReposicao): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListaLoteReposicao.SetItems(const Value: TArrayListaLoteReposicao);
begin
   FItems := Value;
end;

function TListaLoteReposicao.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TLoteReposicao }

class function TReposicaoStatus.ListaStatus: OleVariant;
begin
  dmReposicao.QryListarRepoStatus.Close;
  DmReposicao.QryListarRepoStatus.Open;
  Result := dmReposicao.DspListarRepoStatus.Data;
end;

class function TReposicaoStatus.PegarStatus(pCodigo: Integer): TReposicaoStatus;
var
  vlStatus: TReposicaoStatus;
begin
  dmReposicao.qryPegarRepoStatus.Close;
  dmReposicao.qryPegarRepoStatus.Parameters.ParamByName('pCdReposicaoStatus').Value := pCodigo;
  dmReposicao.qryPegarRepoStatus.Open;

  if (dmReposicao.qryPegarRepoStatus.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Status da Reposição não encontrado!');
    end;

  vlStatus        := TReposicaoStatus.Create;
  vlStatus.Codigo := dmReposicao.qryPegarRepoStatus.FieldByName('cdReposicaoStatus').AsInteger;
  vlStatus.Nome   := dmReposicao.qryPegarRepoStatus.FieldByName('nmReposicaoStatus').AsString;

  Result := vlStatus;
end;

class function TReposicaoTipo.ListarTipos: OleVariant;
begin
  dmReposicao.qryListarRepoTipo.Close;
  dmReposicao.qryListarRepoTipo.Open;

  Result := dmReposicao.dspListarRepoTipo.Data;
end;

class function TReposicaoTipo.PegarTipo(pCodigo: Integer): TReposicaoTipo;
var
  vlTipo: TReposicaoTipo;
begin
  dmReposicao.qryPegarRepoTipo.Close;
  dmReposicao.qryPegarRepoTipo.Parameters.ParamByName('pCdReposicaoTipo').Value := pCodigo;
  dmReposicao.qryPegarRepoTipo.Open;

  if (dmReposicao.qryPegarRepoTipo.IsEmpty = True) then
    begin
      raise Exception.Create('Código do Tipo da Reposição não encontrado!');
    end;

  vlTipo        := TReposicaoTipo.Create;
  vlTipo.Codigo := dmReposicao.qryPegarRepoTipo.FieldByName('cdReposicaoTipo').AsInteger;
  vlTipo.Nome   := dmReposicao.qryPegarRepoTipo.FieldByName('nmReposicaoTipo').AsString;

  Result := vlTipo;
end;

{ TLoteReposicao }

constructor TLoteReposicao.Create(cCdProduto: Int64; cCdLote: Integer;
  cEstoqueTipo: TTipoEstoque; cCdEndOrigem: Integer; cNmEndOrigem: String;
  cCdEndDestino: Integer; cNmEndDestino: String; cCdSuario,
  cQuantidade: Integer);
begin
  FCdProduto    := cCdProduto;
  FCdLote       := cCdLote;
  FEstoqueTipo  := cEstoqueTipo;
  FCdEndOrigem  := cCdEndOrigem;
  FNmEndOrigem  := cNmEndOrigem;
  FCdEndDestino := cCdEndDestino;
  fNmEndDestino := cNmEndDestino;
  FCdUsuario    := cCdSuario;
  FQuantidade   := cQuantidade
end;

end.

