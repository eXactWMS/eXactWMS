unit ConfiguracaoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     Rest.Json, System.Json, Rest.Types; //, Vcl.Controls, Vcl.Dialogs

Type

  TConfiguracaoWMS = Class
  private
    FCadClienteIncluir    : Integer;
    FCadFornecedorIncluir : Integer;
    FCadProdutoIncluir    : Integer;
    FCadEntradaIncluir    : Integer;
    FCadRastroIdProdNovo  : Integer;
    FAutorizarAltLote     : Integer;
    FShelfLifeRecebimento : Integer;
    FShelfLifeExpedicao   : Integer;
    FEntradaBloqueioVencimento	: integer;
    FSaidaBloqueioVencimento	  : integer;
    FTagProdutoEntrada          : Integer;
    FStatusFornecedor	          : integer;
    FStatusCliente	            : integer;
    FEnderecarProdutoEntrada    : Integer;
    FCubagemProdutoEntrada      : Integer;
    FEnderecoSegregadoId        : Integer;
    FEnderecoIdVolumeExpedidoCancelado : Integer;
    FEnderecoVolumeExpedidoCancelado   : String;
    FEnderecoIdStage            : Integer;
    FEnderecoIdStageSngpc       : Integer;
    FBalancaPrecisao	           : integer;
    FEsteiraDesvioRota	         : integer;
    FEsteiraDesvioAuditoria	    : integer;
    FEsteiraTipoDesvioAuditoria	: integer;
    FPickingByLight	            : integer;
    FPickingByLightModelo	      : integer;
    FPickingByVoice	            : integer;
    FPickingByVoiceModelo	      : integer;
    FCheckInItem                : Integer;
    FBuscarStage                : Integer;
    FModeloPrinterCodBarra      : String;
    FPortaPrinterCodBarra       : String;
    FModeloPrinterGerencial     : String;
    FPortaPrinterGerencial      : String;
    FMesesParaPreVencido        : Integer;
    //Validações
    //Apanhe - CheckOut
    FRegApanhe                      : Integer;
    FApanheConsolidado              : Integer;
    FModeloEtqVolume                : Integer;
    FPrinterEtqVolumeExtraAuto      : Integer;
    FBeepProdIndividual             : Integer;
    FBeepIndividualLimiteUnid       : Integer;
    FIdentCaixaApanhe               : Integer;
    FOmitirUnidEtqVolume            : Integer;
    FLacreSeguranca                 : Integer;
    FCorteSupervisionado            : Integer;
    FCargaEmTransito                : Integer;
    FVolCxaFechadaExpedicao         : Integer;
    FVolCxaFracionadaExpedicao      : Integer;
    FLoteApanhe                     : Integer;
    FSeparacaoCodInterno            : Integer;
    FReconferirCorteReconferencia   : Integer;
    FExigirReconferenciaToExpedicao : Integer;
    FVolumeAuditoria                : Integer;
    //Inventario
    FInventarioForcarMaxContagem    : Integer;
    FInventarioDivergenciaSegregado : Integer;
    FIntegrarAjusteERP      : Integer;
    FInventarioAjustePadrao : Integer;
    FTagVolumeOrdem      : Integer;
    FReCheckOutUsuario   : Integer;
    FReposicaoColetor    : Integer;
    FReposicaoAutomatica : Integer;
    FReposicaoColetaParaPicking : Integer;
    FEmpresa             : String; //Identificacao do CD
    FSqlclientnetaddress : String;
    FBackupBd            : TDate;
    FAtivarBackup        : Integer;
    FEcraColetor         : Integer;
    FUrlUpdateAPK        : String;
    FMudarPickingEstoquePallet : Integer;
    FExpedicaoOffLine    : Integer; //Nao baixar estoque no momento de registrar na Expedicao, Uma Scherdule na API fará o processo
    //Produtividade
    FCheckInMeta                   : Integer;
    FCheckInTolerancia             : Integer;
    FArmazenagemMeta               : Integer;
    FArmazenagemTolerancia         : Integer;
    FSeparacaoFracionadoMeta       : Integer;
    FSeparacaoFracionadoTolerancia : Integer;
    FCheckoutFracionadoMeta        : Integer;
    FCheckoutFracionadoTolerancia  : Integer;
    FCheckoutCxaFechadaMeta        : Integer;
    FCheckoutCxaFechadaTolerancia  : Integer;
    FExpedicaoMeta                 : Integer;
    FExpedicaoTolerancia           : Integer;
    FReposicaoColetaMeta           : Integer;
    FReposicaoColetaTolerancia     : Integer;
    FDebugDev                      : integer;

    procedure SetCadClienteIncluir(const Value: Integer);
    procedure SetCadFornecedorIncluir(const Value: Integer);
    procedure SetCadProdutoIncluir(const Value: Integer);
    Procedure SetCadEntradaIncluir(Const Value: Integer);

    Procedure SetEntradaBloqueioVencimento(Const Value: Integer);
    Procedure SetSaidaBloqueioVencimento(Const Value: Integer);
    Procedure SetStatusFornecedor(Const Value: Integer);
    Procedure SetStatusCliente(Const Value: Integer);
    Procedure SetPrinterEtqVolumeExtraAuto(Const Value: Integer);
    Procedure SetBalancaPrecisao(Const Value: Integer);
    Procedure SetEsteiraDesvioRota(Const Value: Integer);
    Procedure SetEsteiraDesvioAuditoria(Const Value: Integer);
    Procedure SetEsteiraTipoDesvioAuditoria(Const Value: Integer);
    Procedure SetPickingByLight(Const Value: Integer);
    Procedure SetPickginByLightModelo(Const Value: Integer);
    Procedure SetPickingByVoice(Const Value: Integer);
    Procedure SetPickginByVoiceModelo(Const Value: Integer);
    Procedure SetCheckInItem(Const Value : Integer);
    Procedure SetModeloPrinterCodBarra(Const Value : String);
    Procedure SetPortaPrinterCodBarra(Const Value : string);
    Procedure SetModeloPrinterGerencial(Const Value : String);
    Procedure SetPortaPrinterGerencial(Const Value : String);
  Public
    constructor Create;
    Property CadClienteIncluir    : Integer read FCadClienteIncluir    write SetCadClienteIncluir;
    Property CadFornecedorIncluir : Integer read FCadFornecedorIncluir write SetCadFornecedorIncluir;
    Property CadProdutoIncluir    : Integer read FCadProdutoIncluir    write SetCadProdutoIncluir;
    Property CadEntradaIncluir    : Integer read FCadEntradaIncluir    write SetCadEntradaIncluir;
    Property CadRastroIdProdNovo  : Integer Read FCadRastroIdProdNovo  Write FCadRastroIdProdNovo;
    Property AutorizarAltLote     : Integer Read FAutorizarAltLote     Write FAutorizarAltLote;
    Property ShelfLifeRecebimento : Integer Read FShelfLifeRecebimento Write FShelfLifeRecebimento;
    Property ShelfLifeExpedicao   : Integer Read FShelflifeexpedicao   Write fshelflifeexpedicao;
    Property EntradaBloqueioVencimento	  :	integer	Read FEntradaBloqueioVencimento	 Write SetEntradaBloqueioVencimento;
    Property SaidaBloqueioVencimento	    :	integer	Read FSaidaBloqueioVencimento	   Write SetSaidaBloqueioVencimento;
    Property StatusFornecedor	            :	integer	Read FStatusFornecedor	         Write SetStatusFornecedor;
    Property StatusCliente	              :	integer	Read FStatusCliente	             Write SetStatusCliente;
    Property TagProdutoEntrada            : Integer Read FTagProdutoEntrada          Write FTagProdutoEntrada;
    Property PrinterEtqVolumeExtraAuto	  : integer	Read FPrinterEtqVolumeExtraAuto	 Write SetPrinterEtqVolumeExtraAuto;
    Property BeepProdIndividual           : Integer Read FBeepProdIndividual         Write FBeepProdIndividual;
    Property BeepIndividualLimiteUnid     : Integer Read FBeepIndividualLimiteUnid   Write FBeepIndividualLimiteUnid;
    Property IdentCaixaApanhe             : Integer Read FIdentCaixaApanhe           Write FIdentCaixaApanhe;
    Property OmitirUnidEtqVolume          : Integer Read FOmitirUnidEtqVolume        Write FOmitirUnidEtqVolume;
    Property LacreSeguranca               : Integer Read FLacreSeguranca             Write FLacreSeguranca;
    Property CorteSupervisionado          : Integer Read FCorteSupervisionado        Write FCorteSupervisionado;
    Property CargaEmTransito              : Integer Read FCargaEmTransito            Write FCargaEmTransito;
    Property VolCxaFechadaExpedicao       : Integer Read FVolCxaFechadaExpedicao     Write FVolCxaFechadaExpedicao;
    Property VolCxaFracionadaExpedicao    : Integer Read FVolCxaFracionadaExpedicao  Write FVolCxaFracionadaExpedicao;
    Property LoteApanhe                   : Integer Read FLoteApanhe                 Write FLoteApanhe;
    Property SeparacaoCodInterno          : Integer Read FSeparacaoCodInterno        Write FSeparacaoCodInterno;
    Property 	BalancaPrecisao	            :	integer	Read FBalancaPrecisao	           Write SetBalancaPrecisao;
    Property 	EsteiraDesvioRota	          :	integer	Read FEsteiraDesvioRota	         Write SetEsteiraDesvioRota;
    Property 	EsteiraDesvioAuditoria	    :	integer	Read FEsteiraDesvioAuditoria	   Write SetEsteiraDesvioAuditoria;
    Property 	EsteiraTipoDesvioAuditoria	:	integer	Read FEsteiraTipoDesvioAuditoria Write SetEsteiraTipoDesvioAuditoria;
    Property 	PickingByLight	            :	integer	Read FPickingByLight	           Write SetPickingByLight;
    Property 	PickingByLightModelo	      :	integer	Read FPickingByLightModelo	     Write SetPickginByLightModelo;
    Property 	PickingByVoice	            :	integer	Read FPickingByVoice	           Write SetPickingByVoice;
    Property 	PickingByVoiceModelo	      :	integer	Read FPickingByVoiceModelo	     Write SetPickginByVoiceModelo;
    //Validações
    Property CheckInItem                 : Integer Read FCheckInItem                Write SetCheckInItem;
    Property BuscarStage                 : Integer Read FBuscarStage                Write FBuscarStage;
    Property ModeloPrinterCodBarra       : String  Read FModeloPrinterCodBarra      Write SetModeloPrinterCodBarra;
    Property PortaPrinterCodBarra        : String  Read FPortaPrinterCodBarra       Write SetPortaPrinterCodBarra;
    Property ModeloPrinterGerencial      : String  Read FModeloPrinterGerencial     Write SetModeloPrinterGerencial;
    Property PortaPrinterGerencial       : String  Read FPortaPrinterGerencial      Write SetPortaPrinterGerencial;
    Property MesesParaPreVencido         : Integer Read FMesesParaPreVencido        Write FMesesParaPreVencido;
    Property EnderecarProdutoEntrada     : Integer Read FEnderecarProdutoEntrada    Write FEnderecarProdutoEntrada;
    Property CubagemProdutoEntrada       : Integer Read FCubagemProdutoEntrada      Write FCubagemProdutoEntrada;
    Property EnderecoSegregadoId         : Integer Read FEnderecoSegregadoId        Write FEnderecoSegregadoId;
    Property EnderecoIdVolumeExpedidoCancelado : Integer Read FEnderecoIdVolumeExpedidoCancelado  Write FEnderecoIdVolumeExpedidoCancelado;
    Property EnderecoVolumeExpedidoCancelado   : String  Read FEnderecoVolumeExpedidoCancelado    Write FEnderecoVolumeExpedidoCancelado;
    Property EnderecoIdStage                : Integer Read FEnderecoIdStage            Write FEnderecoIdStage;
    Property EnderecoIdStageSngpc           : Integer Read FEnderecoIdStageSngpc       Write FEnderecoIdStageSngpc;
    //Apanhe - CheckOut
    Property RegApanhe                      : Integer Read FRegApanhe                      Write FRegApanhe;
    Property ModeloEtqVolume                : Integer Read FModeloEtqVolume                Write FModeloEtqVolume;
    Property ApanheConsolidado              : Integer Read FApanheConsolidado              Write FApanheConsolidado;
    Property ReconferirCorteReconferencia   : Integer Read FReconferirCorteReconferencia   Write FReconferirCorteReconferencia;
    Property ExigirReconferenciaToExpedicao : Integer Read FExigirReconferenciaToExpedicao Write FExigirReconferenciaToExpedicao;
    Property VolumeAuditoria                : Integer Read FVolumeAuditoria                Write FVolumeAuditoria;
    Property InventarioForcarMaxContagem    : Integer Read FInventarioForcarMaxContagem    Write FInventarioForcarMaxContagem;
    Property InventarioDivergenciaSegregado : Integer Read FInventarioDivergenciaSegregado Write FInventarioDivergenciaSegregado;
    Property IntegrarAjusteERP              : Integer Read FIntegrarAjusteERP       Write FIntegrarAjusteERP;
    Property InventarioAjustePadrao         : Integer Read FInventarioAjustePadrao  Write FInventarioAjustePadrao;
    Property TagVolumeOrdem              : Integer Read FTagVolumeOrdem             Write FTagVolumeOrdem;
    Property ReCheckOutUsuario           : Integer Read FReCheckOutUsuario          Write FReCheckOutUsuario;
    Property ReposicaoColetor            : Integer Read FReposicaoColetor           Write FReposicaoColetor;
    Property ReposicaoAutomatica         : Integer Read FReposicaoAutomatica        Write FReposicaoAutomatica;
    Property ReposicaoColetaParaPicking  : Integer Read FReposicaoColetaParaPicking Write FReposicaoColetaParaPicking;
    Property Empresa                     : String  Read FEmpresa Write FEmpresa;
    Property Sqlclientnetaddress         : String  Read FSqlclientnetaddress        Write FSqlclientnetaddress;
    Property BackupBd                    : TDate   Read FBackupBd                   Write FBackupBd;
    Property AtivarBackup                : Integer Read FAtivarBackup               Write FAtivarBackup;
    Property EcraColetor                 : integer Read FEcraColetor                Write FEcraColetor;
    Property URLUpdateApk                : String  Read FURLUpdateAPK               Write FURLUpdateApk;
    Property MudarPickingEstoquePallet   : Integer Read FMudarPickingEstoquePallet  Write FMudarPickingEstoquePallet;
    Property ExpedicaoOffLine            : Integer Read FExpedicaoOffLine           Write FExpedicaoOffLine;
    //Produtividade
    Property CheckInMeta                   : Integer Read FCheckInMeta             Write FCheckInMeta;
    Property CheckInTolerancia             : Integer Read FCheckInTolerancia       Write FCheckInTolerancia;
    Property ArmazenagemMeta               : Integer Read FArmazenagemMeta         Write FArmazenagemMeta;
    Property ArmazenagemTolerancia         : Integer Read FArmazenagemTolerancia   Write FArmazenagemTolerancia;
    Property SeparacaoFracionadoMeta       : Integer Read FSeparacaoFracionadoMeta Write FSeparacaoFracionadoMeta;
    Property SeparacaoFracionadoTolerancia : Integer Read FSeparacaoFracionadoTolerancia Write FSeparacaoFracionadoTolerancia;
    Property CheckoutFracionadoMeta        : Integer Read FCheckOutFracionadoMeta        Write FCheckOutFracionadoMeta;
    Property CheckoutFracionadoTolerancia  : Integer Read FCheckOutFracionadoTolerancia  Write FCheckOutFracionadoTolerancia;
    Property CheckoutCxaFechadaMeta        : Integer Read FCheckOutCxaFechadaMeta        Write FCheckOutCxaFechadaMeta;
    Property CheckoutCxaFechadaTolerancia  : Integer Read FCheckOutCxaFechadaTolerancia  Write FCheckOutCxaFechadaTolerancia;
    Property ExpedicaoMeta                 : Integer Read FExpedicaoMeta                 Write FExpedicaoMeta;
    Property ExpedicaoTolerancia           : Integer Read FExpedicaoTolerancia           Write FExpedicaoTolerancia;
    Property ReposicaoColetaMeta           : Integer Read FReposicaoColetaMeta           Write FReposicaoColetaMeta;
    Property ReposicaoColetaTolerancia     : Integer Read FReposicaoColetaTolerancia     Write FReposicaoColetaTolerancia;
    Property DebugDev                      : Integer Read FDebugDev                      Write FDebugDev;

    Class Function ClassToJson(Const ObjConfiguracaoWMS : TConfiguracaoWMS) : String;
    Class Function JsonToClass(jSon : String) : TConfiguracaoWMS;
  End;
