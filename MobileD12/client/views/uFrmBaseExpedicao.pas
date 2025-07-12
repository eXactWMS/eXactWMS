unit uFrmBaseExpedicao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, System.Rtti,
  FMX.Grid.Style, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components,
  Data.Bind.Grid, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Data.Bind.DBScope, FMX.Gestures, FMX.ActnList, System.Actions, FMX.TabControl,
  FMX.Edit, FMX.ScrollBox, FMX.Grid, FMX.ListView, FMX.Layouts,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrmBase1 = class(TFrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBase1: TFrmBase1;

implementation

{$R *.fmx}

end.
