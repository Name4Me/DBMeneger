object FAbout: TFAbout
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'FAbout'
  ClientHeight = 35
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 5
    Top = 5
    Width = 100
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 115
    Top = 5
    Width = 100
    Height = 25
    Caption = #1057#1090#1086#1087
    TabOrder = 1
    OnClick = Button3Click
  end
  object PopupMenu1: TPopupMenu
    Left = 136
    Top = 65528
    object Start1: TMenuItem
      Caption = 'Start'
    end
    object Stop1: TMenuItem
      Caption = 'Stop'
    end
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
    object Properties1: TMenuItem
      Caption = 'Properties'
      OnClick = Properties1Click
    end
  end
end
