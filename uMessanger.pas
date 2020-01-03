unit uMessanger;

interface

uses
  System.SysUtils, System.Classes
  // User moduls
    , uHTTPDownloader, uExUtils;

type

  TMessanger = class(TObject)
  strict private
    FHTTPDownloader: THTTPDownloader;

    function GetRegistationPage(out AErrorStr: string): Boolean;
    function GetSmsCode(const APhoneNumber: string; out AErrorStr: string): Boolean;
  public
    function SendMessage(const APhoneNuber: string; out AErrorStr: string): Boolean;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

const
  constRegistrationUrl = 'https://www.sportmaster.ru/user/session/register.do';
  constValidRegistrationText = 'Зарегистрируйтесь в Клубной программе сегодня и получите';
  constSmsCodeUrl = 'https://www.sportmaster.ru/user/session/sendSmsCode.do?phone=%2B';
  constUnixTime = '&_=157623171364';
  constValidSmsText = 'true';

implementation

{ TMeesanger }

procedure TMessanger.AfterConstruction;
begin
  inherited;
  FHTTPDownloader := THTTPDownloader.Create;
end;

procedure TMessanger.BeforeDestruction;
begin
  FreeAndNilEx(FHTTPDownloader);
  inherited;
end;

function TMessanger.GetRegistationPage(out AErrorStr: string): Boolean;
var
  lPageSource: string;
begin
  Result := False;
  try
    if FHTTPDownloader.PageSource(constRegistrationUrl, lPageSource, AErrorStr) then
    begin
      if Pos(constValidRegistrationText, lPageSource) > 0 then
        Result := True
      else
        AErrorStr := 'Error load page ' + Self.ClassName + ' GetRegistationPage ' + 'HTMLText = ' + lPageSource;
    end;
  except
    on E: Exception do
    begin
      AErrorStr := E.ClassName + E.Message;
    end;
  end;

end;

function TMessanger.GetSmsCode(const APhoneNumber: string; out AErrorStr: string): Boolean;
var
  lPageSourse: string;
begin
  Result := False;
  try
    if FHTTPDownloader.PageSource(constSmsCodeUrl + APhoneNumber + constUnixTime, lPageSourse, AErrorStr) then
    begin
      if Pos(constValidSmsText, lPageSourse) > 0 then
        Result := True
      else
        AErrorStr := 'Error load page ' + Self.ClassName + ' GetRegistationPage ' + 'HTMLText = ' + lPageSourse;
    end;
  except
    on E: Exception do
    begin
      AErrorStr := E.ClassName + E.Message;
    end;
  end;
end;

function TMessanger.SendMessage(const APhoneNuber: string; out AErrorStr: string): Boolean;
begin
  Result := False;
  try
    FHTTPDownloader.ClearCookies;

    if not GetRegistationPage(AErrorStr) then
      Exit;
    // It is necessary for correct work.
    Sleep(6000);

    if not GetSmsCode(APhoneNuber, AErrorStr) then
      Exit;

    Result := True;
  except
    on E: Exception do
    begin
      AErrorStr := E.ClassName + E.Message;
    end;
  end;

end;

end.
