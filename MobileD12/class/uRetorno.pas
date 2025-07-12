unit uRetorno;

interface

uses SysUtils;

type
  TRetorno = class
  private
    FMSGErro: String;
    FDescricao: String;
    FCodigo: Integer;
    procedure SetCodigo(const Value: Integer);
    procedure SetDescricao(const Value: String);
    procedure SetMSGErro(const Value: String);
  Published
     Class Procedure Register; //Registrar a classe por recomendacao do Brutus do Delphi WebServices 6
  public
    property Codigo    : Integer read FCodigo    write SetCodigo;
    property Descricao : String  read FDescricao write SetDescricao;
    Property MSGErro   : String  read FMSGErro   write SetMSGErro;
  end;

implementation

{ TRetorno }

class procedure TRetorno.Register;
begin

end;

procedure TRetorno.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TRetorno.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TRetorno.SetMSGErro(const Value: String);
begin
  FMSGErro := Value;
end;

Initialization
  TRetorno.Register;

end.
