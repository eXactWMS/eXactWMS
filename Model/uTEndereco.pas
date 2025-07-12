unit uTEndereco;

interface

uses uTEnderecoRua, uTEnderecoSetor, uTEnderecoTipo, uTHistorico,
  uDmCadastroGeral, Math, Dialogs;

type
  TEndereco = class
    private
      FCodigo: Integer;
      FEndereco: string;
      FRua: TEnderecoRua;
      FSetor: TEnderecoSetor;
      FTipo: TEnderecoTipo;
      FVolume : Integer;
      FStatus : Boolean;
      procedure setRua(pRua: TEnderecoRua);
      procedure setSetor(pSetor: TEnderecoSetor);
      procedure setTipo(pTipo: TEnderecoTipo);
    public
      property Codigo: Integer        read FCodigo   write FCodigo;
      property Endereco: string       read FEndereco write FEndereco;
      property Rua: TEnderecoRua      read FRua      write setRua;
      property Setor: TEnderecoSetor  read FSetor    write setSetor;
      property Tipo: TEnderecoTipo    read FTipo     write setTipo;
      Property Volume : Integer       Read FVolume   Write FVolume;
      Property Status : Boolean       Read FStatus   Write FStatus;

      destructor Destroy; override;
      constructor Create(cCodigo : Integer = 0; cEndereco : String = ''; cRua : TEnderecoRua = Nil;
                          cSetor : TEnderecoSetor = Nil; cTipo : TEnderecoTipo = Nil; cVolume : Integer = 0;
                          cStatus : Boolean = True); OverLoad;
      class function FormatarEndereco(pEndereco, pMascara: string): string;
      class function ListarEnderecamento(pCodigoSetor: string; pStatus: Integer): OleVariant;
      class function GetEnderecoOcupacao(pCodigoSetor, pSituacao, pEnderecoInicial, PEnderecoFinal : string): OleVariant;
      class function GetLocalTAG(pEndInicial, pEndFinal: string; pTipo: Integer; pStatus : Integer = 0; pFilterSector : String = ''; pPickUse : String = 'T'): OleVariant;
      class function ListarEnderecos(pEndInicial, pEndFinal: string; pTipo: Integer; pStatus : Integer = 0; pFilterSector : String = ''; pPickUse : String = 'T'): OleVariant;
      Class Function ListarEnderecoResumida(Filtro : String) : OleVariant;
      class function PegarEndereco(pCodigo: Integer; pNome : String ): TEndereco; OverLoad;
      class function PegarEndereco(pCodigo: Integer ) : TEndereco ; OverLoad;
      class function PegarEnderecoNome(pNome : String ) : TEndereco ; OverLoad;
      Class Function PesquisarSetor(pCdEndereco, pSetor : Integer; pEndereco : String): OleVariant;
      class function Pesquisar(pCdEndereco, pCdSetor : Integer; pNome, pSetor: string): OleVariant; OverLoad;
      class function Pesquisar(pNome: string): OleVariant; OverLoad;
      class function SearchEndereco(pCodigo: Integer; pNome : String ): Boolean;
      class function MapeamentoCD: OleVariant; OverLoad;

      function EnderecoFormatado(pMascara: string): string;
      Procedure Salvar(pHistorico: THistorico);
      class Procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
      Class Procedure BlockAddress(pCodigo: Integer; pHistorico   : THistorico);
      Class Procedure SalvarCreateEnd(pLocalizacao: String; pRua, pSetor: Integer);
      Class Procedure UpdateSetor(pNmEndereco : String; pCdEnderecoSetor : Integer);
  end;

implementation

uses uDmEndereco, SysUtils, DB, uFuncoes;

{ TEndereco }

class procedure TEndereco.BlockAddress(pCodigo: Integer;
  pHistorico: THistorico);
begin
  try
    With DmCadastroGeral.qryVinculos do Begin
      Close;
      Sql.Clear;
      Sql.Add('Select Count(*) TotReg From TbProduto Where CdEndereco = '+IntToStr(pCodigo));
      Open;
      if FieldByName('TotReg').AsInteger > 0 then Begin
       	raise Exception.Create('Procedimento não autorizado. Existem Produto(s) vinculado(s) a este Endereço.');
         Exit;
      End;
    End;
    With DmCadastroGeral.qryExcluir do Begin
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;
      Close;
      Sql.Clear;
