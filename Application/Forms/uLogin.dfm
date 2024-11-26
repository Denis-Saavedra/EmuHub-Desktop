object formLogin: TformLogin
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Login'
  ClientHeight = 227
  ClientWidth = 288
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
  object Label1: TLabel
    Left = 32
    Top = 35
    Width = 32
    Height = 15
    Caption = 'Email:'
  end
  object Label2: TLabel
    Left = 32
    Top = 99
    Width = 35
    Height = 15
    Caption = 'Senha:'
  end
  object edtEmail: TEdit
    Left = 32
    Top = 56
    Width = 225
    Height = 23
    TabOrder = 0
  end
  object edtSenha: TEdit
    Left = 32
    Top = 120
    Width = 225
    Height = 23
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnSignIn: TButton
    Left = 32
    Top = 168
    Width = 97
    Height = 25
    Caption = 'Registrar'
    TabOrder = 2
    OnClick = btnSignInClick
  end
  object btnLogin: TButton
    Left = 144
    Top = 168
    Width = 113
    Height = 25
    Caption = 'Logar'
    TabOrder = 3
    OnClick = btnLoginClick
  end
end
