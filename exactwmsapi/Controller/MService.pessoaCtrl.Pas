{
  Micro Servico - Controller - pessoaCtrl.Pas
  Criado por Genilson S Soares (RhemaSys) em 16/09/2020
  Projeto: RhemaWMS
}

unit MService.pessoaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  pessoaClass,
  Horse, Horse.utils.ClientIP,
  System.JSON;

Type

  TpessoaCtrl = Class
  Private
    Fpessoa: Tpessoa;
  Public
    constructor Create;
    destructor Destroy; override;
    Property Objpessoa: Tpessoa Read Fpessoa Write Fpessoa;
  End;

procedure Registry;
procedure GetPessoa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPessoaID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure PessoaInsert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PessoaEstrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPessoa4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCodigoERP(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

procedure GetForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetIDForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCodigoERPForn(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetDescricaoForn(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure UpdateForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure DeleteForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetAddressVolume(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);

implementation

{ tCtrlpessoa }

uses MService.pessoaDAO, uFuncoes, exactwmsservice.lib.utils;

procedure Registry;
begin
  THorse.Get('/v1/pessoa', GetPessoa);
  THorse.Get('/v1/pessoas4D', GetPessoa4D);
  THorse.Get('/v1/pessoa/:pessoaid', GetPessoaID);
  THorse.Post('/v1/pessoa', PessoaInsert);
  THorse.Put('/v1/pessoa', PessoaInsert);
  THorse.Get('/v1/pessoa/estrutura', PessoaEstrutura);
  THorse.Delete('/v1/pessoa/:id/:pessoatipoid', Delete);
  THorse.Post('/v1/pessoa/import', Import);

  THorse.Get('/v1/cliente', Get);
  THorse.Get('/v1/cliente/:id', GetID);
  THorse.Get('/v1/cliente/codigoerp/:codigoerp', GetCodigoERP);
  THorse.Get('/v1/cliente/:id/:descricao', GetDescricao);
  THorse.Put('/v1/cliente/:id', Update);
  THorse.Delete('/v1/cliente/:id', Delete);
  THorse.Get('v1/pessoa/getaddresstovolume', GetAddressVolume);

  THorse.Get('/v1/fornecedor', GetForn);
  THorse.Get('/v1/fornecedor/:id', GetIDForn);
  THorse.Get('/v1/fornecedor/codigoerp/:codigoerp', GetCodigoERPForn);
  THorse.Get('/v1/fornecedor/:id/:descricao', GetDescricaoForn);
  THorse.Put('/v1/fornecedor/:id', UpdateForn);
  THorse.Delete('/v1/fornecedor/:id', DeleteForn);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetID(0, 1)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure GetCodigoERP(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>
        (pessoaDAO.GetCodigoERP(StrToIntDef(Req.Params.Items['codigoerp'], 0), 1))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure GetCodigoERPForn(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TjsonArray;
begin
  Try
    try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>
        (pessoaDAO.GetCodigoERP(StrToIntDef(Req.Params.Items['codigoerp'], 0), 2))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetDescricao(Req.Params.Items['descricao'],
        1)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetID(StrToIntDef(Req.Params.Items['id'], 0),
        1)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  Objpessoa: TJSONObject;
  pessoaDAO: TpessoaDao;
begin
  Try
    Try
      Objpessoa := TJSONObject.Create;
      Objpessoa := Req.Body<TJSONObject>;
      pessoaDAO := TpessoaDao.Create;
      pessoaDAO.InsertUpdate(Objpessoa.GetValue<Integer>('pessoaId'),
        Objpessoa.GetValue<Integer>('codpessoaerp'),
        Objpessoa.GetValue<String>('razao'),
        Objpessoa.GetValue<String>('fantasia'), 1,
        // GetValueInjSon(Objpessoa, 'PessoaTipoID').ToInteger,
        Objpessoa.GetValue<String>('cnpjcpf'), Objpessoa.GetValue<String>('fone'),
        Objpessoa.GetValue<String>('email'),
        Objpessoa.GetValue<String>('homepage'),
        Objpessoa.GetValue<Integer>('shelflife'),
        Objpessoa.GetValue<Integer>('status'),
        Objpessoa.GetValue<Integer>('rotaId'),
        Objpessoa.GetValue<Integer>('transportadoraid'));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      On E: Exception do
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
    End;
  Finally
    FreeAndNil(Objpessoa);
    FreeAndNil(pessoaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  pessoaDAO: TpessoaDao;
begin
  Try
    Try
      pessoaDAO := TpessoaDao.Create;
      If pessoaDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0),
        StrToIntDef(Req.Params.Items['pessoatipoid'], 0)) Then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro Excluído com Sucesso!'))).Status(THttpStatus.NoContent)
      Else
         raise Exception.Create('Não foi possível Excluir o registro"');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

constructor TpessoaCtrl.Create;
begin
  Fpessoa := Tpessoa.Create;
end;

destructor TpessoaCtrl.Destroy;
begin
  FreeAndNil(FPessoa);
  inherited;
end;

// Rotina para Fornecedor
procedure GetForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetID(0, 2));
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure GetDescricaoForn(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetDescricao(Req.Params.Items['descricao'],
        2)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
End;

procedure GetIDForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
begin
  Try
    try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetID(StrToIntDef(Req.Params.Items['id'], 0),
        2)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure UpdateForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  Objpessoa: TJSONObject;
  pessoaDAO: TpessoaDao;
begin
  Try
    Try
      Objpessoa := Req.Body<TJSONObject>;
      pessoaDAO := TpessoaDao.Create;
      pessoaDAO.InsertUpdate(GetValueInjSon(Objpessoa, 'pessoaId').ToInteger,
        GetValueInjSon(Objpessoa, 'codpessoaerp').ToInteger,
        GetValueInjSon(Objpessoa, 'razao'), GetValueInjSon(Objpessoa, 'fantasia'),
        2, // GetValueInjSon(Objpessoa, 'PessoaTipoID').ToInteger,
        GetValueInjSon(Objpessoa, 'cnpjcpf'), GetValueInjSon(Objpessoa, 'fone'),
        GetValueInjSon(Objpessoa, 'email'), GetValueInjSon(Objpessoa, 'homepage'),
        GetValueInjSon(Objpessoa, 'shelflife').ToInteger,
        Objpessoa.GetValue<Integer>('status'),
        Objpessoa.GetValue<Integer>('rotaid'),
        Objpessoa.GetValue<Integer>('transportadoraid'));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjPessoa);
    FreeAndNil(pessoaDAO);
  End;
end;

procedure DeleteForn(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  pessoaDAO: TpessoaDao;
begin
  Try
    Try
      pessoaDAO := TpessoaDao.Create;
      If pessoaDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0), 2) then
         Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
           'Registro Excluído com Sucesso!'))).Status(THttpStatus.NoContent)
      Else
         raise Exception.Create('Não foi possível Excluir o Registro');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.Import(Req.Body<TJSonArray>))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
