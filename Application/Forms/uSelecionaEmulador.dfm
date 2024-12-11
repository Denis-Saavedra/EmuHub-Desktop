object formSelecionaEmulador: TformSelecionaEmulador
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Selecionar Emulador'
  ClientHeight = 164
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 164
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 328
    ExplicitTop = 128
    ExplicitWidth = 185
    ExplicitHeight = 41
    object ListBox1: TListBox
      Left = 1
      Top = 1
      Width = 425
      Height = 162
      Align = alClient
      Color = clWindowFrame
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      Items.Strings = (
        'Game Boy'
        'Game Boy Color'
        'Game Boy Advanced'
        'Game Cube')
      ParentFont = False
      TabOrder = 0
      OnClick = ListBox1Click
      ExplicitLeft = 112
      ExplicitTop = 32
      ExplicitWidth = 145
      ExplicitHeight = 97
    end
  end
end
