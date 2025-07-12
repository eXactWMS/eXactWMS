{
   ConfiguracaoCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit ConfiguracaoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     ConfiguracaoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TConfiguracaoCtrl = Class
  Private
    //Funções de Validação
    FObjConfiguracao : TConfiguracaoWMS;
    LstConfiguracao : TObjectList<TConfiguracaoWMS>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindConfiguracao : tJsonArray;
    Function GetConfiguracao : TObjectList<TConfiguracaoWMS>;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function doBackup : TJsonObject;
    Function ManutencaoLog : TJsonObject;
    Class Function DelConfiguracao(pIdConfiguracao : Integer) : Boolean;
    Property ObjConfiguracao  : TConfiguracaoWMS Read FObjConfiguracao Write FObjConfiguracao;
  End;

implementation

{ tCtrlConfiguracao }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes, EnderecoCtrl; //, uFrmPesquisa

Function tConfiguracaoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjConfiguracao do Begin
//    if Descricao = '' then raise Exception.Create('Informe o Nome do Fabricante!');

  End;
  Result := True;
End;

constructor TConfiguracaoCtrl.Create;
begin
  ObjConfiguracao := TConfiguracaoWMS.Create;
end;

class function TConfiguracaoCtrl.DelConfiguracao(pIdConfiguracao : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/configuracao/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', pIdConfiguracao.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     ShowMessage('Registro excluído com sucesso');
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TConfiguracaoCtrl.Destroy;
begin
  FreeAndNil(FObjConfiguracao);
  FObjCOnfiguracao.DisposeOf;
  LstConfiguracao := Nil;
  inherited;
end;

function TConfiguracaoCtrl.doBackup: TJsonObject;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/backup';
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject
    Else
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject;
  Except On E: Exception do Begin
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
     End;
  End;
end;

Function tConfiguracaoCtrl.FindConfiguracao : TJsonArray; //(pConfiguracaoId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TConfiguracao>;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/configuracao';
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  Except On E: Exception do Begin
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
     End;
  End;
End;

function TConfiguracaoCtrl.GetConfiguracao : TObjectList<TConfiguracaoWMS>;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonConfiguracao : tJsonObject;
    vBackupBd : String;
    ObjEnderecoCtrl : TEnderecoCtrl;
    JsonArrayEndereco : TJsonArray;
    vErro : String;
begin
  Result := TObjectList<TConfiguracaoWMS>.Create;
  ReturnJson := FindConfiguracao;
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       jSonConfiguracao := tJsonObject.Create;
       jSonConfiguracao := ReturnJson.Items[xItens] as TJSONObject;
       ObjConfiguracao  := ObjConfiguracao.JsonToClass(jSonConfiguracao.ToString());
       vBackupBd := jSonConfiguracao.GetValue<String>('backupbd');
       if vBackupBd = '' then
          ObjConfiguracao.BackupBd := 0
       Else Begin
          vBackupBd := Copy(vBackupBd, 9, 2)+'/'+Copy(vBackupBd, 6, 2)+'/'+Copy(vBackupBd, 1, 4);
          ObjConfiguracao.BackupBd := StrToDate( vBackupBd );
       End;
       Result.Add(ObjConfiguracao);
       jSonConfiguracao           := Nil;
       jSonConfiguracao.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro de Configuração não encontrado');
end;

function TConfiguracaoCtrl.ManutencaoLog: TJsonObject;
begin
  Try
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/manutencaolog';
    DmeXactWMS.RESTRequestWMS.Method := rmDelete;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject;
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.message);
    End;
  End;
end;

Function tConfiguracaoCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonConfiguracao : TJsonObject;
Begin
  Result := True;
  jSonConfiguracao := tJson.ObjectToJsonObject(ObjConfiguracao);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonConfiguracao.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/configuracao';
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonConfiguracao);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     ShowMessage('Registro gravado com sucesso!')
  Else
    raise Exception.Create('Erro: '+(DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject).GetValue<String>('Erro'));
End;

End.

