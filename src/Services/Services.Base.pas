unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, Providers.Request;

type
  TServiceBase = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FRequest : IRequest;
    FBASEUrl : String;
  public
    property Request: IRequest read FRequest write FRequest;
    Property BaseURL: String   Read FBASEUrl Write FBASEUrl;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uFrmeXactWMS;

{$R *.dfm}

procedure TServiceBase.DataModuleCreate(Sender: TObject);
begin
  FRequest := TRequest.New;
  FBaseURL := FrmeXactWMS.BaseURL;
end;

procedure TServiceBase.DataModuleDestroy(Sender: TObject);
begin
  FRequest := nil;
end;

end.