//      Sql.Add('Delete From TbEndereco Where CdEndereco = '+IntToStr(pCodigo));
//      Sql.Add('  And Not Exists (Select CdEnderecom From TbEstoqueProducao Where CdEndereco = '+IntStr(pCodigo));
      Sql.Add('Update TbEndereco Set Status = 1 Where CdEndereco = '+pCodigo.ToString());
      ExecSQL;

      pHistorico.CodigoRegistro := pCodigo;
      pHistorico.Observacao     := 'Endereço bloqueado: ';
      pHistorico.Salvar;
      Connection.CommitTrans;
    End;
  except on e: Exception do Begin
    DmCadastroGeral.qryExcluir.Connection.RollbackTrans;
    raise Exception.Create('Ocorreu um erro:' + #13 + E.Message);
    End;
  end;
end;

constructor TEndereco.Create(cCodigo: Integer; cEndereco: String;
  cRua: TEnderecoRua; cSetor: TEnderecoSetor; cTipo: TEnderecoTipo;
  cVolume: Integer; cStatus: Boolean);
begin
  FCodigo   := cCodigo;
  FEndereco := cEndereco;
  FRua      := TEnderecoRua.Create;
  FSetor    := TEnderecoSetor.Create;
  FTipo     := TEnderecoTipo.Create;
  FVolume   := cVolume;
  FStatus   := cStatus;
end;

destructor TEndereco.Destroy;
begin
(*
   FreeAndNil(FRua);
   FreeAndNil(FSetor);
   FreeAndNil(FTipo);
*)
  FRua   := Nil;
  FSetor := Nil;
  FTipo  := Nil;
  inherited;
end;

function TEndereco.EnderecoFormatado(pMascara: string): string;
begin
  Result := AplicarMascara(FEndereco, pMascara);
end;

class procedure TEndereco.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    With DmCadastroGeral.qryVinculos do Begin
      Close;
      Sql.Clear;
      Sql.Add('Select Count(*) TotReg From TbProduto Where CdEndereco = '+IntToStr(pCodigo));
      Open;
      if FieldByName('TotReg').AsInteger > 0 then Begin
       	raise Exception.Create('Procedimento não autorizado. Existem Produto(s) vinculado(s) a este Endereço.');
         Exit;
      End;
    End;
    With DmCadastroGeral.qryExcluir do Begin
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;
      Close;
      Sql.Clear;
//      Sql.Add('Delete From TbEndereco Where CdEndereco = '+IntToStr(pCodigo));
//      Sql.Add('  And Not Exists (Select CdEnderecom From TbEstoqueProducao Where CdEndereco = '+IntStr(pCodigo));
      Sql.Add('Delete From Endereco Where Localizacao = (Select NmEndereco From TbEndereco Where CdEndereco = '+IntToStr(pCodigo)+')');
      Sql.add('   And Not Exists (Select Localizacao From Estoque Where Localizacao = Endereco.Localizacao)');
      ExecSQL;

      pHistorico.CodigoRegistro := pCodigo;
      pHistorico.Observacao     := 'Exclusão de Endereço';
      pHistorico.Salvar;
      Connection.CommitTrans;
    End;
  except on e: Exception do Begin
    DmCadastroGeral.qryExcluir.Connection.RollbackTrans;
    raise Exception.Create('Ocorreu um erro:' + #13 + E.Message);
    End;
  end;
end;

class function TEndereco.FormatarEndereco(pEndereco, pMascara: string): string;
begin
  if pMascara = '' then With DmEndereco.QryGetMascara do Begin
     Close;
     Parameters.ParamByName('pNmEndereco').value := pEndereco;
     Open;
     pMascara := FieldByName('Mascara').AsString;
     Close;
  End;
  Result := AplicarMascara(pEndereco, pMascara);
end;

class function TEndereco.GetEnderecoOcupacao(pCodigoSetor, pSituacao,
  pEnderecoInicial, PEnderecoFinal: string): OleVariant;
Var SqlWhere : String;
begin
  SqlWhere := 'Where ';
  if pCodigoSetor <> '' then SqlWhere := SqlWhere + 'TEnd.CdEnderecoSetor In ('+pCodigoSetor+') and  ';
  if pEnderecoInicial <> '' then SqlWhere := SqlWhere +'TEnd.NmEndereco >= '+QuotedStr(pEnderecoInicial)+' and  ';
  if pEnderecoFinal   <> '' then SqlWhere := SqlWhere +'TEnd.NmEndereco <= '+QuotedStr(pEnderecoFinal)+' and  ';
  if pSituacao = 'O' then SqlWhere := SqlWhere + ' Prd.NmProduto Is Not Null and  ';
  if pSituacao = 'D' then SqlWhere := SqlWhere + ' Prd.NmProduto Is Null and  ';
  System.Delete(SqlWhere, Length(SqlWhere)-5, 6);
  dmEndereco.QryEnderecoOcupacao.Close;
  if SqlWhere <> '' then DmEndereco.QryEnderecoOcupacao.SQL.Strings[6] := SqlWhere;
  DmEndereco.QryEnderecoOcupacao.Open;
  Result := DmEndereco.DspEnderecoOcupacao.Data;
end;

class function TEndereco.GetLocalTAG(pEndInicial, pEndFinal: string; pTipo,
  pStatus: Integer; pFilterSector, pPickUse: String): OleVariant;
begin
  pEndInicial := TraduzirEndereco(RemoverCaracteresEspeciais(RemoverEspacos(pEndInicial)));
  pEndFinal   := TraduzirEndereco(RemoverCaracteresEspeciais(RemoverEspacos(pEndFinal)));
  With dmEndereco.qryGetLocalTAG do Begin
    Close;
    Parameters.ParamByName('pEndInicial').Value     := pEndInicial;
    Parameters.ParamByName('pEndFinal').Value       := pEndFinal;
    Parameters.ParamByName('pCdEnderecoTipo').Value := pTipo;
    Parameters.ParamByName('pStatus').Value         := pStatus;
    Parameters.ParamByName('pPickUse').Value        := pPickUse;
    if pFilterSector <> '' then
       SQL[31] := ' And Edr.CdEnderecoSetor In ('+pFilterSector+')';
    Open;
  End;
  Result := dmEndereco.dspGetLocalTAG.Data;
end;

class function TEndereco.ListarEnderecamento(pCodigoSetor: string; pStatus: Integer): OleVariant;
var
  vlCondicao: string;
begin
  ValidarParametroTexto(pCodigoSetor);

  case pStatus of
    0: vlCondicao := '';                              // 0 = Todos
    1: vlCondicao := 'and prd.cdProduto is null';     // 1 = Vazios
    2: vlCondicao := 'and prd.cdProduto is not null'; // 2 = Ocupados
  end;

  dmEndereco.qryListarEnderecamento.Close;
  dmEndereco.qryListarEnderecamento.SQL.Strings[18]                                  := vlCondicao;
  dmEndereco.qryListarEnderecamento.Parameters.ParamByName('pCdEnderecoSetor').Value := pCodigoSetor;
//  dmEndereco.qryListarEnderecamento.Prepared                                         := True;
  if DebugHook <> 0 then dmEndereco.qryListarEnderecamento.Sql.SaveToFile('EndOcupaca.Sql');
  dmEndereco.qryListarEnderecamento.Open;
  Result := dmEndereco.dspListarEnderecamento.Data;
end;

class function TEndereco.ListarEnderecoResumida(Filtro: String): OleVariant;
begin
  With DmEndereco.QryListaEnderecoResumida do Begin
    Close;
    if Filtro <> '' then
       Sql.Strings[10] := 'Where '+Filtro
    Else
       Sql.Strings[10] := '--';
    If DebugHook <> 0 Then Sql.SaveToFile('ListaEnderecoResumida.Sql');
    Open;
    Result := DmEndereco.DspListaEnderecoResumida.Data
  End;
end;

//Parametro pStatus incluido em 26/03/2019 para gerar relatório de Endereçamento Geral
class function TEndereco.ListarEnderecos(pEndInicial, pEndFinal: string; pTipo: Integer; pStatus : Integer; pFilterSector : String; pPickUse : String): OleVariant;
begin
  pEndInicial := TraduzirEndereco(RemoverCaracteresEspeciais(RemoverEspacos(pEndInicial)));
  pEndFinal   := TraduzirEndereco(RemoverCaracteresEspeciais(RemoverEspacos(pEndFinal)));
  dmEndereco.qryListarEnderecos.Close;
     dmEndereco.qryListarEnderecos.Parameters.ParamByName('pEndInicial').Value     := pEndInicial;
  dmEndereco.qryListarEnderecos.Parameters.ParamByName('pEndFinal').Value       := pEndFinal;
  dmEndereco.qryListarEnderecos.Parameters.ParamByName('pCdEnderecoTipo').Value := pTipo;
  dmEndereco.qryListarEnderecos.Parameters.ParamByName('pStatus').Value         := pStatus;
  dmEndereco.qryListarEnderecos.Parameters.ParamByName('pPickUse').Value        := pPickUse;
  if pFilterSector <> '' then
       dmEndereco.qryListarEnderecos.SQL[29] := ' And Edr.CdEnderecoSetor In ('+pFilterSector+')';
  dmEndereco.qryListarEnderecos.SQL.SaveToFile('RelEndereco.Sql');
  dmEndereco.qryListarEnderecos.Open;
  Result := dmEndereco.dspListarEnderecos.Data;
end;

class function TEndereco.MapeamentoCD: OleVariant;
begin
  With DmEndereco.QryMapeamentoCd do Begin
    Close;
    Open;
  End;
  Result := dmEndereco.DspMapeamentoCD.Data;
end;

class function TEndereco.PegarEndereco(pCodigo: Integer; pNome : String): TEndereco;
var
  vlEndereco: TEndereco;
  vlRua: TEnderecoRua;
  vlSetor: TEnderecoSetor;
  vlTipo: TEnderecoTipo;
begin
//  if PNome <> '' then pNome := '%'+pNome+'%';
  dmEndereco.qryPegarEndereco.Close;
  dmEndereco.qryPegarEndereco.Parameters.ParamByName('pCdEndereco').Value := pCodigo;
  dmEndereco.qryPegarEndereco.Parameters.ParamByName('pNmEndereco').Value := pNome; //QuotedStr(pNome);
  dmEndereco.qryPegarEndereco.Open;

  if (dmEndereco.qryPegarEndereco.IsEmpty = True) then
  	begin
  		raise Exception.Create('Endereço não encontrado!');
  	end;

  /////////////// Criação do Objeto Rua /////////////////
  vlRua        := TEnderecoRua.Create;
  vlRua.Codigo := dmEndereco.qryPegarEndereco.FieldByName('cdEnderecoRua').AsInteger;
  vlRua.Nome   := dmEndereco.qryPegarEndereco.FieldByName('nmEnderecoRua').AsString;
  ///////////////////////////////////////////////////////

  /////////////// Criação do Objeto Setor /////////////////
  vlSetor        := TEnderecoSetor.Create;
  vlSetor.Codigo := dmEndereco.qryPegarEndereco.FieldByName('cdEnderecoSetor').AsInteger;
  vlSetor.Nome   := dmEndereco.qryPegarEndereco.FieldByName('nmEnderecoSetor').AsString;
  ///////////////////////////////////////////////////////

  /////////////// Criação do Objeto Tipo /////////////////
  vlTipo        := TEnderecoTipo.Create;
  vlTipo.Codigo := dmEndereco.qryPegarEndereco.FieldByName('cdEnderecoTipo').AsInteger;
  vlTipo.Nome   := dmEndereco.qryPegarEndereco.FieldByName('nmEnderecoTipo').AsString;
  ///////////////////////////////////////////////////////

  vlEndereco          := TEndereco.Create;
  vlEndereco.Codigo   := dmEndereco.qryPegarEndereco.FieldByName('cdEndereco').AsInteger;
  vlEndereco.Endereco := dmEndereco.qryPegarEndereco.FieldByName('nmEndereco').AsString;
  vlEndereco.Rua      := vlRua;
  vlEndereco.Setor    := vlSetor;
  vlEndereco.Tipo     := vlTipo;
  vlEndereco.Volume   := DmEndereco.qryPegarEndereco.FieldByName('Volume').AsInteger;
  vlEndereco.Status   := dmEndereco.qryPegarEndereco.FieldByName('Status').AsBoolean;
  Result := vlEndereco;
end;

class function TEndereco.Pesquisar(pNome: string): OleVariant;
begin
  pNome := RemoverEspacos(pNome);
  if (pNome = '') then pNome := '%'
  else pNome := TraduzirEndereco(pNome);
  dmEndereco.qryPesquisar.Close;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pCdEndereco').Value := 0;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pNmEndereco').Value := pNome;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pCdEnderecoSetor').Value := 0;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pNmEnderecoSetor').Value := '';
  DmEndereco.QryPesquisar.Prepared := True;
  dmEndereco.qryPesquisar.Open;
  Result := dmEndereco.dspPesquisar.Data;
