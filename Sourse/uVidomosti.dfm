object VidomostiForm: TVidomostiForm
  Left = 202
  Top = 173
  Caption = #1042#1110#1076#1086#1084#1086#1089#1090#1110
  ClientHeight = 399
  ClientWidth = 1114
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 121
    Width = 1114
    Height = 259
    Align = alClient
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
    TabOrder = 4
    OnDragOver = StringGrid1DragOver
    OnDrawCell = StringGrid1DrawCell
    OnKeyDown = StringGrid1KeyDown
    OnKeyUp = StringGrid1KeyUp
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 1114
    Height = 56
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 727
      Top = 6
      Width = 107
      Height = 44
      Caption = #1055#1086#1082#1072#1079#1072#1090#1080
      TabOrder = 8
      OnClick = Button1Click
    end
    object CB3: TComboBox
      Left = 488
      Top = 8
      Width = 129
      Height = 21
      DropDownCount = 25
      ItemHeight = 13
      Sorted = True
      TabOrder = 5
      OnChange = MyClick
    end
    object CB4: TComboBox
      Left = 616
      Top = 8
      Width = 57
      Height = 21
      DropDownCount = 25
      ItemHeight = 13
      Sorted = True
      TabOrder = 6
      OnChange = MyClick
    end
    object CB5: TComboBox
      Left = 672
      Top = 8
      Width = 49
      Height = 21
      DropDownCount = 25
      ItemHeight = 13
      Sorted = True
      TabOrder = 7
      OnChange = MyClick
    end
    object CheckBox1: TCheckBox
      Left = 8
      Top = 8
      Width = 25
      Height = 17
      TabOrder = 0
      OnClick = MyClick
    end
    object DTP: TDateTimePicker
      Left = 24
      Top = 8
      Width = 97
      Height = 20
      Date = 0.531137731501076000
      Time = 0.531137731501076000
      Enabled = False
      TabOrder = 1
      OnChange = MyClick
    end
    object CB1: TComboBox
      Left = 120
      Top = 8
      Width = 97
      Height = 21
      DropDownCount = 25
      ItemHeight = 13
      TabOrder = 2
      OnChange = MyClick
      Items.Strings = (
        #1055#1088#1086#1076#1072#1085#1086' '#1079'...'
        #1042#1080#1076#1072#1085#1086' '#1085#1072'...'
        #1055#1086#1074#1077#1088#1085#1077#1085#1086' '#1085#1072'...'
        #1055#1077#1088#1077#1084#1110#1097#1077#1085#1086' '#1079'...'
        #1055#1077#1088#1077#1084#1110#1097#1077#1085#1086' '#1085#1072'...'
        #1028' '#1074' '#1085#1072#1103#1074#1085#1086#1089#1090#1110'...'
        #1042#1089#1110' '#1086#1087#1077#1088#1072#1094#1110#1111'...')
    end
    object CB2: TComboBox
      Left = 216
      Top = 8
      Width = 162
      Height = 21
      DropDownCount = 30
      ItemHeight = 13
      Sorted = True
      TabOrder = 3
      OnChange = MyClick
    end
    object CB: TComboBox
      Left = 376
      Top = 8
      Width = 113
      Height = 21
      DropDownCount = 25
      ItemHeight = 13
      Sorted = True
      TabOrder = 4
      OnChange = MyClick
    end
    object CheckBox2: TCheckBox
      Left = 8
      Top = 33
      Width = 25
      Height = 17
      TabOrder = 9
      OnClick = MyClick
    end
    object DTP1: TDateTimePicker
      Left = 24
      Top = 29
      Width = 97
      Height = 20
      Date = 0.531137731501076000
      Time = 0.531137731501076000
      Enabled = False
      TabOrder = 10
      OnChange = MyClick
    end
    object CB6: TComboBox
      Left = 216
      Top = 29
      Width = 161
      Height = 21
      DropDownCount = 30
      ItemHeight = 13
      Sorted = True
      TabOrder = 11
      OnChange = MyClick
    end
    object CheckBox3: TCheckBox
      Left = 840
      Top = 34
      Width = 121
      Height = 17
      Caption = 'Limit'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object SpinEdit1: TSpinEdit
      Left = 840
      Top = 6
      Width = 121
      Height = 22
      Increment = 10
      MaxValue = 10000
      MinValue = 1
      TabOrder = 13
      Value = 100
    end
    object CheckBox4: TCheckBox
      Left = 888
      Top = 34
      Width = 49
      Height = 17
      Caption = 'OCina'
      TabOrder = 14
    end
    object CheckBox5: TCheckBox
      Left = 943
      Top = 34
      Width = 49
      Height = 17
      Caption = 'ZCina'
      TabOrder = 15
    end
    object Button2: TButton
      Left = 967
      Top = 3
      Width = 75
      Height = 25
      Caption = #1044#1088#1091#1082
      TabOrder = 16
      OnClick = Button2Click
    end
  end
  object SB: TStatusBar
    Left = 0
    Top = 380
    Width = 1114
    Height = 19
    Panels = <
      item
        Width = 70
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object HC1: THeaderControl
    Left = 0
    Top = 0
    Width = 1114
    Height = 17
    Anchors = [akLeft, akRight]
    DragReorder = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        Alignment = taRightJustify
        AllowClick = False
        ImageIndex = -1
        Text = #1044#1072#1090#1072
        Width = 120
      end
      item
        Alignment = taRightJustify
        AllowClick = False
        ImageIndex = -1
        Text = #1054#1087#1077#1088#1072#1094#1110#1103
        Width = 98
      end
      item
        Alignment = taRightJustify
        AllowClick = False
        ImageIndex = -1
        Text = #1052#1110#1089#1094#1077
        Width = 160
      end
      item
        Alignment = taRightJustify
        AllowClick = False
        ImageIndex = -1
        Text = #1053#1072#1079#1074#1072
        Width = 111
      end
      item
        Alignment = taRightJustify
        AllowClick = False
        ImageIndex = -1
        Text = #1058#1080#1087
        Width = 130
      end
      item
        Alignment = taRightJustify
        AllowClick = False
        ImageIndex = -1
        Text = #1056#1086#1079#1084#1110#1088
        Width = 55
      end
      item
        Alignment = taRightJustify
        AllowClick = False
        ImageIndex = -1
        Text = #1056#1110#1089#1090
        Width = 46
      end
      item
        Alignment = taRightJustify
        AllowClick = False
        AutoSize = True
        ImageIndex = -1
        Width = 394
      end>
    Style = hsFlat
    ParentFont = False
  end
  object HC2: THeaderControl
    Left = 0
    Top = 17
    Width = 1114
    Height = 24
    DragReorder = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        ImageIndex = -1
        Width = 60
      end
      item
        ImageIndex = -1
        Width = 60
      end
      item
        ImageIndex = -1
        Width = 78
      end
      item
        ImageIndex = -1
        Width = 20
      end
      item
        ImageIndex = -1
        Width = 80
      end
      item
        ImageIndex = -1
        Width = 80
      end
      item
        ImageIndex = -1
        Width = 111
      end
      item
        ImageIndex = -1
        Width = 130
      end
      item
        ImageIndex = -1
        Width = 55
      end
      item
        ImageIndex = -1
        Width = 46
      end
      item
        AutoSize = True
        ImageIndex = -1
        Width = 394
      end>
    Style = hsFlat
    ParentFont = False
  end
  object HC: THeaderControl
    Left = 0
    Top = 97
    Width = 1114
    Height = 24
    DragMode = dmAutomatic
    DragReorder = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        ImageIndex = -1
        Text = #1057#1086#1088#1090#1091#1074#1072#1090#1080':'
        Width = 100
      end
      item
        ImageIndex = -1
        Text = 'Oper'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Zvidk'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Misce'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Nazva'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Tip'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Rozmir'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Rist'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Data'
        Width = 50
      end
      item
        ImageIndex = -1
        Text = 'Time'
        Width = 50
      end>
    Style = hsFlat
    ParentFont = False
    OnDragDrop = HCDragDrop
    OnDragOver = HCDragOver
    OnEndDrag = HCEndDrag
  end
end
