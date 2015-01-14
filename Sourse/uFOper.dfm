object FOperForm: TFOperForm
  Left = 246
  Top = 212
  BorderStyle = bsDialog
  Caption = #1044#1086#1076#1072#1090#1082#1086#1074#1110' '#1074#1080#1090#1088#1072#1090#1080' / '#1085#1072#1076#1093#1086#1076#1078#1077#1085#1085#1103
  ClientHeight = 123
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 32
    Height = 13
    Caption = #1050#1083#1110#1108#1085#1090
    Enabled = False
  end
  object Label2: TLabel
    Left = 192
    Top = 0
    Width = 46
    Height = 13
    Caption = #1054#1087#1077#1088#1072#1094#1110#1103
  end
  object ComboBox1: TComboBox
    Left = 192
    Top = 16
    Width = 169
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 0
    OnChange = ComboBox1Change
    Items.Strings = (
      #1047#1072#1073#1086#1088#1075#1086#1074#1072#1085#1110#1089#1090#1100
      #1055#1086#1075#1072#1096#1077#1085#1085#1103' '#1073#1086#1088#1075#1091
      #1047#1072#1088#1086#1073#1110#1090#1085#1103' '#1087#1083#1072#1090#1072
      #1054#1088#1077#1085#1076#1085#1072' '#1087#1083#1072#1090#1072
      #1061#1072#1088#1095#1091#1074#1072#1085#1085#1103
      #1030#1085#1096#1110' '#1076#1086#1093#1086#1076#1080
      #1030#1085#1096#1110' '#1074#1080#1090#1088#1072#1090#1080)
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 56
    Width = 177
    Height = 21
    AutoCompleteDelay = 3000
    Enabled = False
    ItemHeight = 0
    Sorted = True
    TabOrder = 1
  end
  object LabeledEdit1: TLabeledEdit
    Left = 192
    Top = 56
    Width = 169
    Height = 21
    EditLabel.Width = 115
    EditLabel.Height = 13
    EditLabel.Caption = #1044#1086#1076#1072#1090#1082#1086#1074#1072' '#1110#1085#1092#1086#1088#1084#1072#1094#1110#1103
    MaxLength = 20
    TabOrder = 2
  end
  object LabeledEdit2: TLabeledEdit
    Left = 8
    Top = 16
    Width = 105
    Height = 21
    BiDiMode = bdRightToLeft
    EditLabel.Width = 26
    EditLabel.Height = 13
    EditLabel.BiDiMode = bdRightToLeft
    EditLabel.Caption = #1057#1091#1084#1072
    EditLabel.ParentBiDiMode = False
    ParentBiDiMode = False
    TabOrder = 3
    Text = '0,00'
    OnExit = LabeledEdit2Exit
    OnKeyPress = LabeledEdit2KeyPress
  end
  object Button1: TButton
    Left = 8
    Top = 88
    Width = 353
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1089#1090#1080
    TabOrder = 4
    OnClick = Button1Click
  end
  object RadioButton1: TRadioButton
    Left = 120
    Top = 8
    Width = 65
    Height = 17
    Caption = #1043#1088#1085'.'
    Checked = True
    TabOrder = 5
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 120
    Top = 32
    Width = 65
    Height = 17
    Caption = '$'
    TabOrder = 6
  end
end
