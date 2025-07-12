unit uTMovtoEstoque;

interface

uses SysUtils, uTEstoque, uTEndereco, uDmCadastroGeral, Variants;

type

  TMovimentacaoTipo = class
    private
      FCodigo : Integer;
      FNome   : string;
      FOperacaoEstoque : TOperacaoEstoque;
    public
      property Codigo : Integer          Read FCodigo Write FCodigo;
      property Nome   : string           Read FNome   Write FNome;
      Property OperacaoEstoque : TOperacaoEstoque Read FOperacaoEstoque   Write FOperacaoEstoque;
  end;

  TMovimentacao = class
    private
      FCodigo: Int64;
      FCodigoMotivo: Integer;
      FCodigoUsuario: Integer;
      FCodigoLote: Integer;
      FCodigoEnderecoOrigem: Integer;
      FCodigoEnderecoDestino: Integer;
      FDataHora: TDateTime;
      FOrigem: string;
      FDestino: string;
      FQtdMovimentada: Integer;
      FQtdFinalOrigem: Integer;
      FQtdFinalDestino: Integer;
      FFlagIntegracao: Boolean;
      FEstoqueOrigem  : TTipoEstoque;
      FEstoqueDestino : TTipoEstoque;
      //FTipo: TMovimentacaoTipo; //Substituir pela operacao Abaixo.
      FOperacaoEstoque : TOperacaoEstoque;
      procedure SalvarEntrada;
      procedure SalvarInterna;
      procedure SalvarSaida;
    public
      property Codigo: Int64                    read FCodigo                  write FCodigo;
      property CodigoMotivo: Integer            read FCodigoMotivo            write FCodigoMotivo;
      property CodigoUsuario: Integer           read FCodigoUsuario           write FCodigoUsuario;
      property CodigoLote: Integer              read FCodigoLote              write FCodigoLote;
      property CodigoEnderecoOrigem: Integer    read FCodigoEnderecoOrigem    write FCodigoEnderecoOrigem;
      property CodigoEnderecoDestino: Integer   read FCodigoEnderecoDestino   write FCodigoEnderecoDestino;
      property DataHora: TDateTime              read FDataHora;
      property Origem: string                   read FOrigem                  write FOrigem;
      property Destino: string                  read FDestino                 write FDestino;
      property QtdMovimentada: Integer          read FQtdMovimentada          write FQtdMovimentada;
      property QtdFinalOrigem: Integer          read FQtdFinalOrigem;
      property QtdFinalDestino: Integer         read FQtdFinalDestino;
      //property Tipo: TMovimentacaoTipo          read FTipo                    write FTipo;
      property FlagIntegracao: Boolean          read FFlagIntegracao          write FFlagIntegracao;
      property EstoqueOrigem: TTipoEstoque      read FEstoqueOrigem           write FEstoqueOrigem;
      property EstoqueDestino: TTipoEstoque     read FEstoqueDestino          write FEstoqueDestino;
      Property OperacaoEstoque : TOperacaoEstoque Read FOperacaoEstoque       Write FOperacaoEstoque;

      constructor Create;
      destructor Destroy; override;

      Procedure Salvar(pOperacaoEstoque : TOperacaoEstoque = OperacaoUndefined);
      Procedure MovimentarEstoque;
      Class Procedure MovStageTo(pCdLote, pCdEndereco, pQtde, pCdUsuario : Integer; pEstacao, pVersao : String);
      Class Procedure MovEstoque(pCdLote, pCdEnderecoOrigem, pCdEnderecoDest, pQtde, pCdUsuario : Integer; pEstacao, pVersao : String);
      Class Function HistoricoMovimentacao(pCdProduto : Int64; pDatainicio , pDataFinal : String) : OleVariant;
      Class Function HistoricoMovimentacaoInterna(pCdProduto : Int64; pDatainicio , pDataFinal : String) : OleVariant;
  end;

implementation

uses uDmMovtoEstoque, uTUsuario;
{
 uTEstoqueSegregado, uTEstoqueEspera,
   uTEstoqueCrossDocking, uTEstoqueExpedicao,
   uTEstoqueReserva;

}
{ TMovimentacao }

constructor TMovimentacao.Create;
begin
{  FTipo            := TMovimentacaoTipo.Create;
  FTipo.Codigo     := 0;
  FTipo.Nome       := '';
}  FOperacaoEstoque := OperacaoUndefined;

  FEstoqueOrigem   := TipoUndefined;
  FEstoqueDestino  := TipoUndefined;
  FOperacaoEstoque := OPeracaoUndefined;
  FFlagIntegracao  := False;
end;

destructor TMovimentacao.Destroy;
begin
//  FreeAndNil(FTipo);
  FreeAndNil(FEstoqueOrigem);
  FreeAndNil(FEstoqueDestino);

  inherited;
