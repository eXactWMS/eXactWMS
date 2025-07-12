object WebModuleApi: TWebModuleApi
  OnCreate = WebModuleCreate
  Actions = <
    item
      Default = True
      Name = 'WebActionPadrao'
      OnAction = WebModuleApiWebActionPadraoAction
    end>
  BeforeDispatch = WebModuleBeforeDispatch
  Height = 251
  Width = 486
end
