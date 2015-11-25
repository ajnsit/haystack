module Haystack.Lib where

import qualified Config.Dyre as Dyre
import Config.Dyre.Relaunch

import System.IO

data Config = Config { message :: String, errorMsg :: Maybe String }
data State  = State { bufferLines :: [String] } deriving (Read, Show)

defaultConfig :: Config
defaultConfig = Config "Haystack Example v0.1" Nothing

showError :: Config -> String -> Config
showError cfg msg = cfg { errorMsg = Just msg }

realMain :: Config -> IO ()
realMain Config{message = message, errorMsg = errorMsg } = do
    (State buffer) <- restoreTextState $ State []
    case errorMsg of
         Nothing -> return ()
         Just em -> putStrLn $ "Error: " ++ em
    putStrLn message
    mapM putStrLn . reverse $ buffer
    putStr "> " >> hFlush stdout
    input <- getLine
    case input of
         "exit" -> return ()
         "quit" -> return ()
         other  -> relaunchWithTextState (State $ other:buffer) Nothing

haystackConfig :: Config -> IO ()
haystackConfig = Dyre.wrapMain $ Dyre.defaultParams
    { Dyre.projectName = "haystack"
    , Dyre.realMain    = realMain
    , Dyre.showError   = showError
    }
