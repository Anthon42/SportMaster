object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Sms'
  ClientHeight = 347
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnTool: TPanel
    Left = 0
    Top = 315
    Width = 298
    Height = 32
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 314
    ExplicitWidth = 339
    object lbCountryCode: TLabel
      Left = 3
      Top = 7
      Width = 14
      Height = 13
      Caption = '+7'
    end
    object btSend: TButton
      Left = 152
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Send'
      TabOrder = 0
      OnClick = btSendClick
    end
    object edCityCode: TEdit
      Left = 23
      Top = 4
      Width = 29
      Height = 21
      MaxLength = 3
      TabOrder = 1
    end
    object edMidleNuber: TEdit
      Left = 58
      Top = 4
      Width = 29
      Height = 21
      MaxLength = 3
      TabOrder = 2
    end
    object edDoubleNumber: TEdit
      Left = 93
      Top = 4
      Width = 20
      Height = 21
      MaxLength = 3
      TabOrder = 3
    end
    object edEndNumber: TEdit
      Left = 119
      Top = 4
      Width = 20
      Height = 21
      MaxLength = 3
      TabOrder = 4
    end
    object cbLoop: TCheckBox
      Left = 238
      Top = 8
      Width = 57
      Height = 17
      Caption = 'Loop'
      TabOrder = 5
    end
  end
  object meText: TMemo
    Left = 0
    Top = 0
    Width = 298
    Height = 315
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitWidth = 653
    ExplicitHeight = 275
  end
end
