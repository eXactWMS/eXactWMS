object FrameNavigator: TFrameNavigator
  Left = 0
  Top = 0
  Width = 299
  Height = 263
  TabOrder = 0
  object CEFWindowParent1: TCEFWindowParent
    Left = 0
    Top = 0
    Width = 299
    Height = 263
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -739
    ExplicitTop = -331
    ExplicitWidth = 1038
    ExplicitHeight = 594
  end
  object TmFrameWeb: TTimer
    Interval = 300
    OnTimer = TmFrameWebTimer
    Left = 56
    Top = 88
  end
  object Chromium1: TChromium
    OnBeforePopup = Chromium1BeforePopup
    OnAfterCreated = Chromium1AfterCreated
    OnBeforeClose = Chromium1BeforeClose
    OnClose = Chromium1Close
    OnOpenUrlFromTab = Chromium1OpenUrlFromTab
    Left = 56
    Top = 152
  end
  object CEFSentinel1: TCEFSentinel
    OnClose = CEFSentinel1Close
    Left = 56
    Top = 224
  end
end
