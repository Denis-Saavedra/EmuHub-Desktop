unit uConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, MyCustomPanel,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TformConfiguracoes = class(TForm)
    pnlPrincipal: TPanel;
    btnContas: TMyCustomPanel;
    ImageCollection1: TImageCollection;
    btnDiretorio: TMyCustomPanel;
    btnSalvamento: TMyCustomPanel;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnContasMouseEnter(Sender: TObject);
    procedure btnContasMouseLeave(Sender: TObject);
    procedure btnDiretorioMouseEnter(Sender: TObject);
    procedure btnDiretorioMouseLeave(Sender: TObject);
    procedure btnSalvamentoMouseEnter(Sender: TObject);
    procedure btnSalvamentoMouseLeave(Sender: TObject);
    procedure btnDiretorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSalvamentoClick(Sender: TObject);
    procedure btnContasClick(Sender: TObject);
  private
    { Private declarations }
    DiretorioPadrao: String;
  public
    { Public declarations }
  end;

var
  formConfiguracoes: TformConfiguracoes;

implementation

uses
  uLibrary, ShellAPI, uMenu;

{$R *.dfm}

procedure TformConfiguracoes.btnContasClick(Sender: TObject);
begin
  TformMenu(Owner).TrocaFormAtivo('Contas');
end;

procedure TformConfiguracoes.btnContasMouseEnter(Sender: TObject);
begin
  HoverOn(btnContas);
end;

procedure TformConfiguracoes.btnContasMouseLeave(Sender: TObject);
begin
  HoverOff(btnContas);
end;

procedure TformConfiguracoes.btnDiretorioClick(Sender: TObject);
var
  Pasta: string;
begin
  // Defina o caminho da pasta que você deseja abrir
  Pasta := DiretorioPadrao;

  // Verifique se a pasta existe
  if DirectoryExists(Pasta) then
  begin
    ShellExecute(0, 'open', PChar(Pasta), nil, nil, SW_SHOWNORMAL);
  end
  else
  begin
    ShowMessage('A pasta especificada não existe: ' + Pasta);
  end;
end;

procedure TformConfiguracoes.btnDiretorioMouseEnter(Sender: TObject);
begin
  HoverOn(btnDiretorio);
end;

procedure TformConfiguracoes.btnDiretorioMouseLeave(Sender: TObject);
begin
  HoverOff(btnDiretorio);
end;

procedure TformConfiguracoes.btnSalvamentoClick(Sender: TObject);
var
  Pasta: string;
begin
  // Defina o caminho da pasta que você deseja abrir
  Pasta := DiretorioPadrao + '\RaLibRetro\Saves\';

  // Verifique se a pasta existe
  if DirectoryExists(Pasta) then
  begin
    ShellExecute(0, 'open', PChar(Pasta), nil, nil, SW_SHOWNORMAL);
  end
  else
  begin
    ShowMessage('A pasta especificada não existe: ' + Pasta);
  end;
end;

procedure TformConfiguracoes.btnSalvamentoMouseEnter(Sender: TObject);
begin
  HoverOn(btnSalvamento);
end;

procedure TformConfiguracoes.btnSalvamentoMouseLeave(Sender: TObject);
begin
  HoverOff(btnSalvamento);
end;

procedure TformConfiguracoes.FormCreate(Sender: TObject);
begin
  DiretorioPadrao := PegaDiretorio;
end;

procedure TformConfiguracoes.FormResize(Sender: TObject);
begin
  btnContas.Width := pnlPrincipal.Width - 55;
  btnDiretorio.Width := pnlPrincipal.Width - 55;
  btnSalvamento.Width := pnlPrincipal.Width - 55;
end;

procedure TformConfiguracoes.FormShow(Sender: TObject);
begin
  //Trata painel
  pnlPrincipal.Color := RGB(40, 40, 40);
  pnlPrincipal.Repaint;

  //Trata Botões
  btnContas.BorderEnabled := False;
  btnDiretorio.BorderEnabled := False;
  btnSalvamento.BorderEnabled := False;
end;

end.
