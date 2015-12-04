module Haystack.Lib (
  message, errorMsg,
  haystackConfig, defaultConfig
) where

import Haystack.Config

import qualified Config.Dyre as Dyre
import Config.Dyre.Relaunch

import System.IO

data State  = State { bufferLines :: [String] } deriving (Read, Show)

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
