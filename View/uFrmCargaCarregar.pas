unit uFrmCargaCarregar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.JSON, REST.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, DataSet.Serialize,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, Vcl.Buttons, JvToolEdit, JvBaseEdits, CargasCtrl, System.Generics.Collections,
  Vcl.Samples.Gauges, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase, ACBrETQ,
  Vcl.ComCtrls, Vcl.DBGrids, dxCameraControl;

type
  TFrmCargaCarregar = class(TFrmBase)
    Label2: TLabel;
    EdtCargaId: TJvCalcEdit;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    JvCalcEdit2: TJvCalcEdit;
    Label4: TLabel;
    PnlGridBottom: TPanel;
    PnlCliente: TPanel;
    Label5: TLabel;
    EdtPessoaCarregamento: TEdit;
    EdtProxPessoaCarregamento: TEdit;
    Label6: TLabel;
    LstAdvPedidos: TAdvStringGrid;
    LstAdvClientes: TAdvStringGrid;
    EdtVolumeId: TJvCalcEdit;
    Label7: TLabel;
    EdtPessoaId: TJvCalcEdit;
    EdtRazao: TEdit;
    FdMemClientes: TFDMemTable;
    GProcCarregamento: TGauge;
    Label16: TLabel;
    Label13: TLabel;
    LblProcesso: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtCargaIdExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtCargaIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtVolumeIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    ObjCargaCarregarCtrl : TCargasCtrl;
    Procedure MontaListaCarga(pJsonArray : TJsonArray);
    Procedure GetListaCarga(pCargaId : Integer; pDataInicial, pDataFinal : TDateTime;
                        pRota, pTransportadora, pMotorista : String; pVeiculoId : Integer; pPlaca, pProcesso : String);
    Procedure IniciarCarregamento;
    Procedure MontaPedidos(pJsonArray : TJsonArray);
    Procedure MontaClientes(pJsonArray : TJsonArray);
    Procedure ConferirVolume(Const pVolumeId : Integer);
  Protected
    Function DeleteReg : Boolean; OverRide;
    Procedure ShowDados; override;
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmCargaCarregar: TFrmCargaCarregar;

implementation

{$R *.dfm}

uses uFuncoes, uFrmeXactWMS;

