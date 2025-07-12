unit uFrmCaixaLiberacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, System.Rtti, FMX.Grid.Style, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.ActnList,
  System.Actions, FMX.TabControl, ksTypes, ksLoadingIndicator, FMX.Media,
  FMX.Effects, FMX.Filter.Effects, FMX.Ani, FMX.Objects, FMX.ListView,
  FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid,
  FMX.Layouts, EmbalagemCaixaCtrl, System.Generics.Collections, System.JSON,
  REST.Json, Rest.Types;

type
  TFrmCaixaLiberacao = class(TFrmBase)
    LblCaixaModelo: TLabel;
    EdtCaixaModelo: TEdit;
    Line1: TLine;
    ChkDisponivel: TCheckBox;
    EdtPedidoVolumeId: TEdit;
    Line2: TLine;
    LblPedidoVolumeId: TLabel;
    RctCaixa: TRectangle;
    EdtIdentificacao: TEdit;
    Line3: TLine;
    Label1: TLabel;
    procedure EdtCodigoValidate(Sender: TObject; var Text: string);
  private
    { Private declarations }
    procedure SalvarCaixaLiberacao(pCaixaId : Int64);
    Procedure ThreadTerminateAcompanhamentoCaixas(Sender: TObject);
  Protected
    Procedure AtivaCampoDefault; OverRide;
  public
    { Public declarations }
  end;

var
  FrmCaixaLiberacao: TFrmCaixaLiberacao;

implementation

{$R *.fmx}

procedure TFrmCaixaLiberacao.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'EdtCodigo' then Begin
     EdtCodigo.Text := '';
     DelayEdSetFocus(EdtCodigo);
  End;
end;

procedure TFrmCaixaLiberacao.EdtCodigoValidate(Sender: TObject; var Text: string);
Var ObjCaxiaEmbalagemCtrl : TCaixaEmbalagemCtrl;
    JsonArrayRetorno  : TJsonArray;
    vErro : String;
begin
  inherited;
  Try
    ObjCaxiaEmbalagemCtrl := TCaixaEmbalagemCtrl.Create;
    Try
      JsonArrayRetorno  := ObjCaxiaEmbalagemCtrl.GetCaixaEmbalagemJson(0, StrToIntDef(EdtCodigo.Text, 0),
                           StrToIntDef(EdtCodigo.Text, 0),  0, 'A', 99, 0);
      If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
         SetCampoDefault('EdtCodigo');
         ShowErro('Erro: '+vErro);
      End
      Else If JsonArrayRetorno.Items[0].TryGetValue('MSG', vErro) then Begin
         SetCampoDefault('EdtCodigo');
         ShowMSG('Atenão: '+vErro);
      End
      Else Begin
         SetAtivoOnOff(JsonArrayRetorno.Items[0].GetValue<Integer>('status', 0)>0);
         chkDisponivel.IsChecked := JsonArrayRetorno.Items[0].GetValue<Integer>('pedidovolumeid', 0) = 0;
         If JsonArrayRetorno.Items[0].GetValue<Integer>('pedidovolumeid', 0) > 0 then
            EdtPedidoVolumeId.Text := JsonArrayRetorno.Items[0].GetValue<String>('pedidovolumeid', '')
         Else
            EdtPedidoVolumeId.Text := '';
         EdtCaixaModelo.text   := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('VolumeEmbalagem').Items[0].GetValue<String>('descricao');
         EdtIdentificacao.text := JsonArrayRetorno.Items[0].GetValue<TJsonArray>('VolumeEmbalagem').Items[0].GetValue<String>('identificacao');
         If JsonArrayRetorno.Items[0].GetValue<Integer>('pedidovolumeid', 0) > 0 then begin
            SalvarCaixaLiberacao(StrToInt64Def(EdtCodigo.Text, 0));
         end;
         EdtCodigo.Text := '';
         Text := '';
         DelayEdSetFocus(EdtCodigo);
      End;
    Except On E: Exception do
       ShowErro('Erro: '+E.Message);
    End;
  Finally
    FreeAndNil(ObjCaxiaEmbalagemCtrl);
  End;
end;

procedure TFrmCaixaLiberacao.SalvarCaixaLiberacao(pCaixaId : Int64);
Var Th: TThread;
    ObjCaixaEmbalagemCtrl : TCaixaEmbalagemCtrl;
    JsonArrayRetorno      : TJsonArray;
    vErro : String;
begin
//   Th := TThread.CreateAnonymousThread(procedure
//      Var ObjCaixaEmbalagemCtrl : TCaixaEmbalagemCtrl;
//          JsonArrayRetorno      : TJsonArray;
//          vErro : String;
//   begin
     ObjCaixaEmbalagemCtrl := TCaixaEmbalagemCtrl.Create;
     JsonArrayRetorno := ObjCaixaEmbalagemCtrl.SalvarCaixaLiberacao(pCaixaId);
     if JsonArrayRetorno.TryGetValue('Erro', vErro) then Begin
        JsonArrayRetorno := Nil;
        FreeAndNil(ObjCaixaEmbalagemCtrl);
        raise Exception.Create(vErro);
     End
     Else Begin
        JsonArrayRetorno := Nil;
        FreeAndNil(ObjCaixaEmbalagemCtrl);
        ShowOk('Caixa Liberada!');
     End;
//   End);
//   Th.OnTerminate := ThreadTerminateAcompanhamentoCaixas;
//   Th.Start;
end;

procedure TFrmCaixaLiberacao.ThreadTerminateAcompanhamentoCaixas(
  Sender: TObject);
begin
  if Sender is TThread then begin
     if Assigned(TThread(Sender).FatalException) then
        ShowErro('Erro: Caixa não liberada.');
  end;
end;

end.
