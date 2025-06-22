program EmuHub;

uses
  Vcl.Forms,
  uPrincipal in 'Forms\uPrincipal.pas' {formPrincipal},
  uLibrary in 'uLibrary.pas',
  uDownload in 'TesteFuncionalidade\uDownload.pas' {FormDownload},
  uLogin in 'Forms\uLogin.pas' {Form1},
  uMenu in 'Forms\uMenu.pas' {formMenu},
  MyCustomPanel in 'Components\MyCustomPanel.pas',
  uEmpresas in 'Forms\uEmpresas.pas' {formEmpresas},
  uNintendo in 'Forms\uNintendo.pas' {formNintendo},
  uMenuPrincipal in 'Forms\uMenuPrincipal.pas' {formMenuPrincipal},
  uConfiguracoes in 'Forms\uConfiguracoes.pas' {formConfiguracoes},
  uSelecionaEmulador in 'Forms\uSelecionaEmulador.pas' {formSelecionaEmulador},
  uContas in 'Forms\uContas.pas' {formContas},
  uGBA in 'Forms\Emuladores\uGBA.pas' {formGBA},
  uGB in 'Forms\Emuladores\uGB.pas' {formGB},
  uGBC in 'Forms\Emuladores\uGBC.pas' {formGBC},
  uNDS in 'Forms\Emuladores\uNDS.pas' {formNDS},
  uN64 in 'Forms\Emuladores\uN64.pas' {formN64},
  uNES in 'Forms\Emuladores\uNES.pas' {formNES},
  uSNES in 'Forms\Emuladores\uSNES.pas' {formSNES},
  uSony in 'Forms\uSony.pas' {formSony},
  uSega in 'Forms\uSega.pas' {formSega},
  uSMS in 'Forms\Emuladores\uSMS.pas' {formSMS},
  uPS1 in 'Forms\Emuladores\uPS1.pas' {formPS1},
  uDC in 'Forms\Emuladores\uDC.pas' {formDC};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
