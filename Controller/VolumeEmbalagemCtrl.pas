{
   VolumeEmbalagemCtrl.Pas
   Criado por Genilson S Soares em 28/05/2021
   Projeto: eXactWMS
}
unit VolumeEmbalagemCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
     Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , VolumeEmbalagemClass;

Type
  TVolumeEmbalagemCtrl = Class
  Private
    FObjVolumeEmbalagem : TVolumeEmbalagem;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function GetVolumeEmbalagem(pVolumeEmbalagemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TObjectList<TVolumeEmbalagemCtrl>;
    Function GetVolumeEmbalagemMultipla(pVolumeEmbalagemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TJsonArray;
    Function GetVolumeEmbalagemJson(pVolumeEmbalagemId : Integer = 0; pDescricao : String = ''; pShowErro : Integer = 1) : TJsonArray;
    Function Salvar  : Boolean;  //(pHistorico: THistorico)
    Function DelVolumeEmbalagem : Boolean;

    Property ObjVolumeEmbalagem : TVolumeEmbalagem Read FObjVolumeEmbalagem Write FObjVolumeEmbalagem;
  End;

implementation

{ tCtrlVolumeEmbalagem }

uses uDmeXactWMS, uFuncoes, uVolumeEmbalagemDAO;

Function tVolumeEmbalagemCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjVolumeEmbalagem do Begin
    If Descricao = ''  Then
       raise Exception.Create('Informe a Descrição da Embalagem.');
    if (Tipo='') or (Not (Self.FObjVolumeEmbalagem.Tipo[1] in ['R', 'P', 'C', 'U'])) then
       raise Exception.Create('Informe o Tipo da Embalagem.');
    if Self.FObjVolumeEmbalagem.Altura*Self.FObjVolumeEmbalagem.Largura*Self.FObjVolumeEmbalagem.Comprimento <= 0 then
       raise Exception.Create('Especifições de volumetria(Altura x Largura x Comprimento) inválido.');
    if Self.FObjVolumeEmbalagem.Altura*Self.FObjVolumeEmbalagem.Largura*Self.FObjVolumeEmbalagem.Comprimento <= 0 then
       raise Exception.Create('Capacidade inválida.');
    if Self.FObjVolumeEmbalagem.Aproveitamento <= 0 then
       raise Exception.Create('Informe o percentual de aproveitamento(máximo) da Embalagem.');
  End;
  Result := True;
End;

constructor TVolumeEmbalagemCtrl.Create;
begin
  FObjVolumeEmbalagem := TVolumeEmbalagem.Create;
end;

function TVolumeEmbalagemCtrl.DelVolumeEmbalagem : Boolean;
Var ObjVolumeEmbalagemDAO : TVolumeEmbalagemDAO;
begin
  ObjVolumeEmbalagemDAO := TVolumeEmbalagemDAO.Create;
  ObjVolumeEmbalagemDAO.VolumeEmbalagem.EmbalagemId := Self.ObjVolumeEmbalagem.EmbalagemId;
  Result := ObjVolumeEmbalagemDAO.Delete;
  if Result then
     Self.ObjVolumeEmbalagem.EmbalagemId := 0;
  ObjVolumeEmbalagemDAO := Nil;
  ObjVolumeEmbalagemDAO.DisposeOf;
end;

destructor TVolumeEmbalagemCtrl.Destroy;
begin
  FreeAndNil(FObjVolumeEmbalagem);
  inherited;
end;

function TVolumeEmbalagemCtrl.GetVolumeEmbalagem(pVolumeEmbalagemId: Integer; pDescricao: String;
  pShowErro : Integer): TObjectList<TVolumeEmbalagemCtrl>;
Var ReturnJson : TJsonArray;
    JsonVolumeEmbalagem : TJsonObject;
    xItens         : Integer;
    ObjVolumeEmbalagemCtrl    : TVolumeEmbalagemCtrl;
    Var ObjVolumeEmbalagemDAO : TVolumeEmbalagemDAO;
begin
  Result     := TObjectList<TVolumeEmbalagemCtrl>.Create;
  ObjVolumeEmbalagemDAO := TVolumeEmbalagemDAO.Create;
  ObjVolumeEmbalagemDAO.VolumeEmbalagem.EmbalagemId := Self.ObjVolumeEmbalagem.EmbalagemId;
  ReturnJson := ObjVolumeEmbalagemDAO.GetVolumeEmbalagem(pVolumeEmbalagemId, pDescricao, pShowErro);
  ObjVolumeEmbalagemDAO := Nil;
  ObjVolumeEmbalagemDAO.DisposeOf;
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     repeat
       ObjVolumeEmbalagemCtrl := TVolumeEmbalagemCtrl.Create;
       jsonVolumeEmbalagem    := tJsonObject.create;
//       jSonVolumeEmbalagem    := ReturnJson.Items[xItens] as TJSONObject;
       //With ObjVolumeEmbalagemCtrl.FObjVolumeEmbalagem Do Begin
       With ObjVolumeEmbalagemCtrl.FObjVolumeEmbalagem do Begin
         EmbalagemId    := ReturnJson.Items[xItens].GetValue<Integer>('embalagemid');
         Descricao      := ReturnJson.Items[xItens].GetValue<String>('descricao');
         Identificacao  := ReturnJson.Items[xItens].GetValue<String>('identificacao');
         Tipo           := ReturnJson.Items[xItens].GetValue<String>('tipo');
//         TipoEmbalagem  := '';
         Altura         := ReturnJson.Items[xItens].GetValue<double>('altura');
         Largura        := ReturnJson.Items[xItens].GetValue<double>('largura');
         Comprimento    := ReturnJson.Items[xItens].GetValue<double>('comprimento');
//         Volume         := ReturnJson.Items[xItens].GetValue<Integer>('
         Aproveitamento := ReturnJson.Items[xItens].GetValue<Integer>('aproveitamento');
         Tara           := ReturnJson.Items[xItens].GetValue<double>('tara');
         Capacidade     := ReturnJson.Items[xItens].GetValue<double>('capacidade');
         QtdLacres      := ReturnJson.Items[xItens].GetValue<Integer>('qtdlacres');
         CodBarras      := ReturnJson.Items[xItens].GetValue<Integer>('codbarras');
         Disponivel     := ReturnJson.Items[xItens].GetValue<Integer>('disponivel');
         PrecoCusto     := ReturnJson.Items[xItens].GetValue<double>('precocusto');
//         DtInclusao     := ReturnJson.Items[xItens].GetValue<Integer>('dtinclusao');
//         HrInclusao     := ReturnJson.Items[xItens].GetValue<Integer>('hrinclusao');
         Status         := ReturnJson.Items[xItens].GetValue<Integer>('status');
       End;
//       ObjVolumeEmbalagemCtrl.FObjVolumeEmbalagem := Self.ObjVolumeEmbalagem.JsonToClass(JsonVolumeEmbalagem.ToString());
//       Self.ObjVolumeEmbalagem.Tipo := Self.ObjVolumeEmbalagem.Tipo;
       Result.Add(ObjVolumeEmbalagemCtrl);
       jsonVolumeEmbalagem := Nil;
       ObjVolumeEmbalagemCtrl  := Nil;
      xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End
  Else If pShowErro = 1 then
     Raise Exception.Create('Registro de Embalagem não encontrado');
end;

function TVolumeEmbalagemCtrl.GetVolumeEmbalagemJson(
  pVolumeEmbalagemId: Integer; pDescricao: String;
  pShowErro: Integer): TJsonArray;
Var ObjVolumeEmbalagemDAO : TVolumeEmbalagemDAO;
    vErro : String;
begin
  ObjVolumeEmbalagemDAO := TVolumeEmbalagemDAO.Create;
  ObjVolumeEmbalagemDAO.VolumeEmbalagem.EmbalagemId := Self.ObjVolumeEmbalagem.EmbalagemId;
  Result := ObjVolumeEmbalagemDAO.GetVolumeEmbalagem(pVolumeEmbalagemId, pDescricao, pShowErro);
  FreeAndNil(ObjVolumeEmbalagemDAO);
  If (Result.Items[0].TryGetValue('Erro', vErro)) and (pShowErro = 1) then
     Raise Exception.Create('Registro de Tipo de Embalagem não encontrado');
end;

function TVolumeEmbalagemCtrl.GetVolumeEmbalagemMultipla(pVolumeEmbalagemId: Integer; pDescricao: String;
  pShowErro: Integer): TJsonArray;
Var ObjVolumeEmbalagemDAO : TVolumeEmbalagemDAO;
    vErro : String;
begin
  ObjVolumeEmbalagemDAO := TVolumeEmbalagemDAO.Create;
  Result := ObjVolumeEmbalagemDAO.GetVolumeEmbalagemMultipla(pVolumeEmbalagemId, pDescricao, pShowErro);
  FreeAndNil(ObjVolumeEmbalagemDAO);
  If (Result.Items[0].TryGetValue('Erro', vErro)) and (pShowErro = 1) then
     Raise Exception.Create('Registro de Tipo de Embalagem não encontrado');
end;

function TVolumeEmbalagemCtrl.Salvar: Boolean;
Var ObjVolumeEmbalagemDAO : TVolumeEmbalagemDAO;
Begin
  if Not VerificaDados then
     Exit;
  Try
    ObjVolumeEmbalagemDAO := TVolumeEmbalagemDAO.Create;
    ObjVolumeEmbalagemDAO.VolumeEmbalagem := Self.ObjVolumeEmbalagem;
    Result := ObjVolumeEmbalagemDAO.Salvar;
    if Result then
       Self.ObjVolumeEmbalagem.EmbalagemId := 0;
  Finally
    FreeAndNil(ObjVolumeEmbalagemDAO);
  End;
end;

End.
