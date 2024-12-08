program Emuhub;

uses
  Vcl.Forms,
  uSpeedButtonWithBorder in 'Librarys\uSpeedButtonWithBorder.pas',
  uPrincipal in 'Formularios\uPrincipal.pas' {formPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'EmuHub';
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
