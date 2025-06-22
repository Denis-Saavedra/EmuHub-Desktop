unit uMenuPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, MyCustomPanel,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TformMenuPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    btnCarregarNucleo: TMyCustomPanel;
    ImageCollection1: TImageCollection;
    btnCarregarRom: TMyCustomPanel;
    btnFechar: TMyCustomPanel;
    procedure FormShow(Sender: TObject);
    procedure btnCarregarNucleoMouseEnter(Sender: TObject);
    procedure btnCarregarNucleoMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCarregarRomMouseEnter(Sender: TObject);
    procedure btnCarregarRomMouseLeave(Sender: TObject);
    procedure btnCarregarNucleoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFecharMouseEnter(Sender: TObject);
    procedure btnFecharMouseLeave(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCarregarRomClick(Sender: TObject);
  private
    { Private declarations }
    DiretorioPadrao: String;
  public
    { Public declarations }
    EmuladorSelecionado: String;
  end;

var
  formMenuPrincipal: TformMenuPrincipal;

implementation

uses
  uLibrary, System.IOUtils, uSelecionaEmulador;

{$R *.dfm}

procedure TformMenuPrincipal.btnCarregarNucleoClick(Sender: TObject);
var
  OpenDialog: TOpenDialog;
  DllFile: string;
  DestPath: string;
begin
  // Configurar a pasta de destino (altere para o local desejado)
  DestPath := DiretorioPadrao + '\RaLibRetro\Cores\';
  if not TDirectory.Exists(DestPath) then
    TDirectory.CreateDirectory(DestPath);

  // Criar e configurar o diálogo de seleção de arquivos
  OpenDialog := TOpenDialog.Create(Self);
  try
    // Selecionar o arquivo .dll
    OpenDialog.Title := 'Selecione o arquivo .DLL';
    OpenDialog.Filter := 'Bibliotecas DLL|*.dll';
    if not OpenDialog.Execute then
    begin
      ShowMessage('Operação cancelada.');
      Exit;
    end;
    DllFile := OpenDialog.FileName;

    // Copiar os arquivo para a pasta de destino
    TFile.Copy(DllFile, TPath.Combine(DestPath, TPath.GetFileName(DllFile)), True);

    // Exibir mensagem de sucesso
    ShowMessage('Core incluido com sucesso!');
  finally
    OpenDialog.Free;
  end;
end;

procedure TformMenuPrincipal.btnCarregarNucleoMouseEnter(Sender: TObject);
begin
  HoverOn(btnCarregarNucleo);
end;

procedure TformMenuPrincipal.btnCarregarNucleoMouseLeave(Sender: TObject);
begin
  HoverOff(btnCarregarNucleo);
end;

procedure TformMenuPrincipal.btnCarregarRomClick(Sender: TObject);
var
  Emulador: String;
  OpenDialog: TOpenDialog;
  Rom: string;
  DestPath: string;
begin
  formSelecionaEmulador := TformSelecionaEmulador.Create(Self);
  formSelecionaEmulador.ShowModal;

  if EmuladorSelecionado = 'Game Boy' then
    Emulador := 'GB'
  else if EmuladorSelecionado = 'Game Boy Color' then
    Emulador := 'GBC'
  else if EmuladorSelecionado = 'Game Boy Advanced' then
    Emulador := 'GBA'
  else if EmuladorSelecionado = 'Nintendo DS' then
    Emulador := 'DS'
  else if EmuladorSelecionado = 'Nintendinho' then
    Emulador := 'NES'
  else if EmuladorSelecionado = 'Super Nintendo' then
    Emulador := 'SNES'
  else if EmuladorSelecionado = 'Nintendo 64' then
    Emulador := 'N64'
  else if EmuladorSelecionado = 'Playstation' then
    Emulador := 'PS'
  else if EmuladorSelecionado = 'Playstation 2' then
    Emulador := 'P2'
  else if EmuladorSelecionado = 'Master System' then
    Emulador := 'SMS'
  else if EmuladorSelecionado = 'Dream Cast' then
    Emulador := 'DC'
  else
    Emulador := '';

  EmuladorSelecionado := '';

  if Emulador <> '' then
  begin
    // Configurar a pasta de destino (altere para o local desejado)
    DestPath := DiretorioPadrao + '\' + Emulador + '\';
    if not TDirectory.Exists(DestPath) then
      TDirectory.CreateDirectory(DestPath);

    // Criar e configurar o diálogo de seleção de arquivos
    OpenDialog := TOpenDialog.Create(Self);
    try
      // Selecionar a rom
      OpenDialog.Title := 'Selecione a ROM';
      if not OpenDialog.Execute then
      begin
        ShowMessage('Operação cancelada.');
        Exit;
      end;
      Rom := OpenDialog.FileName;

      // Copiar os arquivos para a pasta de destino
      TFile.Copy(Rom, TPath.Combine(DestPath, TPath.GetFileName(Rom)), True);

      // Exibir mensagem de sucesso
      ShowMessage('Rom carregada com sucesso!');
    finally
      OpenDialog.Free;
    end;
  end;
end;

procedure TformMenuPrincipal.btnCarregarRomMouseEnter(Sender: TObject);
begin
  HoverOn(btnCarregarRom);
end;

procedure TformMenuPrincipal.btnCarregarRomMouseLeave(Sender: TObject);
begin
  HoverOff(btnCarregarRom);
end;

procedure TformMenuPrincipal.btnFecharClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TformMenuPrincipal.btnFecharMouseEnter(Sender: TObject);
begin
  HoverOn(btnFechar);
end;

procedure TformMenuPrincipal.btnFecharMouseLeave(Sender: TObject);
begin
  HoverOff(btnFechar);
end;

procedure TformMenuPrincipal.FormCreate(Sender: TObject);
begin
  DiretorioPadrao := PegaDiretorio;
end;

procedure TformMenuPrincipal.FormResize(Sender: TObject);
begin
  btnCarregarNucleo.Width := pnlPrincipal.Width - 55;
  btnCarregarRom.Width := pnlPrincipal.Width - 55;
  btnFechar.Width := pnlPrincipal.Width - 55;
end;

procedure TformMenuPrincipal.FormShow(Sender: TObject);
begin
  //Trata painel
  pnlPrincipal.Color := RGB(40, 40, 40);
  pnlPrincipal.Repaint;

  //Trata Botões
  btnCarregarNucleo.BorderEnabled := False;
  btnCarregarRom.BorderEnabled := False;
  btnFechar.BorderEnabled := False;
end;



end.
