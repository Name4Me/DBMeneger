object OptCalculateForm: TOptCalculateForm
  Left = 0
  Top = 0
  Caption = #1056#1086#1079#1088#1072#1093#1091#1085#1086#1082
  ClientHeight = 437
  ClientWidth = 689
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
    689
    437)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 676
    Top = 8
    Width = 5
    Height = 19
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 33
    Width = 673
    Height = 396
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
  end
end
