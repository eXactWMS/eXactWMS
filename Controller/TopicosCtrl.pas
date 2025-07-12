{
   TopicosCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit TopicosCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls, Vcl.Dialogs, Generics.Collections,
     TopicosClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TTopicosCtrl = Class
  Private
    //Funções de Validação
    FObjTopicos      : TTopicos;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function GetTopicos(pTopico : String = ''; pShowErro : Integer = 1) : TObjectList<TTopicos>;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelTopicos : Boolean;
    Property ObjTopicos : TTopicos Read FObjTopicos Write FObjTopicos;
  End;

implementation

{ tCtrlTopicos }

uses TopicosDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tTopicosCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With ObjTopicos do Begin
    if (ObjTopicos.Descricao = '') then
       raise Exception.Create('Informe a descrição do tópico!');
  End;
  Result := True;
End;

constructor TTopicosCtrl.Create;
begin
  FObjTopicos      := TTopicos.Create;
end;

function TTopicosCtrl.DelTopicos : Boolean;
Var ObjTopicosDAO : TTopicosDAO;
begin
  ObjTopicosDAO := TTopicosDAO.Create;
  ObjTopicosDAO.ObjTopicos.TopicoId := Self.ObjTopicos.TopicoId;
  Result := ObjTopicosDAO.Delete;
  if Result then
     Self.ObjTopicos.TopicoId := 0;
  ObjTopicosDAO := Nil;
  ObjTopicosDAO.DisposeOf;
end;

destructor TTopicosCtrl.Destroy;
begin
  FreeAndNil(FObjTopicos);
  inherited;
end;

Function tTopicosCtrl.GetTopicos(pTopico : String = ''; pShowErro : Integer = 1) : TObjectList<TTopicos>;
Var ObjTopicosDAO : TTopicosDAO;
    ReturnJson     : TJsonArray;
    jsonTopicos   : tjsonObject;
    xItensTopicos : Integer;
    TmpTopico     : TTopicos;
begin
  ObjTopicosDAO := TTopicosDAO.Create;
  ReturnJson    := ObjTopicosDAO.GetTopicos(pTopico, pShowErro);
  Result        := TObjectList<TTopicos>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensTopicos := 0;
     repeat
//       jsonTopicos := tJsonObject.Create;
//       jsonTopicos := ReturnJson.Items[xItensTopicos] as TJSONObject;
//       ObjTopicos  := ObjTopicos.JsonToClass(ReturnJson.Get(xItensTopicos).ToString());
        TmpTopico := TTopicos.Create;
        TmpTopico.Topicoid  := ReturnJson.Get(xItensTopicos).GetValue<Integer>('topicoid');
        TmpTopico.Descricao := ReturnJson.Get(xItensTopicos).GetValue<String>('descricao');
        TmpTopico.Status    := ReturnJson.Get(xItensTopicos).GetValue<Integer>('status');
        TmpTopico.Data      := StrToDate(ReturnJson.Get(xItensTopicos).GetValue<String>('data'));
        TmpTopico.Hora      := StrToTime(ReturnJson.Get(xItensTopicos).GetValue<String>('hora'));

       Result.Add(TmpTopico);
//       jSonTopicos := Nil;
//       jSonTopicos.DisposeOf;
       xItensTopicos := xItensTopicos + 1;
     until (xItensTopicos > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Tópico não encontrado para o software!');
//  jsonTopicos := Nil;
//  jsonTopicos.DisposeOf;
  TmpTopico     := Nil;
  ObjTopicosDAO := Nil;
  ObjTopicosDAO.DisposeOf;
End;

Function tTopicosCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjTopicosDAO : TTopicosDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjTopicosDAO := TTopicosDAO.Create;
  ObjTopicosDAO.ObjTopicos := ObjTopicos;
  Result := ObjTopicosDAO.Salvar;
  ObjTopicosDAO := Nil;
  ObjTopicosDAO.DisposeOf;
End;

End.
