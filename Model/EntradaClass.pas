{
  EntradaClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit EntradaClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json, OperacaoTipoClass, PessoaClass, EntradaItensClass;

type
  Tcrud = (Ins, Upd);

  TEntrada = class
  private
    // FCrud            : TCrud;
    FEntradaId: Integer;
    FOperacaoTipo: TOperacaoTipo;
    FPessoa: TPessoa;
    FDocumentoNr: String;
    FDocumentoData: TDate;
    FRegistroERP: String;
    FArmazemId: Integer;
    FDtInclusao: TDate;
    FHrInclusao: TTime;
    FItens: TObjectList<TEntradaItens>;
    FStatus: Integer;
    // 0-Recebido 2-CheckIn Finalizado 3-Cancelada 4-Retornado ERP
    FProcessoId: Integer;
    FProcesso: String;
    // FArmazemId    : TArmazem;
    Function NextCodigo: Integer; // Gerador de Código Automático
  Protected
  Public
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar(ObjEntrada: TEntrada): Boolean;
    // (const ObjEntrada: TEntrada)
    Function ExportaExcel: Boolean;
    Function ClassToJson(Const ObjEntrada: TEntrada): String;
    Function JsonToClass(Json: String): TEntrada;
    Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Function GetEntrada(pEntradaId: Integer = 0; pPessoaId: Integer = 0;
      pDocumentoNr: String = ''; pRazao: String = ''; pRegistroERP: String = '';
      pDtNotaFiscal: TDateTime = 0; pPendente: Integer = 0;
      pAgrupamentoId: Integer = 0; pShowErro: Integer = 1; pCodProduto : String = '0'): tJsonArray;
    Function GetEntradaBasica(pEntradaId: Integer = 0;
      pCodPessoaERP: Integer = 0; pDocumentoNr: String = '';
      pRazao: String = ''; pRegistroERP: String = '';
      pDtNotaFiscal: TDateTime = 0; pPendente: Integer = 0;
      pAgrupamentoId: Integer = 0; pCodProduto : String = '0'): tJsonArray;
    Function DeleteEntrada(pJsonDelete: TJsonObject): Boolean;
    Function GetEntradaProduto(pPedidoId: Integer): tJsonArray;
    Function GetEntradaItens(pPedidoId: Integer): tJsonArray;
    Function GetAgrupamentoPedido(pAgrupamentoId, pPedidoId: Integer) : tJsonArray;
    Function GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer): tJsonArray;
    Function GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer) : tJsonArray;

    Procedure Limpar;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    property EntradaId: Integer Read FEntradaId Write FEntradaId;
    property OperacaoTipo: TOperacaoTipo Read FOperacaoTipo Write FOperacaoTipo;
    property Pessoa: TPessoa Read FPessoa Write FPessoa;
    property DocumentoNr: String Read FDocumentoNr Write FDocumentoNr;
    property DocumentoData: TDate Read FDocumentoData Write FDocumentoData;
    Property RegistroERP: String Read FRegistroERP Write FRegistroERP;
    Property ArmazemId: Integer Read FArmazemId Write FArmazemId;
    property DtInclusao: TDate Read FDtInclusao Write FDtInclusao;
    property HrInclusao: TTime Read FHrInclusao Write FHrInclusao;
    Property Itens: TObjectList<TEntradaItens> Read FItens Write FItens;
    Property Status: Integer Read FStatus Write FStatus;
    Property ProcessoId: Integer Read FProcessoId Write FProcessoId;
    Property Processo: String Read FProcesso Write FProcesso;
  End;

implementation

{ TEntrada }

Uses uFuncoes, uEntradaDAO;

Function TEntrada.ClassToJson(Const ObjEntrada: TEntrada): String;
begin
  Result := tJson.ObjectToJsonString(ObjEntrada);
end;

procedure TEntrada.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TEntrada.Create;
Begin
  FOperacaoTipo := TOperacaoTipo.Create();
  FPessoa := TPessoa.Create();
  FItens := TObjectList<TEntradaItens>.Create;
  FProcessoId := 0;
  FProcesso := '';
  Limpar;
End;

