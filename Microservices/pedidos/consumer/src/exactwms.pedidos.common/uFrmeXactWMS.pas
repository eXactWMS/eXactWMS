unit uFrmeXactWMS;

interface

uses
  sysutils, usuarioclass;

type
  TUsuarioCtrl = Class(TObject)
  Private

    FObjUsuario: TUsuario;
  Public
    Property ObjUsuario: TUsuario Read FObjUsuario Write FObjUsuario;
  End;

  TFrmeXactWMS = class
  public
    ObjUsuarioCtrl: TUsuarioCtrl;
   constructor create()  ;

  end;
  var
  FrmeXactWMS:TFrmeXactWMS;

implementation

{ TFrmeXactWMS }

constructor TFrmeXactWMS.create;
begin
   ObjUsuarioCtrl:= TUsuarioCtrl.create;
   ObjUsuarioCtrl.ObjUsuario:= TUsuario.create;
   ObjUsuarioCtrl.ObjUsuario.UsuarioId:=1;
   ObjUsuarioCtrl.ObjUsuario.Nome:='microserviço'
end;

end.
