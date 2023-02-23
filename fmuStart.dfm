object fmStart: TfmStart
  Left = 0
  Top = 0
  Caption = 'fmStart'
  ClientHeight = 289
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 554
    Height = 289
    ActivePage = TabDatabase
    Align = alClient
    TabOrder = 0
    object TabEnter: TTabSheet
      Caption = 'TabEnter'
      DesignSize = (
        546
        261)
      object BitBtn1: TBitBtn
        Left = 454
        Top = 224
        Width = 75
        Height = 25
        Caption = 'BitBtn1'
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object GroupBoxUser: TGroupBox
        Left = 3
        Top = 48
        Width = 540
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        Caption = 'GroupBoxUser'
        TabOrder = 1
        DesignSize = (
          540
          49)
        object ComboBoxUser: TComboBox
          Left = 3
          Top = 16
          Width = 534
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'ComboBoxUser'
        end
      end
      object GroupBoxPassword: TGroupBox
        Left = 3
        Top = 103
        Width = 540
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        Caption = 'GroupBoxPassword'
        TabOrder = 2
        DesignSize = (
          540
          49)
        object EditPassword: TEdit
          Left = 3
          Top = 16
          Width = 534
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'EditPassword'
        end
      end
    end
    object TabDatabase: TTabSheet
      Caption = 'TabDatabase'
      ImageIndex = 1
      DesignSize = (
        546
        261)
      object GroupBoxDatabasePath: TGroupBox
        Left = 3
        Top = 3
        Width = 540
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        Caption = 'GroupBoxDatabasePath'
        TabOrder = 0
        DesignSize = (
          540
          49)
        object EditDatabasePath: TEdit
          Left = 3
          Top = 16
          Width = 534
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'EditDatabasePath'
        end
      end
      object GroupBoxDatabaseLogin: TGroupBox
        Left = 3
        Top = 58
        Width = 540
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        Caption = 'GroupBoxDatabaseLogin'
        TabOrder = 1
        DesignSize = (
          540
          49)
        object EditDatabaseLogin: TEdit
          Left = 3
          Top = 16
          Width = 534
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'EditDatabaseLogin'
        end
      end
      object GroupBoxDatabasePassword: TGroupBox
        Left = 3
        Top = 113
        Width = 540
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        Caption = 'GroupBoxDatabasePassword'
        TabOrder = 2
        DesignSize = (
          540
          49)
        object EditDatabasePassword: TEdit
          Left = 3
          Top = 16
          Width = 534
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'EditDatabasePassword'
        end
      end
      object GroupBoxDatabaseIPaddress: TGroupBox
        Left = 3
        Top = 168
        Width = 540
        Height = 49
        Anchors = [akLeft, akTop, akRight]
        Caption = 'GroupBoxDatabaseIPaddress'
        TabOrder = 3
        DesignSize = (
          540
          49)
        object EditDatabaseIPaddress: TEdit
          Left = 3
          Top = 16
          Width = 534
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'EditDatabaseIPaddress'
        end
      end
      object BitBtnSaveDatabase: TBitBtn
        Left = 465
        Top = 233
        Width = 75
        Height = 25
        Caption = 'BitBtnSaveDatabase'
        TabOrder = 4
        OnClick = BitBtnSaveDatabaseClick
      end
    end
  end
  object TaskDialog1: TTaskDialog
    Buttons = <>
    RadioButtons = <>
    Left = 228
    Top = 232
  end
end