procedure TFrmCargaCarregar.ConferirVolume(const pVolumeId: Integer);
Var xLista : Integer;
    pJsonCarregamento, pJsonFinalizar : TJsonObject;
    vErro : String;
 begin
   if FdMemPesqGeral.Locate('pedidovolumeid', EdtVolumeId.Text, [loPartialkey]) then Begin
      if FdMemPesqGeral.FieldByName('Conferido').AsInteger = 1 then Begin
         ShowErro('Volume('+EdtVolumeId.Text+') já carregado!');
         EdtVolumeId.Clear;
      End
      Else if FdMemPesqGeral.FieldByName('PessoaId').AsInteger <> StrToInt(EdtPessoaId.Text) then Begin
         ShowErro('O Volume('+EdtVolumeId.Text+') não pertence ao cliente '+EdtRazao.Text+'!');
         EdtVolumeId.Clear;
      End
     Else Begin
        for xLista := 1 to Pred(LstAdvPedidos.RowCount) do Begin
          if LstAdvPedidos.Cells[0, xLista]  = FdMemPesqGeral.FieldByName('PedidoId').AsString then Begin
             pJsonCarregamento := TJsonObject.Create();
             pJsonCarregamento.AddPair('cargaid', TJsonNumber.Create(StrToInt(EdtCargaId.Text)));
             pJsonCarregamento.AddPair('volumeid', TJsonNumber.Create(StrToInt(EdtVolumeId.Text)));
             pJsonCarregamento.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
             pjsonCarregamento.AddPair('terminal', NomeDoComputador);
             if ObjCargaCarregarCtrl.RegistrarCarregamento(pJsonCarregamento).tryGetValue<String>('Erro', vErro) then Begin
                ShowErro('😢Erro: '+vErro);
                Player('toast4');
                EdtVolumeId.Clear;
                pJsonCarregamento := Nil;
                Break;
             End;
             LstAdvPedidos.Cells[4, xLista] := (StrToInt(LstAdvPedidos.Cells[4, xLista]) + 1).ToString();
             FdMemPesqGeral.Edit;
             FdMemPesqGeral.FieldByName('Conferido').AsInteger := 1;
             FdMemPesqGeral.Post;
             gProcCarregamento.Progress := gProcCarregamento.Progress + 1;
             if LstAdvPedidos.Cells[4, xLista].ToInteger = LstAdvPedidos.Cells[3, xLista].ToInteger then Begin
                LstAdvPedidos.Colors[0, xLista] := clGreen;
                LstAdvPedidos.Colors[1, xLista] := clGreen;
                LstAdvPedidos.Colors[2, xLista] := clGreen;
                LstAdvPedidos.Colors[3, xLista] := clGreen;
                LstAdvPedidos.Colors[4, xLista] := clGreen;
                FdMemClientes.Next;
                if (FdMemClientes.Eof) Then Begin
                   pJsonFinalizar := TJsonObject.Create();
                   pJsonFinalizar.AddPair('cargaid', TJsonNumber.Create(StrToInt(EdtCargaId.Text)));
                   pJsonFinalizar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
                   pJsonFinalizar.AddPair('terminal', NomeDoComputador);
                   If ObjCargaCarregarCtrl.FinalizarCarregamento(pJsonFinalizar).tryGetValue<String>('Erro', vErro) then
                      ShowErro(vErro)
                   Else Begin
                     Confirmacao('Carregamento', 'Carregamento Finalizado!', False);
                     Limpar;
                     EdtCargaId.ReadOnly := False;
                     EdtCargaId.Enabled  := True;
                     EdtCargaId.SetFocus;
                   End;
                End
                Else begin
                   EdtPessoaId.Text := FdMemClientes.FieldByName('PessoaId').AsString;
                   EdtRazao.Text    := FdMemClientes.FieldByName('Razao').AsString;
                end;
             End
             Else Begin
                LstAdvPedidos.Colors[0, xLista] := clYellow;
                LstAdvPedidos.Colors[1, xLista] := clYellow;
                LstAdvPedidos.Colors[2, xLista] := clYellow;
                LstAdvPedidos.Colors[3, xLista] := clYellow;
                LstAdvPedidos.Colors[4, xLista] := clYellow;
             End;
             EdtVolumeId.Clear;
             pJsonCarregamento := Nil;
             pJsonFinalizar    := Nil;
             Break;
          End;
        End;
     End;
  End
  Else Begin
     ShowErro('Volume('+EdtVolumeId.Text+') não pertence a essa carga!');
     EdtVolumeId.Clear;
  End
end;

function TFrmCargaCarregar.DeleteReg: Boolean;
Var JsonObjecRetorno : TJsonObject;
    vErro : String;
begin
  JsonObjecRetorno := ObjCargaCarregarCtrl.CancelarCarregamento(ObjCargaCarregarCtrl.ObjCargas.cargaid);
  if JsonObjecRetorno.TryGetValue('erro', vErro) then
     ShowErro('Erro', vErro)
  Else
     ShowOk('Carga Excluída com sucesso!');
end;

