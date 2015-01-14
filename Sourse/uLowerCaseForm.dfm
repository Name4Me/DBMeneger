object LowerCaseForm: TLowerCaseForm
  Left = 0
  Top = 0
  Caption = 'LowerCaseForm'
  ClientHeight = 341
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  DesignSize = (
    643
    341)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 40
    Width = 627
    Height = 97
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'LowerCase'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo2: TMemo
    Left = 8
    Top = 143
    Width = 627
    Height = 190
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