end;

class function TEndereco.PesquisarSetor(pCdEndereco, pSetor : Integer; pEndereco : String): OleVariant;
begin
  pEndereco := RemoverEspacos(pEndereco);
//  if (pEndereco = '') then pEndereco := '%'
//  else pEndereco := TraduzirEndereco(pEndereco);

  if PEndereco <> '' then Begin
     TraduzirEndereco(pEndereco);
     pEndereco := pEndereco + '%';
  End;

  dmEndereco.qryPesquisarSetor.Close;
  dmEndereco.qryPesquisarSetor.Parameters.ParamByName('pCdEndereco').Value := pCdEndereco;
  dmEndereco.qryPesquisarSetor.Parameters.ParamByName('pNmEndereco').Value := pEndereco;
  dmEndereco.qryPesquisarSetor.Parameters.ParamByName('pCdEnderecoSetor').Value := pSetor;
  dmEndereco.qryPesquisarSetor.Open;
  Result := dmEndereco.dspPesquisarSetor.Data;
end;

class function TEndereco.PegarEndereco(pCodigo: Integer): TEndereco;
begin
   Result := PegarEndereco(pCodigo, '');
end;

class function TEndereco.PegarEnderecoNome(pNome: String): TEndereco;
var
  vlEndereco: TEndereco;
  vlRua: TEnderecoRua;
  vlSetor: TEnderecoSetor;
  vlTipo: TEnderecoTipo;
