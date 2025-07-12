unit uListview;

interface

uses System.SysUtils, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView, FMX.Graphics;

type
    TMyListview = class
    private

    public
        class procedure SetupItem(lv: TListView; Item: TListViewItem; img_uncheck,
                                  img_check: TBitmap); static;
        class procedure SelecionarItem(lv: TListView; Item: TListViewItem;
                                       img_uncheck, img_check: TBitmap); static;
        class function SelectedCount(lview: TListView): integer; static;
        class procedure AddItem(lv: TListView; codigo, descricao: string;
                                QtdEndereco : Integer; bmp: TBitmap; pChecked : Boolean); static;

end;

implementation

class procedure TMyListview.SetupItem(lv: TListView; Item: TListViewItem;
                                  img_uncheck, img_check: TBitmap);
begin
    with item do
    begin
        if Checked then
            TListItemImage(Objects.FindDrawable('ImgChkZona')).Bitmap := img_check
        else
            TListItemImage(Objects.FindDrawable('ImgChkZona')).Bitmap := img_uncheck;
    end;
end;


class procedure TMyListview.SelecionarItem(lv: TListView; Item: TListViewItem;
                                           img_uncheck, img_check: TBitmap);
begin
    Item.Checked := NOT Item.Checked;
    SetupItem(lv, item, img_uncheck, img_check);
end;

class function TMyListview.SelectedCount(lview: TListView): integer;
var
    x : integer;
begin
    Result := 0;

    for x := lview.ItemCount - 1 downto 0 do
        if lview.Items[x].Checked then
            Inc(Result);
end;

class procedure TMyListview.AddItem(lv: TListView;
                                    codigo, descricao: string;
                                    QtdEndereco : Integer;
                                    bmp: TBitmap; pChecked : Boolean);
begin
    //lv.Items.AddItem()
    Lv.BeginUpdate;
    with lv.Items.Add do
    begin
        //Height := 60;
        if Lv.Name = 'LvZona' then begin
           TagString := codigo;
           Checked := pChecked;
           TListItemText(Objects.FindDrawable('ItZonaId')).Text      := Codigo;
           TListItemText(Objects.FindDrawable('ItZona')).Text        := descricao;
           TListItemText(Objects.FindDrawable('ItQtdEndereco')).Text := QtdEndereco.ToString();
           TListItemImage(Objects.FindDrawable('ImgChkZona')).Bitmap := bmp;
        end
        Else Begin
           TListItemText(Objects.FindDrawable('ItZonaId')).Text      := Codigo;
           TListItemText(Objects.FindDrawable('ItEndereco')).Text    := descricao;
        End;
    end;
    Lv.EndUpdate;
end;


end.
