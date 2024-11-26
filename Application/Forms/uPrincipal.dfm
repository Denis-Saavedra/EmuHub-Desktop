object formPrincipal: TformPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'EmuHub'
  ClientHeight = 516
  ClientWidth = 708
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 56
    Width = 708
    Height = 460
    Align = alBottom
    TabOrder = 0
  end
  object pnlUser: TPanel
    Left = 0
    Top = 0
    Width = 708
    Height = 57
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 264
      Top = 21
      Width = 140
      Height = 15
      Caption = 'RetroAchievements: FALSE'
    end
    object btnLogout: TButton
      Left = 616
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Sair'
      TabOrder = 0
      OnClick = btnLogoutClick
    end
  end
end
