unit uNintendo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, MyCustomPanel,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TformNintendo = class(TForm)
    pnlPrincipal: TPanel;
    btnGB: TMyCustomPanel;
    ImageCollection1: TImageCollection;
    btnGBC: TMyCustomPanel;
    btnGBA: TMyCustomPanel;
    btnDS: TMyCustomPanel;
    btnN64: TMyCustomPanel;
    btnSNES: TMyCustomPanel;
    btnNES: TMyCustomPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGBClick(Sender: TObject);
    procedure btnGBCClick(Sender: TObject);
    procedure btnGBAClick(Sender: TObject);
    procedure btnDSClick(Sender: TObject);
    procedure btnNESClick(Sender: TObject);
    procedure btnSNESClick(Sender: TObject);
    procedure btnGCClick(Sender: TObject);
    procedure btnN64Click(Sender: TObject);
    procedure btnGBMouseEnter(Sender: TObject);
    procedure btnGBMouseLeave(Sender: TObject);
    procedure btnGBCMouseEnter(Sender: TObject);
    procedure btnGBCMouseLeave(Sender: TObject);
    procedure btnGBAMouseEnter(Sender: TObject);
    procedure btnGBAMouseLeave(Sender: TObject);
    procedure btnDSMouseEnter(Sender: TObject);
    procedure btnDSMouseLeave(Sender: TObject);
    procedure btnNESMouseEnter(Sender: TObject);
    procedure btnNESMouseLeave(Sender: TObject);
    procedure btnSNESMouseEnter(Sender: TObject);
    procedure btnSNESMouseLeave(Sender: TObject);
    procedure btnN64MouseEnter(Sender: TObject);
    procedure btnN64MouseLeave(Sender: TObject);
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
  formNintendo: TformNintendo;

implementation

uses
  uMenu, uLibrary;

{$R *.dfm}

procedure TformNintendo.TrocaBotaoAtivo(botao: String);
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
  if botao = 'GB' then
    btnAtivo := btnGB
  else if botao = 'GBC' then
    btnAtivo := btnGBC
  else if botao = 'GBA' then
    btnAtivo := btnGBA
  else if botao = 'DS' then
    btnAtivo := btnDS
  else if botao = 'NES' then
    btnAtivo := btnNES
  else if botao = 'SNES' then
    btnAtivo := btnSNES
  else if botao = 'N64' then
    btnAtivo := btnN64;

  //Trata o Novo Botão
  btnAtivo.Enabled := False;
  btnAtivo.BorderEnabled := True;
  btnAtivo.Repaint;
end;

procedure TformNintendo.btnDSClick(Sender: TObject);
begin
  TrocaBotaoAtivo('DS');
  TformMenu(Owner).TrocaFormAtivo('NDS');
end;

procedure TformNintendo.btnDSMouseEnter(Sender: TObject);
begin
    HoverOn(btnDS);
end;

procedure TformNintendo.btnDSMouseLeave(Sender: TObject);
begin
    HoverOff(btnDS);
end;

procedure TformNintendo.btnGBAClick(Sender: TObject);
begin
  TrocaBotaoAtivo('GBA');
  TformMenu(Owner).TrocaFormAtivo('GBA');
end;

procedure TformNintendo.btnGBAMouseEnter(Sender: TObject);
begin
    HoverOn(btnGBA);
end;

procedure TformNintendo.btnGBAMouseLeave(Sender: TObject);
begin
  HoverOff(btnGBA);
end;

procedure TformNintendo.btnGBCClick(Sender: TObject);
begin
  TrocaBotaoAtivo('GBC');
  TformMenu(Owner).TrocaFormAtivo('GBC');
end;

procedure TformNintendo.btnGBClick(Sender: TObject);
begin
  TrocaBotaoAtivo('GB');
  TformMenu(Owner).TrocaFormAtivo('GB');
end;

procedure TformNintendo.btnGBCMouseEnter(Sender: TObject);
begin
    HoverOn(btnGBC);
end;

procedure TformNintendo.btnGBCMouseLeave(Sender: TObject);
begin
    HoverOff(btnGBC);
end;

procedure TformNintendo.btnGBMouseEnter(Sender: TObject);
begin
  HoverOn(btnGB);
end;

procedure TformNintendo.btnGBMouseLeave(Sender: TObject);
begin
  HoverOff(btnGB);
end;

procedure TformNintendo.btnGCClick(Sender: TObject);
begin
  TrocaBotaoAtivo('GC');
end;

procedure TformNintendo.btnN64Click(Sender: TObject);
begin
  TrocaBotaoAtivo('N64');
  TformMenu(Owner).TrocaFormAtivo('N64');
end;

procedure TformNintendo.btnN64MouseEnter(Sender: TObject);
begin
  HoverOn(btnN64);
end;

procedure TformNintendo.btnN64MouseLeave(Sender: TObject);
begin
  HoverOff(btnN64);
end;

procedure TformNintendo.btnNESClick(Sender: TObject);
begin
  TrocaBotaoAtivo('NES');
  TformMenu(Owner).TrocaFormAtivo('NES');
end;

procedure TformNintendo.btnNESMouseEnter(Sender: TObject);
begin
    HoverOn(btnNES);
end;

procedure TformNintendo.btnNESMouseLeave(Sender: TObject);
begin
    HoverOff(btnNES);
end;

procedure TformNintendo.btnSNESClick(Sender: TObject);
begin
  TrocaBotaoAtivo('SNES');
  TformMenu(Owner).TrocaFormAtivo('SNES');
end;

procedure TformNintendo.btnSNESMouseEnter(Sender: TObject);
begin
  HoverOn(btnSNES);
end;

procedure TformNintendo.btnSNESMouseLeave(Sender: TObject);
begin
  HoverOff(btnSNES);
end;

procedure TformNintendo.FormCreate(Sender: TObject);
begin
  Application.OnMessage := AppMessage;
end;

procedure TformNintendo.FormShow(Sender: TObject);
begin
  //Trata o Panel
  pnlPrincipal.Color := RGB(55, 55, 55);
  pnlPrincipal.Repaint;

  //Trata os Botões
  btnGB.BorderEnabled := False;
  btnGBC.BorderEnabled := False;
  btnGBA.BorderEnabled := False;
  btnDS.BorderEnabled := False;
  btnNES.BorderEnabled := False;
  btnSNES.BorderEnabled := False;
  btnN64.BorderEnabled := False;
end;

procedure TformNintendo.AppMessage(var Msg: TMsg; var Handled: Boolean);
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
