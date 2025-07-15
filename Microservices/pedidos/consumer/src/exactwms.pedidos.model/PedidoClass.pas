{
  PedidoClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit PedidoClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  Rest.Json.Types,
  System.Json, OperacaoTipoClass, PessoaClass;

type
  Tcrud = (Ins, Upd);
  TProcesso = (moRecebido, moCubagem, moImpresso, moCheckIn, moCheckInEnd,
    moDevolvido, moApanhe, moApanheEnd, moCheckOut, moCheckOutEnd, moExpedição,
    moExpedido, moCancelado, moCargaMontagem, moCargaCompletado,
    moCargaTrânsito, moCargaLoja, moCargaFinalizada, moCargaCancelada,
    moReProcessado);

  TPedido = class
  private
    FPedidoId: Integer;
    FOperacaoTipo: TOperacaoTipo;
    FPessoa: TPessoa;
    FDocumentoNr: String;
    FDocumentoData: TDate;
    FRegistroERP: String;
    FArmazemId: Integer;
    FDtInclusao: TDate;
    FHrInclusao: TTime;
    FProcesso: TProcesso;
    FStatus: Integer;
    // 0-Recebido 2-CheckIn Finalizado 3-Cancelada 4-Retornado ERP
    Fuuid: String;
  Protected
  Public
    [JSONMarshalledAttribute(False)]
    CRUD: Tcrud;
    constructor Create;
    Destructor Destroy; OverRide;
    Function Salvar(ObjPedido: TPedido): Boolean; // (const ObjPedido: TPedido)
    Function ExportaExcel: Boolean;
    // http://www.activedelphi.com.br/forum/viewtopic.php?t=72648&sid=143f45840f077863eb7bbc51fe422c77
    Function ClassToJson(Const ObjPedido: TPedido): String;
    Function JsonToClass(Json: String): TPedido;
    Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    property PedidoId: Integer Read FPedidoId Write FPedidoId;
    property OperacaoTipo: TOperacaoTipo Read FOperacaoTipo Write FOperacaoTipo;
    property Pessoa: TPessoa Read FPessoa Write FPessoa;
    property DocumentoNr: String Read FDocumentoNr Write FDocumentoNr;
    // [JsonDates('DocumentoData')]
    property DocumentoData: TDate Read FDocumentoData Write FDocumentoData;
    Property RegistroERP: String Read FRegistroERP Write FRegistroERP;
    // uuid enviado pelo ERP
    Property ArmazemId: Integer Read FArmazemId Write FArmazemId;
    property DtInclusao: TDate Read FDtInclusao Write FDtInclusao;
    property HrInclusao: TTime Read FHrInclusao Write FHrInclusao;
    Property Processo: TProcesso Read FProcesso Write FProcesso;
    Property Status: Integer Read FStatus Write FStatus;
    Property uuid: String Read Fuuid Write Fuuid;
  End;

implementation

{ TPedido }

Uses uFuncoes;

Function TPedido.ClassToJson(Const ObjPedido: TPedido): String;
begin
  // Result := tJson.ObjectToJsonString(ObjPedido);
end;

procedure TPedido.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TPedido.Create;
Begin
  FPedidoId := 0;
  FOperacaoTipo := TOperacaoTipo.Create();
  FPessoa := TPessoa.Create();
  FDocumentoNr := '';
  FDocumentoData := 0;
  FRegistroERP := '';
  FArmazemId := 0;
  FDtInclusao := 0;
  FHrInclusao := StrToTime('00:00');
  FProcesso := moRecebido;
  FStatus := 0;
  Fuuid := '';
End;

destructor TPedido.Destroy;
begin
  Try
    FOperacaoTipo := Nil;
  Except
    raise Exception.Create('Erro Free Operacao Tipo');
  End;
  Try
    FPessoa := Nil;
  Except
    raise Exception.Create('Erro Free Pessoa');
  End;
  inherited;
end;

Function TPedido.ExportaExcel: Boolean;
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

Function TPedido.JsonToClass(Json: String): TPedido;
begin
  Result := TPedido.Create;
  Result := tJson.JsonToObject<TPedido>(Json, [joDateFormatUnix])
end;

function TPedido.Salvar(ObjPedido: TPedido): Boolean;
// (const ObjLaboratorio: TLaboratorio):
begin
  Result := True;
End;

End.
