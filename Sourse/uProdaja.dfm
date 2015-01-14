object ProdajaForm: TProdajaForm
  Left = -4
  Top = -4
  BorderStyle = bsToolWindow
  Caption = #1056#1086#1079#1076#1088#1110#1073
  ClientHeight = 393
  ClientWidth = 906
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  DesignSize = (
    906
    393)
  PixelsPerInch = 96
  TextHeight = 13
  object Label0: TLabel
    Left = 457
    Top = 175
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
    Left = 576
    Top = 175
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
    Width = 906
    Height = 2
    Align = alTop
    Shape = bsBottomLine
    ExplicitWidth = 1280
  end
  object Bevel2: TBevel
    Left = 0
    Top = 33
    Width = 906
    Height = 2
    Align = alTop
    Shape = bsBottomLine
    ExplicitTop = 95
    ExplicitWidth = 1280
  end
  object Label2: TLabel
    Left = 878
    Top = 183
    Width = 6
    Height = 24
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ExplicitLeft = 904
  end
  object Label3: TLabel
    Left = 787
    Top = 183
    Width = 6
    Height = 24
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object HC1: THeaderControl
    Left = 0
    Top = 2
    Width = 906
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
        Width = 35
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 185
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 45
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 30
      end
      item
        AllowClick = False
        ImageIndex = -1
        Width = 300
      end
      item
        ImageIndex = -1
        Width = 50
      end>
    Style = hsFlat
    ParentBiDiMode = False
    ParentFont = False
  end
  object ListBox1: TListBox
    Tag = 1
    Left = 8
    Top = 41
    Width = 180
    Height = 344
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
    OnClick = ListBoxClick
  end
  object ListBox4: TListBox
    Tag = 4
    Left = 411
    Top = 42
    Width = 40
    Height = 343
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
    TabOrder = 1
    OnClick = ListBoxClick
  end
  object ListBox5: TListBox
    Tag = 5
    Left = 457
    Top = 41
    Width = 25
    Height = 128
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
    OnClick = ListBoxClick
  end
  object SpinEdit1: TSpinEdit
    Left = 488
    Top = 41
    Width = 112
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
    OnChange = SpinEditChange
    OnExit = SpinEdit1Exit
  end
  object Button1: TButton
    Left = 488
    Top = 119
    Width = 112
    Height = 50
    Caption = #1055#1088#1086#1074#1077#1089#1090#1080
    Enabled = False
    TabOrder = 4
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 626
    Top = 190
    Width = 129
    Height = 17
    Caption = #1042#1110#1076#1086#1073#1088#1072#1078#1072#1090#1080' '#1086#1087#1077#1088#1072#1094#1110#1111
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object ListBox2: TListBox
    Tag = 2
    Left = 194
    Top = 41
    Width = 25
    Height = 344
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 7
    OnClick = ListBoxClick
  end
  object StringGrid1: TStringGrid
    Left = 457
    Top = 213
    Width = 441
    Height = 172
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 8
    OnKeyUp = StringGrid1KeyUp
  end
  object ListBox3: TListBox
    Tag = 3
    Left = 225
    Top = 41
    Width = 180
    Height = 344
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 9
    OnClick = ListBoxClick
  end
  object Edit3: TEdit
    Left = 488
    Top = 73
    Width = 112
    Height = 40
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    Text = '0,00'
  end
  object SpinButton1: TSpinButton
    Left = 580
    Top = 75
    Width = 18
    Height = 36
    DownGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000008080000080800000808000000000000080800000808000008080000080
      8000008080000080800000808000000000000000000000000000008080000080
      8000008080000080800000808000000000000000000000000000000000000000
      0000008080000080800000808000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    TabOrder = 11
    UpGlyph.Data = {
      0E010000424D0E01000000000000360000002800000009000000060000000100
      200000000000D800000000000000000000000000000000000000008080000080
      8000008080000080800000808000008080000080800000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000080
      8000008080000080800000000000000000000000000000000000000000000080
      8000008080000080800000808000008080000000000000000000000000000080
      8000008080000080800000808000008080000080800000808000000000000080
      8000008080000080800000808000008080000080800000808000008080000080
      800000808000008080000080800000808000}
    OnDownClick = SpinButton1DownClick
    OnUpClick = SpinButton1UpClick
  end
  object Edit1: TEdit
    Left = 626
    Top = 136
    Width = 258
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 12
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 608
    Top = 40
  end
end
