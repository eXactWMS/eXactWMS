unit uTRuaPicking;

interface

uses System.Classes, uTHistorico, uDmCadastroGeral;

Type TRuaPicking = Class
    private
      FCodigo     : Integer;
      FDescricao  : string;
    public
      property Codigo    : Integer                read FCodigo                write FCodigo;
      property Descricao : string                 read FDescricao             write FDescricao;

      class function PegarRuaPicking(pCodigo: Integer)       : TRuaPicking;
      class function Pesquisar(pCodigo, pDescricao: string)  : OleVariant;
      class function ListarRuaPicking: OleVariant;
      class function ListarEndereco(pCodigo : String) : OleVariant;
      class function ListarEnderecoAVincular(Endereco1, Endereco2, EnderecoRua : String; Save : Boolean) : TStringList;

      procedure Salvar(pHistorico: THistorico);
      class procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
  end;

implementation

uses uDmFornecedor, SysUtils, DBClient, DB;

{ TRuaPicking }

class procedure TRuaPicking.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    With DmCadastroGeral.qryVinculos do Begin
      Close;
      Sql.Clear;
      Sql.Add('Select Count(*) TotReg From TbEndereco Where CdEnderecoRua = '+IntToStr(pCodigo));
      Open;
      if FieldByName('TotReg').AsInteger > 0 then Begin
       		raise Exception.Create('Procedimento não autorizado. Existem endereço(s) vinculado(s) a esta Rua.');
         Exit;
      End;
    End;
    With DmCadastroGeral.qryExcluir do Begin
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;
      Close;
      Sql.Clear;
      Sql.Add('Delete From TbEnderecoRua Where CdEnderecoRua = '+IntToStr(pCodigo));
      ExecSQL;

      pHistorico.CodigoRegistro := pCodigo;
      pHistorico.Observacao     := 'Exclusão do Tipo de Entrada';
      pHistorico.Salvar;
      Connection.CommitTrans;
    End;
  except
    DmCadastroGeral.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Operação inválida!' + #13 +
                           'Existem vínculos que impedem a exclusão desta Rua de Picking.');
  end;
end;

class function TRuaPicking.ListarEndereco(pCodigo: String) : OleVariant;
begin
  if pCodigo = '' then pCodigo := '-1';
  With DmCadastroGeral.qryPesquisar do Begin
    Close;
    Sql.Clear;
    Sql.Add('Select NmEndereco, NmEnderecoRua, NmEnderecoSetor, CdEndereco, CdEnderecoRua');
    Sql.Add('From vEndereco');
    Sql.Add('Where CdEnderecoRua = '+pCodigo);
    Sql.Add('Order By NmEnderecoRua Desc');
    Open;
    Result := DmCadastroGeral.dspPesquisar.Data;
  End;
end;

class function TRuaPicking.ListarEnderecoAVincular(Endereco1, Endereco2, EnderecoRua : String; Save : Boolean): TStringList;
begin
  Result := TStringList.Create;
  With DmCadastroGeral.qryPesquisar do Begin
    Close;
    Sql.Clear;
    if Save Then Begin
       Sql.Add('Update TbEndereco');
       Sql.Add('  Set CdEnderecoRua = '+EnderecoRua);
       Sql.Add('Where NmEndereco >= '+Endereco1+' and NmEndereco <= '+Endereco2+';');
       Sql.Add(' ');
       Sql.Add('Update Endereco Set Rua ='+EnderecoRua);
       Sql.Add('Where Localizacao >= '+Endereco1+' and Localizacao <= '+Endereco2+';');

       Try
         ExecSql;
         Result.add('Ok');
       Except
         Result.Add('ERRO');
       End;
    End
    Else Begin
       Sql.Add('Select NmEndereco as Endereco, NmEnderecoRua as Rua, NmEnderecoSetor as Setor');
       Sql.Add('From VEndereco');
       Sql.Add('Where NmEndereco >= '+Endereco1+' and NmEndereco <= '+Endereco2);
       Sql.Add('Order By NmEndereco');
       Open;
       while Not Eof do Begin
         Result.Add(FieldByName('Endereco').AsString+' '+FieldByName('Rua').AsString+' '+
         FieldByName('Setor').AsString);
         Next;
       End;
    End;
  End;
