object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'SQL'
  ClientHeight = 410
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    538
    410)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 447
    Top = 39
    Width = 83
    Height = 53
    Anchors = [akTop, akRight]
    Caption = 'SQL'
    TabOrder = 0
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 232
    Width = 522
    Height = 153
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 8
    Top = 98
    Width = 522
    Height = 128
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 2
    OnClick = Memo1Click
    OnDblClick = Memo1DblClick
  end
  object Memo2: TMemo
    Left = 8
    Top = 8
    Width = 433
    Height = 84
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 391
    Width = 538
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object Button2: TButton
    Left = 447
    Top = 8
    Width = 83
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1055#1110#1076#1082#1083#1102#1095#1077#1085#1085#1103
    TabOrder = 5
  end
end
