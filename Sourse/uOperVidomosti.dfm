object OVForm: TOVForm
  Left = 334
  Top = 119
  BorderStyle = bsToolWindow
  Caption = #1054#1087#1077#1088#1072#1094#1110#1111
  ClientHeight = 392
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 281
    Top = 0
    Width = 8
    Height = 373
    ExplicitHeight = 272
  end
  object SB1: TStatusBar
    Left = 0
    Top = 373
    Width = 744
    Height = 19
    Panels = <
      item
        Alignment = taRightJustify
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Width = 280
      end
      item
        Width = 90
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 281
    Height = 373
    Align = alLeft
    TabOrder = 1
    object TV1: TTreeView
      Left = 1
      Top = 1
      Width = 279
      Height = 267
      Align = alClient
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnClick = TV1Click
      Items.NodeData = {
        0103000000310000000000000003000000FFFFFFFFFFFFFFFF00000000040000
        000C12044104560420003E043F04350440043004460456045704270000000000
        000001000000FFFFFFFFFFFFFFFF0000000002000000071F0440043E04340430
        0436043004270000000000000008000000FFFFFFFFFFFFFFFF00000000000000
        000720043E0437043404400456043104210000000000000009000000FFFFFFFF
        FFFFFFFF00000000000000000413044304400442042500000000000000040000
        00FFFFFFFFFFFFFFFF0000000000000000061204380434043004470430042D00
        0000000000000A000000FFFFFFFFFFFFFFFF00000000000000000A1F043E0432
        04350440043D0435043D043D044F042F0000000000000002000000FFFFFFFFFF
        FFFFFF00000000000000000B1F043504400435043C045604490435043D043D04
        4F04410000000000000005000000FFFFFFFFFFFFFFFF00000000000000001412
        0447043E044004300448043D04560420003F043504400435043C045604490435
        043D043D044F0421000000000000000F000000FFFFFFFFFFFFFFFF0000000001
        000000041A0430044104300429000000000000000E000000FFFFFFFFFFFFFFFF
        0000000000000000081E043F04350440043004460456045704}
    end
    object Panel2: TPanel
      Left = 1
      Top = 268
      Width = 279
      Height = 104
      Align = alBottom
      AutoSize = True
      BevelOuter = bvLowered
      Ctl3D = False
      Padding.Left = 2
      Padding.Top = 2
      Padding.Right = 2
      ParentCtl3D = False
      TabOrder = 1
      object Bevel1: TBevel
        Left = 3
        Top = 63
        Width = 273
        Height = 10
        Align = alTop
        Shape = bsSpacer
        Style = bsRaised
      end
      object Button8: TButton
        Left = 3
        Top = 3
        Width = 273
        Height = 30
        Align = alTop
        Caption = #1054#1085#1086#1074#1080#1090#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Button8Click
      end
      object Button1: TButton
        Left = 3
        Top = 73
        Width = 273
        Height = 30
        Align = alTop
        Caption = #1044#1088#1091#1082' '#1077#1090#1080#1082#1077#1090#1086#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 3
        Top = 33
        Width = 273
        Height = 30
        Align = alTop
        Caption = #1044#1088#1091#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = Button6Click
      end
    end
  end
  object StringGrid1: TStringGrid
    Left = 289
    Top = 0
    Width = 455
    Height = 373
    Align = alClient
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 2
    OnDrawCell = StringGrid1DrawCell
    OnKeyUp = StringGrid1KeyUp
    OnMouseUp = StringGrid1MouseUp
  end
end
