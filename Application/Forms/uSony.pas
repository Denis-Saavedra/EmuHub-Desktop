unit uSony;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, MyCustomPanel,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TformSony = class(TForm)
    pnlPrincipal: TPanel;
    btnPS: TMyCustomPanel;
    ImageCollection1: TImageCollection;
    btnPS2: TMyCustomPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPSClick(Sender: TObject);
    procedure btnPS2Click(Sender: TObject);
    procedure btnPSMouseEnter(Sender: TObject);
    procedure btnPSMouseLeave(Sender: TObject);
    procedure btnPS2MouseEnter(Sender: TObject);
    procedure btnPS2MouseLeave(Sender: TObject);
  private
    { Private declarations }
    procedure TrocaBotaoAtivo(botao: String);
  public
    { Public declarations }
    btnAtivo: TMyCustomPanel;
  protected
    { Protected declarations }
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
  end;


var
  formSony: TformSony;

implementation

uses
  uMenu, uLibrary;

{$R *.dfm}

procedure TformSony.TrocaBotaoAtivo(botao: String);
begin
  TformMenu(Owner).BotaoAtivo.BorderEnabled := False;
  TformMenu(Owner).BotaoAtivo.Repaint;

  //Trata o Botão Ativo Anterior
  if Assigned(btnAtivo) then
  begin
    btnAtivo.Enabled := True;
    btnAtivo.BorderEnabled := False;
    btnAtivo.Repaint;
  end;

  //Verifica qual o botão clicado
  if botao = 'PS' then
    btnAtivo := btnPS
  else if botao = 'PS2' then
    btnAtivo := btnPS2;

  //Trata o Novo Botão
  btnAtivo.Enabled := False;
  btnAtivo.BorderEnabled := True;
  btnAtivo.Repaint;
end;

procedure TformSony.btnPS2Click(Sender: TObject);
begin
  TrocaBotaoAtivo('PS2');
  TformMenu(Owner).TrocaFormAtivo('PS2');
end;

procedure TformSony.btnPS2MouseEnter(Sender: TObject);
begin
  HoverOn(btnPS2);
end;

procedure TformSony.btnPS2MouseLeave(Sender: TObject);
begin
  HoverOff(btnPS2);
end;

procedure TformSony.btnPSClick(Sender: TObject);
begin
  TrocaBotaoAtivo('PS');
  TformMenu(Owner).TrocaFormAtivo('PS');
end;

procedure TformSony.btnPSMouseEnter(Sender: TObject);
begin
  HoverOn(btnPS);
end;

procedure TformSony.btnPSMouseLeave(Sender: TObject);
begin
  HoverOff(btnPS);
end;

procedure TformSony.FormCreate(Sender: TObject);
begin
  Application.OnMessage := AppMessage;
end;

procedure TformSony.FormShow(Sender: TObject);
begin
  //Trata o Panel
  pnlPrincipal.Color := RGB(55, 55, 55);
  pnlPrincipal.Repaint;

  //Trata os Botões
  btnPS.BorderEnabled := False;
  btnPS2.BorderEnabled := False;
end;

procedure TformSony.AppMessage(var Msg: TMsg; var Handled: Boolean);
var
  LocalPoint: TPoint;
  ControlUnderMouse: TControl;
begin
  // Captura o evento de clique do botão direito do mouse
  if Msg.message = WM_RBUTTONDOWN then
  begin
    // Converte as coordenadas globais para locais
    LocalPoint := ScreenToClient(Point(Msg.pt.x, Msg.pt.y));

    // Verifica se o clique está dentro do formulário
    if PtInRect(Self.ClientRect, LocalPoint) then
    begin
      // Descobre qual controle está sob o mouse
      ControlUnderMouse := ControlAtPos(LocalPoint, True, True);
      if Assigned(ControlUnderMouse) then
      begin
        // Executa a ação desejada (troca de formulário)
        TformMenu(Owner).TrocaFormMenu('Empresas');
        Handled := True; // Marca a mensagem como processada
      end;
    end;
  end;
end;

end.
