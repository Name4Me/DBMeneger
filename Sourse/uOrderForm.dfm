object OrderForm: TOrderForm
  Left = 0
  Top = 0
  Caption = #1055#1086#1090#1086#1095#1085#1077' '#1079#1072#1084#1086#1074#1083#1077#1085#1085#1103
  ClientHeight = 438
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 2
  Padding.Top = 1
  Padding.Right = 2
  Padding.Bottom = 2
  OldCreateOrder = False
  Visible = True
  OnActivate = FormShow
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 2
    Top = 301
    Width = 720
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 15
    ExplicitWidth = 248
  end
  object GroupBox1: TGroupBox
    Left = 2
    Top = 1
    Width = 720
    Height = 300
    Align = alTop
    Caption = #1050#1072#1090#1072#1083#1086#1075
    TabOrder = 0
    DesignSize = (
      720
      300)
    object Label1: TLabel
      Left = 432
      Top = 50
      Width = 40
      Height = 16
      Caption = #1053#1072#1079#1074#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 432
      Top = 75
      Width = 27
      Height = 16
      Caption = #1058#1080#1087':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 432
      Top = 100
      Width = 43
      Height = 16
      Caption = #1056#1086#1079#1084#1110#1088':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 432
      Top = 125
      Width = 27
      Height = 16
      Caption = #1056#1110#1089#1090':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 568
      Top = 50
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 568
      Top = 75
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 568
      Top = 100
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 568
      Top = 125
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 432
      Top = 150
      Width = 110
      Height = 16
      Caption = #1044#1086#1089#1090#1091#1087#1085#1072' '#1082#1110#1083#1100#1082#1110#1089#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 568
      Top = 150
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 568
      Top = 175
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 432
      Top = 175
      Width = 26
      Height = 16
      Caption = #1062#1110#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 432
      Top = 200
      Width = 26
      Height = 16
      Caption = #1050#1091#1088#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 568
      Top = 200
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 432
      Top = 225
      Width = 20
      Height = 16
      Caption = 'TID'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 568
      Top = 225
      Width = 7
      Height = 19
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ListBox1: TListBox
      Left = 11
      Top = 16
      Width = 150
      Height = 278
      AutoCompleteDelay = 3000
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object ListBox2: TListBox
      Left = 167
      Top = 16
      Width = 150
      Height = 278
      AutoCompleteDelay = 3000
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 1
      OnClick = ListBox2Click
    end
    object ListBox3: TListBox
      Left = 323
      Top = 16
      Width = 46
      Height = 278
      AutoCompleteDelay = 3000
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 2
      OnClick = ListBox3Click
    end
    object Button1: TButton
      Left = 432
      Top = 247
      Width = 121
      Height = 27
      Caption = #1047#1072#1084#1086#1074#1080#1090#1080
      Enabled = False
      TabOrder = 3
      OnClick = Button1Click
    end
    object CheckBox: TCheckBox
      Left = 616
      Top = 18
      Width = 89
      Height = 17
      Anchors = [akTop, akRight]
      BiDiMode = bdRightToLeft
      Caption = #1058#1110#1083#1100#1082#1080' '#1085#1072#1103#1074#1085#1110
      Checked = True
      ParentBiDiMode = False
      State = cbChecked
      TabOrder = 4
    end
    object SpinEdit: TSpinEdit
      Left = 421
      Top = 16
      Width = 121
      Height = 22
      MaxValue = 100
      MinValue = 1
      TabOrder = 5
      Value = 1
    end
    object ListBox4: TListBox
      Left = 375
      Top = 16
      Width = 40
      Height = 278
      AutoCompleteDelay = 1500
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 6
      OnClick = ListBox4Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 2
    Top = 304
    Width = 720
    Height = 132
    Align = alClient
    BiDiMode = bdRightToLeft
    Caption = #1055#1086#1090#1086#1095#1085#1077' '#1079#1072#1084#1086#1074#1083#1077#1085#1085#1103
    ParentBiDiMode = False
    TabOrder = 1
    DesignSize = (
      720
      132)
    object Label17: TLabel
      Left = 693
      Top = 20
      Width = 12
      Height = 19
      Anchors = [akTop, akRight]
      Caption = '[]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object SGrid: TStringGrid
      Left = 11
      Top = 45
      Width = 694
      Height = 81
      Anchors = [akLeft, akTop, akRight, akBottom]
      BiDiMode = bdLeftToRight
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyUp = SGridKeyUp
    end
    object Button2: TButton
      Left = 11
      Top = 13
      Width = 75
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1080
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 92
      Top = 14
      Width = 323
      Height = 25
      Caption = #1053#1072#1076#1110#1089#1083#1072#1090#1080' '#1079#1072#1084#1086#1074#1083#1077#1085#1085#1103
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 421
      Top = 14
      Width = 75
      Height = 25
      Caption = #1042#1080#1076#1072#1083#1080#1090#1080
      TabOrder = 3
      OnClick = Button4Click
    end
  end
end
