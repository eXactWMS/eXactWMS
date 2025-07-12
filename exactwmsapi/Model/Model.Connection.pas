unit Model.Connection;

interface

uses
  System.JSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  FireDAC.Comp.Client,
  Firedac.DApt,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.MSSQL,
  System.Generics.Collections;

var
  FDriver : TFDPhysFBDriverLink;
  FConnList : TObjectList<TFDConnection>;

function Connected : Integer;
procedure Disconnected(Index : Integer);

implementation

function Connected : Integer;
Var Conn : TFdConnection;
begin
  Conn := TFdConnection.Create(nil);
  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;
  FConnList.Add(TFDConnection.Create(nil));
  Result := Pred(FConnList.Count);
  With FConnList.Items[Result] do Begin
    Params.Values['DriverId']       := 'MsSql';
    Params.Values['Server']         := 'LocalHost';
    Params.Values['DataBase']       := 'RhemaWMS';
    Params.Values['User_Name']      := 'sa';
    Params.Values['PassWord']       := 'Ctpd$#*%0';
    Connected := True;
  End;
{
   FConnList.Items[Result].Params.DriverID := 'MSSQL';
   FConnList.Items[Result].Params.Database := 'Teste';
   FConnList.Items[Result].Params.UserName := 'sa';
   FConnList.Items[Result].Params.Password := 'xxxxxxx';
   FConnList.Items[Result].Connected;
}
end;

procedure Disconnected(Index : Integer);
begin
  FConnList.Items[Index].Connected := False;
  FConnList.Items[Index].Free;
  FConnList.TrimExcess;
end;

end.
