object formLogin: TformLogin
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Login'
  ClientHeight = 390
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 586
    Height = 390
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 56
    ExplicitTop = 105
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 176
      Top = 99
      Width = 32
      Height = 15
      Caption = 'Email:'
    end
    object Label2: TLabel
      Left = 176
      Top = 163
      Width = 35
      Height = 15
      Caption = 'Senha:'
    end
    object edtEmail: TEdit
      Left = 176
      Top = 120
      Width = 225
      Height = 23
      TabOrder = 0
    end
    object edtSenha: TEdit
      Left = 176
      Top = 184
      Width = 225
      Height = 23
      PasswordChar = '*'
      TabOrder = 1
    end
    object btnSignIn: TButton
      Left = 176
      Top = 232
      Width = 97
      Height = 25
      Caption = 'Registrar'
      TabOrder = 2
      OnClick = btnSignInClick
    end
    object btnLogin: TButton
      Left = 288
      Top = 232
      Width = 113
      Height = 25
      Caption = 'Logar'
      TabOrder = 3
      OnClick = btnLoginClick
    end
  end
end