implementation

{ TConfiguracao }

uses uFuncoes;       //uDmeXactWMS,

class function TConfiguracaoWMS.ClassToJson(
  const ObjConfiguracaoWMS: TConfiguracaoWMS): String;
begin
  Result := tJson.ObjectToJsonString(ObjConfiguracaoWMS);
end;

constructor TConfiguracaoWMS.Create;
begin
  FCadClienteIncluir          := 0;
  FCadFornecedorIncluir       := 0;
  FCadProdutoIncluir          := 0;
  FCadEntradaIncluir          := 0;
  FCadRastroIdProdNovo        := 0;
  FAutorizarAltLote           := 0;
  FShelfLifeRecebimento       := 0;
  FShelfLifeExpedicao         := 0;
  FEntradaBloqueioVencimento  := 0;
  FSaidaBloqueioVencimento    := 0;
  FStatusFornecedor           := 0;
  FStatusCliente              := 0;
  FTagProdutoEntrada          := 0;
  FEnderecarProdutoEntrada    := 0;
  FCubagemProdutoEntrada      := 0;
  FEnderecoSegregadoId        := 0;
  FEnderecoIdVolumeExpedidoCancelado := 0;
  FEnderecoVolumeExpedidoCancelado   := '';
  FEnderecoIdStage            := 0;
  FEnderecoIdStageSngpc       := 0;
  FPrinterEtqVolumeExtraAuto  := 0;
  FBeepProdIndividual         := 0;
  FBeepIndividualLimiteUnid   := 0;
  FIdentCaixaApanhe           := 0;
  FOmitirUnidEtqVolume        := 0;
  FLacreSeguranca             := 0;
  FCorteSupervisionado        := 0;
  FCargaEmTransito            := 0;
  FVolCxaFechadaExpedicao     := 0;
  FVolCxaFracionadaExpedicao  := 0;
  FLoteApanhe                 := 0;
  FSeparacaoCodInterno        := 0;
  FBalancaPrecisao            := 0;
  FEsteiraDesvioRota          := 0;
  FEsteiraDesvioAuditoria     := 0;
  FEsteiraTipoDesvioAuditoria := 0;
  FPickingByLight             := 0;
  FPickingByLightModelo       := 0;
  FPickingByVoice             := 0;
  FPickingByVoiceModelo       := 0;
  FCheckInItem                := 0;
  FBuscarStage                := 0;
  FModeloPrinterCodBarra      := '';
  FPortaPrinterCodBarra       := '';
  FModeloPrinterGerencial     := '';
  FPortaPrinterGerencial      := '';
  FMesesParaPreVencido        := 6;
  FRegApanhe                  := 0;
  FModeloEtqVolume            := 0;
  FApanheConsolidado          := 0;
  FReconferirCorteReconferencia   := 1;
  FExigirReconferenciaToExpedicao := 0;
  FVolumeAuditoria                := 0;
  FInventarioForcarMaxContagem    := 0;
  FInventarioDivergenciaSegregado := 0;
  FIntegrarAjusteERP              := 0;
  FInventarioAjustePadrao         := -1;
  FTagVolumeOrdem             := 0;
  FReCheckOutUsuario          := 0;
  FReposicaoColetor           := 0;
  FReposicaoAutomatica        := 0;
  FReposicaoColetaParaPicking := 0;
  FEmpresa                    := '';
  FSqlclientnetaddress        := '';
  FBackupBd                   := 0;
  FAtivarBackup               := 0;
  FEcraColetor                := 1;
  FURLUpdateApk               := '';
  FMudarPickingEstoquePallet  := 1;
  FExpedicaoOffLine           := 0;
  //Produtividade
  FArmazenagemMeta               := 0;
  FArmazenagemTolerancia         := 0;
  FSeparacaoFracionadoMeta       := 0;
  FSeparacaoFracionadoTolerancia := 0;
  FCheckoutFracionadoMeta        := 0;
  FCheckoutFracionadoTolerancia  := 0;
  FCheckoutCxaFechadaMeta        := 0;
  FCheckoutCxaFechadaTolerancia  := 0;
  FExpedicaoMeta                 := 0;
  FExpedicaoTolerancia           := 0;
  FReposicaoColetaMeta           := 0;
  FReposicaoColetaTolerancia     := 0;
  FCheckInMeta                   := 0;
  FCheckInTolerancia             := 0;
  FDebugDev                      := 0;
