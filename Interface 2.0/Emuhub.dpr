program Emuhub;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {formPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'EmuHub';
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
