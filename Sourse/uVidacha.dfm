object VidachaForm: TVidachaForm
  Left = 103
  Top = 139
  BorderStyle = bsToolWindow
  Caption = #1055#1086#1074#1077#1088#1085#1077#1085#1085#1103
  ClientHeight = 572
  ClientWidth = 976
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010002002020100000000000E80200002600000010101000000000002801
    00000E0300002800000020000000400000000100040000000000800200000000
    0000000000000000000000000000000000000000800000800000008080008000
    0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
    0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
    000000000000000000000000000000000000000000BBB0000000000000000000
    000000000BB0BB00000000000000000000000000BB0B0BB00000000000000000
    0000000BB0BBB0BB0000000000000000000000BB0BBBBB0BB000000000000000
    00000BB0BBBBBBB0BB000000000000000000BB0BBBBBBBBB0BB0000000000000
    000BB0BBBBB0BBBBB0BB00000000000000BB0BBBBB000BBBBB0BB00000000000
    0BB0BBBBB00000BBBBB0BB0000000000BB0BBBBB0000000BBBBB0BB00000000B
    B0BBBBB000000000BBBBB0BB000000BB0BBBBBB000000000BBBBBB0BB0000BB0
    BBBBBBBBBB000BBBBBBBBBB0BB000B0BBBBBBBBBBB000BBBBBBBBBBB0B000BB0
    BBBBBBBBBB000BBBBBBBBBB0BB0000BB0BBBBBBBBB000BBBBBBBBB0BB000000B
    B0BBBBBBBB000BBBBBBBB0BB00000000BB0BBBBBBB000BBBBBBB0BB000000000
    0BB0BBBBBB000BBBBBB0BB000000000000BB0BBBBB000BBBBB0BB00000000000
    000BB0BBBB000BBBB0BB0000000000000000BB0BBBBBBBBB0BB0000000000000
    00000BB0BBBBBBB0BB00000000000000000000BB0BBBBB0BB000000000000000
    0000000BB0BBB0BB000000000000000000000000BB0B0BB00000000000000000
    000000000BB0BB0000000000000000000000000000BBB0000000000000000000
    0000000000000000000000000000FFFFFFFFFFFC7FFFFFF83FFFFFF01FFFFFE0
    0FFFFFC007FFFF8003FFFF0001FFFE0000FFFC00007FF800003FF000001FE000
    000FC00000078000000300000001000000010000000180000003C0000007E000
    000FF000001FF800003FFC00007FFE0000FFFF0001FFFF8003FFFFC007FFFFE0
    0FFFFFF01FFFFFF83FFFFFFC7FFF280000001000000020000000010004000000
    0000C00000000000000000000000000000000000000000000000000080000080
    00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
    000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
    000BB0000000000000B00B00000000000B0BB0B000000000B0BBBB0B0000000B
    0BB00BB0B00000B0BB0000BB0B000B0BB000000BB0B00B0BBBB00BBBB0B000B0
    BBB00BBB0B00000B0BB00BB0B0000000B0B00B0B000000000B0BB0B000000000
    00B00B0000000000000BB00000000000000000000000FE7F0000FC3F0000F81F
    0000F00F0000E0070000C003000080010000000000000000000080010000C003
    0000E0070000F00F0000F81F0000FC3F0000FE7F0000}
  KeyPreview = True
  Padding.Left = 2
  Padding.Top = 2
  Padding.Right = 2
  Padding.Bottom = 2
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    976
    572)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 497
    Top = 63
    Width = 477
    Height = 488
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      477
      488)
    object Label1: TLabel
      Left = 423
      Top = 64
      Width = 5
      Height = 24
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object StringGrid1: TStringGrid
      Left = 6
      Top = 94
      Width = 467
      Height = 388
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 6
      OnKeyUp = StringGrid1KeyUp
    end
    object Button1: TButton
      Left = 6
      Top = 6
      Width = 161
      Height = 59
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080
      Enabled = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button26: TButton
      Left = 354
      Top = 264
      Width = 75
      Height = 25
      Caption = 'Button26'
      TabOrder = 1
      Visible = False
      OnClick = Button26Click
    end
    object Memo1: TMemo
      Left = 154
      Top = 217
      Width = 194
      Height = 72
      Anchors = [akTop, akRight]
      ScrollBars = ssBoth
      TabOrder = 2
      Visible = False
    end
    object Button27: TButton
      Left = 353
      Top = 295
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1080
      TabOrder = 3
      Visible = False
      OnClick = Button27Click
    end
    object Button28: TButton
      Left = 354
      Top = 233
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080
      TabOrder = 4
      Visible = False
      OnClick = Button28Click
    end
    object CheckBox1: TCheckBox
      Left = 6
      Top = 71
      Width = 129
      Height = 17
      Caption = #1042#1110#1076#1086#1073#1088#1072#1078#1072#1090#1080' '#1086#1087#1077#1088#1072#1094#1110#1111
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
  end
  object HC2: THeaderControl
    Left = 2
    Top = 31
    Width = 972
    Height = 32
    BorderWidth = 1
    DragReorder = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Sections = <
      item
        ImageIndex = -1
        Width = 180
      end
      item
        ImageIndex = -1
        Width = 45
      end
      item
        ImageIndex = -1
        Width = 180
      end
      item
        ImageIndex = -1
        Width = 50
      end
      item
        ImageIndex = -1
        Width = 40
      end
      item
        ImageIndex = -1
        Width = 70
      end
      item
        AllowClick = False
        AutoSize = True
        ImageIndex = -1
        Width = 405
      end>
    Style = hsFlat
    ParentFont = False
  end
  object HC1: THeaderControl
    Left = 2
    Top = 2
    Width = 972
    Height = 29
    Anchors = [akLeft, akRight]
    BorderWidth = 1
    DragReorder = True
    Enabled = False
    Sections = <
      item
        ImageIndex = -1
        Text = #1053#1072#1079#1074#1072
        Width = 180
      end
      item
        ImageIndex = -1
        Width = 45
      end
      item
        ImageIndex = -1
        Text = #1058#1080#1087
        Width = 180
      end
      item
        ImageIndex = -1
        Text = #1056#1086#1079#1084#1110#1088
        Width = 50
      end
      item
        ImageIndex = -1
        Text = #1056#1110#1089#1090
        Width = 40
      end
      item
        ImageIndex = -1
        Text = #1050#1110#1083#1100#1082#1110#1089#1090#1100
        Width = 70
      end
      item
        AllowClick = False
        AutoSize = True
        ImageIndex = -1
        Width = 405
      end>
    Style = hsFlat
  end
  object SB: TStatusBar
    Left = 2
    Top = 551
    Width = 972
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object ListBox1: TListBox
    Tag = 1
    Left = 2
    Top = 63
    Width = 180
    Height = 488
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 4
    OnClick = ListBoxClick
  end
  object ListBox3: TListBox
    Tag = 3
    Left = 227
    Top = 63
    Width = 180
    Height = 488
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 5
    OnClick = ListBoxClick
  end
  object ListBox4: TListBox
    Tag = 4
    Left = 407
    Top = 63
    Width = 50
    Height = 488
    Align = alLeft
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 6
    OnClick = ListBoxClick
  end
  object ListBox5: TListBox
    Tag = 5
    Left = 457
    Top = 63
    Width = 40
    Height = 488
    Align = alLeft
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
  object ListBox2: TListBox
    Tag = 2
    Left = 182
    Top = 63
    Width = 45
    Height = 488
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    Sorted = True
    TabOrder = 8
    OnClick = ListBoxClick
  end
  object SpinEdit1: TSpinEdit
    Left = 500
    Top = 32
    Width = 65
    Height = 26
    Ctl3D = True
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 3
    MaxValue = 1000
    MinValue = 1
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 9
    Value = 1
  end
  object SpinEdit2: TSpinEdit
    Left = 928
    Top = 3
    Width = 42
    Height = 22
    Anchors = [akTop, akRight]
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 3
    MaxValue = 20
    MinValue = 1
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 10
    Value = 1
    OnChange = SpinEdit2Change
  end
  object Edit1: TEdit
    Left = 571
    Top = 36
    Width = 400
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 11
    Visible = False
  end
end
