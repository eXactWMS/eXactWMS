{
   NovidadesCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 01/11/2022
   Projeto: eXactWMS
}
unit NovidadesCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs,
     Generics.Collections, Rest.Json, System.Json, Rest.Types, Rest.Client;

Type
  TipoConsulta = (Resumida, Completa);
  TNovidadesCtrl = Class
  Private
    //Funções de Validação
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function GetNovidades(pNovidadeid : Integer; pVersao : String; pStatus : Integer) : tJsonArray;
    Class Function MarkRead(pIdNovidades : Integer) : Boolean;
  End;

implementation

{ tCtrlNovidades }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

constructor TNovidadesCtrl.Create;
begin
  //
end;

class function TNovidadesCtrl.MarkRead(pIdNovidades : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/novidades/{novidadeid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('novidadeid', pIdNovidades.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     ShowMessage('Dica marcado com lida!');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível marcar a dica.');
end;

destructor TNovidadesCtrl.Destroy;
begin
  inherited;
end;

Function tNovidadesCtrl.GetNovidades(pNovidadeid : Integer; pVersao : String; pStatus : Integer) : TJsonArray; //(pNovidadesId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TNovidades>;
Var pRestRequest  : TRestRequest;
    pRESTClient   : TRESTClient;
    pRestResponse : TRestResponse;
    vResourceURI  : String;
Begin
  //Result := TJsonArray.Create;
  pRestRequest  := TRestRequest.Create(Nil);
  pRESTClient   := TRESTClient.Create(Nil);
  pRestResponse := TRestResponse.Create(Nil);


  pRestRequest.ResetToDefaults;
  pRESTClient.Accept         := 'application/json';//, text/plain; q=0.9, text/html;q=0.8,';
  pRESTClient.AcceptCharset  := 'UTF-8, *;q=0.8';   //'application/json';//
  pRestRequest.Timeout := 30000*5;




  pRestRequest  := DmeXactWMS.RESTRequestWMS;
  pRestResponse := DmeXactWMS.RESTResponseWMS;
  vResourceURI := 'v1/novidades?';
  if pNovidadeId <> 0 then
     vResourceURI := vResourceURI+'&novidadeid='+pNovidadeId.ToString();
  if pVersao <> '' then
     vResourceURI := vResourceURI+'&versao='+pVersao;
  if pStatus > 0 then
     vResourceURI := vResourceURI+'&status='+pStatus.ToString();
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  pRestRequest.Resource := vResourceURI;
  pRestRequest.Method := RmGet;
  pRestRequest.Execute;
  if (pRestResponse.StatusCode = 200) or (pRestResponse.StatusCode = 201) Then
     Result := pRestResponse.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+pRestResponse.StatusText);
  //FreeAndNil(pRestRequest);
  //FreeAndNil(pRESTClient);
  //FreeAndNil(pRestResponse);
End;

End.

