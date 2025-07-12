unit uTUsuario;

interface

uses FMX.Dialogs, DBClient, SysUtils, DB, System.Json;//, uTHistorico;
     //uTUsuarioPerfil, uTUsuarioStatus,
type
  TModulo = Class
    private
      FCodigo: Integer;
      FNome: String;
      procedure SetCodigo(const Value: Integer);
      procedure SetNome(const Value: String);
    Public
      Property Codigo : Integer read FCodigo write SetCodigo;
      Property Nome   : String  read FNome   write SetNome;
  End;

  TFuncao = Class
    private
      FHistorico: Integer;
      FCodigo: Integer;
      FNome: String;
      procedure SetCodigo(const Value: Integer);
      procedure SetHistorico(const Value: Integer);
      procedure SetNome(const Value: String);
    Public
     Constructor Create(cCdHistorico : Integer = 0; cCdFuncao : Integer = 0;
                        cNmFuncao : String = '');
      Property Codigo    : Integer read FCodigo write SetCodigo;
      Property Nome      : String read FNome write SetNome;
      Property Historico : Integer read FHistorico write SetHistorico;
  End;

  TListModulos = Array Of TModulo;
  TArrayListFuncoes = Array Of TFuncao;

  TListFuncoes = Class //Funcoes do Perfil
  private
    FItems: TArrayListFuncoes;
    procedure SetItems(const Value: TArrayListFuncoes);
    Published
      Property Items : TArrayListFuncoes read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TFuncao) : Integer;
  End;

  TUsuarioPerfil = Class
    private
      FCodigo: Integer;
      FNome: string;
      FModulos: TListModulos;
      FFuncoes: TListFuncoes;
    Published
      Constructor Create(cCodigo : Integer = 0; cNome : String = ''; cModulo : TListModulos = Nil; cFuncoes : TLIstFuncoes = Nil); Reintroduce;
    Public
      property Codigo: Integer        read FCodigo  write FCodigo;
      property Nome: string           read FNome    write FNome;
      property Modulos : TListModulos read FModulos write FModulos;
      property Funcoes : TListFuncoes read FFuncoes write FFuncoes;
  End;

  TUsuarioStatus = class
    private
      FCodigo: Integer;
      FNome: string;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;
//      class function ListarStatus: OleVariant;
  end;

  TArrayLstFuncoesUsuario = Array Of TFuncao;

  TLstFuncoesUsuario = Class //Funcoes do Perfil
  private
    FItems: TArrayLstFuncoesUsuario;
    procedure SetItems(const Value: TArrayLstFuncoesUsuario);
    Published
      Property Items : TArrayLstFuncoesUsuario read FItems write SetItems;
    Public
      Function Size : Integer;
      Function Add(Item : TFuncao) : Integer;
  End;

  TUsuario = class
    private
      FCodigo  : integer;
      FNome    : string;
      FSenha   : string;
      FStatus  : Integer;
      FPerfil  : TUsuarioPerfil;
      FFuncoes : TLstFuncoesUsuario;

      procedure ListarFuncoes;
      procedure SalvarFuncoesExtras(pFuncoesExtras: OleVariant);
      procedure SalvarModulosExtras(pModulosExtras: OleVariant);
      procedure setPerfil(const Value: TUsuarioPerfil);
    Public
      Constructor Create(cCodigo : Integer = 0; cNome : String = ''; cSenha : String = '';
                         cPerfil : TUsuarioPerfil = Nil); Reintroduce;
      Class Procedure Register; //Registrar a classe por recomendacao do Brutus do Delphi WebServices 6
    Published
      property Codigo: Integer   read FCodigo    write FCodigo;
      property Nome  : string    read FNome      write FNome;
      property Senha  : string   read FSenha     write FSenha;
      Property Status : Integer  Read FStatus    Write FStatus;
      property Perfil: TUsuarioPerfil read FPerfil    write setPerfil;
      Property Funcoes : TLstFuncoesUsuario Read FFuncoes   Write FFuncoes;

      //constructor Create;
      destructor Destroy; override;

      class procedure AlterarSenha(pCodigo: integer; pNovaSenha: string);
      class function  PegarUsuario(pCodigo: integer): TUsuario;
      class function  Pesquisar(pCodigo, pNome: string): OleVariant;
      Class Function  RelUSuarioFuncao(vUsuario, vPerfil, vModulo, vFuncao : Integer) : OleVariant;
      function  ListarFuncoesExtras(pCodigoPerfil: Integer): OleVariant;
      function  ListarModulosExtras(pCodigoPerfil: Integer): OleVariant;
      function  RelatorioCaixasFechadas(pDataHora: TDateTime): OleVariant;
      function  RelatorioCaixasFracionadas(pDataHora: TDateTime): OleVariant;
      Class Function ServerBD : String;
