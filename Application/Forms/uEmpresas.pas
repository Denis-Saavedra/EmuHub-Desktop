unit uEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, MyCustomPanel,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TformEmpresas = class(TForm)
    pnlPrincipal: TPanel;
    btnNintendo: TMyCustomPanel;
    btnSega: TMyCustomPanel;
    btnSony: TMyCustomPanel;
    ImageCollection1: TImageCollection;
    procedure FormShow(Sender: TObject);
    procedure btnNintendoClick(Sender: TObject);
    procedure btnNintendoMouseEnter(Sender: TObject);
    procedure btnNintendoMouseLeave(Sender: TObject);
    procedure btnSegaMouseEnter(Sender: TObject);
    procedure btnSegaMouseLeave(Sender: TObject);
    procedure btnSonyMouseEnter(Sender: TObject);
    procedure btnSonyMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formEmpresas: TformEmpresas;

implementation

uses
  uMenu;

{$R *.dfm}

procedure TformEmpresas.btnNintendoClick(Sender: TObject);
begin
  TformMenu(Owner).TrocaFormMenu('Nintendo');
end;

procedure TformEmpresas.btnNintendoMouseEnter(Sender: TObject);
begin
  btnNintendo.BorderEnabled := True;
  btnNintendo.Repaint;
end;

procedure TformEmpresas.btnNintendoMouseLeave(Sender: TObject);
begin
  btnNintendo.BorderEnabled := False;
  btnNintendo.Repaint;
end;

procedure TformEmpresas.btnSegaMouseEnter(Sender: TObject);
begin
  btnSega.BorderEnabled := True;
  btnSega.Repaint;
end;

procedure TformEmpresas.btnSegaMouseLeave(Sender: TObject);
begin
  btnSega.BorderEnabled := False;
  btnSega.Repaint;
end;

procedure TformEmpresas.btnSonyMouseEnter(Sender: TObject);
begin
  btnSony.BorderEnabled := True;
  btnSony.Repaint;
end;

procedure TformEmpresas.btnSonyMouseLeave(Sender: TObject);
begin
  btnSony.BorderEnabled := False;
  btnSony.Repaint;
end;

procedure TformEmpresas.FormShow(Sender: TObject);
begin
  //Trata o Panel
  pnlPrincipal.Color := RGB(55, 55, 55);
  pnlPrincipal.Repaint;

  //Trata os botões
  btnNintendo.BorderEnabled := False;
  btnSega.BorderEnabled := False;
  btnSony.BorderEnabled := False;
end;

end.