begin
//  if PNome <> '' then pNome := '%'+pNome+'%';
  dmEndereco.qryPegarEnderecoNome.Close;
  dmEndereco.qryPegarEnderecoNome.Parameters.ParamByName('pNmEndereco').Value := pNome;
  dmEndereco.qryPegarEnderecoNome.Open;

  if (dmEndereco.qryPegarEnderecoNome.IsEmpty = True) then
  	begin
  		raise Exception.Create('Endereço não encontrado. Tente novamente!');
  	end;

  /////////////// Criação do Objeto Rua /////////////////
  vlRua        := TEnderecoRua.Create;
  vlRua.Codigo := dmEndereco.qryPegarEnderecoNome.FieldByName('cdEnderecoRua').AsInteger;
  vlRua.Nome   := dmEndereco.qryPegarEnderecoNome.FieldByName('nmEnderecoRua').AsString;
  ///////////////////////////////////////////////////////

  /////////////// Criação do Objeto Setor /////////////////
  vlSetor        := TEnderecoSetor.Create;
  vlSetor.Codigo := dmEndereco.qryPegarEnderecoNome.FieldByName('cdEnderecoSetor').AsInteger;
  vlSetor.Nome   := dmEndereco.qryPegarEnderecoNome.FieldByName('nmEnderecoSetor').AsString;
  ///////////////////////////////////////////////////////

  /////////////// Criação do Objeto Tipo /////////////////
  vlTipo        := TEnderecoTipo.Create;
  vlTipo.Codigo := dmEndereco.qryPegarEnderecoNome.FieldByName('cdEnderecoTipo').AsInteger;
  vlTipo.Nome   := dmEndereco.qryPegarEnderecoNome.FieldByName('nmEnderecoTipo').AsString;
  ///////////////////////////////////////////////////////

  vlEndereco          := TEndereco.Create;
  vlEndereco.Codigo   := dmEndereco.qryPegarEnderecoNome.FieldByName('cdEndereco').AsInteger;
  vlEndereco.Endereco := dmEndereco.qryPegarEnderecoNome.FieldByName('nmEndereco').AsString;
  vlEndereco.Rua      := vlRua;
  vlEndereco.Setor    := vlSetor;
  vlEndereco.Tipo     := vlTipo;
  vlEndereco.Volume   := DmEndereco.QryPegarEnderecoNome.FieldByName('Volume').AsInteger;
  vlEndereco.Status   := dmEndereco.qryPegarEnderecoNome.FieldByName('Status').AsBoolean;
  Result := vlEndereco;
