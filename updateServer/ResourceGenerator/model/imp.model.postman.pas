unit imp.model.postman;

interface

uses
  System.SysUtils, System.Classes;

type
  IPostman = interface
  ['{B6E40577-9EF6-42A6-82F9-7663416F8771}']
    function Execute(ANomeResource, ANomeCampos: string): string;
    function PostmanJson(ATexto: string): string;
  end;

type
  TPostman = class(TInterfacedObject, IPostman)
  private


    function PostmanResources(ANomeTabela, ANomeCampos: string): string;
    function Execute(ANomeResource, ANomeCampos: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function Ref: IPostman;
    function PostmanJson(ATexto: string): string;
  end;

var
  Postman: TPostman;

implementation

{ TPostman }

constructor TPostman.Create;
begin
  inherited Create;
end;

destructor TPostman.Destroy;
begin
  inherited Destroy;
end;

function TPostman.Ref: IPostman;
begin
  result := Self;
end;

function TPostman.Execute(ANomeResource, ANomeCampos: string): string;
begin
  result := PostmanResources(ANomeResource, ANomeCampos);
end;

function TPostman.PostmanJson(ATexto: string): string;
begin
  result := '{ ' + #13#10
          + '    "info": { ' + #13#10
          + '        "_postman_id": "923871e0-5ccf-413f-ba24-4d5111ceefea", ' + #13#10
          + '        "name": "WK", ' + #13#10
          + '        "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json", ' + #13#10
          + '        "_exporter_id": "20996876" ' + #13#10
          + '    }, ' + #13#10
          + '    "item": [ ' + #13#10
          + '        { ' + #13#10
          + '            "name": "Cadastros", ' + #13#10
          + '            "item": [ ' + #13#10
          + '                @texto            ]' + #13#10
          + '        }, ' + #13#10
          + '        { ' + #13#10
          + '            "name": "autorizacao", ' + #13#10
          + '            "request": { ' + #13#10
          + '                "method": "POST", ' + #13#10
          + '                "header": [ ' + #13#10
          + '                    { ' + #13#10
          + '                        "key": "Content-Type", ' + #13#10
          + '                        "value": "application/json", ' + #13#10
          + '                        "type": "text" ' + #13#10
          + '                    } ' + #13#10
          + '                ], ' + #13#10
          + '                "body": { ' + #13#10
          + '                    "mode": "raw", ' + #13#10
          + '                    "raw": "{\r\n\"user\":\"adm\",\r\n\"password\":\"adm\"\r\n}" ' + #13#10
          + '                }, ' + #13#10
          + '                "url": { ' + #13#10
          + '                    "raw": "{{Url_Api}}authorization", ' + #13#10
          + '                    "host": [ ' + #13#10
          + '                        "{{Url_Api}}authorization" ' + #13#10
          + '                    ] ' + #13#10
          + '                } ' + #13#10
          + '            }, ' + #13#10
          + '            "response": [ ' + #13#10
          + '                { ' + #13#10
          + '                    "name": "autorizacao", ' + #13#10
          + '                    "originalRequest": { ' + #13#10
          + '                        "method": "POST", ' + #13#10
          + '                        "header": [ ' + #13#10
          + '                            { ' + #13#10
          + '                                "key": "Content-Type", ' + #13#10
          + '                                "value": "application/json", ' + #13#10
          + '                                "type": "text" ' + #13#10
          + '                            } ' + #13#10
          + '                        ], ' + #13#10
          + '                        "body": { ' + #13#10
          + '                        "mode": "raw", ' + #13#10
          + '                        "raw": "{\r\n\"user\":\"adm\",\r\n\"password\":\"adm\"\r\n}" ' + #13#10
          + '                        }, ' + #13#10
          + '                        "url": { ' + #13#10
          + '                            "raw": "{{Url_Api}}authorization", ' + #13#10
          + '                            "host": [ ' + #13#10
          + '                                "{{Url_Api}}authorization" ' + #13#10
          + '                            ] ' + #13#10
          + '                        } ' + #13#10
          + '                    }, ' + #13#10
          + '                    "_postman_previewlanguage": "Text", ' + #13#10
          + '                    "header": [], ' + #13#10
          + '                    "cookie": [], ' + #13#10
          + '                    "body": "" ' + #13#10
          + '                } ' + #13#10
          + '            ] ' + #13#10
          + '        } ' + #13#10
          + '    ], ' + #13#10
          + '    "event": [ ' + #13#10
          + '        { ' + #13#10
          + '            "listen": "prerequest", ' + #13#10
          + '            "script": { ' + #13#10
          + '                "type": "text/javascript", ' + #13#10
          + '                "exec": [ ' + #13#10
          + '                    "" ' + #13#10
          + '                ] ' + #13#10
          + '            } ' + #13#10
          + '        }, ' + #13#10
          + '        { ' + #13#10
          + '             "listen": "test", ' + #13#10
          + '             "script": { ' + #13#10
          + '                 "type": "text/javascript", ' + #13#10
          + '                 "exec": [ ' + #13#10
          + '                     "" ' + #13#10
          + '                 ] ' + #13#10
          + '             } ' + #13#10
          + '        } ' + #13#10
          + '    ], ' + #13#10
          + '    "variable": [ ' + #13#10
          + '        { ' + #13#10
          + '            "key": "Url_Api", ' + #13#10
          + '            "value": "http://localhost:8081/v1/", ' + #13#10
          + '            "type": "string" ' + #13#10
          + '        }, ' + #13#10
          + '        { ' + #13#10
          + '            "key": "Token", ' + #13#10
          + '            "value": "Bearer substituir", ' + #13#10
          + '            "type": "string" ' + #13#10
          + '        } ' + #13#10
          + '    ] ' + #13#10
          + '} ' + #13#10;

   result := result.Replace('@texto', ATexto, [rfReplaceAll]);
end;

function TPostman.PostmanResources(ANomeTabela, ANomeCampos: string): string;
begin
  result := '{ ' + #13#10
          + '                    "name": "@tabela", ' + #13#10
          + '                    "item": [ ' + #13#10
          + '                        { ' + #13#10
          + '                            "name": "Busca @tabela", ' + #13#10
          + '                            "request": { ' + #13#10
          + '                                "method": "GET", ' + #13#10
          + '                                "header": [ ' + #13#10
          + '                                    { ' + #13#10
          + '                                        "key": "x-api-key", ' + #13#10
          + '                                        "value": "{{Token}}", ' + #13#10
          + '                                        "type": "text" ' + #13#10
          + '                                    } ' + #13#10
          + '                                ], ' + #13#10
          + '                                "url": { ' + #13#10
          + '                                    "raw": "{{Url_Api}}@tabela", ' + #13#10
          + '                                    "host": [ ' + #13#10
          + '                                        "{{Url_Api}}@tabela" ' + #13#10
          + '                                    ], ' + #13#10
          + '                                    "query": [ ' + #13#10
          + '                                        { ' + #13#10
          + '                                            "key": "pageSize", ' + #13#10
          + '                                            "value": "0", ' + #13#10
          + '                                            "disabled": true ' + #13#10
          + '                                        } ' + #13#10
          + '                                    ] ' + #13#10
          + '                                } ' + #13#10
          + '                            }, ' + #13#10
          + '                            "response": [] ' + #13#10
          + '                        }, ' + #13#10
          + '                        { ' + #13#10
          + '                            "name": "Inclui @tabela", ' + #13#10
          + '                            "request": { ' + #13#10
          + '                                "method": "POST", ' + #13#10
          + '                                "header": [ ' + #13#10
          + '                                    { ' + #13#10
          + '                                        "key": "x-api-key", ' + #13#10
          + '                                        "value": "{{Token}}", ' + #13#10
          + '                                        "type": "text" ' + #13#10
          + '                                    } ' + #13#10
          + '                                ], ' + #13#10
          + '                                @campos ' + #13#10
          + '                                "url": { ' + #13#10
          + '                                    "raw": "{{Url_Api}}@tabela", ' + #13#10
          + '                                    "host": [ ' + #13#10
          + '                                        "{{Url_Api}}@tabela" ' + #13#10
          + '                                    ] ' + #13#10
          + '                                } ' + #13#10
          + '                            }, ' + #13#10
          + '                            "response": [] ' + #13#10
          + '                        }, ' + #13#10
          + '                        { ' + #13#10
          + '                            "name": "Altera @tabela", ' + #13#10
          + '                            "request": { ' + #13#10
          + '                                "method": "PUT", ' + #13#10
          + '                                "header": [ ' + #13#10
          + '                                    { ' + #13#10
          + '                                        "key": "Content-Type", ' + #13#10
          + '                                        "value": "application/json", ' + #13#10
          + '                                        "type": "text" ' + #13#10
          + '                                    }, ' + #13#10
          + '                                    { ' + #13#10
          + '                                        "key": "x-api-key", ' + #13#10
          + '                                        "value": "{{Token}}", ' + #13#10
          + '                                        "type": "text" ' + #13#10
          + '                                    } ' + #13#10
          + '                                ], ' + #13#10
          + '                                @campos ' + #13#10
          + '                                "url": { ' + #13#10
          + '                                    "raw": "{{Url_Api}}@tabela/1", ' + #13#10
          + '                                    "host": [ ' + #13#10
          + '                                        "{{Url_Api}}@tabela" ' + #13#10
          + '                                    ], ' + #13#10
          + '                                    "path": [ ' + #13#10
          + '                                        "1" ' + #13#10
          + '                                    ] ' + #13#10
          + '                                } ' + #13#10
          + '                            }, ' + #13#10
          + '                            "response": [] ' + #13#10
          + '                        }, ' + #13#10
          + '                        { ' + #13#10
          + '                            "name": "Exclui @tabela", ' + #13#10
          + '                            "request": { ' + #13#10
          + '                                "method": "DELETE", ' + #13#10
          + '                                "header": [ ' + #13#10
          + '                                    { ' + #13#10
          + '                                        "key": "Content-Type", ' + #13#10
          + '                                        "value": "application/json", ' + #13#10
          + '                                        "type": "text" ' + #13#10
          + '                                    }, ' + #13#10
          + '                                    { ' + #13#10
          + '                                        "key": "x-api-key", ' + #13#10
          + '                                        "value": "{{Token}}", ' + #13#10
          + '                                        "type": "text" ' + #13#10
          + '                                    } ' + #13#10
          + '                                ], ' + #13#10
          + '                                "url": { ' + #13#10
          + '                                    "raw": "{{Url_Api}}@tabela/2", ' + #13#10
          + '                                    "host": [ ' + #13#10
          + '                                        "{{Url_Api}}@tabela" ' + #13#10
          + '                                    ], ' + #13#10
          + '                                    "path": [ ' + #13#10
          + '                                        "2" ' + #13#10
          + '                                    ] ' + #13#10
          + '                                } ' + #13#10
          + '                            }, ' + #13#10
          + '                            "response": [] ' + #13#10
          + '                        } ' + #13#10
          + '                    ] ' + #13#10
          + '                } ' + #13#10;

  result := result.Replace('@tabela', ANomeTabela, [rfReplaceAll]);
  result := result.Replace('@campos', ANomeCampos, [rfReplaceAll]);
end;

end.

