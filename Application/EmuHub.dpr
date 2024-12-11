program EmuHub;

uses
  Vcl.Forms,
  uPrincipal in 'Forms\uPrincipal.pas' {formPrincipal},
  uGBA in 'Forms\uGBA.pas' {formGBA},
  uLibrary in 'uLibrary.pas',
  uDownload in 'TesteFuncionalidade\uDownload.pas' {FormDownload},
  uLogin in 'Forms\uLogin.pas' {Form1},
  uMenu in 'Forms\uMenu.pas' {formMenu},
  MyCustomPanel in 'Components\MyCustomPanel.pas',
  uEmpresas in 'Forms\uEmpresas.pas' {formEmpresas},
  uNintendo in 'Forms\uNintendo.pas' {formNintendo},
  uMenuPrincipal in 'Forms\uMenuPrincipal.pas' {formMenuPrincipal},
  uConfiguracoes in 'Forms\uConfiguracoes.pas' {formConfiguracoes},
  uSelecionaEmulador in 'Forms\uSelecionaEmulador.pas' {formSelecionaEmulador};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TformMenu, formMenu);
  Application.CreateForm(TformEmpresas, formEmpresas);
  Application.CreateForm(TformNintendo, formNintendo);
  Application.CreateForm(TformMenuPrincipal, formMenuPrincipal);
  Application.CreateForm(TformConfiguracoes, formConfiguracoes);
  Application.CreateForm(TformSelecionaEmulador, formSelecionaEmulador);
  Application.Run;
end.
