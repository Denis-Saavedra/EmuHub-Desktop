unit uContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, MyCustomPanel,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TformContas = class(TForm)
    pnlPrincipal: TPanel;
    btnUsuario: TMyCustomPanel;
    btnRA: TMyCustomPanel;
    ImageCollection1: TImageCollection;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnUsuarioMouseEnter(Sender: TObject);
    procedure btnUsuarioMouseLeave(Sender: TObject);
    procedure btnRAMouseEnter(Sender: TObject);
    procedure btnRAMouseLeave(Sender: TObject);
    procedure btnUsuarioClick(Sender: TObject);
    procedure btnRAClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formContas: TformContas;

implementation

uses
  uLibrary, uMenu, ShellAPI;

{$R *.dfm}

procedure TformContas.btnRAClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('https://retroachievements.org/login'), nil, nil, SW_SHOWNORMAL);
end;

procedure TformContas.btnRAMouseEnter(Sender: TObject);
begin
  HoverOn(btnRA);
end;

procedure TformContas.btnRAMouseLeave(Sender: TObject);
begin
  HoverOff(btnRA);
end;

procedure TformContas.btnUsuarioClick(Sender: TObject);
begin
  TformMenu(Owner).TrocaFormAtivo('Login');
end;

procedure TformContas.btnUsuarioMouseEnter(Sender: TObject);
begin
  HoverOn(btnUsuario);
end;

procedure TformContas.btnUsuarioMouseLeave(Sender: TObject);
begin
  HoverOff(btnUsuario);
end;

procedure TformContas.FormResize(Sender: TObject);
begin
  btnUsuario.Width := pnlPrincipal.Width - 55;
  btnRA.Width := pnlPrincipal.Width - 55;
end;

procedure TformContas.FormShow(Sender: TObject);
begin
  //Trata painel
  pnlPrincipal.Color := RGB(40, 40, 40);
  pnlPrincipal.Repaint;

  //Trata Botões
  btnUsuario.BorderEnabled := False;
  btnRA.BorderEnabled := False;
end;

end.
