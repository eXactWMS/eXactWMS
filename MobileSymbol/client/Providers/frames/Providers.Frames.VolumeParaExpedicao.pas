unit Providers.Frames.VolumeParaExpedicao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Providers.Frames.Base, FMX.Controls.Presentation, FMX.Objects;

type
  TFrameVolumeParaExpedicao = class(TFrameBase)
    LblPedidoId: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    LblVolumeId: TLabel;
    Label3: TLabel;
    LblPedidoData: TLabel;
    Label5: TLabel;
    LblDestino: TLabel;
    BtnDel: TButton;
    BtnUpd: TButton;
    lineSeparator: TLine;
    Label4: TLabel;
    Label6: TLabel;
    procedure BtnUpdClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
  private
    { Private declarations }
    FOnDeletePedido: TNotifyEvent;
    FIdentify: string;
    FOnEditPedido: TNotifyEvent;
  public
    { Public declarations }
    property Identify: string read FIdentify write FIdentify;
    property OnDeletePedido: TNotifyEvent read FOnDeletePedido write FOnDeletePedido;
    property OnEditPedido: TNotifyEvent read FOnEditPedido write FOnEditPedido;
  end;

var
  FrameVolumeParaExpedicao: TFrameVolumeParaExpedicao;

implementation

{$R *.fmx}

procedure TFrameVolumeParaExpedicao.BtnDelClick(Sender: TObject);
begin
  inherited;
  if Assigned(FOnDeletePedido) then
    FOnDeletePedido(Self);
end;

procedure TFrameVolumeParaExpedicao.BtnUpdClick(Sender: TObject);
begin
  inherited;
  if Assigned(FOnEditPedido) then
    FOnEditPedido(Self);
end;

end.
