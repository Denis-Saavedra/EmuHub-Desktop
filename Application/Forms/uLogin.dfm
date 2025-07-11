object formLogin: TformLogin
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Login'
  ClientHeight = 534
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 751
    Height = 534
    Align = alClient
    Color = clBlack
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 112
      Top = 107
      Width = 76
      Height = 35
      Caption = 'Email:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 112
      Top = 259
      Width = 91
      Height = 35
      Caption = 'Senha:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
    end
    object edtEmail: TEdit
      Left = 112
      Top = 148
      Width = 433
      Height = 43
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'ddd'
    end
    object edtSenha: TEdit
      Left = 112
      Top = 300
      Width = 433
      Height = 43
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 1
    end
    object btnRegistrar: TMyCustomPanel
      Left = 83
      Top = 424
      Width = 280
      Height = 80
      BevelOuter = bvNone
      BorderWidth = 3
      Caption = 'Registrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnRegistrarClick
      OnMouseEnter = btnRegistrarMouseEnter
      OnMouseLeave = btnRegistrarMouseLeave
      BorderColor = clPurple
      ImageIndex = 8
      ImageWidth = 40
      ImageHeight = 35
    end
    object btnLogin: TMyCustomPanel
      Left = 376
      Top = 424
      Width = 280
      Height = 80
      BevelOuter = bvNone
      BorderWidth = 3
      Caption = 'Logar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnLoginClick
      OnMouseEnter = btnLoginMouseEnter
      OnMouseLeave = btnLoginMouseLeave
      BorderColor = clPurple
      ImageIndex = 8
      ImageWidth = 40
      ImageHeight = 35
    end
  end
end
