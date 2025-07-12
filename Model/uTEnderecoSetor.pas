unit uTEnderecoSetor;

interface

uses uTProdutoControle, uTHistorico, uDmCadastroGeral, Dialogs;

type
  TEnderecoSetor = class
    private
      FCodigo: Integer;
      FNome: string;
      FProdutoControle : Integer;
      FControle: TProdutoControle;
      fExigirLote : Boolean; //Exigir Seleção de Lote na reposição via coletor
      fConfAuto   : Boolean; //Permitir Conferência Automática na Separação
      function  GetProdutoControle: TProdutoControle;
      procedure SetProdutoControle(pProdutoControle : TProdutoControle);
    public
      property Codigo: Integer            read FCodigo     write FCodigo;
      property Nome: string               read FNome       write FNome;
      Property ProdutoControle : Integer  Read FProdutoControle Write FProdutoControle;
      property Controle: TProdutoControle read GetProdutoControle  write SetProdutoControle;
      Property ExigirLote : Boolean       Read fExigirLote Write fExigirLote;
      Property ConfAuto   : Boolean       Read fConfAuto   Write fConfAuto;
      constructor Create;
      destructor Destroy; override;

      class function Pesquisar(pCodigo, pNome, pTipoEndereco: string): OleVariant;
      //Funcao Pesquisar2 criada devido a funcao Pesquisar vincular com a Tabela endereco,
      //impedindo de encontrar setores sem endereco cadastrado
      class function Pesquisar2(pCodigo, pNome, pTipoEndereco: string): OleVariant; static;
      class function PegarSetor(pCodigo: Integer): TEnderecoSetor;
      procedure Salvar(pHistorico: THistorico);
      class procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
      class function ListarEnderecoSetor: OleVariant; static;
  end;

implementation

uses
  System.SysUtils, uDmEnderecoSetor, DBClient, DB, uFuncoes;

{ TEnderecoSetor }

constructor TEnderecoSetor.Create;
begin
  FControle        := TProdutoControle.Create;
//  FControle.Codigo := 0;
//  FControle.Nome   := '';
//  FControle.ExigirLote := False;
end;

destructor TEnderecoSetor.Destroy;
begin
  FreeAndNil(FControle);

  inherited;
end;

class procedure TEnderecoSetor.Excluir(pCodigo: Integer;
  pHistorico: THistorico);
begin
  try
    With DmCadastroGeral.qryVinculos do Begin
      Close;
      Sql.Clear;
      Sql.Add('Select Count(*) TotReg From TbEndereco Where CdEnderecoSetor = '+IntToStr(pCodigo));
      Open;
      if FieldByName('TotReg').AsInteger > 0 then Begin
       		raise Exception.Create('Procedimento não autorizado. Existem endereço(s) vinculado(s) a este Endereço.');
         Exit;
      End;
    End;
    With DmCadastroGeral.qryExcluir do Begin
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;
      Close;
      Sql.Clear;
      Sql.Add('Delete From Tipo Where Cod_Tipo = '+IntToStr(pCodigo));
      Sql.Add('  and Not Exists (Select CdEndereSetor From TbEndereco Where CdEnderecoSetor = '+IntToStr(pCodigo)+')');
      ExecSQL;

      pHistorico.CodigoRegistro := pCodigo;
      pHistorico.Observacao     := 'Exclusão de Setor de Endereços';
      pHistorico.Salvar;
      Connection.CommitTrans;
    End;
  except
    DmCadastroGeral.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão deste Setor.');
  end;
end;

function TEnderecoSetor.GetProdutoControle: TProdutoControle;
begin
  if (Assigned(FControle) = False) and (FProdutoControle > 0) then
    begin
      SetProdutoControle(TProdutoControle.PegarProdutoControle(FProdutoControle));
    end;

  Result := FControle;
end;

