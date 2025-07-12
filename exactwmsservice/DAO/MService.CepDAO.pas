unit MService.CepDAO;

interface

uses
  Dialogs, FireDAC.Comp.Client, uCepAbertoClass, System.SysUtils,  DataSet.Serialize,
  System.Types, REST.Types, REST.Client, Data.Bind.Components,
  System.JSON, REST.Json, System.JSON.Types;

type
  TCepDao = class
  private
    
    ObjCepDAO : TCepAberto;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function Get(pCep : String): TJsonObject;
  end;

implementation

uses uSistemaControl, uDmBase;

{ TClienteDao }

constructor TCepDao.Create;
begin
  ObjCepDAO := TCepAberto.Create;
  inherited;
end;

destructor TCepDao.Destroy;
begin
  ObjCepDAO.Free;
  inherited;
end;

function TCepDao.Get(pCep: String): TJsonObject;
//Var DmBase : TDmBase;
begin
  Try
    DmBase := TDmBase.Create(DmBase);
    DmBase.RESTClientCep.BaseURL := 'http://www.cepaberto.com/api/v3/cep?cep='+pCep;
    DmBase.RESTRequestCep.Execute;
    Result := (tJsonObject(DmBase.RESTRequestCep.Response.JSONValue) as TJsonObject);
  Except
    Result := Nil;
  End;
end;

End.