//      procedure Salvar(pModulosExtras, pFuncoesExtras: OleVariant; pHistorico: THistorico);
      procedure ValidarAcesso(pCodigoModulo: Integer; pSenha: string);
  end;

implementation

{ TUsuario }

Uses uFuncoes; //, uDmClient; //, uDmServidor;

class procedure TUsuario.AlterarSenha(pCodigo: integer; pNovaSenha: string);
begin
{  DmServidor.qryAlterarSenha.Close;
  dmUsuario.qryAlterarSenha.Parameters.ParamByName('pNovaSenha').Value := Criptografar(pNovaSenha);
  dmUsuario.qryAlterarSenha.Parameters.ParamByName('pCdUsuario').Value := pCodigo;
  dmUsuario.qryAlterarSenha.ExecSQL;
}end;

constructor TUsuario.Create(cCodigo: Integer; cNome, cSenha: String;
  cPerfil: TUsuarioPerfil);
begin
  FCodigo  := cCodigo;
  FNome    := cNome;
  FSenha   := cSenha;
  FPerfil  := cPerfil;
end;

destructor TUsuario.Destroy;
begin
{  if (Assigned(FStatus) = True) then
    begin
      FreeAndNil(FStatus);
    end;

  if (Assigned(FPerfil) = True) then
    begin
      FreeAndNil(FPerfil);
    end;
}
  inherited;
end;

{class procedure TUsuario.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmUsuario.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmUsuario.qryExcluir.Connection.BeginTrans;

    dmUsuario.qryExcluir.Close;
    dmUsuario.qryExcluir.Parameters.ParamByName('pCdUsuario').Value := pCodigo;
    dmUsuario.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclusão do Cadastro do Usuário';

    pHistorico.Salvar;

    dmUsuario.qryExcluir.Connection.CommitTrans;
  except
    dmUsuario.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste usuário. ' + #13 +
                           'Utilize o campo "Status" para inativá-lo.');
  end;
end;
}
class function TUsuario.PegarUsuario(pCodigo: integer): TUsuario;
var
  vlUsuario: TUsuario;
//  vlPerfil: TUsuarioPerfil;
  vlPesquisar: TClientDataSet;
begin
  try
    vlPesquisar      := TClientDataSet.Create(nil);
    VlPesquisar.Data := Pesquisar(IntToStr(pCodigo), '');

    if (vlPesquisar.IsEmpty = True) then
       raise Exception.Create('Usuário não encontrado!');

//    vlPerfil        := TUsuarioPerfil.Create;
//    vlPerfil.Codigo := vlPesquisar.FieldByName('cdPerfil').AsInteger;
//    vlPerfil.Nome   := vlPesquisar.FieldByName('nmPerfil').AsString;

    vlUsuario        := TUsuario.Create;
    vlUsuario.Codigo := vlPesquisar.FieldByName('cdUsuario').AsInteger;
    vlUsuario.Nome   := vlPesquisar.FieldByName('nmUsuario').AsString;
    vlUsuario.Senha  := Criptografar(vlPesquisar.FieldByName('Senha').AsString);
    vlUsuario.Status := vlPesquisar.FieldByName('CdUsuarioStatus').AsInteger;
//    vlUsuario.Perfil := vlPerfil;

