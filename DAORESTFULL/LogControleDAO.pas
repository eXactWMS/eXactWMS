unit LogControleDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, PedidoSaidaClass, System.JSON, REST.Json, Rest.Types, System.Generics.Collections;

Type

  TLogControleDao = class
  private
    FLogControle : TPedidoSaida;
  public
    constructor Create;
    Function GetLogControle(pDataInicio, pDataTermino : TDateTime;
                            pUsuarioId : Integer; pTerminal, pRequisicao : String; pVerbo, pSomenteErro : Integer) : tJsonArray;
    Function GetLogDashBoard : TJsonArray;
//    Property LogControle : TPedidoSaida Read FLogControle Write FLogControle;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TLogControleDao.Create;
begin
//  Self.FLogControle := TPedidoSaida.Create;
end;

function TLogControleDAO.GetLogControle(pDataInicio, pDataTermino : TDateTime;
                          pUsuarioId : Integer; pTerminal, pRequisicao : String; pVerbo, pSomenteErro : Integer): tJsonArray;
Var vComplemento : String;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/monitorlog/lista'; //logcontrole';
    vComplemento := '?';
    if pDataInicio <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'datainicio='+DateToStr(pDataInicio);
       vComplemento := '&';
    End;
    if pDataTermino <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'datatermino='+DateToStr(pDataTermino);
       vComplemento := '&';
    End;
    if pUsuarioId <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'usuarioid='+pUsuarioId.ToString();
       vComplemento := '&';
    End;
    if pTerminal <> ''then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'terminal='+pTerminal;
       vComplemento := '&';
    End;
    if pRequisicao <> '' then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'url='+pRequisicao;
       vComplemento := '&';
    End;
    if pVerbo > 0 then Begin
       case pVerbo of
         1: DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'verbo=Get';
         2: DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'verbo=Put' ;
         3: DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'verbo=Post';
         4: DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'verbo=Delete';
       end;
       vComplemento := '&';
    End;
    if pSomenteErro <> 0 then Begin
       DmeXactWMS.RESTRequestWMS.Resource := DmeXactWMS.RESTRequestWMS.Resource+vComplemento+'somenteerro='+pSomenteErro.ToString();
       vComplemento := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TLogControleDao.GetLogDashBoard: TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/monitorlog/dashboard';
    DmeXactWMS.RESTRequestWMS.Method   := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do
    raise Exception.Create(E.Message);
  End;
end;

end.
