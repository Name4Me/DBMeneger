object SetingsForm: TSetingsForm
  Left = 0
  Top = 0
  Caption = #1054#1087#1094#1110#1111
  ClientHeight = 341
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 128
    Height = 13
    Caption = #1055#1086#1088#1090' '#1089#1082#1072#1085#1077#1088#1072' '#1096#1090#1088#1110#1093' '#1082#1086#1076#1072
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 0
    OnChange = ComboBox1Change
  end
  object Button1: TButton
    Left = 159
    Top = 22
    Width = 75
    Height = 25
    Caption = #1047#1073#1077#1088#1077#1075#1090#1080
    TabOrder = 1
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 458
    Top = 0
    Width = 185
    Height = 341
    Align = alRight
    Caption = 'Panel1'
    TabOrder = 2
    object CheckListBox1: TCheckListBox
      Left = 1
      Top = 22
      Width = 183
      Height = 131
      Align = alTop
      ItemHeight = 13
      Items.Strings = (
        
          #1047#1072#1075#1072#1083#1100#1085#1080#1081' '#1085#1072#1073#1110#1088': '#1056#1086#1079#1076#1088#1110#1073', '#1055#1086#1074#1077#1088#1085#1077#1085#1085#1103', '#1042#1110#1076#1086#1084#1086#1089#1090#1110', '#1045' '#1074' '#1085#1072#1103#1074#1085#1086#1089#1090#1110', ' +
          #1044#1088#1091#1082
        #1054#1055#1058
        #1042#1080#1076#1072#1095#1072
        #1055#1077#1088#1077#1084#1110#1097#1077#1085#1085#1103' Old'
        #1040#1074#1090#1086' '#1079#1072#1084#1086#1074#1083#1077#1085#1085#1103
        #1044#1088#1091#1082
        #1044#1088#1091#1082' '#1077#1090#1080#1082#1077#1090#1086#1082
        'Servise'
        'Servise+')
      TabOrder = 0
    end
    object CheckListBox2: TCheckListBox
      Left = 1
      Top = 153
      Width = 183
      Height = 162
      Align = alClient
      ItemHeight = 13
      TabOrder = 1
    end
    object ComboBox2: TComboBox
      Left = 1
      Top = 1
      Width = 183
      Height = 21
      Align = alTop
      ItemHeight = 13
      TabOrder = 2
      OnChange = ComboBox2Change
    end
    object Button2: TButton
      Left = 1
      Top = 315
      Width = 183
      Height = 25
      Align = alBottom
      Caption = #1042#1089#1090#1072#1085#1086#1074#1080#1090#1080
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object Button3: TButton
    Left = 159
    Top = 53
    Width = 75
    Height = 25
    Caption = #1047#1073#1077#1088#1077#1075#1090#1080
    TabOrder = 3
    OnClick = Button3Click
  end
  object DTP: TDateTimePicker
    Left = 8
    Top = 52
    Width = 145
    Height = 21
    Date = 40059.586573530090000000
    Time = 40059.586573530090000000
    TabOrder = 4
  end
  object SaveDialog1: TSaveDialog
    Left = 8
    Top = 80
  end
end
