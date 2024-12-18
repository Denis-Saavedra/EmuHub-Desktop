unit uPS1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList, Vcl.BaseImageCollection,
  Vcl.ImageCollection, MyCustomPanel, System.Generics.Collections;

type
  TformPS1 = class(TForm)
    pnlPrincipal: TPanel;
    imgCollection: TImageCollection;
    sbPrincipal: TScrollBox;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    BotoesRoms: TList<TMyCustomPanel>;
    procedure CarregaRoms;
    procedure BotaoClick(Sender: TObject);
    procedure BotaoEnter(Sender: TObject);
    procedure BotaoLeave(Sender: TObject);
  public
    { Public declarations }
  end;

var
  formPS1: TformPS1;

implementation

uses
  uPrincipal, System.IOUtils, System.Win.Registry, uLibrary,
  ShellAPI, Vcl.Imaging.pngimage, Vcl.Buttons;

var
  DiretorioPadrao: String;

{$R *.dfm}

procedure TformPS1.CarregaRoms;
var
  Diretorio: String;
  Arquivos: TArray<string>;
  Arquivo: string;
  Botao: TMyCustomPanel;
  I: Integer;
  PNGImage: TPNGImage; // Para imagens PNG
  Bitmap: TBitmap; // Para bitmap
  Item: TImageCollectionItem;
begin
  Diretorio := DiretorioPadrao + 'PS';

  if not TDirectory.Exists(Diretorio) then
  begin
    sbPrincipal.Visible := False;
    pnlPrincipal.Caption := 'Nenhuma Rom de PS';
    Exit;
  end;

  Arquivos := TDirectory.GetFiles(Diretorio, '*.bin', TSearchOption.soTopDirectoryOnly);

  BotoesRoms := TList<TMyCustomPanel>.Create; // Inicializa a lista de botões
  try
    I := 0;
    for Arquivo in Arquivos do
    begin
      // Cria o botão
      Botao := TMyCustomPanel.Create(Self);
      Botao.Parent := sbPrincipal; // Define o painel como pai do botão
      Botao.BevelOuter := bvNone;
      Botao.Height := 120;
      //Botao.Width := sbPrincipal.Width - 55;
      Botao.ImageWidth := 100;
      Botao.ImageHeight := 100;
      Botao.Font.Name := 'Pixelify Sans';
      Botao.Font.Color := clWhite;
      Botao.Font.Size := 55;
      Botao.BorderColor := clPurple;
      Botao.BorderEnabled := False;
      Botao.Left := 32;
      Botao.Top := (25 + (145 * I));
      Botao.Name := 'btn' + IntToStr(I); // Use o índice ou outra forma para nomear o botão

      // Define o Caption do botão sem a extensão .gba
      Botao.Caption := ChangeFileExt(ExtractFileName(Arquivo), '');

      Botao.OnClick := BotaoClick;
      Botao.OnMouseEnter := BotaoEnter;
      Botao.OnMouseLeave := BotaoLeave;

      // Criar novas instâncias para cada iteração
      PNGImage := TPNGImage.Create;
      Bitmap := TBitmap.Create;
      try
        // Verifica se a imagem existe
        if FileExists(Diretorio + '\' + ChangeFileExt(ExtractFileName(Arquivo), '.png')) then
        begin
          // Carregar a imagem de um arquivo
          PNGImage.LoadFromFile(Diretorio + '\' + ChangeFileExt(ExtractFileName(Arquivo), '.png'));

          // Converter o PNG para um Bitmap
          Bitmap.Assign(PNGImage);

          // Criar um novo item no ImageCollection
          ImgCollection.Add(Botao.Caption, (Diretorio + '\' + ChangeFileExt(ExtractFileName(Arquivo), '.png')));

          // Define a imagem do botão
          Botao.ImageCollection := ImgCollection;
          Botao.ImageIndex := ImgCollection.Count - 1; // Usar o índice da imagem recém-adicionada
        end;

      finally
        Bitmap.Free;     // Libera o Bitmap após adicionar
        PNGImage.Free;   // Libera a imagem PNG
      end;

      // Adiciona o botão à lista de botões
      BotoesRoms.Add(Botao);
      I := I + 1;
    end;
  finally
    //BotoesRoms.Free; // Certifique-se de liberar a lista de botões se não precisar mais
  end;
end;


procedure TformPS1.BotaoClick(Sender: TObject);
var
  Botao: TMyCustomPanel;
  Comando: string;
begin
  Botao := Sender as TMyCustomPanel;
  Comando := 'start /b ' + DiretorioPadrao + 'RaLibRetro\RALibretro.exe ' +
  '--core pcsx_rearmed_libretro ' +
  '--system 12 ' +
  '--game "' + DiretorioPadrao + '\PS\' + Botao.Caption + '.bin"';
  // Executa o comando no CMD
  ShellExecute(0, 'open', 'cmd.exe', PChar('/C ' + Comando), nil, SW_SHOWNORMAL);
end;

procedure TformPS1.BotaoEnter(Sender: TObject);
var
  Botao: TMyCustomPanel;
begin
  Botao := Sender as TMyCustomPanel;
  HoverOn(Botao);
end;

procedure TformPS1.BotaoLeave(Sender: TObject);
var
  Botao: TMyCustomPanel;
begin
  Botao := Sender as TMyCustomPanel;
  HoverOff(Botao);
end;

procedure TformPS1.FormCreate(Sender: TObject);
begin
  DiretorioPadrao := PegaDiretorio;
  CarregaRoms;
end;

procedure TformPS1.FormResize(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to BotoesRoms.Count - 1 do
  begin
    BotoesRoms[I].Width := pnlPrincipal.Width - 55;
  end;
end;

procedure TformPS1.FormShow(Sender: TObject);
begin
  //Trata Painel
  pnlPrincipal.Color := RGB(40, 40, 40);
end;

procedure TformPS1.btnVoltarClick(Sender: TObject);
begin
  TformPrincipal(Owner).TrocaForm('Nintendo');
end;

initialization
  RegisterClass(TformPS1);  // Registra a classe para uso dinâmico

end.
