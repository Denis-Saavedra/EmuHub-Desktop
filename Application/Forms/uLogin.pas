unit uLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  MyCustomPanel;

type
  TformLogin = class(TForm)
    pnlPrincipal: TPanel;
    Label1: TLabel;
    edtEmail: TEdit;
    Label2: TLabel;
    edtSenha: TEdit;
    btnRegistrar: TMyCustomPanel;
    btnLogin: TMyCustomPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnLoginMouseEnter(Sender: TObject);
    procedure btnLoginMouseLeave(Sender: TObject);
    procedure btnRegistrarMouseEnter(Sender: TObject);
    procedure btnRegistrarMouseLeave(Sender: TObject);
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
  System.IniFiles, uLibrary, uMenu;

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
    // L� valores de se��es e chaves
    Email := Ini.ReadString('Login', 'Email', '');
    Password := Ini.ReadString('Login', 'Password', '');
  finally
    Ini.Free;  // Libera o objeto ap�s o uso
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
    // Escreve valores em se��es e chaves
    Ini.WriteString('Login', 'Email', Email);
    Ini.WriteString('Login', 'Password', Password);

  finally
    Ini.Free;  // Libera o objeto ap�s o uso
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

    // Adiciona os par�metros email e password ao form-data
    FormData.AddFormField('email', Email);
    FormData.AddFormField('password', Password);

    try
      // Envia a requisi��o POST e captura a resposta
      Response := HTTPClient.Post('http://52.45.165.140/api/token/', FormData);

      // Exibe a resposta para diagn�stico
      //ShowMessage('Resposta da API: ' + Response);

      // Converte o conte�do da resposta para JSON
      JSONResponse := TJSONObject.ParseJSONValue(Response) as TJSONObject;
      try
        if JSONResponse <> nil then
        begin
          if JSONResponse.TryGetValue<string>('token', Token) then
          begin
            ShowMessage('Logou! Token: ' + Token);
            Logado := True;
            SalvaLogin(Email, Password);
            TformMenu(Owner).TrocaFormAtivo('Contas');
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
          ShowMessage('Resposta n�o � um JSON v�lido.');
        end;
      finally
        JSONResponse.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        if (E.ErrorCode = 400) or (E.ErrorCode = 401) then
          ShowMessage('Erro usu�rio e/ou senha n�o encontrados!')
        else
          ShowMessage('Erro HTTP: ' + E.ErrorMessage + ' (C�digo: ' + IntToStr(E.ErrorCode) + ')');
      end;

      on E: Exception do
        ShowMessage('Erro na requisi��o: ' + E.Message);
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

procedure TformLogin.btnLoginMouseEnter(Sender: TObject);
begin
  HoverOn(btnLogin);
end;

procedure TformLogin.btnLoginMouseLeave(Sender: TObject);
begin
  HoverOff(btnLogin);
end;

procedure TformLogin.btnRegistrarClick(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('http://52.45.165.140:5173/sign-in'), nil, nil, SW_SHOWNORMAL);
end;

procedure TformLogin.btnRegistrarMouseEnter(Sender: TObject);
begin
  HoverOn(btnRegistrar);
end;

procedure TformLogin.btnRegistrarMouseLeave(Sender: TObject);
begin
  HoverOff(btnRegistrar);
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

procedure TformLogin.FormResize(Sender: TObject);
begin
  edtEmail.Width := pnlPrincipal.Width - 180;
  edtSenha.Width := pnlPrincipal.Width - 180;
  btnRegistrar.Left := 150;
  btnLogin.Left := pnlPrincipal.Width - 400;
end;

procedure TformLogin.FormShow(Sender: TObject);
begin
   //Trata painel
  pnlPrincipal.Color := RGB(40, 40, 40);
  pnlPrincipal.Repaint;

  //Trata Bot�es
  btnLogin.BorderEnabled := False;
  btnRegistrar.BorderEnabled := False;
end;

function TformLogin.Logou:Boolean;
begin
  result := Logado;
end;

end.
