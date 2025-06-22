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
    procedure VerificaRomExiste(Emulador, Rom: String);
    procedure BaixarRom(DestinoArquivo, Emulador, Rom: string);
  public
    { Public declarations }
    procedure TrocaForm(para: String);
  end;

var
  formPrincipal: TformPrincipal;

implementation

uses
  uEmpresas, uGBA, System.StrUtils, IdURI, uLibrary, Vcl.Buttons,
  IdHTTP, IdSSLOpenSSL, System.Zip, uLogin, System.IniFiles, uMenu,
  MyCustomPanel, System.Types, System.IOUtils;

{$R *.dfm}

procedure TformPrincipal.BaixarRom(DestinoArquivo, Emulador, Rom: string);
var
  IdHTTP: TIdHTTP;
  FileStream, FileStreamImage: TFileStream;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  URL, URLimg: String;
  ZipFile: TZipFile;
  DestinoImagem, DiretorioDestino, TempPath, NomeOriginal, ExtensaoOriginal, ArquivoExtraido, NovoNomeCompleto: String;
  Files: TStringDynArray;
begin
  DestinoImagem := DestinoArquivo + '.png';
  DestinoArquivo := DestinoArquivo + '.zip';
  DiretorioDestino := ExtractFilePath(DestinoArquivo);

  // Pasta temporária
  TempPath := IncludeTrailingPathDelimiter(DiretorioDestino) + 'TEMP_EXTRACT\';
  if not DirectoryExists(TempPath) then
    ForceDirectories(TempPath);

  IdHTTP := TIdHTTP.Create(nil);
  FileStream := TFileStream.Create(DestinoArquivo, fmCreate);
  FileStreamImage := TFileStream.Create(DestinoImagem, fmCreate);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  URL := 'http://18.229.134.132:5000/api/Games/Download/' +
         Emulador + '/' +
         StringReplace(Rom, ' ', '%20', [rfReplaceAll]);
  URLimg := 'http://18.229.134.132:5000/api/Games/DownloadImage/' +
            Emulador + '/' +
            StringReplace(Rom, ' ', '%20', [rfReplaceAll]);

  try
    IdHTTP.IOHandler := SSLHandler;
    IdHTTP.Request.UserAgent := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/58.0.3029.110 Safari/537.3';

    IdHTTP.Get(URL, FileStream);
    IdHTTP.Get(URLimg, FileStreamImage);
  except
    on E: Exception do
    begin
      ShowMessage('Erro ao baixar arquivo: ' + E.Message);
      Exit;
    end;
  end;

  FileStream.Free;
  FileStreamImage.Free;
  IdHTTP.Free;
  SSLHandler.Free;

  ZipFile := TZipFile.Create;
  try
    ZipFile.Open(DestinoArquivo, zmRead);

    // Extrai tudo para a pasta temporária, mantendo estrutura interna só ali
    ZipFile.ExtractAll(TempPath);
  finally
    ZipFile.Free;
  end;

  // Localiza o primeiro arquivo real dentro da pasta temporária (ignorando subpastas)
  Files := TDirectory.GetFiles(TempPath, '*.*', TSearchOption.soAllDirectories);
  if Length(Files) = 1 then
  begin
    ExtensaoOriginal := ExtractFileExt(Files[0]);
    NovoNomeCompleto := IncludeTrailingPathDelimiter(DiretorioDestino) + Rom + ExtensaoOriginal;

    // Move e renomeia o arquivo para o destino final
    TFile.Move(Files[0], NovoNomeCompleto);
  end
  else
    ShowMessage('Erro: ZIP contém mais de um arquivo ou nenhum arquivo.');

  // Apaga a pasta temporária inteira
  TDirectory.Delete(TempPath, True);

  // Exclui o ZIP baixado
  DeleteFile(DestinoArquivo);
end;

procedure TformPrincipal.VerificaRomExiste(Emulador, Rom: String);
var
  Arquivo: String;
  Formulario: TForm;
  Painel: TMyCustomPanel;
  i: Integer;
  FormClass: TFormClass;
begin
  Arquivo := DiretorioPadrao + Emulador + '\' + Rom;
  if not FileExists(Arquivo + RetornaExtensao(Emulador)) then
  begin
    ForceDirectories(DiretorioPadrao + Emulador + '\');
    BaixarRom(Arquivo, Emulador, Rom);
  end;

  // Troca para o formulário correspondente ao emulador
  TformMenu(FormAtivo).TrocaFormAtivo(Emulador);

  // Encontra o formulário usando o nome do emulador de forma dinâmica
  FormClass := TFormClass(FindClass('Tform' + Emulador)); // Exemplo: TformGBA, TformSNES

  if Assigned(FormClass) and (TformMenu(FormAtivo).FormAtivo is FormClass) then
  begin
    // Percorre os controles do ScrollBox de forma genérica
    for i := 0 to TScrollBox(TformMenu(FormAtivo).FormAtivo.FindComponent('sbPrincipal')).ControlCount - 1 do
    begin
      if TScrollBox(TformMenu(FormAtivo).FormAtivo.FindComponent('sbPrincipal')).Controls[i] is TMyCustomPanel then
      begin
        Painel := TMyCustomPanel(TScrollBox(TformMenu(FormAtivo).FormAtivo.FindComponent('sbPrincipal')).Controls[i]);
        // Verifica se o Caption ou Tag do painel bate com o nome da ROM (sem a extensão)
        if Painel.Caption = ChangeFileExt(Rom, '') then
        begin
          // Simula a ação de clique no painel
          if Assigned(Painel.OnClick) then
            Painel.OnClick(Painel); // Chama o evento OnClick, se existir

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


  // Divide os parâmetros usando "&" como delimitador
  Parametros := SplitString(Parametro, '&');

  // Verifica se foram passados os 3 parâmetros esperados
  if Length(Parametros) < 2 then
  begin
    ShowMessage('Número insuficiente de parâmetros.');
    formPrincipal.Close;
  end;

  // Atribui os parâmetros
  Emulador := Parametros[0];
  Rom := Parametros[1];

  VerificaRomExiste(Emulador, Rom);
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
  TrocaForm('Menu');

  if (ParamCount > 0) then
    ValidaParametros;
end;

procedure TformPrincipal.TrocaForm(para: String);
begin
  FreeAndNil(FormAtivo);

  if para = 'Menu' then
    FormAtivo := TformMenu.Create(Self);
       

  FormAtivo.Parent := pnlPrincipal;
  FormAtivo.Show;
end;

end.
