object FPM: TFPM
  Left = -4
  Top = -4
  Align = alCustom
  BorderStyle = bsToolWindow
  Caption = #1055#1077#1088#1077#1084#1110#1097#1077#1085#1085#1103
  ClientHeight = 437
  ClientWidth = 864
  Color = clWindow
  DockSite = True
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
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000040000000000000CCCCCCCCCCCCC00000440000000000000000
    0000000000000444400000000000CCCCCCCCCCCCC00044444400000000000000
    0000000000044444400000000000CCCCCCCCCCCCC00440440000000000000000
    0000000000040040000000000000CCCCCCCCCCCCC00400000000000000000000
    0000000000040000000000000000CCCCCC000000000040000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000500000000000000000000000000000055000000C000000000000000
    0000000555500000C0000000000000000000005555550000C000000000000000
    0000000555555000C0000000000000000000000055055000C000000000000000
    0000000005005000C0000000000000000000000000005000C000000000000000
    0000000000005000C0000000000000000000000000050000C000000000000000
    0000000000000000C0000000000000000000000000000000C000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDDF70007CD8FFFFF866F00070347FFFE
    067B00064C3BFFFEDC7D0006FC73FFFEFC1B03FF7C05FFFFFE01FFFFFF07BEFB
    FFFFB1F3F400CDE1F7FFE8C0F400CF6077FF877274008FBB77FF8E7F7400837F
    77FF80BEF400C03FF7FFE0FFF400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    864
    437)
  PixelsPerInch = 96
  TextHeight = 13
  object Label0: TLabel
    Left = 501
    Top = 198
    Width = 102
    Height = 32
    Caption = #1059#1089#1100#1086#1075#1086': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 609
    Top = 198
    Width = 8
    Height = 32
    Caption = '-'
    Color = clCaptionText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentColor = False
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 864
    Height = 2
    Align = alTop
    Shape = bsBottomLine
    ExplicitWidth = 1280
  end
  object Bevel2: TBevel
    Left = 0
    Top = 95
    Width = 864
    Height = 2
    Align = alTop
    Shape = bsBottomLine
    ExplicitWidth = 1280
  end
  object GroupBox1: TGroupBox
    Left = 462
    Top = 236
    Width = 394
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    BiDiMode = bdRightToLeft
    Caption = '[]'
    ParentBiDiMode = False
    TabOrder = 15
    object Splitter1: TSplitter
      Left = 2
      Top = 99
      Width = 390
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 70
    end
    object StringGrid2: TStringGrid
      Left = 2
      Top = 15
      Width = 390
      Height = 84
      Align = alTop
      BiDiMode = bdLeftToRight
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentBiDiMode = False
      TabOrder = 0
      OnKeyUp = StringGrid1KeyUp
    end
    object StringGrid1: TStringGrid
      Left = 2
      Top = 102
      Width = 390
      Height = 93
      Align = alClient
      BiDiMode = bdLeftToRight
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentBiDiMode = False
      TabOrder = 1
      OnKeyUp = StringGrid1KeyUp
    end
  end
  object HC2: THeaderControl
    Left = 0
    Top = 64
    Width = 864
    Height = 31
    BiDiMode = bdLeftToRight
    FullDrag = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        AllowClick = False
        ImageIndex = -1
        Width = 190
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 175
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 45
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 40
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 75
      end>
    Style = hsFlat
    ParentBiDiMode = False
    ParentFont = False
  end
  object ListBox3: TListBox
    Left = 8
    Top = 170
    Width = 177
    Height = 263
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = ListBox3Click
  end
  object ListBox5: TListBox
    Left = 414
    Top = 103
    Width = 42
    Height = 330
    Anchors = [akLeft, akTop, akBottom]
    BiDiMode = bdLeftToRight
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentBiDiMode = False
    ParentFont = False
    Sorted = True
    TabOrder = 1
    OnClick = ListBox5Click
  end
  object ListBox6: TListBox
    Left = 462
    Top = 103
    Width = 33
    Height = 121
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 2
    OnClick = ListBox6Click
  end
  object Edit1: TSpinEdit
    Left = 455
    Top = 66
    Width = 65
    Height = 26
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 3
    MaxValue = 20
    MinValue = 1
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    Value = 1
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 501
    Top = 103
    Width = 105
    Height = 89
    Caption = #1055#1088#1086#1074#1077#1089#1090#1080
    TabOrder = 4
    OnClick = Button1Click
  end
  object HC1: THeaderControl
    Left = 0
    Top = 2
    Width = 864
    Height = 31
    Anchors = [akLeft, akRight]
    DragReorder = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        ImageIndex = -1
        Text = #1047#1074#1110#1076#1082#1080
        Width = 100
      end
      item
        ImageIndex = -1
        Width = 200
      end
      item
        ImageIndex = -1
        Text = '>>'
        Width = 40
      end>
    Style = hsFlat
    ParentFont = False
  end
  object ListBox1: TComboBox
    Left = 8
    Top = 103
    Width = 177
    Height = 28
    DropDownCount = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 5
    OnChange = ListBox1Click
  end
  object ListBox2: TComboBox
    Left = 8
    Top = 136
    Width = 177
    Height = 28
    DropDownCount = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 6
    OnChange = ListBox2Click
    OnExit = ListBox2Exit
  end
  object HC3: THeaderControl
    Left = 0
    Top = 33
    Width = 864
    Height = 31
    Anchors = [akLeft, akRight]
    DragReorder = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        ImageIndex = -1
        Text = #1050#1091#1076#1080
        Width = 100
      end
      item
        ImageIndex = -1
        Width = 200
      end
      item
        ImageIndex = -1
        Text = '<<'
        Width = 40
      end>
    Style = hsFlat
    ParentFont = False
  end
  object SpinEdit1: TSpinEdit
    Left = 793
    Top = 65
    Width = 65
    Height = 26
    Anchors = [akTop, akRight]
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 3
    MaxValue = 999
    MinValue = 0
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 7
    Value = 0
    OnChange = SpinEdit1Change
  end
  object CheckBox1: TCheckBox
    Left = 727
    Top = 103
    Width = 129
    Height = 17
    Caption = #1042#1110#1076#1086#1073#1088#1072#1078#1072#1090#1080' '#1086#1087#1077#1088#1072#1094#1110#1111
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = SpinEdit1Change
  end
  object ListBox4: TListBox
    Left = 238
    Top = 103
    Width = 170
    Height = 330
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 9
    OnClick = ListBox4Click
  end
  object Edit2: TEdit
    Left = 640
    Top = 198
    Width = 216
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 10
    Visible = False
  end
  object ListBox7: TListBox
    Tag = 2
    Left = 191
    Top = 103
    Width = 41
    Height = 330
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 11
    OnClick = ListBox7Click
  end
end
