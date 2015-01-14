object StructForm: TStructForm
  Left = 267
  Top = 391
  BorderStyle = bsSingle
  Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072
  ClientHeight = 522
  ClientWidth = 758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SG2: TStringGrid
    Left = 193
    Top = 0
    Width = 565
    Height = 522
    Align = alClient
    ColCount = 13
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 522
    Align = alLeft
    TabOrder = 2
    object ChB: TCheckBox
      Left = 8
      Top = 8
      Width = 145
      Height = 17
      Caption = '*'
      TabOrder = 0
    end
    object CB: TComboBox
      Left = 8
      Top = 32
      Width = 179
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = True
      TabOrder = 1
      OnClick = MyClick
    end
    object CB1: TComboBox
      Left = 8
      Top = 66
      Width = 179
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = True
      TabOrder = 2
      OnClick = MyClick
    end
  end
  object SG1: TStringGrid
    Left = 193
    Top = 0
    Width = 565
    Height = 522
    Align = alClient
    ColCount = 6
    RowCount = 14
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24
      24)
  end
end
