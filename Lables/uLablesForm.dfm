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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 803
    Height = 531
    Align = alClient
    TabOrder = 0
    object SpinEdit1: TSpinEdit
      Left = 199
      Top = 13
      Width = 50
      Height = 22
      MaxValue = 99999
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = SpinEdit1Change
    end
    object Button1: TButton
      Left = 199
      Top = 42
      Width = 75
      Height = 25
      Caption = 'Print'
      TabOrder = 1
      OnClick = Button1Click
    end
    object SpinEdit2: TSpinEdit
      Left = 255
      Top = 13
      Width = 50
      Height = 22
      MaxValue = 99999
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
    object SpinEdit3: TSpinEdit
      Left = 311
      Top = 13
      Width = 50
      Height = 22
      MaxValue = 99999
      MinValue = 1
      TabOrder = 3
      Value = 1
    end
    object SpinEdit4: TSpinEdit
      Left = 546
      Top = 13
      Width = 50
      Height = 22
      MaxValue = 99999
      MinValue = 1
      TabOrder = 4
      Value = 1
    end
    object SpinEdit5: TSpinEdit
      Left = 199
      Top = 73
      Width = 75
      Height = 22
      MaxValue = 99999
      MinValue = 1
      TabOrder = 5
      Value = 1
    end
    object FontName: TComboBox
      Left = 367
      Top = 13
      Width = 173
      Height = 21
      Hint = 'Font Name|Select font name'
      Ctl3D = False
      DropDownCount = 10
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 6
    end
    object Editor: TRichEdit
      Left = 8
      Top = 13
      Width = 185
      Height = 89
      Lines.Strings = (
        'Test 1'
        'Test 2'
        'Test 3'
        'Test 4')
      TabOrder = 7
      OnSelectionChange = EditorSelectionChange
    end
    object Button2: TButton
      Left = 602
      Top = 11
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 8
      OnClick = Button2Click
    end
  end
end