end;

class function TConfiguracaoWMS.JsonToClass(jSon: String): TConfiguracaoWMS;
begin
  Result := tJson.JsonToObject<TConfiguracaoWMS>(jSon);
end;

procedure TConfiguracaoWMS.SetBalancaPrecisao(const Value: Integer);
begin
  FBalancaPrecisao := Value;
end;

procedure TConfiguracaoWMS.SetCadClienteIncluir(const Value: Integer);
begin
  FCadClienteIncluir := Value;
end;

procedure TConfiguracaoWMS.SetCadEntradaIncluir(const Value: Integer);
begin
  FCadEntradaIncluir := Value;
end;

procedure TConfiguracaoWMS.SetCadFornecedorIncluir(const Value: Integer);
begin
  FCadFornecedorIncluir := Value;
end;

procedure TConfiguracaoWMS.SetCadProdutoIncluir(const Value: Integer);
begin
  FCadProdutoIncluir := Value;
end;

procedure TConfiguracaoWMS.SetCheckInItem(const Value: Integer);
begin
  FCheckInItem := Value;
end;

procedure TConfiguracaoWMS.SetEntradaBloqueioVencimento(const Value: Integer);
begin
  FEntradaBloqueioVencimento := Value;
end;

procedure TConfiguracaoWMS.SetEsteiraDesvioAuditoria(const Value: Integer);
begin
  FEsteiraDesvioAuditoria := Value;
