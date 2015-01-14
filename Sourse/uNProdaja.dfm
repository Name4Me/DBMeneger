object FNP: TFNP
  Left = 125
  Top = 129
  Align = alClient
  BorderStyle = bsToolWindow
  Caption = #1056#1086#1079#1076#1088#1110#1073
  ClientHeight = 446
  ClientWidth = 763
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 332
    Width = 763
    Height = 6
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 1
    ExplicitTop = 302
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 763
    Height = 73
    Align = alTop
    TabOrder = 0
    TabStop = True
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 33
      Height = 20
      Caption = #1062#1110#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 48
      Top = 32
      Width = 6
      Height = 32
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 129
      Top = 48
      Width = 5
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 8
      Top = 56
      Width = 6
      Height = 13
      Caption = '1'
      Visible = False
    end
    object Edit5: TEdit
      Left = 458
      Top = 4
      Width = 95
      Height = 40
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = '0,00'
      OnKeyPress = Edit3KeyPress
    end
    object Edit1: TEdit
      Left = 8
      Top = 4
      Width = 121
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnChange = Edit1Change
      OnKeyPress = Edit1KeyPress
      OnKeyUp = MyKeyUp
    end
    object Button2: TButton
      Left = 304
      Top = 35
      Width = 137
      Height = 28
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Button2Click
    end
    object SpinEdit1: TSpinEdit
      Left = 123
      Top = 4
      Width = 57
      Height = 42
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 999
      MinValue = 1
      ParentFont = False
      TabOrder = 2
      Value = 1
      OnChange = MyChange
      OnKeyUp = MyKeyUp
    end
    object IPN: TEdit
      Left = 304
      Top = 8
      Width = 137
      Height = 21
      Enabled = False
      TabOrder = 3
      Visible = False
      OnKeyPress = IPNKeyPress
    end
    object Edit3: TEdit
      Left = 186
      Top = 4
      Width = 112
      Height = 40
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -27
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = '0,00'
      OnKeyPress = Edit3KeyPress
      OnKeyUp = MyKeyUp
    end
    object SpinButton1: TSpinButton
      Left = 278
      Top = 6
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
      TabOrder = 5
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
    object Edit4: TEdit
      Left = 458
      Top = 48
      Width = 41
      Height = 21
      Enabled = False
      ReadOnly = True
      TabOrder = 7
    end
    object rb1: TRadioButton
      Left = 560
      Top = 8
      Width = 81
      Height = 17
      Caption = #1056#1086#1079#1076#1088#1110#1073
      Checked = True
      Enabled = False
      TabOrder = 8
      TabStop = True
    end
    object rb2: TRadioButton
      Left = 560
      Top = 24
      Width = 81
      Height = 17
      Caption = #1056#1077#1072#1083#1110#1079#1072#1094#1110#1103
      Enabled = False
      TabOrder = 9
    end
    object rb3: TRadioButton
      Left = 560
      Top = 40
      Width = 81
      Height = 17
      Caption = #1043#1091#1088#1090
      Enabled = False
      TabOrder = 10
    end
    object ListBox1: TListBox
      Tag = 5
      Left = 654
      Top = 1
      Width = 108
      Height = 71
      Align = alRight
      ItemHeight = 13
      TabOrder = 11
      OnClick = ListBox3Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 73
    Width = 763
    Height = 40
    Align = alTop
    TabOrder = 1
    DesignSize = (
      763
      40)
    object SE4: TSpinEdit
      Left = 615
      Top = 8
      Width = 33
      Height = 22
      Anchors = [akTop, akRight]
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 1
    end
    object CheckBox1: TCheckBox
      Left = 304
      Top = 6
      Width = 154
      Height = 17
      Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1085#1077' '#1087#1088#1086#1074#1077#1076#1077#1085#1085#1103
      TabOrder = 1
    end
    object Button7: TButton
      Left = 654
      Top = 6
      Width = 99
      Height = 30
      Anchors = [akTop, akRight]
      Caption = #1044#1088#1091#1082' '#1095#1077#1082#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button7Click
    end
    object CheckBox2: TCheckBox
      Left = 304
      Top = 22
      Width = 154
      Height = 17
      Caption = #1044#1088#1091#1082#1091#1074#1072#1090#1080' '#1087#1086#1087#1077#1088#1077#1076#1078#1077#1085#1085#1103
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 6
      Width = 290
      Height = 22
      AutoCompleteDelay = 3000
      Style = csOwnerDrawFixed
      ItemHeight = 16
      Sorted = True
      TabOrder = 4
      OnClick = ListBox3Click
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 308
    Width = 763
    Height = 24
    Align = alBottom
    TabOrder = 2
    object Label10: TLabel
      Left = 8
      Top = 4
      Width = 3
      Height = 13
    end
    object Panel6: TPanel
      Left = 553
      Top = 1
      Width = 209
      Height = 22
      Align = alRight
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object Label5: TLabel
        Left = 10
        Top = 2
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label9: TLabel
        Left = 155
        Top = 2
        Width = 6
        Height = 13
        Caption = '$'
      end
      object Label8: TLabel
        Left = 147
        Top = 2
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label7: TLabel
        Left = 64
        Top = 2
        Width = 17
        Height = 13
        Caption = #1075#1088#1085
      end
      object Label6: TLabel
        Left = 56
        Top = 2
        Width = 6
        Height = 13
        Caption = '0'
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 113
    Width = 763
    Height = 195
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 3
    object SGrid1: TStringGrid
      Left = 388
      Top = 1
      Width = 156
      Height = 193
      Align = alClient
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
      OnClick = ListBox3Click
      OnKeyUp = MyKeyUp
    end
    object ListBox2: TListBox
      Tag = 3
      Left = 173
      Top = 1
      Width = 176
      Height = 193
      AutoCompleteDelay = 3000
      Align = alLeft
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      OnClick = ListBox3Click
      OnKeyPress = ListBox2KeyPress
    end
    object ListBox3: TListBox
      Tag = 1
      Left = 1
      Top = 1
      Width = 133
      Height = 193
      Align = alLeft
      ItemHeight = 13
      Sorted = True
      TabOrder = 2
      OnClick = ListBox3Click
    end
    object PageControl1: TPageControl
      Left = 544
      Top = 1
      Width = 218
      Height = 193
      ActivePage = TabSheet2
      Align = alRight
      Style = tsFlatButtons
      TabOrder = 3
      object TabSheet2: TTabSheet
        Caption = #1043#1086#1090#1110#1074#1082#1072
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label12: TLabel
          Left = 121
          Top = 7
          Width = 20
          Height = 13
          Caption = #1075#1088#1085'.'
        end
        object Label13: TLabel
          Left = 121
          Top = 34
          Width = 6
          Height = 13
          Caption = '$'
        end
        object Label14: TLabel
          Left = 121
          Top = 88
          Width = 55
          Height = 13
          Caption = #1056#1077#1096#1090#1072' '#1075#1088#1085'.'
        end
        object Label15: TLabel
          Left = 121
          Top = 115
          Width = 41
          Height = 13
          Caption = #1056#1077#1096#1090#1072' $'
        end
        object Label16: TLabel
          Left = 121
          Top = 61
          Width = 84
          Height = 13
          Caption = #1055#1086#1087#1077#1088#1077#1076#1085#1110#1081' '#1073#1086#1088#1075
        end
        object Edit6: TEdit
          Left = 3
          Top = -1
          Width = 112
          Height = 21
          TabOrder = 0
          Text = '0,00'
          OnChange = MyChange
          OnKeyPress = Edit3KeyPress
        end
        object Edit7: TEdit
          Left = 3
          Top = 26
          Width = 112
          Height = 21
          TabOrder = 1
          Text = '0,00'
          OnChange = MyChange
          OnKeyPress = Edit3KeyPress
        end
        object Edit8: TEdit
          Left = 3
          Top = 80
          Width = 112
          Height = 21
          ReadOnly = True
          TabOrder = 2
          Text = '0,00'
          OnChange = MyChange
        end
        object Edit9: TEdit
          Left = 3
          Top = 107
          Width = 112
          Height = 21
          ReadOnly = True
          TabOrder = 3
          Text = '0,00'
          OnChange = MyChange
        end
        object Button6: TButton
          Left = 3
          Top = 134
          Width = 204
          Height = 23
          Caption = #1042' '#1073#1086#1088#1075
          TabOrder = 4
          OnClick = Button6Click
        end
        object Edit10: TEdit
          Left = 3
          Top = 53
          Width = 112
          Height = 21
          ReadOnly = True
          TabOrder = 5
          Text = '0,00'
          OnChange = MyChange
        end
      end
      object TabSheet1: TTabSheet
        Caption = #1040#1074#1090#1086
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        DesignSize = (
          210
          162)
        object Label11: TLabel
          Left = 178
          Top = 8
          Width = 11
          Height = 20
          Caption = '_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Button3: TButton
          Left = 1
          Top = 7
          Width = 81
          Height = 26
          Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1080
          TabOrder = 0
          OnClick = Button3Click
        end
        object Button5: TButton
          Left = 88
          Top = 7
          Width = 82
          Height = 26
          Caption = #1055#1088#1086#1074#1077#1089#1090#1080
          TabOrder = 1
          OnClick = Button5Click
        end
        object Memo1: TMemo
          Left = 1
          Top = 40
          Width = 206
          Height = 116
          Anchors = [akLeft, akTop, akBottom]
          ScrollBars = ssBoth
          TabOrder = 2
        end
      end
    end
    object ListBox4: TListBox
      Tag = 2
      Left = 134
      Top = 1
      Width = 39
      Height = 193
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
      OnClick = ListBox3Click
    end
    object ListBox5: TListBox
      Tag = 4
      Left = 349
      Top = 1
      Width = 39
      Height = 193
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 20
      ParentFont = False
      TabOrder = 5
      OnClick = ListBox3Click
    end
  end
  object SGrid2: TStringGrid
    Left = 0
    Top = 338
    Width = 763
    Height = 108
    Align = alBottom
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 4
    OnClick = ListBox3Click
    OnKeyUp = MyKeyUp
    ExplicitLeft = -1
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 88
    Top = 40
  end
end
