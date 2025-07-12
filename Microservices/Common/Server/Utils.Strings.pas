unit Server.Utils.Strings;

interface

uses
  strutils,
  sysutils,
  classes;

type
  TUtilString = class
  private
  public
    class function Captalize(value: string): string;
    class function SingularMode(value: string): string;
    class function PluralMode(value: string): string;

  end;

implementation

{ TUtilString }
class function TUtilString.Captalize(value: string): string;
begin
  result := value;
  if value = '' then
    exit;
  result := UpperCase(value[1]) + copy(value, 2, length(value));
end;

class function TUtilString.SingularMode(value: string): string;
var
  Case1: Boolean;
begin
  result := value;
  Case1 := EndsText('es', LowerCase(value));
  if Case1 then
    result := copy(value, 1, length(value) - 2)
  else if (LowerCase(value[length(value)]) = 's') then
    result := copy(value, 1, length(value) - 1);
end;

class function TUtilString.PluralMode(value: string): string;
var
  Case1: Boolean;
begin
  result := value;
  Case1 := EndsText('es', LowerCase(value));
  if (not Case1) and (LowerCase(value[length(value)]) <> 's') then
    if (EndsText('r', LowerCase(value))) or (EndsText('z', LowerCase(value)))
    then
      result := value + 'es'
    else
      result := value + 's';

end;

end.
