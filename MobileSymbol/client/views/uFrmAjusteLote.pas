unit uFrmAjusteLote;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, System.Rtti,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FMX.Gestures, FMX.ActnList, System.Actions, FMX.TabControl,
  ksTypes, ksLoadingIndicator, FMX.Edit, FMX.Layouts, FMX.Grid, FMX.ListView,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrmAjusteLote = class(TFrmBase)
    LblProduto: TLabel;
    Label1: TLabel;
    EdtEmbalagem: TEdit;
    Label2: TLabel;
    EdtQtde: TEdit;
    RctMaster: TRectangle;
    RctDet: TRectangle;
    ChkSemEstoque: TSwitch;
    Label3: TLabel;
    Label4: TLabel;
    EdtCdProduto: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAjusteLote: TFrmAjusteLote;

implementation

{$R *.fmx}

uses uFrmMain;

procedure TFrmAjusteLote.Button1Click(Sender: TObject);
begin
  inherited;
  ShowMessage('Fechando...');
  ShowMessage('Removendo 1 da tela');
  FrmMain.LytMain.RemoveObject(1);
  ShowMessage('Removendo 0 da tela');
  FrmMain.LytMain.RemoveObject(0);
end;

procedure TFrmAjusteLote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ShowMessage('Matando os objetos');
  FrmAjusteLote.DisposeOf;
  FrmAjusteLote := Nil;
end;

procedure TFrmAjusteLote.FormCreate(Sender: TObject);
begin
  inherited;
  LblProduto.Text := '';
end;

end.
