object LogForm: TLogForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Log'
  ClientHeight = 228
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 428
    Height = 203
    Align = alClient
    TabOrder = 0
  end
  object Button1: TButton
    Left = 0
    Top = 203
    Width = 428
    Height = 25
    Align = alBottom
    Caption = #1054#1095#1080#1089#1090#1080#1090#1080
    TabOrder = 1
  end
  object Timer1: TTimer
    Tag = 1
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 16
    Top = 16
  end
end
