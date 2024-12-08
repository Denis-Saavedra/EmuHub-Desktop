unit MyCustomPanel;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls,
  Vcl.Graphics, Vcl.ImageCollection, System.Math, Vcl.Imaging.pngimage;

type
  TMyCustomPanel = class(TPanel)
  private
    FBorderColor: TColor;
    FBorderWidth: Integer;
    FBorderRadius: Integer;
    FBorderEnabled: Boolean;
    FImageCollection: TImageCollection;
    FImageIndex: Integer;
    FImageWidth: Integer;
    FImageHeight: Integer;
    procedure SetImageCollection(const Value: TImageCollection);
    procedure SetImageIndex(const Value: Integer);
    procedure SetImageWidth(const Value: Integer);
    procedure SetImageHeight(const Value: Integer);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property BorderColor: TColor read FBorderColor write FBorderColor default clBlack;
    property BorderWidth: Integer read FBorderWidth write FBorderWidth default 2;
    property BorderRadius: Integer read FBorderRadius write FBorderRadius default 10;
    property BorderEnabled: Boolean read FBorderEnabled write FBorderEnabled default True;
    property ImageCollection: TImageCollection read FImageCollection write SetImageCollection;
    property ImageIndex: Integer read FImageIndex write SetImageIndex default -1;
    property ImageWidth: Integer read FImageWidth write SetImageWidth default 0;
    property ImageHeight: Integer read FImageHeight write SetImageHeight default 0;
  end;

procedure Register;

implementation

uses
  Winapi.Windows;

procedure Register;
begin
  RegisterComponents('CustomComponents', [TMyCustomPanel]);
end;

{ TMyCustomPanel }

constructor TMyCustomPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderColor := clBlack;
  FBorderWidth := 2;
  FBorderRadius := 10;
  FBorderEnabled := True;
  FImageIndex := -1; // Nenhuma imagem selecionada por padrão
  FImageCollection := nil;
  FImageWidth := 0;  // Por padrão, a largura será ajustada automaticamente
  FImageHeight := 0; // Por padrão, a altura será ajustada automaticamente
end;

procedure TMyCustomPanel.Paint;
var
  ImgRect: TRect;
  SourceImage: TGraphic;
  PngImage: TPngImage;
  ImgW, ImgH: Integer;
begin
  inherited Paint;

  // Desenhar a borda, se habilitada
  if FBorderEnabled then
  begin
    Canvas.Pen.Color := FBorderColor;
    Canvas.Pen.Width := FBorderWidth;
    Canvas.Brush.Style := bsClear;
    Canvas.RoundRect(FBorderWidth div 2, FBorderWidth div 2,
      Width - FBorderWidth div 2, Height - FBorderWidth div 2,
      FBorderRadius, FBorderRadius);
  end;

  // Desenhar a imagem, se configurada
  if Assigned(FImageCollection) and (FImageIndex >= 0) and
     (FImageIndex < FImageCollection.Count) then
  begin
    // Obter a imagem original da coleção
    SourceImage := FImageCollection.GetSourceImage(FImageIndex, imgW, imgH, True);

    // Verifica se a imagem é um PNG
    if SourceImage is TPngImage then
    begin
      PngImage := TPngImage(SourceImage); // Faz cast para TPngImage

      // Calcula o tamanho da imagem
      ImgW := IfThen(FImageWidth > 0, FImageWidth, Width div 4); // Largura padrão: 25% do painel
      ImgH := IfThen(FImageHeight > 0, FImageHeight, Height);    // Altura padrão: altura do painel

      // Define o retângulo para alinhar à esquerda
      ImgRect := Rect(
        FBorderWidth + 5,           // À esquerda (respeitando a borda)
        (Height - ImgH) div 2,  // Centraliza verticalmente
        FBorderWidth + ImgW,    // Limite direito
        (Height + ImgH) div 2   // Limite inferior
      );

      // Desenhar a imagem com transparência
      PngImage.Draw(Canvas, ImgRect);
    end
    else
    begin
      // Caso não seja TPngImage, desenha como bitmap ou outro formato
      Canvas.StretchDraw(
        Rect(
          FBorderWidth + 5,
          (Height - FImageHeight) div 2,
          FBorderWidth + FImageWidth,
          (Height - (Height - FImageHeight) div 2)
        ),
        SourceImage
      );
    end;
  end;
end;

procedure TMyCustomPanel.SetImageCollection(const Value: TImageCollection);
begin
  if FImageCollection <> Value then
  begin
    FImageCollection := Value;
    Invalidate; // Redesenha o componente
  end;
end;

procedure TMyCustomPanel.SetImageIndex(const Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Invalidate; // Redesenha o componente
  end;
end;

procedure TMyCustomPanel.SetImageWidth(const Value: Integer);
begin
  if FImageWidth <> Value then
  begin
    FImageWidth := Value;
    Invalidate; // Redesenha o componente
  end;
end;

procedure TMyCustomPanel.SetImageHeight(const Value: Integer);
begin
  if FImageHeight <> Value then
  begin
    FImageHeight := Value;
    Invalidate; // Redesenha o componente
  end;
end;

end.

