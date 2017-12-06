object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 306
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 700
    Height = 267
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Button1: TButton
    Left = 617
    Top = 273
    Width = 75
    Height = 25
    Align = alCustom
    Anchors = [akRight, akBottom]
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 273
    Width = 510
    Height = 21
    Align = alCustom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    Text = 'Edit1_TesTT@'#241#241'[test]Encoded=?'#161#191#39
  end
  object Button2: TButton
    Left = 536
    Top = 273
    Width = 75
    Height = 25
    Align = alCustom
    Anchors = [akRight, akBottom]
    Caption = 'Button1'
    TabOrder = 3
    OnClick = Button2Click
  end
end
