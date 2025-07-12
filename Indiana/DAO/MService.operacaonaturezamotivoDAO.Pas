{
  Micro Servico - DAO - operacaonaturezamotivoDAO
  Criado por Genilson S Soares (RhemaSys Soluções) em 30/03/2022
  Projeto: eXactWMSIndiana
}

unit MService.operacaonaturezamotivoDAO;

interface

uses
  FireDAC.Comp.Client, operacaonaturezamotivoClass, System.SysUtils, 
  Math, DataSet.Serialize,
  System.JSON, REST.JSON, System.Generics.Collections,
  exactwmsservice.lib.connection,exactwmsservice.dao.base;

type
  ToperacaonaturezamotivoDao = class(TBasicDao)
  private

    

    Foperacaonaturezamotivo: Toperacaonaturezamotivo;
  Public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function InsertUpdate(pJsonObject: TJsonObject): TJsonObject;
    Function Get(pmotivoid: Integer; pdescricao: String): TjSonArray;
    // Function Get4D(const AParams: TDictionary<string, string>): TJsonObject;
    Function Cancelar(pJsonObject: TJsonObject): Boolean;
    Function Delete(pmotivoid: Integer): Boolean;
    Property Objoperacaonaturezamotivo: Toperacaonaturezamotivo
      Read Foperacaonaturezamotivo Write Foperacaonaturezamotivo;
  end;

implementation

uses uSistemaControl, Constants;

{ ToperacaonaturezamotivoDAO }

constructor ToperacaonaturezamotivoDao.Create;
begin
  inherited;
  Objoperacaonaturezamotivo := Toperacaonaturezamotivo.Create();
end;

Destructor ToperacaonaturezamotivoDao.Destroy;
Begin

  FreeAndNil( Objoperacaonaturezamotivo);
  inherited;
end;

Function ToperacaonaturezamotivoDao.Cancelar(pJsonObject: TJsonObject): Boolean;
Var
  vSql: String;
Begin
  Result := False;
  Try
    // //Esta linha no Finnaly ou Except
    vSql := 'Update operacaonaturezamotivo Set Status = 0 ' + sLineBreak +
            'Where motivoid = ' + pJsonObject.GetValue<Integer>('motivoid').ToString(); //+sLineBreak +
//            'Insert Into DocumentoEtapas Values (' + sLineBreak +
//            '       (Select Uuid From operacaonaturezamotivo Where motivoid = ' + sLineBreak;
//    vSql := vSql + pJsonObject.GetValue<Integer>('motivoid').ToString()+', 15, ' + sLineBreak+
//            pJsonObject.GetValue<Integer>('motivoid').ToString() + ', '+sLineBreak+
//            TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + sLineBreak+
//            ', GetDate(), ' + pJsonObject.GetValue<String>('terminal') + ', 1)';
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Inventarios - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  End;
End;

function ToperacaonaturezamotivoDao.Delete(pmotivoid: Integer): Boolean;
Var
  vSql: String;
Begin
  Result := False;
  Try
    vSql := 'Delete operacaonaturezamotivo where motivoid = ' +
      pmotivoid.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

Function ToperacaonaturezamotivoDao.Get(pmotivoid: Integer; pdescricao: String)
  : TjSonArray;
Var
  vSql: String;
Begin
  Try
    vSql := '' + sLineBreak;
    vSql := vSql + 'Declare @motivoid Integer = ' + pmotivoid.ToString();
    vSql := vSql + 'Declare @descricao VarChar(60) = ' +
      QuotedStr('%' + pdescricao + '%');
    vSql := vSql + 'Select * from operacaonaturezamotivo Where ' + sLineBreak;
    vSql := vSql + '   (@motivoid = 0 or motivoid = @motivoid)' + sLineBreak;
    vSql := vSql + '      or  (@descricao = ' + #39 + #39 +
      ' or descricao Like @descricao)' + sLineBreak;
    FConexao.Query.Open(vSql);
    If FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      Result := FConexao.Query.ToJsonArray;
  Except On E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

Function ToperacaonaturezamotivoDao.InsertUpdate(pJsonObject: TJsonObject)
  : TJsonObject;
Var
  vSql: String;
Begin
  Try
    if pJsonObject.GetValue<Integer>('motivoid') = 0 then
    Begin
      vSql := vSql +
        'Insert Into operacaonaturezamotivo(motivoid, descricao, operacaonaturezaid, status) OutPut Inserted.motivoid Values ('
        + pJsonObject.GetValue<Integer>('motivoid').ToString() + ', ' +
        QuotedStr(pJsonObject.GetValue<String>('descricao') + ', ' +
        pJsonObject.GetValue<Integer>('operacaonaturezaid').ToString() + ', ' +
        pJsonObject.GetValue<Integer>('status').ToString())
    End
    Else
    Begin
      vSql := vSql + 'Update operacaonaturezamotivo Set ' + sLineBreak +
        '   motivoid = ' + pJsonObject.GetValue<Integer>('motivoid').ToString()
        + sLineBreak + '   , descricao = ' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) + sLineBreak +
        '   , operacaonaturezaid = ' + pJsonObject.GetValue<Integer>
        ('operacaonaturezaid').ToString() + sLineBreak + '   , status = ' +
        pJsonObject.GetValue<Integer>('status').ToString() + sLineBreak +
        'OutPut Inserted.motivoid' + sLineBreak + 'Where motivoid = ' +
        pJsonObject.GetValue<Integer>('motivoid').ToString();
    End;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONObject();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Inventarios - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

end.
