{
  Laboratorio.Pas
  Criado por Genilson S Soares (RhemaSys) em 09/09/2020
  Projeto: RhemaWMS
}
unit LaboratoriosClass;

interface

Uses System.Classes, Generics.Collections, System.SysUtils, Rest.Json,
  System.Json, Rest.Types;

type
  Tcrud = (Ins, Upd);

  TLaboratorio = class
  private
    // FCrud            : TCrud;
    FIdLaboratorio: Integer;
    FNome: String;
    Ffone: String;
    Femail: String;
    Fhomepage: String;
    Fstatus: Integer;
    Function NextCodigo: Integer; // Gerador de Código Automático
  Protected
  Public
    CRUD: Tcrud;
    constructor Create;
    Function Salvar: Boolean; // (const ObjLaboratorio: TLaboratorio)
    Class Function ExportaExcel: Boolean;
    Function ClassToJson(Const ObjLaboratorio: TLaboratorio): String;
    Function JsonToClass(Json: String): TLaboratorio;
    Procedure ConfigSizeField(Tabela: String; Sender: TObject);
    Function GetLaboratorio(pIdLaboratorio: Integer = 0; pNome: String = '';
      pShowErro: Integer = 1): tJsonArray;
    Function DeleteLaboratorio: Boolean;
    Function MontarPaginacao: TJsonObject;
    Function ImportDados(pJsonArray: tJsonArray): Boolean;
    Procedure Limpar;
    // property CRUD             : TCRUD    Read FCrud            Write FCRUD;
    property IdLaboratorio: Integer Read FIdLaboratorio Write FIdLaboratorio;
    property NOme: String Read FNome Write FNome;
    property fone: String Read Ffone Write Ffone;
    property email: String Read Femail Write Femail;
    property homepage: String Read Fhomepage Write Fhomepage;
    property status: Integer Read Fstatus Write Fstatus;
  End;

implementation

{ TLaboratorio }

Uses uFuncoes, uLaboratorioDAO;

function TLaboratorio.ClassToJson(Const ObjLaboratorio: TLaboratorio): String;
begin
  Result := tJson.ObjectToJsonString(ObjLaboratorio);
end;

procedure TLaboratorio.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  // DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TLaboratorio.Create;
Begin
  Limpar;
End;

function TLaboratorio.DeleteLaboratorio: Boolean;
Var
  ObjLaboratorioDAO: TLaboratorioDAO;
begin
  // Result := False; //TLaboratorioCtrl.DelLaboratorio(pIdLaboratorio);
  ObjLaboratorioDAO := TLaboratorioDAO.Create;
  ObjLaboratorioDAO.Laboratorio.IdLaboratorio := Self.FIdLaboratorio;
  Result := ObjLaboratorioDAO.Delete;
  FreeAndNil(ObjLaboratorioDAO);
end;

Class function TLaboratorio.ExportaExcel: Boolean;
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

Function TLaboratorio.GetLaboratorio(pIdLaboratorio: Integer = 0;
  pNome: String = ''; pShowErro: Integer = 1): tJsonArray;
Var
  ObjLaboratorioDAO: TLaboratorioDAO;
begin
  ObjLaboratorioDAO := TLaboratorioDAO.Create;
  Result := ObjLaboratorioDAO.GetLaboratorio(pIdLaboratorio, pNome, pShowErro);
  FreeAndNil(ObjLaboratorioDAO);
end;

function TLaboratorio.ImportDados(pJsonArray: tJsonArray): Boolean;
Var
  ObjLaboratorioDAO: TLaboratorioDAO;
begin
{$IFDEF MSWINDOWS}
  Result := False;
  Try
    ObjLaboratorioDAO := TLaboratorioDAO.Create;
    Try
      ObjLaboratorioDAO.ImportDados(pJsonArray);
      Result := True;
    Except On E: Exception do
      Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(ObjLaboratorioDAO);
  End;
{$ENDIF}
end;

function TLaboratorio.JsonToClass(Json: String): TLaboratorio;
begin
  Result := TLaboratorio.Create;
  Result := tJson.JsonToObject<TLaboratorio>(Json, [joDateFormatUnix]);
end;

procedure TLaboratorio.Limpar;
begin
  FIdLaboratorio := 0;
  FNome := '';
  Ffone := '';
  Femail := '';
  Fhomepage := '';
  Fstatus := 0;
end;

function TLaboratorio.MontarPaginacao: TJsonObject;
Var
  ObjLaboratorioDAO: TLaboratorioDAO;
begin
  ObjLaboratorioDAO := TLaboratorioDAO.Create;
  ObjLaboratorioDAO.Laboratorio := Self;
  Result := ObjLaboratorioDAO.MontarPaginacao;
  FreeAndNil(ObjLaboratorioDAO);
end;

function TLaboratorio.NextCodigo: Integer;
Begin
  // Result := DmRhemaWMS.CodGeral('Laboratorio', 'Id', '');
End;

function TLaboratorio.Salvar: Boolean; // (const ObjLaboratorio: TLaboratorio):
Var
  ObjLaboratorioDAO: TLaboratorioDAO;
begin
  ObjLaboratorioDAO := TLaboratorioDAO.Create;
  ObjLaboratorioDAO.Laboratorio := Self;
  Result := ObjLaboratorioDAO.Salvar;
  FreeAndNil(ObjLaboratorioDAO);
End;

End.