end;

class function TEndereco.Pesquisar(pCdEndereco, pCdSetor : Integer; pNome, pSetor: string): OleVariant;
begin
  pNome := RemoverEspacos(pNome);
//  if (pNome = '') then pNome := '%'
//  else pNome := TraduzirEndereco(pNome);
  dmEndereco.qryPesquisar.Close;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pCdEndereco').Value := pCdEndereco;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pNmEndereco').Value := pNome;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pCdEnderecoSetor').Value := pCdSetor;
  dmEndereco.qryPesquisar.Parameters.ParamByName('pNmEnderecoSetor').Value := pSetor;
  dmEndereco.qryPesquisar.Open;
  dmEndereco.qryPesquisar.SaveToFile('PesquisarEndereco.Txt');
  Result := dmEndereco.dspPesquisar.Data;
end;

procedure TEndereco.Salvar(pHistorico: THistorico);
begin
  With DmCadastroGeral do Begin
    QrySalvar.Connection.Execute('SET NOCOUNT ON;');
    QrySalvar.Connection.BeginTrans;
    try
      With QrySalvar do Begin
//Tabela Antiga Endereco
        Close;
        Sql.Clear;
        Sql.Add('Declare @Codigo As Integer = '+IntToStr(FCodigo)+';');
        Sql.Add('Declare @Rua As Integer = '+IntToStr(FRua.Codigo)+';');
        Sql.Add('Declare @Setor As Integer = '+IntToStr(FSetor.Codigo)+';');
        Sql.Add('Declare @Tipo As Integer = '+IntToStr(FTipo.Codigo)+';');
        Sql.Add('Declare @Endereco As VarChar(255) = '+QuotedStr(FEndereco)+';');
        if Status then Sql.Add('Declare @Status as Integer = 1;')
        Else Sql.Add('Declare @Status as Integer = 0;');
        Sql.Add('if (@Codigo = 0)');
        Sql.Add('   Begin');
        Sql.Add('		   insert into Endereco(localizacao, Cod_Tipo, OrdemP, Rua, Nivel, Lado) Values ('	);
        Sql.Add('         			@Endereco, @Setor, 1, @Rua, '+QuotedStr('00')+', '+QuotedStr('00')+');'); //, @Status
        Sql.Add('  	end');
        Sql.Add('else');
        Sql.Add('   begin ');
        Sql.Add('     Update Endereco Set Cod_tipo = @SEtor, Rua = @Rua Where Localizacao = '+QuotedStr(FEndereco)); // Apenas para formar o Begin
        Sql.Add('  	end;');
        if DebugHook <> 0 then Sql.SaveToFile('EnderecoCad.Sql');
        execSql;

        Close;
        Sql.Clear;
        Sql.Add('select CdEndereco From TbEndereco where NmEndereco = '+QuotedStr(Endereco)+';');
        Open;
        FCodigo := FieldByName('CdEndereco').AsInteger;
        //Alterar TbEndereco
        Close;
        Sql.Clear;
        Sql.Add('Update TbEndereco Set');
        Sql.Add('   CdEnderecoRua = '+FRua.Codigo.ToString()+
                ' , CdEnderecoSetor = '+FSetor.Codigo.ToString()+
                ' , Volume = '+FVolume.ToString());
        if Status then Sql.Add(' ,Status  = 1')
        Else Sql.Add(' ,Status = 0');
        Sql.Add('Where CdEndereco = '+FCodigo.ToString());
        if DebugHook <> 0 then Sql.SaveToFile('TbEndereco.Sql');
        ExecSql;
      End;
      pHistorico.CodigoRegistro := FCodigo;
      if FCodigo = 0 then pHistorico.Observacao := 'Novo Cadastro de Rua de Picking'
      Else Begin
         QrySalvar.Close;
         QrySalvar.Sql.Clear;
         QrySalvar.Sql.Add('select CdEndereco From TbEndereco where NmEndereco = '+QuotedStr(Endereco)+';');
         QrySalvar.Open;
         FCodigo := QrySalvar.FieldByName('CdEndereco').AsInteger;
         pHistorico.CodigoRegistro := FCodigo;
         pHistorico.Observacao := 'Alteração  Cadastro de Rua de Picking';
      End;
      pHistorico.Salvar;
      QrySalvar.Connection.CommitTrans;
    except on e: Exception do
      begin
        QrySalvar.Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