end;

Class function TMovimentacao.HistoricoMovimentacao(pCdProduto: Int64; pDatainicio,
  pDataFinal: String): OleVariant;
begin
  With dmMovimentacao.QryHistoricoMovimentacao do Begin
    Close;
    Prepared := True;
    Parameters.ParamByName('pCdProduto').Value  := pCdProduto;
    Parameters.ParamByName('pDataInicio').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDataInicio));
    Parameters.ParamByName('pDataFinal').Value  := FormatDateTime('YYYY-MM-DD', StrToDate(pDataFinal));
    Open;
  End;
  Result := dmMovimentacao.DspHistoricoMovimentacao.data;
end;

Class function TMovimentacao.HistoricoMovimentacaoInterna(pCdProduto: Int64; pDatainicio,
  pDataFinal: String): OleVariant;
begin
  With dmMovimentacao.QryHistoricoMovimentacaoInterna do Begin
    Close;
    Parameters.ParamByName('pCdProduto').Value  := pCdProduto;
    Parameters.ParamByName('pDataInicio').Value := FormatDateTime('YYYY-MM-DD', StrToDate(pDataInicio));
    Parameters.ParamByName('pDataFinal').Value  := FormatDateTime('YYYY-MM-DD', StrToDate(pDataFinal));
    Open;
  End;
  Result := dmMovimentacao.DspHistoricoMovimentacaoInterna.data;
end;

class procedure TMovimentacao.MovEstoque(pCdLote, pCdEnderecoOrigem,
  pCdEnderecoDest, pQtde, pCdUsuario: Integer; pEstacao, pVersao: String);
Var vlTransacaoInterna: Boolean;
    Problema : Boolean;
    Tentativa : Integer;begin
  Problema  := True;
  Tentativa := 1;
  Repeat
    vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação
    try // except
      With DmMovimentacao.QryMovEstoque do begin
        Close;
        if (Connection.InTransaction = False) then begin
          vlTransacaoInterna := True;
          Connection.Execute('SET NOCOUNT ON;');
          //Connection.BeginTrans;
        end;
      Parameters.ParamByName('pCdLote').Value     := pCdLote;
      Parameters.ParamByName('pCdEnderecoOrigem').Value := pCdEnderecoOrigem;
      Parameters.ParamByName('pCdEnderecoDest').Value   := pCdEnderecoDest;
      Parameters.ParamByName('pQtde').Value       := pQtde;
      Parameters.ParamByName('pCdUsuario').Value  := pCdusuario;
      Parameters.ParamByName('pEstacao').Value    := pEstacao;
      Parameters.ParamByName('pVersao').Value     := pVersao;
      //SaveToFile('MovFlowRackToPallet.Sql');
      ExecSQL;
      //if (vlTransacaoInterna = True) then Connection.CommitTrans;
      Problema := False;
      end;
    except on e: Exception do
      begin
//        raise Exception.Create('Informe este ERRO: '+E.Message);
        if (vlTransacaoInterna = True) then Begin
           //dmMovimentacao.QryMovEstoque.Connection.RollbackTrans;
        End;
        Inc(Tentativa);
        if Tentativa > 5 then
           raise Exception.Create(e.Message);
        Sleep(1000);
      end;
    end;
  Until (Not Problema) or (Tentativa > 5);
end;

Class procedure TMovimentacao.MovStageTo(pCdLote, pCdEndereco, pQtde,
  pCdUsuario: Integer; pEstacao, pVersao : String);
Var vlTransacaoInterna: Boolean;
    Problema : Boolean;
    Tentativa : Integer;begin
  Problema  := True;
  Tentativa := 1;
  Repeat
    vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação
    try // except
      With DmMovimentacao.QryMovStageTo do begin
        Close;
        if (Connection.InTransaction = False) then begin
          vlTransacaoInterna := True;
          Connection.Execute('SET NOCOUNT ON;');
          //Connection.BeginTrans;
        end;
      Parameters.ParamByName('pCdLote').Value     := pCdLote;
      Parameters.ParamByName('pCdEndereco').Value := pCdEndereco;
      Parameters.ParamByName('pQtde').Value       := pQtde;
      Parameters.ParamByName('pCdUsuario').Value  := pCdusuario;
      Parameters.ParamByName('pEstacao').Value    := pEstacao;
      Parameters.ParamByName('pVersao').Value     := pVersao;
      ExecSQL;
      //if (vlTransacaoInterna = True) then Connection.CommitTrans;
      Problema := False;
      end;
    except on e: Exception do
      begin
//        raise Exception.Create('Informe este ERRO: '+E.Message);
        if (vlTransacaoInterna = True) then Begin
           //dmMovimentacao.QryMovStageTo.Connection.RollbackTrans;
        End;
        Inc(Tentativa);
        if Tentativa > 5 then
           raise Exception.Create(e.Message);
        Sleep(1000);
      end;
    end;
  Until (Not Problema) or (Tentativa > 5);