Function TEntrada.DeleteEntrada(pJsonDelete: TJsonObject): Boolean;
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.Delete(pJsonDelete);
  if Result then
    Self.FEntradaId := 0;
  ObjEntradaDAO.Free;
end;

destructor TEntrada.Destroy;
begin
  FOperacaoTipo.Free; // := Nil;
  FPessoa.Free; // := Nil;
  FItens.Free; // := Nil;
  inherited;
end;

Function TEntrada.ExportaExcel: Boolean;
begin
  Result := True;
  Try
    // ExportarExcel(DmRhemaWMS.QryLaboratorio);
  Except
    Result := False;
    raise Exception.Create
      ('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
  End;
end;

function TEntrada.GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer) : tJsonArray;
Var ObjEntradaDAO: TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetAgrupamentoFatorarLoteXML(pAgrupamentoId);
    ObjEntradaDAO.Free;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  End;
end;

function TEntrada.GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer)
  : tJsonArray;
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId);
    ObjEntradaDAO.Free;
  Except
    On E: Exception do
      raise Exception.Create(E.Message);
  End;
end;


function TEntrada.GetAgrupamentoPedido(pAgrupamentoId, pPedidoId: Integer)
  : tJsonArray;
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetAgrupamentoPedido(pAgrupamentoId, pPedidoId);
    ObjEntradaDAO.Free;
  Except
    On E: Exception do
    Begin
      ObjEntradaDAO.Free;
      raise Exception.Create(E.Message);
    End;
  End;
end;

Function TEntrada.GetEntrada(pEntradaId, pPessoaId: Integer;
  pDocumentoNr, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
  pPendente: Integer; pAgrupamentoId: Integer; pShowErro: Integer; pCodProduto : String): tJsonArray;
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  ObjEntradaDAO.Entrada.EntradaId := Self.EntradaId;
  Result := ObjEntradaDAO.Pesquisar(pEntradaId, pPessoaId, pDocumentoNr, pRazao,
    pRegistroERP, pDtNotaFiscal, pPendente, pAgrupamentoId, False, pCodProduto);
  ObjEntradaDAO.Free;
end;

function TEntrada.GetEntradaBasica(pEntradaId, pCodPessoaERP: Integer;
  pDocumentoNr, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
  pPendente, pAgrupamentoId : Integer; pCodProduto : String): tJsonArray;
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  ObjEntradaDAO.Entrada.EntradaId := Self.EntradaId;
  Result := ObjEntradaDAO.Pesquisar(pEntradaId, pCodPessoaERP, pDocumentoNr,
    pRazao, pRegistroERP, pDtNotaFiscal, pPendente, pAgrupamentoId, True, pCodProduto);
  ObjEntradaDAO.Free;
end;

function TEntrada.GetEntradaItens(pPedidoId: Integer): tJsonArray;
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  {
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetEntradaItens(pPedidoId);
    ObjEntradaDAO.Free;
  }
end;

function TEntrada.GetEntradaProduto(pPedidoId: Integer): tJsonArray;
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  {
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetEntradaProduto(pPedidoId);
    ObjEntradaDAO.Free;
  }
end;

Function TEntrada.JsonToClass(Json: String): TEntrada;
begin
  Result := TEntrada.Create;
  Result := tJson.JsonToObject<TEntrada>(Json, [joDateFormatUnix])
end;

procedure TEntrada.Limpar;
begin
  FEntradaId := 0;
  FDocumentoNr := '';
  FDocumentoData := 0;
  FRegistroERP := '';
  FArmazemId := 0;
  FDtInclusao := 0;
  FHrInclusao := StrToTime('00:00');
  FStatus := 0;
end;

function TEntrada.NextCodigo: Integer;
Begin
  // Result := DmRhemaWMS.CodGeral('Laboratorio', 'Id', '');
End;

function TEntrada.Salvar(ObjEntrada: TEntrada): Boolean;
// (const ObjLaboratorio: TLaboratorio):
Var
  ObjEntradaDAO: TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  ObjEntradaDAO.Entrada := Self;
  Result := ObjEntradaDAO.Salvar;
  ObjEntradaDAO.Free;
End;

End.
