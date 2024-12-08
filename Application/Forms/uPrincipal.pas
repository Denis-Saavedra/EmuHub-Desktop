unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TformPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FormAtivo: Tform;
    DiretorioPadrao: String;
    procedure ValidaParametros;
    procedure VerificaRomExiste(Empresa, Emulador, Rom: String);
    procedure BaixarRom(DestinoArquivo, Empresa, Emulador, Rom: string);
  public
    { Public declarations }
    procedure TrocaForm(para: String);
  end;

var
  formPrincipal: TformPrincipal;

implementation

uses
  uEmpresas, uNintendo, uGBA, System.StrUtils, IdURI, uLibrary, Vcl.Buttons,
  IdHTTP, IdSSLOpenSSL, System.Zip, uLogin, System.IniFiles, uMenu;

{$R *.dfm}

procedure TformPrincipal.BaixarRom(DestinoArquivo, Empresa, Emulador, Rom: string);
var
  IdHTTP: TIdHTTP;
  FileStream: TFileStream;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  URL: String;
  ZipFile: TZipFile;
  DiretorioDestino: String;
  I: Integer;
begin
  DestinoArquivo := DestinoArquivo + '.zip';
  DiretorioDestino := ExtractFilePath(DestinoArquivo);;

  IdHTTP := TIdHTTP.Create(nil);
  FileStream := TFileStream.Create(DestinoArquivo, fmCreate);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  URL := 'http://52.45.165.140/api/roms/' +
  Empresa + '/' + Emulador + '/' + Rom + '/download/';
  showmessage(URL);

  try
    // Configura o manipulador SSL para conexões HTTPS
    IdHTTP.IOHandler := SSLHandler;

    // Definir um User-Agent para simular um navegador comum
    IdHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3';

    IdHTTP.Get(URL, FileStream); // Baixa o arquivo da URL e salva no FileStream
  except
    on E: Exception do
      ShowMessage('Erro ao baixar arquivo: ' + E.Message); // Mostra mensagem de erro
  end;
  FileStream.Free;
  IdHTTP.Free;
  SSLHandler.Free;

  ZipFile := TZipFile.Create;
  try
    // Abre o arquivo ZIP
    ZipFile.Open(DestinoArquivo, zmRead);

    // Extrai todos os arquivos para o diretório de destino
    ZipFile.ExtractAll(DiretorioDestino);

  finally
    // Libera a memória do objeto TZipFile
    ZipFile.Free;
  end;

  // Após descompactar, apaga o arquivo ZIP
  DeleteFile(DestinoArquivo);
end;

procedure TformPrincipal.VerificaRomExiste(Empresa, Emulador, Rom: String);
var
  Arquivo: String;
  Formulario: TForm;
  Botao: TSpeedButton;
  i: Integer;
  FormClass: TFormClass;
begin
  Arquivo := DiretorioPadrao + Empresa + '\' + Emulador + '\Roms\' + Rom;
  if not FileExists(Arquivo + RetornaExtensao(Empresa, Emulador)) then
  begin
    ForceDirectories(DiretorioPadrao + Empresa + '\' + Emulador + '\Roms\');
    BaixarRom(Arquivo, Empresa, Emulador, Rom);
  end;

  // Troca para o formulário correspondente ao emulador
  TrocaForm(Emulador);

  // Encontra o formulário usando o nome do emulador de forma dinâmica
  FormClass := TFormClass(FindClass('Tform' + Emulador)); // Exemplo: TformGBA, TformSNES

  if Assigned(FormClass) and (FormAtivo is FormClass) then
  begin
    // Percorre os controles do ScrollBox de forma genérica
    for i := 0 to TScrollBox(FormAtivo.FindComponent('sbPrincipal')).ControlCount - 1 do
    begin
      if TScrollBox(FormAtivo.FindComponent('sbPrincipal')).Controls[i] is TSpeedButton then
      begin
        Botao := TSpeedButton(TScrollBox(FormAtivo.FindComponent('sbPrincipal')).Controls[i]);
        // Verifica se o caption do botão bate com o nome da ROM (sem a extensão)
        if Botao.Caption = ChangeFileExt(Rom, '') then
        begin
          // Simula o clique no botão
          Botao.Click;
          Break;
        end;
      end;
    end;
  end;
end;


procedure TformPrincipal.ValidaParametros;
var
  Parametro: String;
  Parametros: TArray<string>;
  Empresa: String;
  Emulador: String;
  Rom: String;
begin
  // Captura o link completo
  Parametro := ParamStr(1);

  // Decodifica o parâmetro da URL
  Parametro := TIdURI.URLDecode(Parametro);

  // Remove o prefixo "EmuHub:"
  Delete(Parametro, 1, Length('EmuHub:'));
  // Remove a barra extra, se existir, do final do nome do jogo
  Parametro := StringReplace(Parametro, '/', '', [rfReplaceAll]);


  // Divide os parâmetros usando "|" como delimitador
  Parametros := SplitString(Parametro, '|');

  // Verifica se foram passados os 3 parâmetros esperados
  if Length(Parametros) < 3 then
  begin
    ShowMessage('Número insuficiente de parâmetros.');
    formPrincipal.Close;
  end;

  // Atribui os parâmetros
  Empresa := Parametros[0];
  Emulador := Parametros[1];
  Rom := Parametros[2];

  VerificaRomExiste(Empresa, Emulador, Rom);
end;


procedure TformPrincipal.btnLogoutClick(Sender: TObject);
begin
  DeleteFile(DiretorioPadrao + '/config.ini');
  OnCreate(formPrincipal);
end;

procedure TformPrincipal.FormCreate(Sender: TObject);
begin
  DiretorioPadrao := PegaDiretorio;
end;

procedure TformPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
  begin
    if WindowState = wsMaximized then
      WindowState := wsNormal
    else
      WindowState := wsMaximized;
  end;
end;

procedure TformPrincipal.FormResize(Sender: TObject);
begin
  if formPrincipal.WindowState = TWindowState.wsMaximized then
    formPrincipal.BorderStyle := bsNone  
  else 
    formPrincipal.BorderStyle := bsSingle;   
end;

procedure TformPrincipal.FormShow(Sender: TObject);
begin
  if not (ParamCount > 0) then
    TrocaForm('Menu')
  else
  begin
    ValidaParametros;
  end;
end;

procedure TformPrincipal.TrocaForm(para: String);
begin
  FreeAndNil(FormAtivo);

  if para = 'Empresas' then
    FormAtivo := TformEmpresas.Create(Self)
  else if para = 'Nintendo' then
    FormAtivo := TformNintendo.Create(Self)
  else if para = 'GBA' then
    FormAtivo := TformGBA.Create(Self)
  else if para = 'Login' then
    FormAtivo := TformLogin.Create(Self)
  else if para = 'Menu' then
    FormAtivo := TformMenu.Create(Self);
       

  FormAtivo.Parent := pnlPrincipal;
  FormAtivo.Show;

  // Verifica se o FormAtivo é do tipo TformEmpresas antes de redimensionar
  if FormAtivo is TformEmpresas then
    TformEmpresas(FormAtivo).FormResize(FormAtivo);
end;

end.
