{
   Laboratorios.Pas
   Criado por Genilson S Soares (RhemaSys) em 09/09/2020
   Projeto: RhemaWMS
}
unit LaboratoriosClass;

interface

Uses System.Classes, Vcl.Dialogs, Generics.Collections, System.SysUtils, Rest.Json;//, UDmRhemaWMS;

type
  Tcrud = (Ins, Upd);

 TLaboratorios = class
   private
     //FCrud            : TCrud;
     FId              : Integer;
     FDescricao       : String;
     Ffone            : String;
     Femail           : String;
     Fhomepage        : String;
     Fstatus          : Integer;
     Function  NextCodigo : Integer;  //Gerador de Código Automático
   Protected
   Public
     CRUD : TCrud;
     constructor Create;
     Function Salvar(const ObjLaboratorios: TLaboratorios) : Boolean;
     Class Function ExportaExcel : Boolean;
     Class Function ClassToJson(Const ObjLaboratorios : TLaboratorios) : String;
     Class Function JsonToClass(jSon : String) : TLaboratorios;
     Class Procedure ConfigSizeField(Tabela : String; Sender : TObject);
     //property CRUD             : TCRUD    Read FCrud            Write FCRUD;
     property Id               : Integer  Read FId              Write FId;
     property Descricao        : String   Read FDescricao       Write FDescricao;
     property fone             : String   Read Ffone            Write Ffone;
     property email            : String   Read Femail           Write Femail;
     property homepage         : String   Read Fhomepage        Write Fhomepage;
     property status           : Integer  Read Fstatus          Write Fstatus;
   End;

implementation

{ TLaboratorios }

Uses uFuncoes; //, uTHistorico;

class function TLaboratorios.ClassToJson(Const ObjLaboratorios : TLaboratorios) : String;
begin
  Result := tJson.ObjectToJsonString(ObjLaboratorios);
end;

Class procedure TLaboratorios.ConfigSizeField(Tabela: String; Sender: TObject);
begin
  //DmRhemaWMS.ConfigSizeField(Tabela, Sender);
end;

constructor TLaboratorios.Create;
Begin
  FId               := 0;
  FDescricao        := '';
  Ffone             := '';
  Femail            := '';
  Fhomepage         := '';
  Fstatus           := 0;
End;

Class function TLaboratorios.ExportaExcel : Boolean;
begin
  Result := True;
  Try
    //ExportarExcel(DmRhemaWMS.QryLaboratorios);
  Except
    result := False;
    raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
  End;
end;

class function TLaboratorios.JsonToClass(jSon: String): TLaboratorios;
begin
  Result := tLaboratorios.Create;
  Result := tJson.JsonToObject<tLaboratorios>(jSon)
end;

function TLaboratorios.NextCodigo: Integer;
Begin
  //Result := DmRhemaWMS.CodGeral('Laboratorios', 'Id', '');
End;

function TLaboratorios.Salvar(const ObjLaboratorios: TLaboratorios): Boolean;
Begin
  Result := False;
{
   With DmRhemaWMS.QryLaboratorios do Begin
     If Crud = Ins Then Begin
       Append;
       Id := NextCodigo;
       FieldbyName('Id').AsInteger := Id;
     End
     Else Begin
       Locate('Id', Id, []);
       Edit;
     End;
       FieldbyName('Descricao').AsString            := Descricao;
       FieldbyName('fone').AsString                 := fone;
       FieldbyName('email').AsString                := email;
       FieldbyName('homepage').AsString             := homepage;
       FieldbyName('status').AsInteger              := status;
 //      FieldbyName('IdUsuarioIncl').AsString      := FrmRhemaWMS.IdUsuarioLogado;
 //      FieldbyName('DataInclusao').AsDateTime     := Now;
     Try
       Post;
       Result := True;
     Except
       on EConvertError do
          Raise Exception.Create('Tipo de valor Numérico inválido...');
       on E : Exception do
         Raise Exception.Create('ATENÇÃO: Erro na INCLUSÃO do registro: '+#13+#13+'ERRO: ['+E.Message+']');
     End;
   End;
   with DmRhemaWMS.QryPesquisa do Begin
     Close;
     Sql.Clear;
     Sql.Add('Delete From CodTemp Where Tabela = '+QuotedStr('Laboratorios')+' and Codigo = '+IntToStr(Id));
     try ExecSql Except end;
   End;
}

End;

End.


