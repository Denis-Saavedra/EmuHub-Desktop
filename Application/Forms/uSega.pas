unit uSega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, MyCustomPanel,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TformSega = class(TForm)
    pnlPrincipal: TPanel;
    btnSMS: TMyCustomPanel;
    ImageCollection1: TImageCollection;
    btnDC: TMyCustomPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSMSClick(Sender: TObject);
    procedure btnDCClick(Sender: TObject);
    procedure btnSMSMouseEnter(Sender: TObject);
    procedure btnSMSMouseLeave(Sender: TObject);
    procedure btnDCMouseEnter(Sender: TObject);
    procedure btnDCMouseLeave(Sender: TObject);
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
  formSega: TformSega;

implementation

uses
  uMenu, uLibrary;

{$R *.dfm}

procedure TformSega.TrocaBotaoAtivo(botao: String);
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
  if botao = 'SMS' then
    btnAtivo := btnSMS
  else if botao = 'DC' then
    btnAtivo := btnDC;

  //Trata o Novo Botão
  btnAtivo.Enabled := False;
  btnAtivo.BorderEnabled := True;
  btnAtivo.Repaint;
end;

procedure TformSega.btnDCClick(Sender: TObject);
begin
  TrocaBotaoAtivo('DC');
  TformMenu(Owner).TrocaFormAtivo('DC');
end;

procedure TformSega.btnDCMouseEnter(Sender: TObject);
begin
  HoverOn(btnDC);
end;

procedure TformSega.btnDCMouseLeave(Sender: TObject);
begin
  HoverOff(btnDC);
end;

procedure TformSega.btnSMSClick(Sender: TObject);
begin
  TrocaBotaoAtivo('SMS');
  TformMenu(Owner).TrocaFormAtivo('SMS');
end;

procedure TformSega.btnSMSMouseEnter(Sender: TObject);
begin
  HoverOn(btnSMS);
end;

procedure TformSega.btnSMSMouseLeave(Sender: TObject);
begin
  HoverOff(btnSMS);
end;

procedure TformSega.FormCreate(Sender: TObject);
begin
  Application.OnMessage := AppMessage;
end;

procedure TformSega.FormShow(Sender: TObject);
begin
  //Trata o Panel
  pnlPrincipal.Color := RGB(55, 55, 55);
  pnlPrincipal.Repaint;

  //Trata os Botões
  btnSMS.BorderEnabled := False;
  btnDC.BorderEnabled := False;
end;

procedure TformSega.AppMessage(var Msg: TMsg; var Handled: Boolean);
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
