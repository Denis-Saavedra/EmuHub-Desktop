unit uMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.TitleBarCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.BaseImageCollection, Vcl.ImageCollection,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.VirtualImage,
  MyCustomPanel;

type
  TformMenu = class(TForm)
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
    pnlMenuMutavel: TPanel;
    pnlMenuPrincipal: TPanel;
    btnMenuPrincipal: TMyCustomPanel;
    btnConfiguracoes: TMyCustomPanel;
    pnlAtivo: TPanel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfiguracoesMouseEnter(Sender: TObject);
    procedure btnConfiguracoesMouseLeave(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure btnMenuPrincipalMouseLeave(Sender: TObject);
    procedure btnMenuPrincipalMouseEnter(Sender: TObject);
    procedure btnMenuPrincipalClick(Sender: TObject);
  private
    { Private declarations }
    FormMenu: Tform;
    FormAtivo: Tform;
    function GetBatteryPercentage: Integer;
    procedure AtualizaDataBateria;
    procedure DeselecionaBotoes;
  public
    { Public declarations }
    BotaoAtivo: TMyCustomPanel;
    procedure TrocaFormMenu(para: String);
    procedure TrocaFormAtivo(para: String);
  end;

var
  formMenu: TformMenu;

implementation

uses
  uEmpresas, uNintendo, uMenuPrincipal, uConfiguracoes, uGBA, uContas;

var
  Timer1: Ttimer;

{$R *.dfm}

procedure TformMenu.DeselecionaBotoes;
begin
  if FormMenu.Name <> 'formEmpresas_2' then
  begin
    if FormMenu.Name = 'formNintendo_1' then
    begin
      if Assigned(TformNintendo(FormMenu).btnAtivo) then
      begin
        TformNintendo(FormMenu).btnAtivo.BorderEnabled := False;
        TformNintendo(FormMenu).btnAtivo.Repaint;
      end;
    end;
  end;
end;

procedure TformMenu.TrocaFormAtivo(para: String);
begin
  FreeAndNil(FormAtivo);

  if para = 'MenuPrincipal' then
    FormAtivo := TformMenuPrincipal.Create(Self)
  else if para = 'Configuracoes' then
    FormAtivo := TformConfiguracoes.Create(Self)
  else if para = 'Contas' then
    FormAtivo := TformContas.Create(Self)
  else if para = 'GBA' then
    FormAtivo := TformGBA.Create(Self);


  FormAtivo.Parent := pnlAtivo;
  FormAtivo.Show;
end;

procedure TformMenu.TrocaFormMenu(para: String);
begin
  FreeAndNil(FormMenu);

  if para = 'Empresas' then
    FormMenu := TformEmpresas.Create(Self)
  else if para = 'Nintendo' then
    FormMenu := TformNintendo.Create(Self);


  FormMenu.Parent := pnlMenuMutavel;
  FormMenu.Show;
end;

procedure TformMenu.AtualizaDataBateria;
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
  labelData.Caption := FormatDateTime('dd/mm - hh:mm', Now);
end;

procedure TformMenu.btnConfiguracoesClick(Sender: TObject);
begin
  DeselecionaBotoes;
  TrocaFormAtivo('Configuracoes');
  BotaoAtivo := btnConfiguracoes;

  btnMenuPrincipal.BorderEnabled := False;
  btnMenuPrincipal.Repaint;
  btnMenuPrincipal.Enabled := True;
end;

procedure TformMenu.btnConfiguracoesMouseEnter(Sender: TObject);
begin
  btnConfiguracoes.BorderEnabled := True;
  btnConfiguracoes.Repaint;
end;

procedure TformMenu.btnConfiguracoesMouseLeave(Sender: TObject);
begin
  if not (BotaoAtivo = btnConfiguracoes) then
  begin
    btnConfiguracoes.BorderEnabled := False;
    btnConfiguracoes.Repaint;
  end;
end;

procedure TformMenu.btnMenuPrincipalClick(Sender: TObject);
begin
  DeselecionaBotoes;
  TrocaFormAtivo('MenuPrincipal');
  BotaoAtivo := btnMenuPrincipal;

  btnConfiguracoes.BorderEnabled := False;
  btnConfiguracoes.Repaint;
  btnConfiguracoes.Enabled := True;
end;

procedure TformMenu.btnMenuPrincipalMouseEnter(Sender: TObject);
begin
  btnMenuPrincipal.BorderEnabled := True;
  btnMenuPrincipal.Repaint;
end;

procedure TformMenu.btnMenuPrincipalMouseLeave(Sender: TObject);
begin
  if not (BotaoAtivo = btnMenuPrincipal) then
  begin
    btnMenuPrincipal.BorderEnabled := False;
    btnMenuPrincipal.Repaint;
  end;
end;

procedure TformMenu.FormCreate(Sender: TObject);
begin
  BotaoAtivo := btnMenuPrincipal;

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

  //Trata os Botões
  btnConfiguracoes.BorderEnabled := False;

  TrocaFormMenu('Empresas');
  TrocaFormAtivo('MenuPrincipal');
end;

function TformMenu.GetBatteryPercentage: Integer;
var
  PowerStatus: TSystemPowerStatus;
begin
  if GetSystemPowerStatus(PowerStatus) then
    Result := PowerStatus.BatteryLifePercent
  else
    Result := -1; // Retorna -1 se houver erro
end;

procedure TformMenu.Timer1Timer(Sender: TObject);
begin
  AtualizaDataBateria;
end;

end.
