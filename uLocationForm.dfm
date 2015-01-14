object LocationForm: TLocationForm
  Left = 0
  Top = 0
  Caption = #1052#1110#1089#1094#1077' '#1079#1085#1072#1093#1086#1076#1078#1077#1085#1085#1103
  ClientHeight = 415
  ClientWidth = 847
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 847
    Height = 415
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    OnDrawTab = PageControl1DrawTab
    object TabSheet1: TTabSheet
      AlignWithMargins = True
      Caption = 'TabSheet1'
      DesignSize = (
        833
        381)
      object Edit1: TEdit
        Left = 3
        Top = 40
        Width = 265
        Height = 27
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ComboBox1: TComboBox
        Left = 3
        Top = 80
        Width = 177
        Height = 298
        Style = csSimple
        Anchors = [akLeft, akTop, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 19
        ParentFont = False
        TabOrder = 1
        OnClick = ComboBox1Click
      end
      object ComboBox2: TComboBox
        Left = 186
        Top = 80
        Width = 219
        Height = 298
        Style = csSimple
        Anchors = [akLeft, akTop, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 19
        ParentFont = False
        TabOrder = 2
        OnClick = ComboBox2Click
      end
      object Button1: TButton
        Left = 274
        Top = 40
        Width = 31
        Height = 25
        Caption = '+'
        TabOrder = 3
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 376
        Top = 40
        Width = 29
        Height = 25
        Caption = '-'
        TabOrder = 4
        OnClick = Button2Click
      end
      object ComboBox3: TComboBox
        Left = 411
        Top = 176
        Width = 135
        Height = 202
        Style = csSimple
        Anchors = [akLeft, akTop, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 19
        ParentFont = False
        TabOrder = 5
        OnClick = ComboBox3Click
      end
      object ListBox1: TListBox
        Left = 411
        Top = 40
        Width = 135
        Height = 130
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemHeight = 19
        ParentFont = False
        TabOrder = 6
        OnClick = ListBox1Click
      end
      object HC: THeaderControl
        Left = 0
        Top = 0
        Width = 833
        Height = 32
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        FullDrag = False
        Sections = <
          item
            AllowClick = False
            ImageIndex = -1
            Width = 187
          end
          item
            AllowClick = False
            ImageIndex = -1
            Width = 185
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
            Width = 361
          end>
        Style = hsFlat
        OnDrawSection = HCDrawSection
      end
      object Button3: TButton
        Left = 311
        Top = 40
        Width = 59
        Height = 25
        Caption = '<>'
        TabOrder = 8
        OnClick = Button3Click
      end
      object TV: TTreeView
        Left = 552
        Top = 40
        Width = 135
        Height = 338
        Anchors = [akLeft, akTop, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Indent = 21
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
        OnClick = TVClick
      end
      object TV1: TTreeView
        Left = 693
        Top = 40
        Width = 137
        Height = 338
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        Indent = 21
        ParentFont = False
        ReadOnly = True
        TabOrder = 10
        OnClick = TV1Click
        OnCustomDraw = TV1CustomDraw
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
    end
  end
end
