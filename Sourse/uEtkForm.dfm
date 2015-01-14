object ETForm: TETForm
  Left = 0
  Top = 0
  Caption = #1044#1088#1091#1082' '#1077#1090#1080#1082#1077#1090#1086#1082
  ClientHeight = 531
  ClientWidth = 803
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 369
    Width = 803
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = -370
    ExplicitTop = 213
    ExplicitWidth = 796
  end
  object Panel1: TPanel
    Left = 0
    Top = 372
    Width = 803
    Height = 159
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      803
      159)
    object Memo1: TMemo
      Left = 617
      Top = 1
      Width = 185
      Height = 121
      Align = alRight
      TabOrder = 0
    end
    object SG: TStringGrid
      Left = 1
      Top = 1
      Width = 616
      Height = 121
      Align = alClient
      ColCount = 2
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      TabOrder = 1
      OnKeyUp = SGKeyUp
    end
    object Button6: TButton
      Left = 421
      Top = 6
      Width = 191
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1095#1080#1089#1090#1080#1090#1080' '#1089#1087#1080#1089#1086#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button6Click
    end
    object Panel3: TPanel
      Left = 1
      Top = 122
      Width = 801
      Height = 36
      Align = alBottom
      TabOrder = 3
      DesignSize = (
        801
        36)
      object Edit3: TEdit
        Left = 7
        Top = 6
        Width = 351
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 
          'Select * From '#1057#1082#1083#1072#1076' Where misce = '#39#1052#1072#1075#1072#1079#1080#1085#39' and nazva = '#39#1050#1086#1089#1090#1102#1084#39 +
          ' Order by Tip,Rozmir,rist'
      end
      object Edit2: TEdit
        Left = 606
        Top = 6
        Width = 89
        Height = 21
        Anchors = [akTop, akRight]
        TabOrder = 1
        Text = 'Bar'
      end
      object Edit1: TEdit
        Left = 511
        Top = 6
        Width = 89
        Height = 21
        Anchors = [akTop, akRight]
        TabOrder = 2
        Text = 'Name'
      end
      object Button3: TButton
        Left = 701
        Top = 6
        Width = 89
        Height = 25
        Anchors = [akTop, akRight]
        Caption = #1044#1088#1091#1082#1091#1074#1072#1090#1080' '#1064#1050
        TabOrder = 3
        OnClick = Button3Click
      end
      object Button2: TButton
        Left = 364
        Top = 6
        Width = 97
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'SQL'
        TabOrder = 4
        OnClick = Button2Click
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 803
    Height = 369
    Align = alClient
    TabOrder = 1
    DesignSize = (
      803
      369)
    object ListBox1: TListBox
      Tag = 1
      Left = 8
      Top = 39
      Width = 169
      Height = 322
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
    object ListBox3: TListBox
      Tag = 3
      Left = 222
      Top = 39
      Width = 169
      Height = 322
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      Sorted = True
      TabOrder = 1
      OnClick = ListBoxClick
    end
    object ListBox4: TListBox
      Tag = 4
      Left = 398
      Top = 39
      Width = 57
      Height = 322
      Anchors = [akLeft, akTop, akBottom]
      BiDiMode = bdLeftToRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 20
      ParentBiDiMode = False
      ParentFont = False
      Sorted = True
      TabOrder = 2
      OnClick = ListBoxClick
    end
    object ListBox5: TListBox
      Tag = 5
      Left = 462
      Top = 39
      Width = 33
      Height = 322
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      Sorted = True
      TabOrder = 3
      OnClick = ListBoxClick
    end
    object SpinEdit1: TSpinEdit
      Left = 501
      Top = 39
      Width = 65
      Height = 26
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 3
      MaxValue = 100
      MinValue = 1
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      Value = 1
    end
    object Button1: TButton
      Left = 572
      Top = 39
      Width = 148
      Height = 41
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = Button1Click
    end
    object HC2: THeaderControl
      Left = 1
      Top = 1
      Width = 801
      Height = 32
      Sections = <
        item
          AllowClick = False
          ImageIndex = -1
          Width = 185
        end
        item
          ImageIndex = -1
          Width = 35
        end
        item
          AllowClick = False
          ImageIndex = -1
          Width = 175
        end
        item
          AllowClick = False
          ImageIndex = -1
          Width = 65
        end
        item
          AllowClick = False
          ImageIndex = -1
          Width = 35
        end
        item
          AllowClick = False
          AutoSize = True
          ImageIndex = -1
          Width = 306
        end>
      Style = hsFlat
    end
    object ComboBox1: TComboBox
      Left = 501
      Top = 203
      Width = 218
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 7
      OnChange = ComboBox1Change
    end
    object ComboBox2: TComboBox
      Left = 501
      Top = 233
      Width = 218
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ParentFont = False
      Sorted = True
      TabOrder = 8
      OnChange = ComboBox2Change
    end
    object Button4: TButton
      Left = 580
      Top = 172
      Width = 139
      Height = 25
      Caption = 'Reset 30*58'
      TabOrder = 9
      OnClick = Button4Click
    end
    object Button7: TButton
      Left = 501
      Top = 135
      Width = 148
      Height = 32
      Caption = #1044#1088#1091#1082' '#1077#1090#1080#1082#1077#1090#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = Button7Click
    end
    object SpinEdit2: TSpinEdit
      Left = 501
      Top = 173
      Width = 73
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 11
      Value = 0
    end
    object CkB1: TCheckBox
      Left = 501
      Top = 263
      Width = 50
      Height = 17
      Caption = #1062#1110#1085#1072
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object ListBox2: TListBox
      Tag = 2
      Left = 183
      Top = 39
      Width = 33
      Height = 322
      Anchors = [akLeft, akTop, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 20
      ParentFont = False
      Sorted = True
      TabOrder = 13
      OnClick = ListBoxClick
    end
    object Button5: TButton
      Left = 655
      Top = 135
      Width = 64
      Height = 32
      Caption = '1/2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = Button7Click
    end
  end
end
