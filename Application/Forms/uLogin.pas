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
  JSONBody, Response: string;
  JSONToSend, JSONResponse: TJSONObject;
  Token: string;
begin
  HTTPClient := TIdHTTP.Create(nil);
  SSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  JSONToSend := TJSONObject.Create;
  try
    HTTPClient.IOHandler := SSLIOHandler;

    // Timeout para evitar travamento infinito
    HTTPClient.ConnectTimeout := 10000;
    HTTPClient.ReadTimeout := 10000;

    // Configuração HTTP
    HTTPClient.Request.ContentType := 'application/json';
    HTTPClient.Request.Connection := 'keep-alive';
    HTTPClient.Request.Accept := 'application/json';

    // Monta o JSON de envio
    JSONToSend.AddPair('email', Email);
    JSONToSend.AddPair('password', Password);
    JSONBody := JSONToSend.ToString;

    try
      // Envia o POST com JSON puro
      Response := HTTPClient.Post('http://18.229.134.132:5000/api/Auth/Login/', TStringStream.Create(JSONBody, TEncoding.UTF8));

      // Processa o JSON de resposta
      JSONResponse := TJSONObject.ParseJSONValue(Response) as TJSONObject;
      try
        if JSONResponse <> nil then
        begin
          if JSONResponse.GetValue<TJSONObject>('userTokens') <> nil then
          begin
            Token := JSONResponse.GetValue<TJSONObject>('userTokens').GetValue<string>('accessToken');
            ShowMessage('Logou com sucesso! Token: ' + Token);  // <<< MENSAGEM RESTAURADA
            Logado := True;
            SalvaLogin(Email, Password);
            TformMenu(Owner).TrocaFormAtivo('Contas');
          end
          else
            ShowMessage('Login sem token na resposta.');
        end
        else
          ShowMessage('Resposta não é JSON válido.');
      finally
        JSONResponse.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        if E.ErrorCode = 400 then
          ShowMessage('E-mail ou senha incorretos!')
        else
          ShowMessage('Erro HTTP: ' + E.Message + ' (Código: ' + IntToStr(E.ErrorCode) + ')');
      end;
      on E: Exception do
        ShowMessage('Erro na requisição: ' + E.Message);
    end;
  finally
    JSONToSend.Free;
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
  ShellExecute(0, 'OPEN', PChar('http://18.229.134.132:8080/sign-up'), nil, nil, SW_SHOWNORMAL);
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

  //Trata Botões
  btnLogin.BorderEnabled := False;
  btnRegistrar.BorderEnabled := False;
end;

function TformLogin.Logou:Boolean;
begin
  result := Logado;
end;

end.