procedure TFrmCargaCarregar.EdtCargaIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmCargaCarregar.EdtCargaIdKeyPress(Sender: TObject; var Key: Char);
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
Begin
  inherited;
  if (Key = #13) and (Not EdtCargaId.ReadOnly) and (EdtCargaId.Text<>'') then Begin
     Limpar;
     if EdtCargaId.Value <= 0 then
        raise Exception.Create('Id inválido para pesquisa!');
     JsonArrayRetorno := ObjCargaCarregarCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', '', 0, '', '', 0);
     if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
        ShowErro('😢Erro: '+vErro);
        Player('toast4');
        Exit;
     End
     Else if JsonArrayRetorno.Items[0].GetValue<Integer>('processoid') = 15 then Begin
       EdtCargaId.Clear;
       ShowMessage('Carga cancelada!');
       Exit;
     End
     Else if JsonArrayRetorno.Items[0].GetValue<Integer>('processoid') > 16 then Begin
       EdtCargaId.Clear;
       ShowMessage('Carga já foi concluída! Processo: '+JsonArrayRetorno.Items[0].GetValue<String>('processo'));
       Exit;
     End;
     JsonArrayRetorno := ObjCargaCarregarCtrl.GetCargaCarregarPedidos(StrToIntDef(EdtCargaId.Text, 0), 0);
     if JsonArrayRetorno.Count > 0 then Begin
        if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
           ShowErro('😢Erro: '+vErro);
           Player('toast4');
           LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
           LstCadastro.RowCount := 1;
        End
        Else Begin
          MontaPedidos(JsonArrayRetorno);
          JsonArrayRetorno := ObjCargaCarregarCtrl.GetCargaCarregarClientes(StrToIntDef(EdtCargaId.Text, 0), 0);
          if JsonArrayRetorno.Count > 0 then Begin
             if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
                ShowErro('😢Erro: '+vErro);
                Player('toast4');
                LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
                LstCadastro.RowCount := 1;
             End
             Else Begin
               MontaClientes(JsonArrayRetorno);
               if (FdMemClientes.Active) then
//                  FdMemClientes.Close;
                   FdMemClientes.EmptyDataSet;
               FdMemClientes.LoadFromJSON(JsonArrayRetorno, False);
               IniciarCarregamento;
             End;
          End
        End;
     End;
     JsonArrayRetorno := Nil;
  End;
end;

procedure TFrmCargaCarregar.EdtVolumeIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) And (StrToIntDef(EdtVolumeId.Text, 0) <> 0) then
      ConferirVolume(StrToIntDef(EdtVolumeId.Text, 0));
end;

procedure TFrmCargaCarregar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmCargaCarregar := Nil;
end;

procedure TFrmCargaCarregar.FormCreate(Sender: TObject);
begin
  inherited;
  ObjCargaCarregarCtrl := TCargasCtrl.Create;
  PnlGridBottom.BevelOuter := bvNone;
  LstCadastro.ColWidths[0] := 50;
  LstCadastro.ColWidths[1] := 70;
  LstCadastro.ColWidths[2] := 150;
  LstCadastro.ColWidths[3] := 150;
  LstCadastro.ColWidths[4] := 60;
  LstCadastro.ColWidths[5] := 80;
  LstCadastro.ColWidths[6] := 80;
  LstCadastro.ColWidths[7] := 70;
  LstCadastro.ColWidths[8] := 120;
  LstCadastro.ColWidths[9] := 110;
  LstCadastro.ColWidths[10] := 120;
  LstCadastro.Alignments[0, 0]  := taRightJustify;
  LstCadastro.FontStyles[0, 0]  := [FsBold];
  GetListaCarga(0, 0, 0, '', '', '', 0, '', '16');

  LstAdvPedidos.ColWidths[0]  := 80;
  LstAdvPedidos.ColWidths[1]  := 105;
  LstAdvPedidos.ColWidths[2]  := 90;
  LstAdvPedidos.ColWidths[3]  := 90;
  LstAdvPedidos.ColWidths[4]  := 80;
  LstAdvPedidos.Alignments[0, 0]  := taRightJustify;
  LstAdvPedidos.Alignments[1, 0]  := taRightJustify;
  LstAdvPedidos.Alignments[2, 0]  := taRightJustify;
  LstAdvPedidos.Alignments[3, 0]  := taRightJustify;
  LstAdvPedidos.Alignments[4, 0]  := taRightJustify;
  LstAdvPedidos.HideColumn(5);

  LstAdvClientes.ColWidths[0]  := 200;
  LstAdvClientes.ColWidths[1]  := 60;
  LstAdvClientes.ColWidths[2]  := 60;
  LstAdvClientes.Alignments[1, 0]  := taRightJustify;
  LstAdvClientes.Alignments[2, 0]  := taRightJustify;
  LstAdvClientes.HideColumn(3);
end;

procedure TFrmCargaCarregar.FormDestroy(Sender: TObject);
begin
  inherited;
  ObjCargaCarregarCtrl := Nil;
