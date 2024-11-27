unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.TitleBarCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.VirtualImage;

type
  TformPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    pnlSuperior: TPanel;
    pnlLateral: TPanel;
    vimageLogo: TVirtualImage;
    ImageCollection: TImageCollection;
    LabelMenu: TLabel;
    pnlLogo: TPanel;
    pnlAdicionais: TPanel;
    VimgData: TVirtualImage;
    VimgBateria: TVirtualImage;
    labelData: TLabel;
    labelBateria: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function GetBatteryPercentage: Integer;
    procedure AtualizaDataBateria;
  public
    { Public declarations }
  end;

var
  formPrincipal: TformPrincipal;

implementation

var
  Timer1: Ttimer;

{$R *.dfm}

procedure TformPrincipal.AtualizaDataBateria;
  var
  BatteryPercentage: Integer;
begin
  // Obter porcentagem da bateria
  BatteryPercentage := GetBatteryPercentage;
  labelBateria.Caption := IntToStr(BatteryPercentage) + '%';
  if BatteryPercentage > 80 then
    VimgBateria.ImageIndex := 1
  else if BatteryPercentage > 60 then
    VimgBateria.ImageIndex := 2
  else if BatteryPercentage > 40 then
    VimgBateria.ImageIndex := 3
  else if BatteryPercentage > 20 then
    VimgBateria.ImageIndex := 4
  else
    VimgBateria.ImageIndex := 5;


  // Atualizar data e hora
  labelData.Caption := FormatDateTime('dd/mm/yy', Now);
end;

procedure TformPrincipal.FormCreate(Sender: TObject);
begin
  AtualizaDataBateria;
  // Cria o Timer dinamicamente
  Timer1 := TTimer.Create(Self);
  Timer1.Interval := 1000; // Atualiza a cada 1 segundo
  Timer1.OnTimer := Timer1Timer; // Liga o evento OnTimer
  Timer1.Enabled := True; // Habilita o Timer

  //Muda as cores dos panels
  pnlPrincipal.Color := RGB(40, 40, 40);
  pnlPrincipal.Repaint;
  pnlSuperior.Color := RGB(40, 40, 40);
  pnlSuperior.Repaint;
  pnlLateral.Color := RGB(55, 55, 55);
  pnlLateral.Repaint;
end;

procedure TformPrincipal.FormDestroy(Sender: TObject);
begin
  // Libera o Timer ao fechar o formulário
  Timer1.Free;
end;

function TformPrincipal.GetBatteryPercentage: Integer;
var
  PowerStatus: TSystemPowerStatus;
begin
  if GetSystemPowerStatus(PowerStatus) then
    Result := PowerStatus.BatteryLifePercent
  else
    Result := -1; // Retorna -1 se houver erro
end;

procedure TformPrincipal.Timer1Timer(Sender: TObject);
begin
  AtualizaDataBateria;
end;

end.