end;

procedure TMovimentacao.Salvar(pOperacaoEstoque : TOperacaoEstoque);
Var vlTransacaoInterna: Boolean;
    Problema : Boolean;
    Tentativa : Integer;
    vEndAreaEspera : Integer;
begin
  if Self.FOperacaoEstoque = OperacaoUndefined then
     raise Exception.Create('Tipo de Operação com Estoque não definida. Operação inválida!');
  Problema  := True;
  Tentativa := 1;
  Repeat
    vlTransacaoInterna := False; // Esta variável é para verificar se este método foi chamado dentro de outra transação
    try // except
      dmMovimentacao.qrySalvar.Close;
      if (dmMovimentacao.qrySalvar.Connection.InTransaction = False) then
        begin
          vlTransacaoInterna := True;
          dmMovimentacao.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
          dmMovimentacao.qrySalvar.Connection.BeginTrans;
        end;
{      case FTipo.Codigo of
        1: SalvarEntrada; // Movimentação de Entrada
        2: SalvarInterna; // Movimentação Interna
        3: SalvarSaida;   // Movimentação de Saída
      end;
}      MovimentarEstoque;
      if FCodigoEnderecoOrigem = 0 then
         vEndAreaEspera := 0;//TEndereco.PegarEndereco(0, '99999999').Codigo;
      dmMovimentacao.qrySalvar.Close;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pCdUsuario').Value          := FCodigoUsuario;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pCdLote').Value             := FCodigoLote;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pEstoqueOrigem').Value      := Ord(Self.EstoqueOrigem); //FEstoqueOrigem.Codigo;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pOrigem').Value             := FOrigem;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pCdEnderecoOrigem').Value   := FCodigoEnderecoOrigem;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pEstoqueDestino').Value     := Ord(Self.EstoqueDestino); //FEstoqueDestino.Codigo;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pDestino').Value            := FDestino;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pCdEnderecoDestino').Value  := FCodigoEnderecoDestino;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pQtMovimentada').Value      := FQtdMovimentada;
      case Self.FOperacaoEstoque of
       Entrada: dmMovimentacao.qrySalvar.Parameters.ParamByName('pCdMovimentacaoTipo').Value := 1;
       Saida:   dmMovimentacao.qrySalvar.Parameters.ParamByName('pCdMovimentacaoTipo').Value := 2;
       Interna: dmMovimentacao.qrySalvar.Parameters.ParamByName('pCdMovimentacaoTipo').Value := 3;
      end;
      dmMovimentacao.qrySalvar.Parameters.ParamByName('pFlgIntegracao').Value      := Ord(FFlagIntegracao);
      dmMovimentacao.qrySalvar.ExecSQL;
      if (vlTransacaoInterna = True) then Begin
         dmMovimentacao.qrySalvar.Connection.CommitTrans;
      End;
      Problema := False;
    except on e: Exception do
      begin
//        raise Exception.Create('Informe este ERRO: '+E.Message);
        if (vlTransacaoInterna = True) then Begin
           dmMovimentacao.qrySalvar.Connection.RollbackTrans;
        End;
        Inc(Tentativa);
        if Tentativa > 5 then
           raise Exception.Create(e.Message);
        Sleep(1000);
      end;
    end;
  Until (Not Problema) or (Tentativa > 5);
end;


procedure TMovimentacao.MovimentarEstoque;
Var ObjEstoque : TEstoque;
begin
  ObjEstoque := TEstoque.Create;
  case (Self.FOperacaoEstoque) of
    Entrada: Begin
      If Self.FEstoqueOrigem = Segregado then Begin//Retirar/Baixar do Segregado
         ObjEstoque.Tipo := Segregado;
         ObjEstoque.Salvar(0, CodigoLote, (FQtdMovimentada * -1), FCodigoMotivo); //FcodigoMotivo referente a segregação
      End;
      ObjEstoque.Tipo := Self.FEstoqueDestino;
      ObjEstoque.Salvar(FCodigoEnderecoDestino, FCodigoLote, FQtdMovimentada, FCodigoMotivo); //FcodigoMotivo referente a segregação
    End;

    Saida: Begin
      //Origem
      ObjEstoque.Tipo := Self.FEstoqueOrigem;
      ObjEstoque.Salvar(FCodigoEnderecoOrigem, FCodigoLote, (FQtdMovimentada-1), FCodigoMotivo); //FcodigoMotivo referente a segregação
      If Self.FEstoqueOrigem = Segregado then Begin//Retirar/Baixar do Segregado
         ObjEstoque.Tipo := Segregado;
         ObjEstoque.Salvar(0, CodigoLote, (FQtdMovimentada * -1), FCodigoMotivo); //FcodigoMotivo referente a segregação
      End;

    End;

    Interna: Begin
      //Origem
      ObjEstoque.Tipo := Self.FEstoqueOrigem;
      ObjEstoque.Salvar(FCodigoEnderecoOrigem, FCodigoLote, (FQtdMovimentada-1), FCodigoMotivo); //FcodigoMotivo referente a segregação
      //Destino
      ObjEstoque.Tipo := Self.FEstoqueOrigem;
      ObjEstoque.Salvar(FCodigoEnderecoDestino, FCodigoLote, FQtdMovimentada, FCodigoMotivo); //FcodigoMotivo referente a segregação
    End;
  end;
  FreeAndNil(ObjEstoque);
