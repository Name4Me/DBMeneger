object NewZnaceniaForm: TNewZnaceniaForm
  Left = 197
  Top = 120
  Caption = #1053#1086#1074#1110' '#1079#1085#1072#1095#1077#1085#1085#1103
  ClientHeight = 559
  ClientWidth = 834
  Color = clBtnFace
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
    0000000000000222000000000000000000000000000022222200000000000000
    000000000002A288222200000000000000000000002AA2877722220000000000
    0000000002666628777722220000000000000000266622FF8877772222000000
    000000026622F2FFFF887777222200000000002622FF2FF87FFF887777220000
    00000222FFF2FFFFF87FFF8877800000000066FFFF2FF87FFFF78FFF88850000
    0006FFFFF2FFFFF78FFFF78FFF850000006FFFFF2FF87FFFF87FFFFFF8550000
    06FFFFF2FFFFF78FFFF87FFF855500006FFFFF2FF78FFFF87FFFFFF855550006
    FFFF66FFFFF87FFFF87FFF855555006FFF660088FFFFF78FFFFFF855555506FF
    6600009888FFFFF87FFF855555556F66000000989988FFFFFFF8555555556600
    00000098999988FFFF8D5555555500000000009899994788F85D555555550000
    0000009833394744845D5555555500000000009899994744445D555555550000
    0000009833394744445D5555555500000000009899994744445D555555550000
    000000989999444F745D5555555500000000009811191474F75D555555550000
    000000911F7111474F5D5555555500000000000991F7911474555F7555550000
    00000000991F79114405D5F7D5550000000000000991119100005D5F7D550000
    0000000000910011000005D555D500000000000000000000000000550055FFFF
    8FFFFFFF03FFFFFE00FFFFFC003FFFF8000FFFF00003FFE00000FFC00000FF80
    0001FF000000FE000000FC000000F8000000F0000000E0000000C0C0000083C0
    00000FC000003FC00000FFC00000FFC00000FFC00000FFC00000FFC00000FFC0
    0000FFC00000FFC00000FFE00000FFF00200FFF80F00FFFCCF80FFFFFFCC}
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 834
    Height = 559
    ActivePage = P1
    Align = alClient
    TabOrder = 0
    ExplicitHeight = 363
    object P1: TTabSheet
      Caption = #1058#1080#1087
      ExplicitHeight = 335
      object P1HC1: THeaderControl
        Left = 0
        Top = 0
        Width = 826
        Height = 25
        Anchors = [akLeft, akRight]
        DragReorder = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Sections = <
          item
            ImageIndex = -1
            Text = #1053#1072#1079#1074#1072
            Width = 400
          end
          item
            Alignment = taRightJustify
            AutoSize = True
            ImageIndex = -1
            Text = #1058#1080#1087
            Width = 426
          end>
        Style = hsFlat
        ParentFont = False
      end
      object Panel3: TPanel
        Left = 571
        Top = 50
        Width = 255
        Height = 481
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitHeight = 285
        object tButton2: TButton
          Left = 4
          Top = 45
          Width = 221
          Height = 30
          Caption = #1042#1080#1076#1072#1083#1080#1090#1080' '#1090#1080#1087
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = ButtonClick
        end
        object tButton1: TButton
          Left = 4
          Top = 9
          Width = 221
          Height = 30
          Caption = #1044#1086#1076#1072#1090#1080' '#1090#1080#1087
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = ButtonClick
        end
        object tButton3: TButton
          Left = 4
          Top = 81
          Width = 221
          Height = 30
          Caption = #1042#1080#1076#1072#1083#1080#1090#1080' '#1090#1080#1087#1080' '#1097#1086' '#1085#1077' '#1074#1080#1082#1086#1088#1080#1089#1090#1086#1074#1091#1102#1090#1100#1089#1103
          TabOrder = 2
          OnClick = ButtonClick
        end
        object tButton4: TButton
          Left = 62
          Top = 117
          Width = 163
          Height = 30
          Caption = #1047#1084#1110#1085#1080#1090#1080' ID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = ButtonClick
        end
        object Edit1: TEdit
          Left = 6
          Top = 119
          Width = 50
          Height = 28
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          Text = '000'
          OnEnter = Edit1Enter
        end
        object tButton5: TButton
          Left = 4
          Top = 153
          Width = 221
          Height = 30
          Caption = #1047#1084#1110#1085#1080#1090#1080' '#1090#1080#1087
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = ButtonClick
        end
        object tButton6: TButton
          Left = 6
          Top = 245
          Width = 219
          Height = 25
          Caption = #1055#1088#1080#1074#1077#1089#1090#1080' ID '#1076#1086' '#1092#1086#1088#1084#1072#1090#1091' ['#1093#1093#1093']'
          TabOrder = 6
          OnClick = ButtonClick
        end
      end
      object ListBox1: TListBox
        Left = 0
        Top = 50
        Width = 180
        Height = 481
        AutoCompleteDelay = 3000
        Align = alLeft
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
        ExplicitHeight = 285
      end
      object ListBox2: TListBox
        Left = 180
        Top = 50
        Width = 40
        Height = 481
        AutoCompleteDelay = 3000
        Align = alLeft
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
        ExplicitHeight = 285
      end
      object ListBox3: TListBox
        Left = 220
        Top = 50
        Width = 180
        Height = 481
        AutoCompleteDelay = 3000
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
        ExplicitHeight = 285
      end
      object P1HC2: THeaderControl
        Left = 0
        Top = 25
        Width = 826
        Height = 25
        Anchors = [akLeft, akRight]
        DragReorder = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Sections = <
          item
            ImageIndex = -1
            Width = 400
          end
          item
            Alignment = taRightJustify
            AutoSize = True
            ImageIndex = -1
            Width = 426
          end>
        Style = hsFlat
        ParentFont = False
      end
      object Panel1: TPanel
        Left = 400
        Top = 50
        Width = 171
        Height = 481
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 6
        ExplicitHeight = 285
      end
    end
    object P2: TTabSheet
      Caption = #1052#1110#1089#1094#1077
      ImageIndex = 1
      object mButton1: TButton
        Left = 464
        Top = 4
        Width = 161
        Height = 37
        Caption = #1044#1086#1076#1072#1090#1080' '#1084#1110#1089#1094#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = ButtonClick
      end
      object mButton2: TButton
        Left = 464
        Top = 47
        Width = 161
        Height = 37
        Caption = #1042#1080#1076#1072#1083#1080#1090#1080' '#1084#1110#1089#1094#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = ButtonClick
      end
      object ListBox4: TListBox
        Left = 0
        Top = 0
        Width = 190
        Height = 531
        Align = alLeft
        ItemHeight = 13
        TabOrder = 2
        OnClick = ListBoxClick
      end
      object mButton3: TButton
        Left = 464
        Top = 90
        Width = 161
        Height = 37
        Caption = #1047#1084#1110#1085#1080#1090#1080' '#1084#1110#1089#1094#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = ButtonClick
      end
    end
  end
end
