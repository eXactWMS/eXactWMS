unit uMyTabOrderClassHelper;

interface

Uses FMX.Types, FMX.Controls;

type
   TFMXControlClassHelper = class helper for TControl
    public
      procedure SelectNext(CurControl: TControl; GoFoward: Boolean);
    end;

implementation

{ TFMXControlClassHelper }

procedure TFMXControlClassHelper.SelectNext(CurControl: TControl;
  GoFoward: Boolean);
  var
    tablist          : ITabList;
    next             : IControl;
    parente, controle: TControl;
  begin
    controle := CurControl;
    parente  := controle.ParentControl;
    repeat
      tablist := parente.GetTabList;
      next    := tablist.FindNextTabStop(controle, GoFoward, True);
      if (not Assigned(next)) or (TControl(next) = controle) then
      begin
        controle := parente;
        parente  := parente.ParentControl;
      end
      else
        Break;
    until parente = nil;

    if (Assigned(next)) then
      controle := TControl(next)
    else
      controle := nil;

    if (Assigned(controle)) then
      controle.SetFocus;
  end;

end.