end;

procedure TMovimentacao.SalvarSaida;
begin
  raise Exception.Create('Chamada de Função inválida. SalvarSaida');

{  // Atualizar a Origem
  case FEstoqueOrigem.Codigo of
    1: TEstoqueEspera.Salvar(FCodigoLote, (FQtdMovimentada * -1));       // 1 = Área de Espera
    2: TEstoqueCrossDocking.Salvar(FCodigoLote, (FQtdMovimentada * -1)); // 2 = Cross Docking
    5: TEstoqueExpedicao.Salvar(FCodigoLote, (FQtdMovimentada * -1));    // 5 = Expedição
    6: TEstoqueProducao.Salvar(Self.CodigoEnderecoDestino, FCodigoLote, (FQtdMovimentada * -1));    // 5 = Expedição
  end;

  // Atualizar o Destino
  case FEstoqueDestino.Codigo of
    3: TEstoqueSegregado.Salvar(FCodigoLote, FCodigoMotivo, FQtdMovimentada); // 3 = Expedição
  end;
}end;

procedure TMovimentacao.SalvarEntrada;
begin
  raise Exception.Create('Chamada de Função inválida. SalvarEntrada');
{  // Atualizar a Origem
  case FEstoqueOrigem.Codigo of
    3: TEstoqueSegregado.Salvar(FCodigoLote, FCodigoMotivo, (FQtdMovimentada * -1)); // 3 = Segregado
  end;

  // Atualizar o Destino
  case FEstoqueDestino.Codigo of
    1: TEstoqueEspera.Salvar(FCodigoLote, FQtdMovimentada);       // 1 = Área de Espera
    2: TEstoqueCrossDocking.Salvar(FCodigoLote, FQtdMovimentada); // 2 = Cross Docking
    6: TEstoqueProducao.Salvar(FCodigoEnderecoDestino, FCodigoLote, fQtdMovimentada);  //EstoqueProducao  // 6 = Picking - Devolução de Loja
  end;
}end;

procedure TMovimentacao.SalvarInterna;
begin
  raise Exception.Create('Chamada de Função inválida. SalvarInterna');
{  // Atualizar origem

  case FEstoqueOrigem.Codigo of
    1: TEstoqueEspera.Salvar(FCodigoLote, (FQtdMovimentada * -1));                          // 1 = Área de Espera
    2: TEstoqueCrossDocking.Salvar(FCodigoLote, (FQtdMovimentada * -1));                    // 2 = Cross Docking
    4: TEstoqueProducao.Salvar(FCodigoEnderecoOrigem, FCodigoLote, (FQtdMovimentada * -1)); // 4 = Produção
    5: TEstoqueExpedicao.Salvar(FCodigoLote, (FQtdMovimentada * -1));                       // 5 = Expedição
    7: Begin //Reposição de Picking por Coletor
       if FCodigoEnderecoOrigem = 0 then Begin
          TEstoqueReserva.MoveByPicking(FCodigoLote, FQtdMovimentada, 0);
          TEstoqueEspera.Salvar(FCodigoLote, (FQtdMovimentada * -1));                           // 1 = Área de Espera
          End
       Else Begin
          TEstoqueReserva.MoveByPicking(FCodigoLote, FQtdMovimentada, FCodigoEnderecoOrigem);
          TEstoqueProducao.Salvar(FCodigoEnderecoOrigem, FCodigoLote, (FQtdMovimentada * -1));
       End;
    End;
  end;

  // Atualizar destino
  case FEstoqueDestino.Codigo of
    1: TEstoqueEspera.Salvar(FCodigoLote, FQtdMovimentada);                           // 1 = Área de Espera
    2: TEstoqueCrossDocking.Salvar(FCodigoLote, FQtdMovimentada);                     // 2 = Cross Docking
    4: TEstoqueProducao.Salvar(FCodigoEnderecoDestino, FCodigoLote, FQtdMovimentada); // 4 = Produção
    5: TEstoqueExpedicao.Salvar(FCodigoLote, FQtdMovimentada);                        // 5 = Expedição
  end;
}end;

end.
