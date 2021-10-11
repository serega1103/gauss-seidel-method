object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1095#1105#1090' '#1084#1086#1083#1103#1088#1085#1086#1081' '#1082#1086#1085#1094#1077#1085#1090#1088#1072#1094#1080#1080' '#1074#1077#1097#1077#1089#1090#1074#1072' '#1074' '#1088#1072#1089#1090#1074#1086#1088#1077
  ClientHeight = 624
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 149
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1088#1072#1079#1083#1080#1095#1085#1099#1093' '#1074#1086#1083#1085':'
  end
  object Label2: TLabel
    Left = 16
    Top = 44
    Width = 115
    Height = 13
    Caption = #1058#1086#1095#1085#1086#1089#1090#1100' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1081':'
  end
  object Label3: TLabel
    Left = 16
    Top = 271
    Width = 296
    Height = 26
    Caption = 
      #1042#1074#1077#1076#1080#1090#1077' '#1086#1090#1085#1086#1096#1077#1085#1080#1103' '#1086#1073#1097#1077#1075#1086' '#1089#1074#1077#1090#1086#1087#1086#1075#1083#1072#1097#1077#1085#1080#1103' '#1088#1072#1089#1090#1074#1086#1088#1086#1074' '#1082' '#1076#1083#1080#1085#1077' '#1074#1086#1083#1085#1099 +
      ' '#1087#1088#1080' '#1088#1072#1079#1083#1080#1095#1085#1099#1093' '#1076#1083#1080#1085#1072#1093' '#1074#1086#1083#1085':'
    WordWrap = True
  end
  object Label4: TLabel
    Left = 16
    Top = 83
    Width = 230
    Height = 26
    Caption = 
      #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1084#1086#1083#1103#1088#1085#1086#1075#1086' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1072' '#1089#1074#1077#1090#1086#1087#1086#1075#1083#1072#1097#1077#1085#1080#1103' '#1085#1072' '#1074#1089#1077#1093' ' +
      #1074#1086#1083#1085#1072#1093':'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 16
    Top = 480
    Width = 48
    Height = 13
    Caption = #1056#1077#1096#1077#1085#1080#1077':'
    WordWrap = True
  end
  object edEpsilon: TEdit
    Left = 191
    Top = 41
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Bd: TStringGrid
    Left = 16
    Top = 303
    Width = 297
    Height = 120
    ColCount = 2
    DefaultColWidth = 50
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
    TabOrder = 1
    RowHeights = (
      24)
  end
  object Ad: TStringGrid
    Left = 16
    Top = 123
    Width = 297
    Height = 120
    ColCount = 1
    DefaultColWidth = 50
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
    TabOrder = 2
    ColWidths = (
      50)
  end
  object OutputResult: TMemo
    Left = 16
    Top = 499
    Width = 297
    Height = 110
    ReadOnly = True
    TabOrder = 3
  end
  object Calculate: TButton
    Left = 16
    Top = 429
    Width = 105
    Height = 33
    Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
    TabOrder = 4
    OnClick = CalculateClick
  end
  object ClearResultAndMatrix: TButton
    Left = 127
    Top = 429
    Width = 186
    Height = 33
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1084#1072#1090#1088#1080#1094#1099' '#1080' '#1087#1086#1083#1077' '#1074#1099#1074#1086#1076#1072
    Enabled = False
    TabOrder = 5
    OnClick = ClearResultAndMatrixClick
  end
  object edN: TSpinEdit
    Left = 191
    Top = 13
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
    OnChange = edNChange
  end
end
