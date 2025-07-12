unit uFrmConfigurarEstacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmPadrao, StdCtrls, ExtCtrls, JvComponentBase, JvComputerInfoEx;

type
  TfrmConfigurarEstacao = class(TfrmPadrao)
    rdgImpressora: TRadioGroup;
    edtPorta: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Atualizar;
  protected
    procedure Desabilitar; override;
    procedure Limpar; override;
    procedure SalvarRegistro; override;
  public
    { Public declarations }
    procedure Cancelar; override;
  end;

var
  frmConfigurarEstacao: TfrmConfigurarEstacao;

implementation

uses IniFiles, uTEtiqueta;

{$R *.dfm}

{ TfrmConfigurarEstacao }

procedure TfrmConfigurarEstacao.Atualizar;
var
  vlIni: TIniFile;
begin
  vlIni := TIniFile.Create(vgPath + '\X3WMS.ini');

  try
    rdgImpressora.ItemIndex := vlIni.ReadInteger('ESTACAO', 'Impressora', 0);
    edtPorta.Text           := vlIni.ReadString('ESTACAO', 'Porta', 'LPT1');
  finally
    FreeAndNil(vlIni);
  end;
end;

procedure TfrmConfigurarEstacao.Cancelar;
begin
  inherited;

  Close;
end;

procedure TfrmConfigurarEstacao.Desabilitar;
begin
  inherited;

  HabilitarAtalhos([aSalvar, aCancelar]);
end;

procedure TfrmConfigurarEstacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  frmConfigurarEstacao := nil;
end;

procedure TfrmConfigurarEstacao.FormCreate(Sender: TObject);
begin
  inherited;

  vgCodigoFuncao := 11; // 11 = Configurar Estação
  Atualizar;
end;

procedure TfrmConfigurarEstacao.Limpar;
begin
  inherited;

  Atualizar;
end;

procedure TfrmConfigurarEstacao.SalvarRegistro;
var
  vlIni: TIniFile;
begin
  inherited;

  vlIni := TIniFile.Create(vgPath + '\X3WMS.ini');

  try
    vgImpressora.Modelo := TImpressoraModelo(rdgImpressora.ItemIndex);
    vgImpressora.Porta  := edtPorta.Text;

    vlIni.WriteInteger('ESTACAO', 'Impressora', rdgImpressora.ItemIndex);
    vlIni.WriteString('ESTACAO', 'Porta', edtPorta.Text);
  finally
    FreeAndNil(vlIni);
  end;
end;

end.
