unit uFrmNovidades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  dxGDIPlusClasses, Vcl.Mask, JvExMask, JvToolEdit, System.JSON, REST.Json,
  Rest.Types, System.Generics.Collections, Services.Base.Cadastro, acPNG;

type
  TFrmNovidades = class(TForm)
    PnHeader: TPanel;
    LblForm: TLabel;
    ImgClose: TImage;
    mmNovidades: TMemo;
    PnlNext: TPanel;
    BtnNext: TShape;
    LblNext: TLabel;
    PnlBack: TPanel;
    BtnBack: TShape;
    LblBack: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EdtDtNovidade: TJvDateEdit;
    EdtVersao: TEdit;
    EdtNovidadeId: TEdit;
    Image1: TImage;
    procedure BtnNextMouseEnter(Sender: TObject);
    procedure BtnNextMouseLeave(Sender: TObject);
    procedure ImgCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure LblBackMouseEnter(Sender: TObject);
    procedure LblBackMouseLeave(Sender: TObject);
    procedure PnlBackClick(Sender: TObject);
    procedure PnlNextClick(Sender: TObject);
  private
    { Private declarations }
    Procedure MoveNovidade(pNovidadeId : Integer);
  Protected
    FService : TServiceBaseCadastro;
  public
    { Public declarations }
    Procedure ShowNovidades(pJsonArrayNovidades : TJsonArray);
  end;

var
  FrmNovidades: TFrmNovidades;

implementation

{$R *.dfm}

uses NovidadesCtrl, Service.Novidades, uFrmeXactWMS;

procedure TFrmNovidades.BtnNextMouseEnter(Sender: TObject);
begin
  TShape(Sender).Pen.Color   := $00ECDECE; //Azul
  TShape(Sender).Brush.Color := $004080FF; //Chocolate
  if Sender = BtnNext then Begin
     LblNext.Font.Color  := $00ECDECE;
     LblNext.Color       := $004080FF;
  End
  Else Begin
     LblBack.Font.Color  := $00ECDECE;
     LblBack.Color       := $004080FF;
  End;
end;

procedure TFrmNovidades.BtnNextMouseLeave(Sender: TObject);
begin
  TShape(Sender).Pen.Color   := $004080FF; //Azul
  TShape(Sender).Brush.Color := $00ECDECE; //Chocolate
  if Sender = BtnNext then Begin
     LblNext.Font.Color  := $004080FF;
     LblNext.Color       := $00ECDECE;
  End
  Else begin
     LblBack.Font.Color  := $004080FF;
     LblBack.Color       := $00ECDECE;
  end;
end;

procedure TFrmNovidades.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FrmNovidades := Nil;
end;

procedure TFrmNovidades.FormCreate(Sender: TObject);
Var ObjNovidadesCtrl : TNovidadesCtrl;
begin
  mmNovidades.Lines.Clear;
end;

procedure TFrmNovidades.FormShow(Sender: TObject);
begin
  //ShowNovidades(nil);
end;

procedure TFrmNovidades.ImgCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmNovidades.LblBackMouseEnter(Sender: TObject);
begin
  if Sender = LblNext then
     BtnNextMouseEnter(BtnNext)
  Else BtnNextMouseEnter(BtnBack);
end;

procedure TFrmNovidades.LblBackMouseLeave(Sender: TObject);
begin
  if Sender = LblNext then
     BtnNextMouseLeave(BtnNext)
  Else BtnNextMouseLeave(BtnBack);
end;

procedure TFrmNovidades.MoveNovidade(pNovidadeId: Integer);
Var ObjNovidadesCtrl   : TNovidadesCtrl;
    vErro : String;
    JsonArrayNovidades : TJsonArray;
begin
  if pNovidadeId <= 0 then Exit;
  FService := TServiceNovidades.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/novidades')
     .ClearParams
     .AddParam('novidadeid', pNovidadeId.ToString());
  JsonArrayNovidades := FService.ListarRegistroJson;
  if Not JsonArrayNovidades.Items[0].TryGetValue('Erro', vErro) then
     ShowNovidades(JsonArrayNovidades);
  JsonArrayNovidades := Nil;
  FService.Free;
end;

procedure TFrmNovidades.PnlBackClick(Sender: TObject);
begin
  MoveNovidade(StrToIntDef(EdtNovidadeId.Text, 0)-1);
end;

procedure TFrmNovidades.PnlNextClick(Sender: TObject);
begin
  MoveNovidade(StrToIntDef(EdtNovidadeId.Text, 0)+1);
end;

procedure TFrmNovidades.ShowNovidades(pJsonArrayNovidades : TJsonArray);
Var xNovidade : Integer;
begin
  for xNovidade := 0 to Pred(pJsonArrayNovidades.Count) do Begin
    if pjsonArrayNovidades.Items[Pred(pJsonArrayNovidades.Count)].GetValue<Integer>('status', 0) = 1 then
       Break;
  End;
  MmNovidades.lines.Clear;
  EdtNovidadeId.Text := pjsonArrayNovidades.Items[xNovidade].GetValue<String>('novidadeid');
  EdtDtNovidade.Text := pjsonArrayNovidades.Items[xNovidade].GetValue<String>('data');
  EdtVersao.Text     := pjsonArrayNovidades.Items[xNovidade].GetValue<String>('versao');
  MmNovidades.Lines.Add(pjsonArrayNovidades.Items[xNovidade].GetValue<String>('texto'));
end;

end.
