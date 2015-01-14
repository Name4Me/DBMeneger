object RestoreForm: TRestoreForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Restore'
  ClientHeight = 359
  ClientWidth = 212
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 212
    Height = 25
    Align = alTop
    Caption = 'Restore'
    TabOrder = 0
    OnClick = Button1Click
  end
  object CLB: TCheckListBox
    Left = 0
    Top = 25
    Width = 212
    Height = 315
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 340
    Width = 212
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object OD: TOpenDialog
    Left = 168
    Top = 48
  end
end