end;

procedure TFrmCargaCarregar.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var vErro : String;
begin
  if (Key = Vk_F5) And (Confirmacao('Carregamento', 'Deseja cancelar o carregamento?', True)) and (EdtCargaId.ReadOnly) then Begin
     If ObjCargaCarregarCtrl.CancelarCarregamento(StrToIntDef(EdtCargaId.Text, 0)).tryGetValue<String>('Erro', vErro) then
        ShowErro(vErro)
     Else Begin
        Confirmacao('Carregamento', 'Cancelamento efetivado!', False);
        Limpar;
        EdtCargaId.Enabled  := True;
        EdtCargaId.ReadOnly := False;
        EdtCargaId.SetFocus;
     End;
  End;
//  inherited;
end;

procedure TFrmCargaCarregar.GetListaCarga(pCargaId : Integer; pDataInicial, pDataFinal : TDateTime;
                       pRota, pTransportadora, pMotorista : String; pVeiculoId : Integer; pPlaca, pProcesso : String);
Var ObjCargasCtrl : TCargasCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  JsonArrayRetorno := ObjCargasCtrl.GetCargas(pCargaId, pDataInicial, pDataFinal,
                       pRota, pRota, pTransportadora, pMotorista, pVeiculoId, pPlaca, pProcesso, 0);
  if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
     ShowErro('😢Erro: '+vErro);
     Player('toast4');
     LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
     LstCadastro.RowCount := 1;
  End
  Else
    MontaListaCarga(JsonArrayRetorno);
  ObjCargasCtrl    := Nil;
  JsonArrayRetorno := Nil;
end;

procedure TFrmCargaCarregar.GetListaLstCadastro;
begin
  inherited;
  GetListaCarga(0, 0, 0, '', '', '', 0, '', '16');
end;

procedure TFrmCargaCarregar.IniciarCarregamento;
begin
  Try
    ObjCargaCarregarCtrl.ObjCargas.CargaId := StrToIntDef(EdtCargaId.Text, 0);
    if (FdMemPesqGeral.Active) then
       FdMemPesqGeral.EmptyDataSet;
    FdMemPesqGeral.LoadFromJSON(ObjCargaCarregarCtrl.GetCargaCarregarVolumes(StrToIntDef(EdtCargaId.Text, 0), 0, 'CA', 0), False);
    gProcCarregamento.MaxValue := FdMemPesqGeral.RecordCount;
    EdtPessoaId.Text := LstAdvClientes.Cells[3, 1];
    EdtRazao.Text    := LstAdvClientes.Cells[0, 1];
    EdtCargaId.ReadOnly  := True;
    EdtCargaId.Enabled   := False;
    EdtVolumeId.ReadOnly := False;
    EdtVolumeId.SetFocus;
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
end;

procedure TFrmCargaCarregar.Limpar;
begin
  inherited;
  if EdtCargaId.ReadOnly then
     EdtCargaId.Clear;
  EdtVolumeId.ReadOnly := True;
  EdtVolumeId.Clear;
  EdtPessoaId.Clear;
  EdtRazao.Clear;
  EdtPessoaCarregamento.Clear;
  EdtProxPessoaCarregamento.Clear;
  LstAdvPedidos.RowCount  := 1;
  LstAdvClientes.RowCount := 1;
  if (FdMemClientes.Active) then
     FdMemClientes.EmptyDataSet;
  GProcCarregamento.Progress := 0;
end;

