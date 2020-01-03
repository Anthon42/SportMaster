program MainProject;

uses
  Vcl.Forms,
  uMainFrom in 'uMainFrom.pas' {MainForm},
  uHttpDownloader in 'uHttpDownloader.pas',
  uExUtils in 'uExUtils.pas',
  uMessanger in 'uMessanger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
