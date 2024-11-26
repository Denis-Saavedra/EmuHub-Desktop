program EmuHub;

uses
  Vcl.Forms,
  uPrincipal in 'Forms\uPrincipal.pas' {formPrincipal},
  uEmpresas in 'Forms\uEmpresas.pas' {formEmpresas},
  uNintendo in 'Forms\uNintendo.pas' {formNintendo},
  uGBA in 'Forms\uGBA.pas' {formGBA},
  uLibrary in 'uLibrary.pas',
  uDownload in 'TesteFuncionalidade\uDownload.pas' {FormDownload},
  uLogin in 'Forms\uLogin.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
