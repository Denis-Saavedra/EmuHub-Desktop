unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TformLogin = class(TForm)
    edtEmail: TEdit;
    edtSenha: TEdit;
    btnSignIn: TButton;
    btnLogin: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnSignInClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Logado: Boolean;
    function Logou:Boolean;
    procedure LoginAPI(const Email, Password: string);
    procedure SalvaLogin(const Email, Password: string);
    procedure LogaIni;
  end;

var
  formLogin: TformLogin;

implementation

uses
  ShellAPI, IdHTTP, IdSSL, System.JSON, IdSSLOpenSSL, IdMultipartFormData,
  System.IniFiles, uLibrary;

{$R *.dfm}

procedure TformLogin.LogaIni;
var
  Ini: TIniFile;
  CaminhoArquivo: string;
  Email: string;
  Password: string;
begin
  // Define o caminho do arquivo .ini
  CaminhoArquivo := PegaDiretorio + '/config.ini';

  // Cria ou abre o arquivo .ini
  Ini := TIniFile.Create(CaminhoArquivo);
  try
    // Lê valores de seções e chaves
    Email := Ini.ReadString('Login', 'Email', '');
    Password := Ini.ReadString('Login', 'Password', '');
  finally
    Ini.Free;  // Libera o objeto após o uso
  end;

  edtEmail.Text := Email;
  edtSenha.Text := Password;
end;

procedure TformLogin.SalvaLogin(const Email, Password: string);
var
  Ini: TIniFile;
  CaminhoArquivo: string;
begin
  // Define o caminho do arquivo .ini
  CaminhoArquivo := PegaDiretorio + '/config.ini';

  // Cria ou abre o arquivo .ini
  Ini := TIniFile.Create(CaminhoArquivo);
  try
    // Escreve valores em seções e chaves
    Ini.WriteString('Login', 'Email', Email);
    Ini.WriteString('Login', 'Password', Password);

  finally
    Ini.Free;  // Libera o objeto após o uso
  end;
end;

procedure TformLogin.LoginAPI(const Email, Password: string);
var
  HTTPClient: TIdHTTP;
  SSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  FormData: TIdMultipartFormDataStream;
  JSONResponse: TJSONObject;
  Response: string;
  Token, ErrorMsg: string;
begin
  HTTPClient := TIdHTTP.Create(nil);
  SSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FormData := TIdMultipartFormDataStream.Create;
  try
    HTTPClient.IOHandler := SSLIOHandler;

    // Configura o timeout e o content-type
    HTTPClient.Request.ContentType := 'multipart/form-data';
    HTTPClient.Request.Connection := 'keep-alive';
    HTTPClient.Request.Accept := 'application/json';

    // Adiciona os parâmetros email e password ao form-data
    FormData.AddFormField('email', Email);
    FormData.AddFormField('password', Password);

    try
      // Envia a requisição POST e captura a resposta
      Response := HTTPClient.Post('http://52.45.165.140/api/token/', FormData);

      // Exibe a resposta para diagnóstico
      //ShowMessage('Resposta da API: ' + Response);

      // Converte o conteúdo da resposta para JSON
      JSONResponse := TJSONObject.ParseJSONValue(Response) as TJSONObject;
      try
        if JSONResponse <> nil then
        begin
          if JSONResponse.TryGetValue<string>('token', Token) then
          begin
            //ShowMessage('Logou! Token: ' + Token);
            Logado := True;
            SalvaLogin(Email, Password);
            Close;
          end
          else if JSONResponse.TryGetValue<string>('error', ErrorMsg) then
          begin
            ShowMessage('Erro de login: ' + ErrorMsg);
          end
          else
          begin
            ShowMessage('Resposta inesperada da API.');
          end;
        end
        else
        begin
          ShowMessage('Resposta não é um JSON válido.');
        end;
      finally
        JSONResponse.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
        ShowMessage('Erro HTTP: ' + E.ErrorMessage + ' (Código: ' + IntToStr(E.ErrorCode) + ')');
      on E: Exception do
        ShowMessage('Erro na requisição: ' + E.Message);
    end;
  finally
    FormData.Free;
    HTTPClient.Free;
    SSLIOHandler.Free;
  end;
end;

procedure TformLogin.btnLoginClick(Sender: TObject);
var
  Email: String;
  Senha: String;
begin
  Email := edtEmail.Text;
  Senha := edtSenha.Text;

  LoginAPI(Email, Senha);
end;

procedure TformLogin.btnSignInClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('http://52.45.165.140:5173/sign-in'), nil, nil, SW_SHOWNORMAL);
end;

procedure TformLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Logado then
    Application.Terminate;
end;

procedure TformLogin.FormCreate(Sender: TObject);
begin
  if FileExists(PegaDiretorio + '/config.ini') then
    LogaIni;
end;

function TformLogin.Logou:Boolean;
begin
  result := Logado;
end;

end.
