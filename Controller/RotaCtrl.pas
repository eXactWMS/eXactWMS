{
   RotaCtrl.Pas
   Criado por Genilson S Soares em 20/05/2021
   Projeto: eXactWMS
}
unit RotaCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , RotaClass;

Type
  TRotaCtrl = Class
  Private
    FObjRota : TRota;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function RotaOnOff(pRotaId : Integer) : Boolean;
    Function GetRota(pRotaId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TObjectList<TRotaCtrl>;
    Function GetRotaParticipante(pRotaId : Integer = 0; pPessoaId : Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function Distancia(pLatitude, pLongitude : String) : Integer;
    Function RotaParticipante(pJsonObject : TJsonObject) : TJsonArray;
    Function GetProducaoDiaria(pDataInicial, pDataFinal : TDateTime) : TJsonObject;

    Function Salvar  : Boolean;  //(pHistorico: THistorico)
    Function DelRota : Boolean;
    Function DelParticipante(pPessoaId :Integer) : Boolean;
    Property ObjRota : TRota Read FObjRota Write FObjRota;
  End;

implementation

{ tCtrlRota }

uses uDmeXactWMS, uFuncoes, uRotaDAO;

Function tRotaCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjRota do Begin
    If Descricao = ''  Then raise
       Exception.Create('Informe a Descrição da Rota.');
  End;
  Result := True;
End;

constructor TRotaCtrl.Create;
begin
  FObjRota := TRota.Create;
end;

function TRotaCtrl.DelParticipante(pPessoaId :Integer) : Boolean;
Var ObjRotaDAO : TRotaDAO;
begin
  ObjRotaDAO := TRotaDAO.Create;
  Result := ObjRotaDAO.DelParticipante(pPessoaId);
  ObjRotaDAO.Free;
end;

function TRotaCtrl.DelRota : Boolean;
Var ObjRotaDAO : TRotaDAO;
begin
  ObjRotaDAO := TRotaDAO.Create;
  ObjRotaDAO.Rota.RotaId := Self.ObjRota.RotaId;
  Result := ObjRotaDAO.Delete;
  if Result then
     Self.ObjRota.RotaId := 0;
  ObjRotaDAO.Free;
end;

destructor TRotaCtrl.Destroy;
begin
  FreeAndNil(FObjRota);
  inherited;
end;

function TRotaCtrl.Distancia(pLatitude, pLongitude: String): Integer;
Var ObjRotaDAO : TRotaDAO;
begin
  ObjRotaDAO := TRotaDAO.Create;
  Result := ObjRotaDAO.Distancia(pLatitude, pLongitude);
  ObjRotaDAO.Free;
end;

function TRotaCtrl.GetProducaoDiaria(pDataInicial,
  pDataFinal: TDateTime): TJsonObject;
Var ObjRotaDAO     : TRotaDAO;
begin
  Try
    ObjRotaDAO := TRotaDAO.Create;
    Result     := ObjRotaDAO.GetProducaoDiaria(pDataInicial, pDataFinal);
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    End;
  End;
end;

function TRotaCtrl.GetRota(pRotaId: Integer; pDescricao: String;
  pShowErro : Integer): TObjectList<TRotaCtrl>;
Var ReturnJson, ArrayJSonRotaPessoa : TJsonArray;
    JsonRota, jsonRotaPessoa : TJsonObject;
    ObjRotaPessoa  : TRotaPessoa;
    xItens         : Integer;
    ObjRotaCtrl    : TRotaCtrl;
    ObjRotaDAO     : TRotaDAO;
    vErro          : String;
begin
  Result     := TObjectList<TRotaCtrl>.Create;
  ObjRotaDAO := TRotaDAO.Create;
  ObjRotaDAO.Rota.RotaId := Self.ObjRota.RotaId;
  ReturnJson := ObjRotaDAO.GetRota(pRotaId, pDescricao, pShowErro);
  if (Not ReturnJson.Items[0].TryGetValue('Erro', vErro)) and (ReturnJson.Count >= 1) then Begin
     xItens := 0;
     Repeat
       ObjRotaCtrl := TRotaCtrl.Create;
       //JsonRota    := tJsonObject.create;
       //JsonRota    := ReturnJson.Items[xItens] as TJSONObject;
       ObjRotaCtrl.ObjRota.RotaId     := ReturnJson.Items[xItens].GetValue<Integer>('rotaId');
       ObjRotaCtrl.ObjRota.Descricao  := ReturnJson.Items[xItens].GetValue<String>('descricao');
       ObjRotaCtrl.ObjRota.Latitude   := ReturnJson.Items[xItens].GetValue<String>('latitude');
       ObjRotaCtrl.ObjRota.Longitude  := ReturnJson.Items[xItens].GetValue<String>('longitude');
       ObjRotaCtrl.ObjRota.dtInclusao := Date(); //StrToDate(ReturnJson.Items[0].GetValue<String>('dtInclusao'));
       ObjRotaCtrl.ObjRota.hrInclusao := time(); //ReturnJson.Items[0].GetValue<Integer>('hrInclusao');
       ObjRotaCtrl.ObjRota.NParticipante := ReturnJson.Items[xItens].GetValue<Integer>('nParticipante');
       ObjRotaCtrl.ObjRota.Status        := ReturnJson.Items[xItens].GetValue<Integer>('status');

//       ObjRotaCtrl.
       //ObjRotaCtrl.FObjRota := ObjRotaCtrl.ObjRota.JsonToClass(JsonRota.ToString());
       Result.Add(ObjRotaCtrl);
       Inc(xItens);
     Until (xItens > Pred(ReturnJson.Count));;
     //jsonRota.DisposeOf;
  End
  Else If pShowErro = 1 then Begin
     ObjRotaDAO.Free;
     Raise Exception.Create('Registro de Rota não encontrado');
  End;
  ObjRotaDAO.Free;
end;

function TRotaCtrl.GetRotaParticipante(pRotaId, pPessoaId,
  pShowErro: Integer): TJsonArray;
Var //ReturnJson, ArrayJSonRotaPessoa : TJsonArray;
    //JsonRota, jsonRotaPessoa : TJsonObject;
    //ObjRotaPessoa  : TRotaPessoa;
    ObjRotaDAO : TRotaDAO;
begin
  Try
    Result     := TJsonArray.Create;
    ObjRotaDAO := TRotaDAO.Create;
    ObjRotaDAO.Rota.RotaId := Self.ObjRota.RotaId;
    Result := ObjRotaDAO.GetRotaParticipante(pRotaId, pPessoaId);
    ObjRotaDAO.Free;
  Except On E: Exception do Begin
    If pShowErro = 1 then
       Raise Exception.Create('Ocorreu um erro:'+E.Message);
    ObjRotaDAO.Free;
    End;
  End;
end;

function TRotaCtrl.RotaOnOff(pRotaId: Integer): Boolean;
Var ObjRotaDAO : TRotaDAO;
begin
  ObjRotaDAO := TRotaDAO.Create;
  ObjRotaDAO.Rota.RotaId := Self.ObjRota.RotaId;
  Result := ObjRotaDAO.RotaOnOff;
  if Result then
     Self.ObjRota.RotaId := 0;
  ObjRotaDAO.Free;
end;

function TRotaCtrl.RotaParticipante(pJsonObject: TJsonObject): TJsonArray;
Var ObjRotaDAO : TRotaDAO;
begin
  Result := TJsonArray.Create;
  ObjRotaDAO := TRotaDAO.Create;
  Result.AddElement( ObjRotaDAO.InsUpdParticipante(pJsonObject) );
  ObjRotaDAO.Free;
end;

function TRotaCtrl.Salvar: Boolean;
Var ObjRotaDAO : TRotaDAO;
Begin
  ObjRotaDAO := TRotaDAO.Create;
  ObjRotaDAO.Rota := Self.ObjRota;
  Result := ObjRotaDAO.Salvar;
  if Result then
     Self.ObjRota.RotaId := 0;
  ObjRotaDAO.Free;
end;

End.

