object MainView: TMainView
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 250
    Height = 25
    Caption = 'Crud Country'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 250
    Height = 25
    Caption = 'Crud Province and Cities'
    TabOrder = 1
    OnClick = Button2Click
  end
end