class function TEnderecoSetor.ListarEnderecoSetor: OleVariant;
begin
  With DmCadastroGeral.qryPesquisar do Begin
    Close;
    Sql.Clear;
    Sql.Add('Select NmEnderecoSetor, CdEnderecoSetor, (Select Count(CdEndereco) From TbEndereco Where CdEnderecoSEtor = TbEnderecoSEtor.cdEnderecoSetor) as TotEnd');
    Sql.Add('From TbEnderecoSetor');
    //Sql.Add('Where CdEnderecoSetor <> 0');
    Sql.Add('Order by CdEnderecoSetor');
    Open;
    Result := DmCadastroGeral.dspPesquisar.Data;
  End;
end;

class function TEnderecoSetor.PegarSetor(pCodigo: Integer): TEnderecoSetor;
var
  vlPesquisar  : TClientDataSet;
  vlEnderecoSetor : TEnderecoSetor;
begin
  vlPesquisar := TClientDataSet.Create(nil);
  try
    vlPesquisar.Close;
    vlPesquisar.Data := Pesquisar(IntToStr(pCodigo), '', '');

    if (vlPesquisar.IsEmpty = True) then
    	begin
    		raise Exception.Create('Código de Setor de Endereço inválido!');
    	end;

    vlEnderecoSetor        := TEnderecoSetor.Create;
    vlEnderecoSetor.Codigo := vlPesquisar.FieldByName('CdEnderecoSetor').AsInteger;
    vlEnderecoSetor.Nome   := vlPesquisar.FieldByName('nmEnderecoSetor').AsString;
    VlEnderecoSetor.FProdutoControle := vlPesquisar.FieldByName('CdProdutoControle').AsInteger;
    vlEnderecoSetor.ExigirLote := vlPesquisar.FieldByName('ExigirLote').AsBoolean;
    vlEnderecoSetor.ConfAuto   := VlPesquisar.FieldByName('SeparacaoConf').AsBoolean;
    Result := vlEnderecoSetor;
  finally
    FreeAndNil(vlPesquisar);
  end;
end;

class function TEnderecoSetor.Pesquisar(pCodigo, pNome, pTipoEndereco: string): OleVariant;
Var xRec : Integer;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%'
    end;
  if (Trim(pNome) = '') then
    begin
      pNome := '%'
    end;
  if (Trim(pTipoEndereco) = '') then
    begin
      pTipoEndereco := '%'
    end;
  DmEnderecoSetor.QryPesquisar.Close;
  dmEnderecoSetor.qryPesquisar.Parameters.ParamByName('pCdEnderecoSetor').Value := pCodigo;
  dmEnderecoSetor.qryPesquisar.Parameters.ParamByName('pNmEnderecoSetor').Value := pNome;
  dmEnderecoSetor.qryPesquisar.Parameters.ParamByName('pCdEnderecoTipo').Value  := pTipoEndereco;
  dmEnderecoSetor.qryPesquisar.Open;
  Result := DmEnderecoSetor.DspPesquisar.Data;
  xRec := DmEnderecoSetor.QryPesquisar.RecordCount;
end;