//    vlUsuario.Status.Codigo := vlPesquisar.FieldByName('cdUsuarioStatus').AsInteger;
//    vlUsuario.Status.Nome   := vlPesquisar.FieldByName('nmUsuarioStatus').AsString;

    vlUsuario.ListarFuncoes;


    Result := vlUsuario;
  Except  on e: Exception do
      raise Exception.Create(e.Message);
  end;
  FreeAndNil(vlPesquisar);
end;

class function TUsuario.Pesquisar(pCodigo, pNome: string): OleVariant;
Var //vlPerfil : TUsuarioPerfil;
    vlUsuario : TUsuario;
begin
end;

class procedure TUsuario.Register;
begin

end;

function TUsuario.RelatorioCaixasFechadas(pDataHora: TDateTime): OleVariant;
begin
{  dmUsuario.qryRelatorioCaixasFechadas.Close;
  dmUsuario.qryRelatorioCaixasFechadas.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
  dmUsuario.qryRelatorioCaixasFechadas.Parameters.ParamByName('pDataHora').Value  := FormatDateTime('yyyy-mm-dd hh:mm:ss', pDataHora);
  dmUsuario.qryRelatorioCaixasFechadas.Open;
  Result := dmUsuario.dspRelatorioCaixasFechadas.Data;
}end;

function TUsuario.RelatorioCaixasFracionadas(pDataHora: TDateTime): OleVariant;
begin
{  dmUsuario.qryRelatorioCaixasFracionadas.Close;
  dmUsuario.qryRelatorioCaixasFracionadas.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
  dmUsuario.qryRelatorioCaixasFracionadas.Parameters.ParamByName('pDataHora').Value  := FormatDateTime('yyyy-mm-dd HH:MM:SS', pDataHora);
  dmUsuario.qryRelatorioCaixasFracionadas.Open;

  Result := dmUsuario.dspRelatorioCaixasFracionadas.Data;
}end;

class function TUsuario.RelUSuarioFuncao(vUsuario, vPerfil, vModulo,
  vFuncao: Integer): OleVariant;
begin
  {With DmUsuario.QryRelUsuarioFuncao do Begin
   Close;
   Parameters.ParamByName('pCdUsuario').Value := IntToSTr(vUsuario);
   Parameters.ParamByName('pCdPerfil').Value  := IntToSTr(vPerfil);
   Parameters.ParamByName('pCdModulo').Value  := IntToSTr(vModulo);
   Parameters.ParamByName('pCdFuncao').Value  := IntToSTr(vFuncao);
   Open;
  End;
  Result := dmUsuario.dspRelUsuarioFuncao.Data;
}end;

procedure TUsuario.ListarFuncoes;
var
  jArr : TJSONArray;
  vListaFuncao : TListFuncoes;
begin
  Self.Funcoes.Add(TFuncao.Create(1, 1, 'Funcao 01'));
  Self.Funcoes.Add(TFuncao.Create(1, 2, 'Funcao 02'));
  Self.Funcoes.Add(TFuncao.Create(1, 3, 'Funcao 03'));
{  jArr := dmClient.GetValidarFuncao(Self.FCodigo, 0);
  vListaFuncao := TListFuncoes.Create;
  for I := 0 to jArr.Count - 1 do Begin
    jObj := jArr.Items[I] as TJSONObject;
//    EdtCodigo.Text    := jObj.GetValue('cdsaida').GetValue<String>;
//    EdtDtSaida.Date   := StrToDate(FormatDateTime('DD/MM/YYYY', jObj.GetValue('dtsaida').GetValue<TDateTime>));
//    EdtCdCliente.Text := jObj.GetValue('cdcliente').GetValue<string>;
      vListaFuncao.Add(TFuncao.Create(0, jObj.GetValue('CdFuncao').GetValue<Integer>, jObj.GetValue('NmFuncao').GetValue<String>)); // := jObj.GetValue('cdsaida').GetValue<Integer>;
  End;
  Self.FFuncoes := vListaFuncao;
  vListaFuncao.DisposeOf;
}end;