Class Procedure TEndereco.SalvarCreateEnd(pLocalizacao : String; pRua, pSetor : Integer);
Var xEnde : Integer;
begin
  With DmCadastroGeral do Begin
    QrySalvar.Connection.Execute('SET NOCOUNT ON;');
    QrySalvar.Connection.BeginTrans;
    xEnde := 0;
    try
      With QrySalvar do Begin
//Tabela Antiga Endereco
        Close;
        Sql.Clear;
        Sql.Add('Declare @Rua As Integer = '+pRua.ToString()+';');
        Sql.Add('Declare @Setor As Integer = '+pSetor.ToString()+';');
        Sql.Add('Declare @Endereco As VarChar(255) = '+QuotedStr(pLocalizacao)+';');
        Sql.Add('insert into Endereco (localizacao, Cod_Tipo, OrdemP, Rua, Nivel, Lado) Values ('	);
        Sql.Add('   @Endereco, @Setor, 1, @Rua, '+QuotedStr('00')+', '+QuotedStr('00')+');'); //, @Status
        if DebugHook <> 0 then Sql.SaveToFile('SaveCreateEnde.Sql');
        execSql;
      End;
      QrySalvar.Connection.CommitTrans;
    except on e: Exception do
      begin
        QrySalvar.Connection.RollbackTrans;
        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