end;

procedure TConfiguracaoWMS.SetEsteiraDesvioRota(const Value: Integer);
begin
  FEsteiraDesvioRota := Value;
end;

procedure TConfiguracaoWMS.SetEsteiraTipoDesvioAuditoria(const Value: Integer);
begin
  FEsteiraTipoDesvioAuditoria := value;
end;

procedure TConfiguracaoWMS.SetModeloPrinterCodBarra(const Value: String);
begin
  FModeloPrinterCodBarra := Value;
end;

procedure TConfiguracaoWMS.SetModeloPrinterGerencial(const Value: String);
begin
  FModeloPrinterGerencial := Value;
end;

procedure TConfiguracaoWMS.SetPickginByLightModelo(const Value: Integer);
begin
  FPickingByLightModelo := value;
end;

procedure TConfiguracaoWMS.SetPickginByVoiceModelo(const Value: Integer);
begin
  FPickingByVoiceModelo := Value;
end;

procedure TConfiguracaoWMS.SetPickingByLight(const Value: Integer);
begin
  FPickingByLight := Value;
end;

procedure TConfiguracaoWMS.SetPickingByVoice(const Value: Integer);
begin
  FPickingByVoice := Value;
end;

procedure TConfiguracaoWMS.SetPortaPrinterCodBarra(const Value: string);
begin
  FPortaPrinterCodBarra := Value;
end;

procedure TConfiguracaoWMS.SetPortaPrinterGerencial(const Value: String);
begin
  FPortaPrinterGerencial := Value;
end;

procedure TConfiguracaoWMS.SetPrinterEtqVolumeExtraAuto(const Value: Integer);
begin
  FPrinterEtqVolumeExtraAuto := Value;
end;

procedure TConfiguracaoWMS.SetSaidaBloqueioVencimento(const Value: Integer);
begin
  FSaidaBloqueioVencimento := Value;
end;

procedure TConfiguracaoWMS.SetStatusCliente(const Value: Integer);
begin
  FStatusCliente := Value;
end;

procedure TConfiguracaoWMS.SetStatusFornecedor(const Value: Integer);
begin
  FStatusFornecedor := Value;
end;

end.