End;

Procedure GetAddressVolume(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  pessoaDAO: TpessoaDao;
  pPessoaTipoId: Integer;
  ErroJsonArray : TJsonArray;
begin
  Try
    Try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetAddressVolume
        (StrToIntDef(Req.Query.Dictionary.Items['codpessoa'], 0)))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
End;

procedure GetPessoa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  AQueryParam: TDictionary<String, String>;
  pPessoaTipoId: Integer;
  ErroJsonArray : TjsonArray;
begin
  Try
    Try
      pPessoaTipoId := 0;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count > 0 then
      Begin
        if AQueryParam.ContainsKey('pessoatipoid') then
          pPessoaTipoId := StrToIntDef(AQueryParam.Items['pessoatipoid'], 0);
      End;
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetPessoaID(0, pPessoaTipoId, 0, '', '')).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure GetPessoa4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var pessoaDAO: TpessoaDao;
    AQueryParam: TDictionary<String, String>;
    pPessoaTipoId: Integer;
begin
  try
    Try
      pessoaDAO := TpessoaDao.Create;
      Res.Send(pessoaDAO.GetPessoa4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

Procedure PessoaEstrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
Begin
  Try
    Try
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.PessoaEstrutura).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
End;

procedure GetPessoaID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pessoaDAO: TpessoaDao;
  AQueryParam: TDictionary<String, String>;
  pPessoaId: Integer;
  pPessoaTipoId: Integer;
  pCodPessoaERP: Integer;
  pRazao: String;
  pFantasia: String;
  ErroJsonArray : TjsonArray;
begin
  Try
    try
      pPessoaId := 0;
      pPessoaTipoId := 0;
      pCodPessoaERP := 0;
      pRazao := '';
      pFantasia := '';
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count > 0 then
      Begin
        if AQueryParam.ContainsKey('pessoatipoid') then
          pPessoaTipoId := StrToIntDef(AQueryParam.Items['pessoatipoid'], 0);
        if AQueryParam.ContainsKey('codpessoaerp') then
          pCodPessoaERP := StrToIntDef(AQueryParam.Items['codpessoaerp'], 0);
        if AQueryParam.ContainsKey('razao') then
          pRazao := AQueryParam.Items['razao'];
        if AQueryParam.ContainsKey('fantasia') then
          pFantasia := AQueryParam.Items['fantasia'];
      End;
      pPessoaId := StrToIntDef(Req.Params.Items['pessoaid'], 0);
      pessoaDAO := TpessoaDao.Create;
      Res.Send<TJSonArray>(pessoaDAO.GetPessoaID(pPessoaId, pPessoaTipoId,
        pCodPessoaERP, pRazao, pFantasia)).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
end;

procedure PessoaInsert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  pessoaDAO: TpessoaDao;
  ErroJsonArray : TJsonArray;
  HrInicioLog: int64;
begin
  Try
    HrInicioLog := getCurrentTime;
    Try
      pessoaDAO := TpessoaDao.Create;
      pessoaDAO.ObjPessoaDAO := pessoaDAO.ObjPessoaDAO.JsonToClass(Req.Body<TJSONObject>.ToString());
      Res.Send<TJSonArray>(pessoaDAO.PessoaInsert).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/pessoa', Trim(Req.Params.Content.Text), Req.Body, '', 'Retorno: Registro importado com Sucesso!',
                      200, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);
    Except On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/pessoa', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                        500, CalculaTempoProcesso(HrInicioLog), Req.Headers['appname']+'_V: '+Req.Headers['versao']);      End;
    end;
  Finally
    FreeAndNil(pessoaDAO);
  End;
End;

End.
