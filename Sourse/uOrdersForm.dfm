object OrdersForm: TOrdersForm
  Left = 0
  Top = 0
  Align = alClient
  Caption = #1047#1072#1084#1086#1074#1083#1077#1085#1085#1103
  ClientHeight = 341
  ClientWidth = 787
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
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object SBar: TStatusBar
    Left = 2
    Top = 320
    Width = 783
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 2
    Top = 0
    Width = 185
    Height = 320
    Align = alLeft
    Caption = #1050#1083#1110#1108#1085#1090#1080
    TabOrder = 1
    object ButtonGroup: TButtonGroup
      Left = 2
      Top = 15
      Width = 181
      Height = 303
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      BevelKind = bkFlat
      BorderStyle = bsNone
      ButtonOptions = [gboFullSize, gboGroupStyle, gboShowCaptions]
      Items = <>
      TabOrder = 0
      OnButtonClicked = ButtonGroupButtonClicked
    end
  end
  object GroupBox2: TGroupBox
    Left = 187
    Top = 0
    Width = 598
    Height = 320
    Align = alClient
    Caption = #1047#1072#1084#1086#1074#1083#1077#1085#1085#1103
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 4
      Top = 229
      Width = 590
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitLeft = 3
      ExplicitTop = 206
      ExplicitWidth = 582
    end
    object TabSet: TTabSet
      Left = 4
      Top = 17
      Width = 590
      Height = 21
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TabPosition = tpTop
      OnClick = TabSetClick
    end
    object Panel1: TPanel
      Left = 474
      Top = 38
      Width = 120
      Height = 191
      Align = alRight
      TabOrder = 1
      object ComboBox1: TComboBox
        Left = 1
        Top = 1
        Width = 118
        Height = 21
        Align = alTop
        ItemHeight = 0
        TabOrder = 0
        OnChange = ComboBox1Change
      end
      object Button1: TButton
        Left = 1
        Top = 22
        Width = 118
        Height = 25
        Align = alTop
        Caption = #1047#1084#1110#1085#1080#1090#1080
        TabOrder = 1
        OnClick = Button1Click
      end
      object ListBox2: TListBox
        Left = 1
        Top = 47
        Width = 118
        Height = 143
        Align = alClient
        ItemHeight = 13
        TabOrder = 2
      end
    end
    object StringGrid1: TStringGrid
      Left = 4
      Top = 232
      Width = 590
      Height = 84
      Align = alBottom
      ColCount = 1
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      TabOrder = 2
    end
    object Panel2: TPanel
      Left = 4
      Top = 38
      Width = 350
      Height = 191
      Align = alClient
      Caption = 'Panel2'
      TabOrder = 3
      object SGrid: TStringGrid
        Left = 1
        Top = 1
        Width = 348
        Height = 164
        Align = alClient
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnKeyUp = SGridKeyUp
        OnMouseUp = SGridMouseUp
        RowHeights = (
          24)
      end
      object Button3: TButton
        Left = 1
        Top = 165
        Width = 348
        Height = 25
        Align = alBottom
        Caption = #1044#1088#1091#1082' '#1079#1072#1084#1086#1074#1083#1077#1085#1103
        TabOrder = 1
        OnClick = Button3Click
      end
    end
    object Panel3: TPanel
      Left = 354
      Top = 38
      Width = 120
      Height = 191
      Align = alRight
      Caption = 'Panel3'
      TabOrder = 4
      object ListBox1: TListBox
        Left = 1
        Top = 1
        Width = 118
        Height = 164
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox1Click
      end
      object Button2: TButton
        Left = 1
        Top = 165
        Width = 118
        Height = 25
        Align = alBottom
        Caption = #1044#1088#1091#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 136
    Top = 24
  end
end
