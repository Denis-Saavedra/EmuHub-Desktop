unit uSpeedButtonWithBorder;

interface

uses
  Vcl.Buttons, Vcl.Graphics, System.Classes, Winapi.Messages, Vcl.Controls;

type
  TSpeedButtonClass = class of TSpeedButton;
  TSpeedButtonWithBorder = class(TSpeedButton)
  private
    FMouseOver: Boolean;  // Variável para armazenar o estado do mouse sobre o botão
  protected
    procedure Paint; override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;  // Detecta quando o mouse entra no botão
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;  // Detecta quando o mouse sai do botão
  public
    constructor Create(AOwner: TComponent); override;
  end;

// Procedimento para substituir o botão por outro da classe especificada
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
  // Cria um novo botão usando a classe fornecida
  Novo := ClasseNova.Create(Velho.Owner);
  with Novo do
  begin
    Parent := Velho.Parent;     // Define o mesmo pai
    Left := Velho.Left;         // Define a mesma posição
    Top := Velho.Top;
    Width := Velho.Width;       // Define o mesmo tamanho
    Height := Velho.Height;
    Caption := Velho.Caption;   // Define a mesma legenda
    OnClick := Velho.OnClick;   // Copia o evento OnClick
  end;

  // Remove e libera o botão antigo
  Velho.Free;

  // Substitui o botão antigo pelo novo
  Velho := Novo;
end;

procedure TSpeedButtonWithBorder.Paint;
var
  Rect: TRect;
  BorderColor: TColor;
begin
  inherited;

  // Definir a cor da borda com base no estado do botão
  if Down then
    BorderColor := clRed // Cor da borda ao clicar
  else if FMouseOver then
    BorderColor := clBlue // Cor da borda ao passar o mouse
  else
    BorderColor := clPurple; // Cor padrão da borda

  // Configurar o desenho da borda
  Canvas.Pen.Color := BorderColor;
  Canvas.Pen.Width := 2;
  Canvas.Brush.Style := bsClear;

  // Evitar o fundo padrão
  if not (csDesigning in ComponentState) then
    Canvas.FillRect(ClientRect);  // Preenche o fundo, se necessário

  // Ajustar o retângulo para evitar sobreposição
  Rect := ClientRect;
  InflateRect(Rect, -1, -1); // Reduz o tamanho para não cobrir a borda interna

  // Desenhar a borda
  Canvas.Rectangle(Rect);
end;

procedure TSpeedButtonWithBorder.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseOver := True; // O mouse entrou no botão
  Invalidate; // Redesenha o botão para atualizar a borda
end;

procedure TSpeedButtonWithBorder.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseOver := False; // O mouse saiu do botão
  Invalidate; // Redesenha o botão para atualizar a borda
end;

end.

