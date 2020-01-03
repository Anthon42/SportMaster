unit uMainFrom;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs
  // User moduls
    , uMessanger
  // Any moduls
    , Vcl.StdCtrls, Vcl.ExtCtrls, IdBaseComponent, IdCookieManager;

type
  TMainForm = class(TForm)
    pnTool: TPanel;
    btSend: TButton;
    meText: TMemo;
    edCityCode: TEdit;
    lbCountryCode: TLabel;
    edMidleNuber: TEdit;
    edDoubleNumber: TEdit;
    edEndNumber: TEdit;
    cbLoop: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btSendClick(Sender: TObject);
  private
    FMessanger: TMessanger;

    procedure LogMessage(const AMessage: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btSendClick(Sender: TObject);
var
  lPhone: string;
  lErrorStr: string;
begin
  lPhone := lbCountryCode.Caption;
  lPhone := lPhone + '+(' + edCityCode.Text + ')+';
  lPhone := lPhone + edMidleNuber.Text + '-';
  lPhone := lPhone + edDoubleNumber.Text + '-';
  lPhone := lPhone + edEndNumber.Text;
  repeat
    Application.ProcessMessages;
    if not FMessanger.SendMessage(lPhone, lErrorStr) then
    begin
      LogMessage(lErrorStr);
    end
    else
      LogMessage('Message sent to phone number ' + lPhone);
  until not cbLoop.Checked;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FMessanger := TMessanger.Create;
end;

procedure TMainForm.LogMessage(const AMessage: string);
begin
  if AMessage <> '' then
    meText.Lines.Add(AMessage)
  else
    meText.Lines.Add('Message is null');
end;

end.
