{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_presentation_v01 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ctlim/.cabal/bin"
libdir     = "/home/ctlim/.cabal/lib/x86_64-linux-ghc-8.6.5/presentation-v01-0.1.0.0-ApjGQY77S7CeitzASvdAu-animation"
dynlibdir  = "/home/ctlim/.cabal/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/ctlim/.cabal/share/x86_64-linux-ghc-8.6.5/presentation-v01-0.1.0.0"
libexecdir = "/home/ctlim/.cabal/libexec/x86_64-linux-ghc-8.6.5/presentation-v01-0.1.0.0"
sysconfdir = "/home/ctlim/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "presentation_v01_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "presentation_v01_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "presentation_v01_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "presentation_v01_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "presentation_v01_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "presentation_v01_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