function TUsuario.ListarFuncoesExtras(pCodigoPerfil: Integer): OleVariant;
begin
{  dmUsuario.qryListarFuncoesExtras.Close;
  dmUsuario.qryListarFuncoesExtras.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
  dmUsuario.qryListarFuncoesExtras.Parameters.ParamByName('pCdPerfil').Value  := pCodigoPerfil;
  dmUsuario.qryListarFuncoesExtras.Open;

  Result := dmUsuario.dspListarFuncoesExtras.Data;
}end;

function TUsuario.ListarModulosExtras(pCodigoPerfil: Integer): OleVariant;
begin
{  dmUsuario.qryListarModulosExtras.Close;
  dmUsuario.qryListarModulosExtras.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
  dmUsuario.qryListarModulosExtras.Parameters.ParamByName('pCdPerfil').Value  := pCodigoPerfil;
  dmUsuario.qryListarModulosExtras.Open;

  Result := dmUsuario.dspListarModulosExtras.Data;
}end;

{procedure TUsuario.Salvar(pModulosExtras, pFuncoesExtras: OleVariant; pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de Novo Usuário: ' + FNome;

      FSenha := '123';
    end
  else
    begin
      pHistorico.Observacao := 'Alteração do Cadastro do Usuário: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmUsuario.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmUsuario.qrySalvar.Connection.BeginTrans;

    dmUsuario.qrySalvar.Close;
    dmUsuario.qrySalvar.Parameters.ParamByName('pCdUsuario').Value       := FCodigo;
    dmUsuario.qrySalvar.Parameters.ParamByName('pCdPerfil').Value        := FPerfil.Codigo;
    dmUsuario.qrySalvar.Parameters.ParamByName('pNmUsuario').Value       := FNome;
    dmUsuario.qrySalvar.Parameters.ParamByName('pSenha').Value           := Criptografar(FSenha);
    dmUsuario.qrySalvar.Parameters.ParamByName('pCdUsuarioStatus').Value := FStatus.Codigo;
    dmUsuario.qrySalvar.Open;

    FCodigo := dmUsuario.qrySalvar.FieldByName('cdUsuario').AsInteger;

    SalvarModulosExtras(pModulosExtras);
    SalvarFuncoesExtras(pFuncoesExtras);

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmUsuario.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmUsuario.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;
}
procedure TUsuario.SalvarFuncoesExtras(pFuncoesExtras: OleVariant);
var
  vlFuncoesExtras: TClientDataSet;
begin
  vlFuncoesExtras := TClientDataSet.Create(nil);

  try
    vlFuncoesExtras.Data     := pFuncoesExtras;
    vlFuncoesExtras.Filter   := '(Ativo = 1)';
    vlFuncoesExtras.Filtered := True;

{    dmUsuario.qryExcluirFuncoesExtras.Close;
    dmUsuario.qryExcluirFuncoesExtras.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
    dmUsuario.qryExcluirFuncoesExtras.ExecSQL;

    vlFuncoesExtras.First;
    while (vlFuncoesExtras.Eof = False) do
      begin
        dmUsuario.qrySalvarFuncaoExtra.Close;
        dmUsuario.qrySalvarFuncaoExtra.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
        dmUsuario.qrySalvarFuncaoExtra.Parameters.ParamByName('pCdFuncao').Value  := vlFuncoesExtras.FieldByName('cdFuncao').AsInteger;
        dmUsuario.qrySalvarFuncaoExtra.ExecSQL;

        vlFuncoesExtras.Next;
      end;
}  finally
    FreeAndNil(vlFuncoesExtras);
  end;
end;

procedure TUsuario.SalvarModulosExtras(pModulosExtras: OleVariant);
var
  vlModulosExtras: TClientDataSet;
begin
  vlModulosExtras := TClientDataSet.Create(nil);

  try
    vlModulosExtras.Data     := pModulosExtras;
    vlModulosExtras.Filter   := '(Ativo = 1)';
    vlModulosExtras.Filtered := True;

 {   dmUsuario.qryExcluirModulosExtras.Close;
    dmUsuario.qryExcluirModulosExtras.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
    dmUsuario.qryExcluirModulosExtras.ExecSQL;

    vlModulosExtras.First;
    while (vlModulosExtras.Eof = False) do
      begin
        dmUsuario.qrySalvarModuloExtra.Close;
        dmUsuario.qrySalvarModuloExtra.Parameters.ParamByName('pCdUsuario').Value := FCodigo;
        dmUsuario.qrySalvarModuloExtra.Parameters.ParamByName('pCdModulo').Value  := vlModulosExtras.FieldByName('cdModulo').AsInteger;
        dmUsuario.qrySalvarModuloExtra.ExecSQL;
        vlModulosExtras.Next;
      end;
}  finally
    FreeAndNil(vlModulosExtras);
  end;
end;

Class Function TUsuario.ServerBD : String;
begin
//  Result := 'Servidor: '+dmUsuario.ServerBd;
end;

procedure TUsuario.setPerfil(const Value: TUsuarioPerfil);
begin
  FPerfil := Value;
end;

{procedure TUsuario.setPerfil(pPerfil: TUsuarioPerfil);
begin
  if (Assigned(FPerfil) = True) then
    begin
      FreeAndNil(FPerfil);
    end;

  FPerfil := pPerfil;
end;

procedure TUsuario.setStatus(pStatus: TUsuarioStatus);
begin
  if (Assigned(FStatus) = True) then
    begin
      FreeAndNil(FStatus);
    end;

  FStatus := pStatus;
end;
 }
procedure TUsuario.ValidarAcesso(pCodigoModulo: Integer; pSenha: string);
begin
  if (Self.Senha <> pSenha) then
    begin
      raise Exception.Create('Senha inválida!');
    end;

 { if (Self.Status.Codigo = 2) then // 2 = Inativo
    begin
      raise Exception.Create('Usuário inativo!' + #13 +
                             'O usuário informado está com o seu acesso inativado!');
    end;

  dmUsuario.qryValidarModulo.Close;
  dmUsuario.qryValidarModulo.Parameters.ParamByName('pCdUsuario').Value := Self.Codigo;
  dmUsuario.qryValidarModulo.Parameters.ParamByName('pCdModulo').Value  := pCodigoModulo;
  dmUsuario.qryValidarModulo.Open;

  if (dmUsuario.qryValidarModulo.IsEmpty = True) then
    begin
      raise Exception.Create('Acesso não permitido!' + #13 +
                             'O usuário informado não tem permissão para acessar este Módulo.');
    end;
}end;

{ TModulo }

procedure TModulo.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TModulo.SetNome(const Value: String);
begin
  FNome := Value;
end;

{ TFuncao }

constructor TFuncao.Create(cCdHistorico, cCdFuncao: Integer; cNmFuncao: String);
begin
  FHistorico := cCdHistorico;
  FCodigo    := cCdFuncao;
  FNome      := cNmFuncao;
end;

procedure TFuncao.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TFuncao.SetHistorico(const Value: Integer);
begin
  FHistorico := Value;
end;

procedure TFuncao.SetNome(const Value: String);
begin
  FNome := Value;
end;

{ TListFuncoes }

function TListFuncoes.Add(Item: TFuncao): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TListFuncoes.SetItems(const Value: TArrayListFuncoes);
begin
  FItems := Value;
end;

function TListFuncoes.Size: Integer;
begin
  Result := Length(FItems);
end;

{ TUsuarioPerfil }

constructor TUsuarioPerfil.Create(cCodigo: Integer; cNome: String;
  cModulo: TListModulos; cFuncoes: TLIstFuncoes);
begin
  FCodigo  := cCodigo;
  FNome    := cNome;
  FModulos := cModulo;
  FFuncoes := cFuncoes;
end;

{ TLstFuncoesUsuario }

function TLstFuncoesUsuario.Add(Item: TFuncao): Integer;
begin
  SetLength(FItems, Size+1);
  FItems[High(FItems)] := Item;
  Result := High(FItems);
end;

procedure TLstFuncoesUsuario.SetItems(const Value: TArrayLstFuncoesUsuario);
begin
  FItems := Value;
end;

function TLstFuncoesUsuario.Size: Integer;
begin
  Result := Length(FItems);
end;

Initialization
  TUsuario.Register;

end.
