object formSony: TformSony
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 480
  ClientWidth = 233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 233
    Height = 480
    Align = alClient
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object btnPS: TMyCustomPanel
      Left = 17
      Top = 18
      Width = 200
      Height = 40
      BevelOuter = bvNone
      BorderWidth = 3
      Caption = 'PlayStation'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnPSClick
      OnMouseEnter = btnPSMouseEnter
      OnMouseLeave = btnPSMouseLeave
      BorderColor = clPurple
      ImageCollection = ImageCollection1
      ImageIndex = 0
      ImageWidth = 32
      ImageHeight = 32
    end
    object btnPS2: TMyCustomPanel
      Left = 17
      Top = 64
      Width = 200
      Height = 40
      BevelOuter = bvNone
      BorderWidth = 3
      Caption = 'PlayStation 2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Pixelify Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = btnPS2Click
      OnMouseEnter = btnPS2MouseEnter
      OnMouseLeave = btnPS2MouseLeave
      BorderColor = clPurple
      ImageCollection = ImageCollection1
      ImageIndex = 1
      ImageWidth = 32
      ImageHeight = 32
    end
  end
  object ImageCollection1: TImageCollection
    Images = <
      item
        Name = 'ps1'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C60000000467414D410000B18F0BFC6105000000206348524D00007A26000080
              840000FA00000080E8000075300000EA6000003A98000017709CBA513C000000
              45504C5445FFFFFF323232626262C8C8C8E1E4EA9FA8B59292922626267B8991
              BBC0CAD5D7DF6673771A1A1AB6B6B6DC0049959EA8DCDC0000FF002557FF00B9
              000096006F7686FFFFFFBA540F160000000174524E530040E6D8660000000162
              4B47440088051D480000000774494D4507E7030D0716150655642E000000F549
              44415438CBD593DDB283200C8411216D486B3CFD79FF576DC2A242A7D3DBCE59
              2EC064F9125043F8179AA038F5DA9E3C3F57A5987326C85611D17C0AE19C679E
              995364224467228E895DF96C84CCEE2835ED569748335C7602D5EC556CC03212
              DCC0184DF246A02ED7390E8257F864D809F29E1F08F5F10B81B9EC8465F94048
              A449B446D7E5EF86BCF68494B663F1BA8EC7DC7B605167A85EDBDCDF03975298
              041646DAAFDAA22014552DEA2F402111A6C464511036835BAAFCE69B013D7809
              1D6F815A89D6C3DDEAE641A4C729ACC0C3FA7B8E62B46384A9059EFE09FA0A73
              DBD01B7C83AF301F867081A6512DFAEB5F0E7A0117531901C23A931400000025
              74455874646174653A63726561746500323032332D30332D31335430373A3230
              3A33322B30303A303004D39BF90000002574455874646174653A6D6F64696679
              00323030372D30342D31335430383A30333A30302B30303A303003BC29DA0000
              000049454E44AE426082}
          end>
      end
      item
        Name = 'ps2'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D494844520000002000000020080300000044A48A
              C60000000467414D410000B18F0BFC6105000000206348524D00007A26000080
              840000FA00000080E8000075300000EA6000003A98000017709CBA513C000000
              42504C5445FFFFFF2626260000003E3E3E5656564A4A4A323232626262009631
              0E0E0E1A1A1A960000B9B9004873FF855BFF0092DC6BC6FF0019500055FF0049
              DC003196FFFFFF6A5E5F6C0000000174524E530040E6D86600000001624B4744
              0088051D480000000774494D4507E7030D0716150655642E000000D749444154
              38CBA592511283200C05212158B4025AEF7FD60242051BEC387D33FAF3D64D44
              8538474A0952F0913188081200B812151125406A389703298A7D021E865A6018
              0695FB041863CE40DD871146375B246027900A308EC018F030B440338105EA3E
              0053CF9081E7343306753562EFAD451B2E76875058B25160BB06470ED139C71B
              42E1C813F9DE0E3E387C687DBC71067F9C230794B7C43EB01378C7000D507F4B
              16F83298BF0D3F7730370DBA4A0696F5F8AD717E7DB2411EB1AC6321705E5352
              5F001D810DF2F36B4905C4A3DE12817015F1069C3B0FB8E39762BB0000002574
              455874646174653A63726561746500323032332D30332D31335430373A32303A
              33322B30303A303004D39BF90000002574455874646174653A6D6F6469667900
              323030372D30332D31355431383A33383A33382B30303A30305B7EFE71000000
              0049454E44AE426082}
          end>
      end>
    Left = 112
    Top = 224
  end
end
