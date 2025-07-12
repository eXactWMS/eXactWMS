{
   CepsCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
Unit MService.CepCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils,  Generics.Collections,
     uCepAbertoClass,
     Horse,
     System.Types,
     System.JSON,
     System.JSON.Types;//, uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);
  TCepCtrl = Class
  Private
    //Funções de Validação
    FCep : TCepAberto;
  Public
    //Rotinas Pública (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjCep : TCepAberto Read FCep Write FCep;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlCep }

uses MService.CepDAO, uFuncoes;

//uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse
    .Group
    .Prefix('v1')
    .Get('/cep/:cep', Get)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var CepDAO : TCepDao;
begin
  CepDAO := TCepDAO.Create;
  Res.Send<TJSonObject>(CepDAO.Get( Req.Params.Items['cep'] ));
  CepDAO.Destroy;
end;


constructor TCepCtrl.Create;
begin
  FCep := TCepAberto.Create;
end;

destructor TCepCtrl.Destroy;
begin
  FCep.Free;
  inherited;
end;

End.

