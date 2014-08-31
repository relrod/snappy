{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Data.ByteString as BS
import Snap.Util.FileServe
import Snap.Http.Server
import Snap.Core

directoryConfig :: MonadSnap m => DirectoryConfig m
directoryConfig =
  fancyDirectoryConfig
  { indexGenerator = defaultIndexGenerator defaultMimeTypes style
  }

style :: BS.ByteString
style =
  "* { font-family: sans-serif; }\
  \.header { font-size: 1.5em; }\
  \.content { width: 700px; }"

main :: IO ()
main = do
  config <- commandLineConfig (setPort 8000 defaultConfig)
  httpServe config (serveDirectoryWith directoryConfig ".")