end;

class function TRuaPicking.ListarRuaPicking: OleVariant;
begin
  With DmCadastroGeral.qryPesquisar do Begin
    Close;
    Sql.Clear;
    Sql.Add('Select NmEnderecoRua, CdEnderecoRua From TbEnderecoRua');
    Sql.Add('Where CdEnderecoRua <> 0');
    Sql.Add('Order by CdEnderecoRua');
    Open;
    Result := DmCadastroGeral.dspPesquisar.Data;
  End;
end;

class function TRuaPicking.PegarRuaPicking(pCodigo: Integer): TRuaPicking;
var
  vlPesquisar  : TClientDataSet;
  vlRuaPicking : TRuaPicking;
begin
  vlPesquisar := TClientDataSet.Create(nil);

  try
    vlPesquisar.Close;
    vlPesquisar.Data := Pesquisar(IntToStr(pCodigo), '');

    if (vlPesquisar.IsEmpty = True) then
    	begin
    		raise Exception.Create('Código de Rua Picking inválido!');
    	end;

    vlRuaPicking           := TRuaPicking.Create;
    vlRuaPicking.Codigo    := vlPesquisar.FieldByName('CdEnderecoRua').AsInteger;
    vlRuaPicking.Descricao := vlPesquisar.FieldByName('nmEnderecoRua').AsString;

    Result := vlRuaPicking;
  finally
    FreeAndNil(vlPesquisar);
  end;
end;

class function TRuaPicking.Pesquisar(pCodigo, pDescricao: string): OleVariant;
begin
  With DmCadastroGeral.qryPesquisar do Begin
     Close;
     Sql.Clear;
     Sql.Add('Select * From TbEnderecoRua');
     if pCodigo <> '' then Sql.Add('Where CdEnderecoRua = '+pCodigo)
     Else Sql.Add('Where NmEnderecoRua like '+QuotedStr('%'+pDescricao+'%'));
     Open;
     Result := DmCadastroGeral.dspPesquisar.Data;
   End;
end;

procedure TRuaPicking.Salvar(pHistorico: THistorico);
Begin
  With DmCadastroGeral do Begin
    QrySalvar.Connection.Execute('SET NOCOUNT ON;');
    QrySalvar.Connection.BeginTrans;
    try
      With QrySalvar do Begin
        Close;
        Sql.Clear;
        Sql.Add('Declare @Codigo As Integer = '+IntToStr(FCodigo)+';');
        Sql.Add('Declare @Descricao As VarChar(255) = '+QuotedStr(FDescricao)+';');
        Sql.Add('if (@Codigo = 0)');
        Sql.Add('   Begin');
        Sql.Add('		   set @Codigo = (select coalesce(MAX(CdEnderecoRua), 0) + 1 from TbEnderecoRua);');
        Sql.Add('		   insert into TbEnderecoRua(CdEnderecoRua, NmEnderecoRua) Values ('	);
        Sql.Add('         			@Codigo, @Descricao);');
        Sql.Add('  	end');
        Sql.Add('else');
        Sql.Add('   begin ');
        Sql.Add('		   update TbEnderecoRua Set');
        Sql.Add('     			CdEnderecoRua = @Codigo');
        Sql.Add('   			 ,NmEnderecoRua = @Descricao');
        Sql.Add('   		where CdEnderecoRua = @Codigo');
        Sql.Add('  	end;');
        Sql.Add('select @Codigo as CdEnderecoRua;');
        if DebugHook <> 0 then Sql.SaveToFile('RuaPicking.Txt');

        ExecSQL;
      End;
      pHistorico.CodigoRegistro := FCodigo;
      pHistorico.Observacao     := 'Alteração do Cadastro de Rua de Picking';
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

end.
