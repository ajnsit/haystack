module Haystack.Config
( Config(..)
, defaultConfig
) where

-- The Haystack config
data Config = Config
  { message :: String
  , errorMsg :: Maybe String
  }

defaultConfig :: Config
defaultConfig = Config "Haystack Example v0.1" Nothing