procedure TFrmCargaCarregar.MontaClientes(pJsonArray : TJsonArray);
Var xLista : Integer;
begin
  LstAdvClientes.RowCount  := pJsonArray.Count + 1;
  LstAdvClientes.FixedCols := 1;
  For xLista := 0 to Pred(pJsonArray.Count) do Begin
    LstAdvClientes.Cells[0, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('razao');
    LstAdvClientes.Cells[1, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('qtdpedido').ToString();
    LstAdvClientes.Cells[2, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('ordem').ToString();
    LstAdvClientes.Cells[3, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('pessoaid').ToString();
    LstAdvClientes.Alignments[1, xLista+1]  := taRightJustify;
    LstAdvClientes.Alignments[2, xLista+1]  := taRightJustify;
    LstAdvClientes.Colors[0, xLista+1] := clWhite;
    LstAdvClientes.Colors[1, xLista+1] := clWhite;
    LstAdvClientes.Colors[2, xLista+1] := clWhite;
  End;
end;

procedure TFrmCargaCarregar.MontaListaCarga(pJsonArray: TJsonArray);
Var xLista : Integer;
begin
  LstCadastro.RowCount  := pJsonArray.Count + 1;
  LstCadastro.FixedCols := 1;
  For xLista := 0 to Pred(pJsonArray.Count) do Begin
    LstCadastro.Cells[0, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('cargaid').ToString();
    LstCadastro.Cells[1, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('dtinclusao');
    LstCadastro.Cells[2, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('rota');
    LstCadastro.Cells[3, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('transportadora');
    LstCadastro.Cells[4, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('placa');
    LstCadastro.Cells[5, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('modelo');
    LstCadastro.Cells[6, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('marca');
    LstCadastro.Cells[7, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('cor');
    LstCadastro.Cells[8, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('motorista');
    LstCadastro.Cells[9, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('usuario');
    LstCadastro.Cells[10, xLista+1] := pJsonArray.Items[xLista].GetValue<String>('processo');
  End;
end;

procedure TFrmCargaCarregar.MontaPedidos(pJsonArray : TJsonArray);
Var xLista : Integer;
begin
  LstAdvPedidos.RowCount  := pJsonArray.Count + 1;
  LstAdvPedidos.FixedCols := 1;
  For xLista := 0 to Pred(pJsonArray.Count) do Begin
    LstAdvPedidos.Cells[0, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('pedidoid').ToString();
    LstAdvPedidos.Cells[1, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('vlmcxafechada').ToString();
    LstAdvPedidos.Cells[2, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('vlmcxafracionado').ToString();
    LstAdvPedidos.Cells[3, xLista+1] := (pJsonArray.Items[xLista].GetValue<Integer>('vlmcxafechada')+
                                         pJsonArray.Items[xLista].GetValue<Integer>('vlmcxafracionado')).ToString();
    LstAdvPedidos.Cells[4, xLista+1] := '0';
    LstAdvPedidos.Cells[5, xLista+1] := pJsonArray.Items[xLista].GetValue<Integer>('pessoaid').ToString();;
    LstAdvPedidos.Alignments[0, xLista+1]  := taRightJustify;
    LstAdvPedidos.Alignments[1, xLista+1]  := taRightJustify;
    LstAdvPedidos.Alignments[2, xLista+1]  := taRightJustify;
    LstAdvPedidos.Alignments[3, xLista+1]  := taRightJustify;
    LstAdvPedidos.Alignments[4, xLista+1]  := taRightJustify;
    LstAdvPedidos.FontStyles[0, xLista+1]  := [FsBold];
    LstAdvPedidos.FontStyles[1, xLista+1]  := [FsBold];
    LstAdvPedidos.FontStyles[2, xLista+1]  := [FsBold];
    LstAdvPedidos.FontStyles[3, xLista+1]  := [FsBold];
    LstAdvPedidos.FontStyles[4, xLista+1]  := [FsBold];
    LstAdvPedidos.Colors[0, xLista+1] := clWhite;
    LstAdvPedidos.Colors[1, xLista+1] := clWhite;
    LstAdvPedidos.Colors[2, xLista+1] := clWhite;
    LstAdvPedidos.Colors[3, xLista+1] := clWhite;
    LstAdvPedidos.Colors[4, xLista+1] := clWhite;
  End;
end;

procedure TFrmCargaCarregar.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  edtCargaId.Text := LstCadastro.Cells[aCol, aRow];
  EdtCargaIdExit(EdtCargaId);
  PgcBase.ActivePage := TabPrincipal;
end;

function TFrmCargaCarregar.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin

end;

procedure TFrmCargaCarregar.ShowDados;
begin
  inherited;

end;

end.
