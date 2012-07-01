
module GUI.Main where 

import Graphics.UI.Gtk
  
-- Load a new file
loadFile :: String -> IO ()
loadFile _ = return ()  
  
-- Configure the actions in the GUI      
actionsSetup:: Builder -> IO ()
actionsSetup builder = do
    -- Open a file
    openFileAction <- builderGetObject builder castToAction "openFileAction"
    on openFileAction actionActivated $ do
        fileChooserDialog <- builderGetObject builder castToFileChooserDialog "fileChooser"
        resp <- dialogRun fileChooserDialog
        if resp == ResponseOk
            then do
                    loadFile "Dummy"
                    widgetHide fileChooserDialog
            else widgetHide fileChooserDialog    
    -- Quit
    quitAction <- builderGetObject builder castToAction "quitAction"
    on quitAction actionActivated mainQuit
    return ()
        
-- Load the user interface glade XML file                
loadUserInterface :: IO Builder
loadUserInterface = do
    builder <- builderNew
    builderAddFromFile builder "rsrc/bintools.ui"
    return builder
    
-- Construct user interface and enter main loop
runMainLoop:: IO ()
runMainLoop = do
    -- Initialise and load user interface
    initGUI
    builder <- loadUserInterface
    actionsSetup builder
    -- Open the main window
    mainWindow <- builderGetObject builder castToWindow "mainWindow"
    widgetShowAll mainWindow
    mainGUI