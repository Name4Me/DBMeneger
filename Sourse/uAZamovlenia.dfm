object AZamovleniaForm: TAZamovleniaForm
  Left = 126
  Top = 167
  BorderStyle = bsToolWindow
  Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1085#1077' '#1079#1072#1084#1086#1074#1083#1077#1085#1085#1103
  ClientHeight = 374
  ClientWidth = 839
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
  object HC1: THeaderControl
    Left = 0
    Top = 25
    Width = 839
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        Alignment = taRightJustify
        ImageIndex = -1
        Width = 180
      end
      item
        Alignment = taRightJustify
        ImageIndex = -1
        Width = 180
      end
      item
        Alignment = taRightJustify
        ImageIndex = -1
        Width = 205
      end
      item
        Alignment = taRightJustify
        ImageIndex = -1
        Width = 205
      end>
    Style = hsFlat
    ParentFont = False
  end
  object HC2: THeaderControl
    Left = 0
    Top = 0
    Width = 839
    Height = 25
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        ImageIndex = -1
        Text = #1047#1074#1110#1076#1082#1080
        Width = 180
      end
      item
        ImageIndex = -1
        Text = #1050#1091#1076#1080
        Width = 180
      end
      item
        ImageIndex = -1
        Text = #1053#1072#1079#1074#1072
        Width = 205
      end
      item
        ImageIndex = -1
        Text = #1058#1080#1087
        Width = 205
      end>
    Style = hsFlat
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 472
    Top = 136
    Width = 305
    Height = 89
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 2
    Visible = False
  end
  object Panel3: TPanel
    Left = 360
    Top = 49
    Width = 479
    Height = 325
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 477
      Height = 72
      Align = alTop
      TabOrder = 0
      object Button1: TButton
        Left = 5
        Top = 39
        Width = 160
        Height = 25
        Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1085#1077' '#1079#1072#1084#1086#1074#1083#1077#1085#1085#1103
        TabOrder = 0
        OnClick = MyOnClick
      end
      object CB3: TComboBox
        Left = 208
        Top = 5
        Width = 200
        Height = 28
        DropDownCount = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = True
        TabOrder = 1
        OnChange = MyOnClick
      end
      object CB2: TComboBox
        Left = 5
        Top = 5
        Width = 197
        Height = 28
        DropDownCount = 30
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 0
        ParentFont = False
        Sorted = True
        TabOrder = 2
        OnClick = MyOnClick
      end
      object Button2: TButton
        Left = 171
        Top = 39
        Width = 89
        Height = 25
        Caption = #1054#1095#1080#1097#1077#1085#1085#1103
        TabOrder = 3
        OnClick = MyOnClick
      end
      object Button4: TButton
        Left = 392
        Top = 39
        Width = 75
        Height = 25
        Caption = #1044#1088#1091#1082
        TabOrder = 4
        OnClick = Button4Click
      end
      object SE1: TSpinEdit
        Left = 414
        Top = 5
        Width = 57
        Height = 26
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        TabOrder = 5
        Value = 1
      end
    end
    object StringGrid1: TStringGrid
      Left = 1
      Top = 73
      Width = 477
      Height = 251
      Align = alClient
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 1
      OnDrawCell = StringGrid1DrawCell
      OnKeyUp = StringGrid1KeyUp
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 49
    Width = 180
    Height = 325
    Align = alLeft
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 4
    OnClick = MyOnClick
  end
  object ListBox2: TListBox
    Left = 180
    Top = 49
    Width = 180
    Height = 325
    Align = alLeft
    ItemHeight = 13
    TabOrder = 5
    OnClick = MyOnClick
  end
end