class function TEndereco.SearchEndereco(pCodigo: Integer;
  pNome: String): Boolean;
begin
  dmEndereco.qryPegarEndereco.Close;
  dmEndereco.qryPegarEndereco.Parameters.ParamByName('pCdEndereco').Value := pCodigo;
  dmEndereco.qryPegarEndereco.Parameters.ParamByName('pNmEndereco').Value := pNome; //QuotedStr(pNome);
  dmEndereco.qryPegarEndereco.Open;
  Result := dmEndereco.QryPegarEndereco.FieldByName('CdEndereco').AsInteger = 0;
end;

procedure TEndereco.setRua(pRua: TEnderecoRua);
begin
//  FreeAndNil(FRua);

  FRua := pRua;
end;

procedure TEndereco.setSetor(pSetor: TEnderecoSetor);
begin
//  FreeAndNil(FSetor);

  FSetor := pSetor;
end;

procedure TEndereco.setTipo(pTipo: TEnderecoTipo);
begin
//  FreeAndNil(FTipo);

  FTipo := pTipo;
end;

class procedure TEndereco.UpdateSetor(pNmEndereco : String; pCdEnderecoSetor: Integer);
begin
  With DmEndereco.QryUpdateSetor do Begin
    Parameters.ParamByName('pNmEndereco').Value      := pNmEndereco;
    Parameters.ParamByName('pCdEnderecoSetor').Value := pCdEnderecoSetor;
    ExecSQL;
  End;
end;

end.
