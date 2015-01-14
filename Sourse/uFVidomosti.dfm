object FVidomostiForm: TFVidomostiForm
  Left = 251
  Top = 162
  Caption = #1054#1073#1083#1110#1082' '#1073#1086#1088#1075#1091
  ClientHeight = 409
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnActivate = FormShow
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 862
    Height = 409
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1041#1086#1088#1075
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object MTV1: TTreeView
        Left = 0
        Top = 0
        Width = 336
        Height = 317
        Align = alClient
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnClick = MTV1Click
        OnCustomDrawItem = MTV1CustomDrawItem
      end
      object Panel2: TPanel
        Left = 0
        Top = 317
        Width = 854
        Height = 64
        Align = alBottom
        TabOrder = 1
        object Label1: TLabel
          Left = 366
          Top = 8
          Width = 82
          Height = 13
          Alignment = taRightJustify
          Caption = #1047#1072#1073#1086#1088#1075#1086#1074#1072#1085#1110#1089#1090#1100':'
        end
        object Label2: TLabel
          Left = 390
          Top = 24
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = #1055#1077#1088#1077#1087#1083#1072#1090#1072':'
        end
        object Label3: TLabel
          Left = 408
          Top = 40
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = #1041#1072#1083#1072#1085#1089':'
        end
      end
      object SGrid: TStringGrid
        Left = 336
        Top = 0
        Width = 518
        Height = 317
        Align = alRight
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1054#1087#1077#1088#1072#1094#1110#1111
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        854
        381)
      object CheckBox1: TCheckBox
        Left = 208
        Top = 8
        Width = 25
        Height = 17
        Hint = #1055#1086#1082#1072#1079#1072#1090#1080' '#1074#1089#1110' '#1086#1087#1077#1088#1072#1094#1110#1111
        Caption = '*'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object DateTimePicker1: TDateTimePicker
        Left = 11
        Top = 8
        Width = 186
        Height = 21
        Date = 38798.921522708290000000
        Time = 38798.921522708290000000
        TabOrder = 1
        OnChange = DateTimePicker1Change
      end
      object StringGrid1: TStringGrid
        Left = 3
        Top = 35
        Width = 848
        Height = 343
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 1
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
        TabOrder = 2
      end
    end
  end
end
