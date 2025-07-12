unit uFrmCorrecaoLotes;

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
  FMX.Layouts;

type
  TFrmCorrecaoLotes = class(TFrmBase)
    Label1: TLabel;
    EdtDescricao: TEdit;
    Line1: TLine;
    EdtDescricao2: TEdit;
    Line2: TLine;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCorrecaoLotes: TFrmCorrecaoLotes;

implementation

{$R *.fmx}

end.
