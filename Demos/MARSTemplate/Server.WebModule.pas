(*
  Copyright 2016, MARS-Curiosity - REST Library

  Home: https://github.com/andrea-magni/MARS
*)
unit Server.WebModule;

interface

uses System.SysUtils, System.Classes, Web.HTTPApp;

type
  TServerWebModule = class(TWebModule)
    procedure ServerWebModuleDefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TServerWebModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  Server.Ignition;

procedure TServerWebModule.ServerWebModuleDefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  inherited;

  if not TServerEngine.Default.HandleRequest(Request, Response) then
  begin
    Response.ContentType := 'application/json';
    Response.Content :=
      '{"success": false, "details": '
      + '{'
        + '"error": "Request not found",'
        + '"pathinfo": "' + Request.PathInfo + '"'
      + '}'
    + '}';
  end
  else
    Handled := True;

//  AResponseInfo.CustomHeaders.AddStrings(LResponse.CustomHeaders);
//  SetCookies(AResponseInfo, LResponse);
end;

end.
