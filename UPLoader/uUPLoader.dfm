object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Form9'
  ClientHeight = 77
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 56
    Width = 332
    Height = 21
    Panels = <
      item
        Alignment = taCenter
        Bevel = pbRaised
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = '[Off Line]'
        Width = 65
      end
      item
        Alignment = taCenter
        Text = '[-]'
        Width = 25
      end
      item
        Width = 50
      end>
    ExplicitTop = 320
    ExplicitWidth = 643
  end
  object UploadButton: TButton
    Left = 170
    Top = 8
    Width = 75
    Height = 25
    Caption = 'UpLoad'
    TabOrder = 2
    OnClick = UploadButtonClick
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 39
    Width = 314
    Height = 10
    Smooth = True
    TabOrder = 3
  end
  object Button2: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Show FileList'
    TabOrder = 4
    OnClick = Button2Click
  end
  object DownLoad: TButton
    Left = 251
    Top = 8
    Width = 75
    Height = 25
    Caption = 'DownLoad'
    TabOrder = 5
  end
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    OnWork = IdFTP1Work
    OnWorkEnd = IdFTP1WorkEnd
    AutoLogin = True
    Host = 'ftp.sline.com.ua'
    Passive = True
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    ReadTimeout = 0
    Left = 248
    Top = 48
  end
end
