unit uHttpDownloader;

interface

uses IdHTTP, IdSSLOpenSSL, System.SysUtils, Vcl.Dialogs, System.Classes, IdCookieManager
  // User moduls
    , uExUtils;

type
  THTTPDownloader = class(TObject)
  strict private
    hpHtmlDownloader: TIdHTTP;
    sslSocket: TIdSSLIOHandlerSocketOpenSSL;
    FCookieManager: TIdCookieManager;
  public
    function PageSource(const AUrl: string; out AResponseText: string; out AErrorStr: string): Boolean;

    function Post(const AUrl: string; const APostData: TStringlist; out AResponseText: string; out AErrorStr: string): Boolean;

    procedure ClearCookies;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

const
  constUserAgent =
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36 OPR/50.0.2762.58';
  constConnectTimeOut = 5000;
  constReadTimeOut = 5000;

implementation

{ THTTPuploader }

procedure THTTPDownloader.AfterConstruction;
begin
  inherited;
  FCookieManager := TIdCookieManager.Create;

  sslSocket := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  sslSocket.SSLOptions.Method := sslvTLSv1_2;

  hpHtmlDownloader := TIdHTTP.Create;
  hpHtmlDownloader.HandleRedirects := True;
  hpHtmlDownloader.CookieManager := FCookieManager;
  hpHtmlDownloader.AllowCookies := True;
  hpHtmlDownloader.Request.UserAgent := constUserAgent;

  hpHtmlDownloader.IOHandler := sslSocket;
  hpHtmlDownloader.ConnectTimeout := constConnectTimeOut;
  hpHtmlDownloader.ReadTimeout := constReadTimeOut;
end;

procedure THTTPDownloader.BeforeDestruction;
begin
  inherited;
  FreeAndNilEx(FCookieManager);
  FreeAndNilEx(hpHtmlDownloader);
  FreeAndNilEx(sslSocket);
end;

procedure THTTPDownloader.ClearCookies;
begin
  hpHtmlDownloader.CookieManager.CookieCollection.Clear;
  hpHtmlDownloader.Response.CustomHeaders.Clear;
end;

function THTTPDownloader.PageSource(const AUrl: string; out AResponseText: string; out AErrorStr: string): Boolean;
begin
  Result := False;
  try
    AResponseText := hpHtmlDownloader.Get(AUrl);

    Result := True;
  except
    on E: Exception do
    begin
      AErrorStr := E.ClassName + E.Message;
    end;
  end;
end;

function THTTPDownloader.Post(const AUrl: string; const APostData: TStringlist; out AResponseText: string;
  out AErrorStr: string): Boolean;
begin
  Result := False;
  try
    if not Assigned(APostData) then
    begin
      AErrorStr := 'Пустые данные для отправки';
      Exit;
    end;

    AResponseText := hpHtmlDownloader.Post(AUrl, APostData);

    Result := True;
  except
    on E: Exception do
    begin
      AErrorStr := E.ClassName + E.Message;
    end;
  end;

end;

end.