class function TEnderecoSetor.Pesquisar2(pCodigo, pNome, pTipoEndereco: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then
    begin
      pCodigo := '%'
    end;
  if (Trim(pTipoEndereco) = '') then
    begin
      pTipoEndereco := '%'
    end;
  DmEnderecoSetor.QryPesquisar2.Close;
  dmEnderecoSetor.qryPesquisar2.Parameters.ParamByName('pCdEnderecoSetor').Value := pCodigo;
  dmEnderecoSetor.qryPesquisar2.Parameters.ParamByName('pNmEnderecoSetor').Value := '%'+pNome+'%';
  dmEnderecoSetor.qryPesquisar2.Parameters.ParamByName('pCdEnderecoTipo').Value  := pTipoEndereco;
  dmEnderecoSetor.qryPesquisar2.Open;
  Result := DmEnderecoSetor.DspPesquisar2.Data;
end;

procedure TEnderecoSetor.Salvar(pHistorico: THistorico);
var vExigirLote, vConfAuto : String;
begin
  if fExigirLote then vExigirLote := '1' Else vExigirLote := '0';
  if fConfAuto   then vConfAuto   := '1' Else vConfAuto   := '0';
  With DmCadastroGeral do Begin
    QrySalvar.Connection.Execute('SET NOCOUNT ON;');
    QrySalvar.Connection.BeginTrans;
    try
      With QrySalvar do Begin
//Tabela Antiga - TIPO
        Close;
        Sql.Clear;
        Sql.Add('Declare @Codigo As Integer = '+IntToStr(FCodigo)+';');
        Sql.Add('Declare @Descricao As VarChar(255) = '+QuotedStr(FNome)+';');
        Sql.Add('if (@Codigo = 0)');
        Sql.Add('   Begin');
        Sql.Add('		   set @Codigo = (select coalesce(MAX(Cod_Tipo), 0) + 1 from Tipo);');
        Sql.Add('		   insert into Tipo (Cod_Tipo, Descricao, Tipo_Rep) Values ('	);
        Sql.Add('         			@Codigo, @Descricao, '+QuotedStr('S')+');');
        Sql.Add('  	end');
        Sql.Add('else');
        Sql.Add('   begin ');
        Sql.Add('      Update Tipo Set Descricao = @Descricao Where Cod_Tipo = '+FCodigo.ToString());  //so para preenche o begin
        Sql.Add('  	end;');
        if DebugHook <> 0 then Sql.SaveToFile('EnderecoSetorOLD.Txt');
        ExecSql;
        if FCodigo = 0 then Begin
           Close;
           Sql.Clear;
           Sql.Add('select coalesce(MAX(Cod_Tipo), 0) as Codigo from Tipo');
           Open;
           FCodigo := FieldByName('Codigo').AsInteger;
        End;


        Close;
        Sql.Clear;
        Sql.Add('Declare @Codigo As Integer = '+IntToStr(FCodigo)+';');
        Sql.Add('Declare @Descricao As VarChar(255) = '+QuotedStr(FNome)+';');
        Sql.Add('if (@Codigo = 0)');
        Sql.Add('   Begin');
        Sql.Add('		 set @Codigo = (select coalesce(MAX(CdEnderecoSetor), 0) + 1 from TbEnderecoSetor);');
        Sql.Add('		 insert into TbEnderecoSetor(CdEnderecoSetor, NmEnderecoSetor, CdProdutoControle, ExigirLote, SeparacaoConf) Values ('	);
        Sql.Add('        @Codigo, @Descricao, '+IntToStr(FControle.Codigo)+', '+vExigirLote+', '+vConfAuto+');');
        Sql.Add('   end');
        Sql.Add('else');
        Sql.Add('   begin ');
        Sql.Add('		   update TbEnderecoSetor Set');
        Sql.Add('   			  NmEnderecoSetor = @Descricao');
        Sql.Add('            ,CdProdutoControle = '+IntToStr(FControle.Codigo));
        Sql.Add('            , ExigirLote    = '+vExigirLote);
        Sql.Add('            , SeparacaoConf = '+vConfAuto);
        Sql.Add('   		where CdEnderecoSetor = @Codigo');
        Sql.Add('  	end;');
        Sql.Add('select @Codigo as CdEnderecoSetor;');
        if DebugHook <> 0 then Sql.SaveToFile('EnderecoSetor.Txt');

        ExecSQL;
      End;
      if FCodigo = 0 then pHistorico.Observacao     := 'Inclusão de Novo Setor de Endereço'
      Else pHistorico.Observacao     := 'Alteração do Cadastro de Setor de Endereços';
      pHistorico.CodigoRegistro := FCodigo;
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

procedure TEnderecoSetor.SetProdutoControle(pProdutoControle: TProdutoControle);
begin
  FreeAndNil(FControle);

  FControle := pProdutoControle;

  if (Assigned(FControle) = True) then
    begin
      FProdutoControle := FControle.Codigo;
    end
  else
    begin
      FProdutoControle := 0;
    end;
end;

end.
