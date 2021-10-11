object Form1: TForm1
  Left = 301
  Top = 129
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'fw Popup Panel'
  ClientHeight = 537
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 17
  object FWPopupPanel1: TFWPopupPanel
    Left = 166
    Top = 10
    Width = 472
    Height = 483
    object Label1: TLabel
      Left = 21
      Top = 21
      Width = 430
      Height = 54
      AutoSize = False
      Caption = 
        #1044#1072#1085#1085#1099#1081' '#1082#1086#1084#1087#1086#1085#1077#1085#1090' '#1087#1086#1079#1074#1086#1083#1103#1077#1090' '#1086#1095#1077#1085#1100' '#1087#1088#1086#1089#1090#1086' '#1074' '#1076#1077#1079#1072#1081#1085#1090#1072#1081#1084#1077' '#1089#1086#1079#1076#1072#1090#1100' '#1089#1086 +
        #1073#1089#1090#1074#1077#1085#1085#1086' '#1089#1086#1089#1090#1072#1074#1085#1086#1077' '#1084#1077#1085#1102' '#1080' '#1087#1086#1090#1086#1084' '#1086#1090#1086#1073#1088#1072#1079#1080#1090#1100' '#1077#1075#1086' '#1074' '#1088#1072#1085#1090#1072#1081#1084#1077'.'
      WordWrap = True
    end
    object Edit1: TEdit
      Left = 21
      Top = 84
      Width = 430
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object Button2: TButton
      Left = 356
      Top = 119
      Width = 98
      Height = 33
      Caption = 'Button2'
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 21
      Top = 126
      Width = 127
      Height = 22
      Caption = 'CheckBox1'
      TabOrder = 2
    end
    object RadioButton1: TRadioButton
      Left = 178
      Top = 126
      Width = 148
      Height = 22
      Caption = 'RadioButton1'
      TabOrder = 3
    end
    object PageControl1: TPageControl
      Left = 21
      Top = 178
      Width = 190
      Height = 158
      ActivePage = TabSheet1
      TabOrder = 4
      object TabSheet1: TTabSheet
        Caption = 'TabSheet1'
      end
      object TabSheet2: TTabSheet
        Caption = 'TabSheet2'
        ImageIndex = 1
      end
    end
    object TrackBar1: TTrackBar
      Left = 260
      Top = 178
      Width = 191
      Height = 43
      TabOrder = 5
    end
    object ProgressBar1: TProgressBar
      Left = 272
      Top = 229
      Width = 169
      Height = 22
      Position = 45
      TabOrder = 6
    end
    object MonthCalendar1: TMonthCalendar
      Left = 218
      Top = 259
      Width = 250
      Height = 209
      Date = 40283.674260520830000000
      TabOrder = 7
    end
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 153
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1084#1077#1085#1102
    TabOrder = 1
    OnClick = Button1Click
  end
end
