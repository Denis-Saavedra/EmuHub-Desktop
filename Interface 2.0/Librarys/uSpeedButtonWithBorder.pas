unit uSpeedButtonWithBorder;

interface

uses
  Vcl.Buttons, Vcl.Graphics, System.Classes, Winapi.Messages, Vcl.Controls;

type
  TSpeedButtonClass = class of TSpeedButton;
  TSpeedButtonWithBorder = class(TSpeedButton)
  private
    FMouseOver: Boolean;  // Vari�vel para armazenar o estado do mouse sobre o bot�o
  protected
    procedure Paint; override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;  // Detecta quando o mouse entra no bot�o
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;  // Detecta quando o mouse sai do bot�o
  public
    constructor Create(AOwner: TComponent); override;
  end;

// Procedimento para substituir o bot�o por outro da classe especificada
procedure ReplaceButton(var Velho: TSpeedButton; ClasseNova: TSpeedButtonClass);

implementation

uses
  Winapi.Windows;

{ TSpeedButtonWithBorder }

constructor TSpeedButtonWithBorder.Create(AOwner: TComponent);
begin
  inherited;
  Flat := True;         // Remove a borda "azulada" de foco do sistema
  ControlStyle := ControlStyle - [csCaptureMouse, csAcceptsControls]; // Remove foco visual
  FMouseOver := False;  // Inicializa o estado do mouse
end;

procedure ReplaceButton(var Velho: TSpeedButton; ClasseNova: TSpeedButtonClass);
var
  Novo: TSpeedButton;
begin
  // Cria um novo bot�o usando a classe fornecida
  Novo := ClasseNova.Create(Velho.Owner);
  with Novo do
  begin
    Parent := Velho.Parent;     // Define o mesmo pai
    Left := Velho.Left;         // Define a mesma posi��o
    Top := Velho.Top;
    Width := Velho.Width;       // Define o mesmo tamanho
    Height := Velho.Height;
    Caption := Velho.Caption;   // Define a mesma legenda
    OnClick := Velho.OnClick;   // Copia o evento OnClick
  end;

  // Remove e libera o bot�o antigo
  Velho.Free;

  // Substitui o bot�o antigo pelo novo
  Velho := Novo;
end;

procedure TSpeedButtonWithBorder.Paint;
var
  Rect: TRect;
  BorderColor: TColor;
begin
  inherited;

  // Definir a cor da borda com base no estado do bot�o
  if Down then
    BorderColor := clRed // Cor da borda ao clicar
  else if FMouseOver then
    BorderColor := clBlue // Cor da borda ao passar o mouse
  else
    BorderColor := clPurple; // Cor padr�o da borda

  // Configurar o desenho da borda
  Canvas.Pen.Color := BorderColor;
  Canvas.Pen.Width := 2;
  Canvas.Brush.Style := bsClear;

  // Evitar o fundo padr�o
  if not (csDesigning in ComponentState) then
    Canvas.FillRect(ClientRect);  // Preenche o fundo, se necess�rio

  // Ajustar o ret�ngulo para evitar sobreposi��o
  Rect := ClientRect;
  InflateRect(Rect, -1, -1); // Reduz o tamanho para n�o cobrir a borda interna

  // Desenhar a borda
  Canvas.Rectangle(Rect);
end;

procedure TSpeedButtonWithBorder.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseOver := True; // O mouse entrou no bot�o
  Invalidate; // Redesenha o bot�o para atualizar a borda
end;

procedure TSpeedButtonWithBorder.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseOver := False; // O mouse saiu do bot�o
  Invalidate; // Redesenha o bot�o para atualizar a borda
end;

end.

