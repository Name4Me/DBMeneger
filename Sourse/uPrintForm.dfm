object PrintForm: TPrintForm
  Left = 979
  Top = 492
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = #1044#1088#1091#1082
  ClientHeight = 203
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020040000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000F8800000000000000000000F8800000000
    0000000000000000000000000000033333333333333333333333333333300FBF
    BFBFBFBFBFBFBFBFBFBFBFBFBF300BFBFBFBFBFBFBFBFBFBFBFBFBFBFB300FB0
    00000000000000000000000000300BFFF0FF0FF0FF0FF0FF0FF0FF0FF03000BF
    000000000000000000000000B300000BFF0FF0FF0FF0FF0FF0FF0FF030000000
    B000000000000000000000B3000000000BF0FF0FF0FF0FF0FF0FF03000000000
    0FBFBFBFBFBFBFBFBFBFBF30000000000BFBFBFBFBFBFBFBFBFBFB3000000000
    0FBFBFBFBFBFBFBFBFBFBF30000000000BFBFBFBF000000BFBFBFB3000000000
    0FBFBFBF07777770BFBFBF300000080080FBFBF0F8FFFF8F0BFBF30800800F80
    8800000FFF8888FFF000008808F00F00FFFF0FFFFFFFFFFFFFF07FFF00F00000
    77770FFCCCCCCCCCCFF087770000000000000FFFFFFFFFFFFFF0000000000000
    00000FFCCCCCCCCCFFF000000000000000000FFFFFFFFFFFFFF0000000000000
    00000FFCCCFFFFFFFFF0000000000000000088FFFFFFFFFFFFF8800000000000
    000000FFFFFFFFFFFFFF00000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFC7FFFF8F83FFFF07800000010000000000000000000000000000
    00000000000080000001C0000003E0000007F000000FF000000FF000000FF000
    000FE00000072000000400000000000000000000000020000004F000000FFF00
    00FFFF0000FFFF0000FFFF00007FFF80007FFF80007FFFFFFFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button3: TButton
    Left = 200
    Top = 8
    Width = 81
    Height = 28
    Caption = #1044#1088#1091#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button3Click
  end
  object CB: TComboBox
    Left = 8
    Top = 8
    Width = 186
    Height = 28
    DropDownCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    Sorted = True
    TabOrder = 1
    OnChange = CBChange
  end
  object Button1: TButton
    Left = 8
    Top = 107
    Width = 273
    Height = 25
    Caption = #1042#1083#1072#1089#1090#1080#1074#1086#1089#1090#1110
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 172
    Width = 273
    Height = 25
    Caption = #1043#1091#1088#1090#1086#1074#1110' '#1094#1110#1085#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object ListBox1: TListBox
    Left = 287
    Top = 8
    Width = 276
    Height = 158
    ItemHeight = 13
    TabOrder = 4
  end
  object Button6: TButton
    Left = 287
    Top = 172
    Width = 276
    Height = 25
    Caption = #1044#1088#1091#1082' '#1075#1091#1088#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = Button6Click
  end
  object SGrid2: TStringGrid
    Left = 8
    Top = 231
    Width = 555
    Height = 165
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 6
    Visible = False
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 42
    Width = 273
    Height = 28
    DropDownCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    Sorted = True
    TabOrder = 7
  end
  object Edit1: TEdit
    Left = 8
    Top = 80
    Width = 273
    Height = 21
    TabOrder = 8
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 138
    Width = 273
    Height = 28
    DropDownCount = 10
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    Sorted = True
    TabOrder = 9
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 296
    Top = 16
  end
end
