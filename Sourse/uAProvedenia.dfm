object AutoForm: TAutoForm
  Left = 0
  Top = 0
  Caption = 'AutoForm'
  ClientHeight = 698
  ClientWidth = 954
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
  DesignSize = (
    954
    698)
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 8
    Top = 168
    Width = 505
    Height = 522
    Anchors = [akLeft, akTop, akBottom]
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
  end
  object Button1: TButton
    Left = 205
    Top = 39
    Width = 191
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1089#1090#1080
    TabOrder = 1
    OnClick = Button1Click
  end
  object StringGrid2: TStringGrid
    Left = 519
    Top = 8
    Width = 427
    Height = 265
    Anchors = [akLeft, akTop, akRight]
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 2
  end
  object StringGrid3: TStringGrid
    Left = 519
    Top = 279
    Width = 427
    Height = 411
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 3
  end
  object Button3: TButton
    Left = 205
    Top = 8
    Width = 191
    Height = 25
    Caption = '<<'
    TabOrder = 4
    OnClick = Button3Click
  end
  object DP: TMonthCalendar
    Left = 8
    Top = 8
    Width = 191
    Height = 154
    Date = 40646.669374039350000000
    TabOrder = 5
    OnClick = DPClick
  end
end
