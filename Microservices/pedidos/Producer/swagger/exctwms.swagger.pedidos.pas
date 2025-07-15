unit exctwms.swagger.pedidos;

interface

uses
  Horse.GBSwagger;

procedure StartDocumentation;

implementation

procedure StartDocumentation;
begin
  Swagger
    .Info
      .Title('API de pedidos– ExctWms')
      .Description('API geraçao de pedidos')
      .Contact
        .Name('ExctWms')
        .Email('genilsonsantos@gmail.com')
        .URL('https://rhemasys.com.br')
      .&End
    .&End;

  Swagger
    .Config
      .ClassPrefixes('TModel')
    .&End;
end;

initialization
  StartDocumentation;

end.

