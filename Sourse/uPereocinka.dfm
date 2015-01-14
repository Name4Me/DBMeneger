object PereocinkaForm: TPereocinkaForm
  Left = 354
  Top = 79
  BorderStyle = bsToolWindow
  Caption = #1055#1077#1088#1077#1086#1094#1110#1085#1082#1072
  ClientHeight = 623
  ClientWidth = 591
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  PrintScale = poNone
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 604
    Width = 591
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 591
    Height = 604
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    ExplicitTop = -6
    object TabSheet1: TTabSheet
      Caption = #1055#1077#1088#1077#1086#1094#1110#1085#1082#1072
      object Panel1: TPanel
        Left = 0
        Top = 57
        Width = 583
        Height = 519
        Align = alClient
        BorderStyle = bsSingle
        TabOrder = 0
      end
      object Button1: TButton
        Left = 9
        Top = 63
        Width = 169
        Height = 25
        Caption = #1055#1088#1086#1074#1077#1089#1090#1080
        Enabled = False
        TabOrder = 1
        OnClick = Button1Click
      end
      object HeaderControl1: THeaderControl
        Left = 0
        Top = 0
        Width = 583
        Height = 25
        Anchors = [akLeft, akRight]
        DragReorder = True
        Sections = <
          item
            AllowClick = False
            ImageIndex = -1
            Text = #1053#1072#1079#1074#1072
            Width = 185
          end
          item
            AllowClick = False
            ImageIndex = -1
            Text = #1058#1080#1087
            Width = 185
          end>
        Style = hsFlat
      end
      object HeaderControl2: THeaderControl
        Left = 0
        Top = 25
        Width = 583
        Height = 32
        Anchors = [akLeft, akRight]
        DragReorder = True
        Sections = <
          item
            AllowClick = False
            ImageIndex = -1
            Width = 185
          end
          item
            AllowClick = False
            ImageIndex = -1
            Width = 185
          end>
        Style = hsFlat
      end
      object ComboBox1: TComboBox
        Left = 3
        Top = 29
        Width = 175
        Height = 21
        DropDownCount = 20
        ItemHeight = 13
        Sorted = True
        TabOrder = 4
        OnChange = ComboBox1Change
      end
      object ComboBox2: TComboBox
        Left = 192
        Top = 30
        Width = 169
        Height = 21
        DropDownCount = 20
        Enabled = False
        ItemHeight = 13
        Sorted = True
        TabOrder = 5
        OnChange = ComboBox2Change
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1052#1072#1088#1078#1072
      ImageIndex = 1
      object StringGrid1: TStringGrid
        Left = 177
        Top = 49
        Width = 406
        Height = 527
        Align = alClient
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
        ExplicitLeft = 183
        ExplicitTop = 47
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 583
        Height = 49
        Align = alTop
        BiDiMode = bdRightToLeftNoAlign
        ParentBiDiMode = False
        TabOrder = 1
        DesignSize = (
          583
          49)
        object RadioGroup1: TRadioGroup
          Left = 424
          Top = 12
          Width = 153
          Height = 31
          Anchors = [akTop, akRight]
          BiDiMode = bdLeftToRight
          Caption = #1057#1086#1088#1090#1091#1074#1072#1090#1080':'
          Columns = 2
          Items.Strings = (
            #1055#1086' '#1090#1080#1087#1091
            #1055#1086' '#1084#1072#1088#1078#1110)
          ParentBiDiMode = False
          TabOrder = 0
          OnClick = RadioGroup1Click
        end
        object LabeledEdit1: TLabeledEdit
          Left = 306
          Top = 22
          Width = 112
          Height = 21
          Anchors = [akTop, akRight]
          EditLabel.Width = 94
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdRightToLeftNoAlign
          EditLabel.Caption = #1052#1110#1085#1110#1084#1072#1083#1100#1085#1072' '#1084#1072#1088#1078#1072
          EditLabel.ParentBiDiMode = False
          TabOrder = 1
          OnKeyUp = LabeledEdit1KeyUp
        end
      end
      object ListBox1: TListBox
        Left = 0
        Top = 49
        Width = 177
        Height = 527
        Align = alLeft
        ItemHeight = 13
        TabOrder = 2
        OnClick = ListBox1Click
        ExplicitTop = 35
        ExplicitHeight = 541
      end
    end
  end
end
