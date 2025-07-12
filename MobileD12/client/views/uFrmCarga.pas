unit uFrmCarga;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, FMX.Gestures,
  System.Actions, FMX.ActnList, FMX.TabControl, FMX.Layouts, FMX.Objects
  ,FMX.Edit, FMX.Controls.Presentation, FMX.ListView, uMyTabOrderClassHelper,
  System.Rtti, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Grid,
  FireDAC.Stan.StorageBin, FMX.Grid.Style, FMX.ScrollBox
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    ,Androidapi.Helpers
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Os, ksTypes, ksLoadingIndicator, FMX.Media, FMX.Effects,
  FMX.Filter.Effects, FMX.Ani, FMX.ListBox
  {$Endif};

type
  TFrmCarga = class(TFrmBase)
    Edit1: TEdit;
    Edit2: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCarga: TFrmCarga;

implementation

{$R *.fmx}

procedure TFrmCarga.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  case Key of
    vkReturn:
      TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
    vkTab:
      TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
  end;
end;

procedure TFrmCarga.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
//  inherited;
end;

procedure TFrmCarga.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  //inherited;

end;

end.
