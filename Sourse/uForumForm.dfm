object ForumForm: TForumForm
  Left = 0
  Top = 0
  Align = alRight
  BorderStyle = bsToolWindow
  Caption = '  '#1060#1086#1088#1091#1084
  ClientHeight = 351
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 2
  Padding.Right = 2
  Padding.Bottom = 2
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 2
    Top = 0
    Width = 259
    Height = 105
    Align = alTop
    Caption = #1055#1086#1074#1110#1076#1086#1084#1083#1077#1085#1085#1103
    Padding.Left = 2
    Padding.Right = 2
    TabOrder = 0
    object Button1: TButton
      Left = 179
      Top = 74
      Width = 75
      Height = 25
      Caption = #1053#1072#1076#1110#1089#1083#1072#1090#1080
      TabOrder = 0
    end
    object Memo1: TMemo
      Left = 4
      Top = 15
      Width = 251
      Height = 53
      Align = alTop
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 2
    Top = 105
    Width = 259
    Height = 244
    Align = alClient
    Caption = #1054#1089#1086#1073#1080#1089#1090#1110' '#1087#1086#1074#1110#1076#1086#1084#1083#1077#1085#1085#1103
    Padding.Left = 1
    Padding.Top = 1
    Padding.Right = 1
    Padding.Bottom = 1
    TabOrder = 1
    object GroupBox4: TGroupBox
      Left = 3
      Top = 16
      Width = 253
      Height = 58
      Align = alTop
      BiDiMode = bdRightToLeft
      Caption = #1055#1086#1074#1110#1076#1086#1084#1083#1077#1085#1085#1103' [!][x]'
      Color = clBtnFace
      ParentBackground = False
      ParentBiDiMode = False
      ParentColor = False
      TabOrder = 0
      OnMouseDown = GroupBox4MouseDown
      OnMouseMove = GroupBox4MouseMove
      object Memo2: TMemo
        Left = 2
        Top = 15
        Width = 249
        Height = 41
        Align = alClient
        BevelInner = bvNone
        BiDiMode = bdLeftToRight
        BorderStyle = bsNone
        Color = clBtnFace
        ParentBiDiMode = False
        TabOrder = 0
      end
    end
  end
end
