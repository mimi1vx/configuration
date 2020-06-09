{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Config.Ghc810x ( ghc810x, resolveConstraints ) where

import Config.ForcedExecutables
import Oracle.Hackage ( )
import Types

import Control.Monad
import Data.List ( intercalate )
import Data.Map.Strict ( fromList, toList, keys, union )
import Data.Maybe
import Development.Shake
import Distribution.Package
import Distribution.PackageDescription
import Distribution.Simple.Utils ( lowercase )
import Distribution.Text
import Distribution.Types.PackageVersionConstraint

ghc810x :: Action PackageSetConfig
ghc810x = do
  let compiler = "ghc-8.10.1"
      flagAssignments = fromList (readFlagAssignents flagList)
      forcedExectables = forcedExectableNames
  packageSet <- fromList <$>
                  forM (toList constraintList) (\(pn,vr) ->
                    (,) pn <$> askOracle (PackageVersionConstraint pn vr))
  pure (PackageSetConfig {..})

targetPackages :: ConstraintSet
targetPackages   = [ "alex >=3.2.5"
                   , "cabal-install ==3.2.*"
                   , "cabal2spec >=2.6"
                   , "distribution-opensuse >= 1.1.1"
                   , "git-annex"
                   , "happy >=1.19.12"
                   , "hledger", "hledger-ui", "hledger-interest"
                   , "pandoc >=2.9.2.1"
                   , "pandoc-citeproc >=0.17"
                   , "postgresql-simple"    -- needed by emu-incident-report
                   , "SDL >=0.6.6.0"        -- Dmitriy Perlow <dap.darkness@gmail.com> needs the
                   , "SDL-image >=0.6.2.0"  -- SDL packages for games/raincat.
                   , "SDL-mixer >=0.6.3.0"
                   , "ShellCheck >=0.7.1"
                   , "xmobar >= 0.33"
                   , "xmonad >= 0.15"
                   , "xmonad-contrib >= 0.16"
                   ]

resolveConstraints :: String
resolveConstraints = unwords ["cabal", "install", "--dry-run", "--minimize-conflict-set", constraints, flags, pkgs]
  where
    pkgs = intercalate " " (display <$> keys targetPackages)
    constraints = "--constraint=" <> intercalate " --constraint=" (show <$> environment)
    environment = display . (\(n,v) -> PackageVersionConstraint n v) <$> toList (corePackages `union` targetPackages)
    flags = unwords [ "--constraint=" <> show (unwords [unPackageName pn, flags'])
                    | pn <- keys targetPackages
                    , Just flags' <- [lookup (unPackageName pn) flagList]
                    ]

constraintList :: ConstraintSet
constraintList = [ "adjunctions"
                 , "aeson"
                 , "aeson-pretty"
                 , "alex"
                 , "ansi-terminal"
                 , "ansi-wl-pprint"
                 , "appar"
                 , "asn1-encoding"
                 , "asn1-parse"
                 , "asn1-types"
                 , "async"
                 , "attoparsec"
                 , "attoparsec-iso8601"
                 , "auto-update"
                 , "aws"
                 , "base-compat"
                 , "base-compat-batteries"
                 , "base-noprelude"
                 , "base-orphans"
                 , "base-prelude"
                 , "base16-bytestring"
                 , "base64-bytestring"
                 , "basement"
                 , "bencode"
                 , "bifunctors"
                 , "bitarray"
                 , "blaze-builder"
                 , "blaze-html"
                 , "blaze-markup"
                 , "bloomfilter"
                 , "brick"
                 , "bsb-http-chunked"
                 , "byteable"
                 , "byteorder"
                 , "bytestring-builder"
                 , "cabal-doctest"
                 , "cabal-install"
                 , "cabal2spec"
                 , "call-stack"
                 , "case-insensitive"
                 , "cassava"
                 , "cassava-megaparsec"
                 , "cereal"
                 , "cipher-aes"
                 , "clientsession"
                 , "clock"
                 , "cmark-gfm"
                 , "cmdargs"
                 , "colour"
                 , "comonad"
                 , "concurrent-output"
                 , "conduit"
                 , "conduit-extra"
                 , "config-ini"
                 , "connection"
                 , "constraints"
                 , "contravariant"
                 , "control-monad-free"
                 , "cookie"
                 , "cprng-aes"
                 , "crypto-api"
                 , "crypto-cipher-types"
                 , "crypto-random"
                 , "cryptohash-md5"
                 , "cryptohash-sha1"
                 , "cryptohash-sha256"
                 , "cryptonite"
                 , "cryptonite-conduit"
                 , "css-text"
                 , "csv"
                 , "data-clist"
                 , "data-default"
                 , "data-default-class"
                 , "data-default-instances-containers"
                 , "data-default-instances-dlist"
                 , "data-default-instances-old-locale"
                 , "DAV"
                 , "dbus"
                 , "Decimal"
                 , "Diff"
                 , "digest"
                 , "disk-free-space"
                 , "distribution-opensuse"
                 , "distributive"
                 , "dlist"
                 , "doclayout"
                 , "doctemplates"
                 , "easy-file"
                 , "echo"
                 , "ed25519"
                 , "edit-distance"
                 , "email-validate"
                 , "emojis"
                 , "enclosed-exceptions"
                 , "entropy"
                 , "errors"
                 , "extensible-exceptions"
                 , "extra"
                 , "fail"
                 , "fast-logger"
                 , "fdo-notify"
                 , "feed"
                 , "fgl"
                 , "file-embed"
                 , "filepath-bytestring"
                 , "foldl"
                 , "free"
                 , "fsnotify"
                 , "git-annex"
                 , "Glob"
                 , "hackage-security"
                 , "haddock-library"
                 , "happy"
                 , "hashable"
                 , "hashtables"
                 , "haskell-lexer"
                 , "hinotify"
                 , "hjsmin"
                 , "hledger"
                 , "hledger-interest"
                 , "hledger-lib"
                 , "hledger-ui"
                 , "hostname"
                 , "hourglass"
                 , "hs-bibutils"
                 , "hsemail"
                 , "hslogger"
                 , "hslua"
                 , "hslua-module-system"
                 , "hslua-module-text"
                 , "HsYAML"
                 , "HsYAML-aeson"
                 , "html"
                 , "HTTP"
                 , "http-api-data"
                 , "http-client"
                 , "http-client-tls"
                 , "http-conduit"
                 , "http-date"
                 , "http-types"
                 , "http2"
                 , "hxt"
                 , "hxt-charproperties"
                 , "hxt-regex-xmlschema"
                 , "hxt-unicode"
                 , "IfElse"
                 , "integer-logarithms"
                 , "invariant"
                 , "iproute"
                 , "ipynb"
                 , "iwlib"
                 , "jira-wiki-markup"
                 , "JuicyPixels"
                 , "kan-extensions"
                 , "language-javascript"
                 , "lens"
                 , "libyaml"
                 , "lifted-async"
                 , "lifted-base"
                 , "lucid"
                 , "lukko"
                 , "magic"
                 , "managed"
                 , "math-functions"
                 , "megaparsec"
                 , "memory"
                 , "microlens"
                 , "microlens-ghc"
                 , "microlens-mtl"
                 , "microlens-platform"
                 , "microlens-th"
                 , "mime-types"
                 , "mmorph"
                 , "monad-control"
                 , "monad-logger"
                 , "monad-loops"
                 , "mono-traversable"
                 , "mountpoints"
                 , "mwc-random"
                 , "network"
                 , "network-bsd"
                 , "network-byte-order"
                 , "network-info"
                 , "network-multicast"
                 , "network-uri"
                 , "old-locale"
                 , "old-time"
                 , "Only"
                 , "optional-args"
                 , "optparse-applicative"
                 , "pandoc"
                 , "pandoc-citeproc"
                 , "pandoc-types"
                 , "parallel"
                 , "parsec-class"
                 , "parsec-numbers"
                 , "parser-combinators"
                 , "path-pieces"
                 , "pem"
                 , "persistent"
                 , "persistent-sqlite"
                 , "persistent-template"
                 , "postgresql-libpq"
                 , "postgresql-simple"
                 , "pretty-show"
                 , "primitive"
                 , "profunctors"
                 , "psqueues"
                 , "QuickCheck"
                 , "random"
                 , "reflection"
                 , "regex-base"
                 , "regex-compat"
                 , "regex-pcre-builtin"
                 , "regex-posix"
                 , "regex-tdfa"
                 , "resolv"
                 , "resource-pool"
                 , "resourcet"
                 , "rfc5051"
                 , "safe"
                 , "SafeSemaphore"
                 , "sandi"
                 , "scientific"
                 , "SDL"
                 , "SDL-image"
                 , "SDL-mixer"
                 , "securemem"
                 , "semigroupoids"
                 , "semigroups"
                 , "setenv"
                 , "setlocale"
                 , "SHA"
                 , "shakespeare"
                 , "ShellCheck"
                 , "shelly"
                 , "silently"
                 , "simple-sendfile"
                 , "skein"
                 , "skylighting"
                 , "skylighting-core"
                 , "socks"
                 , "split"
                 , "splitmix"
                 , "StateVar"
                 , "stm-chans"
                 , "streaming-commons"
                 , "syb"
                 , "system-fileio"
                 , "system-filepath"
                 , "tabular"
                 , "tagged"
                 , "tagsoup"
                 , "tar"
                 , "tasty"
                 , "tasty-hunit"
                 , "tasty-quickcheck"
                 , "tasty-rerun"
                 , "temporary"
                 , "terminal-size"
                 , "texmath"
                 , "text-conversions"
                 , "text-short"
                 , "text-zipper"
                 , "th-abstraction"
                 , "th-lift"
                 , "th-lift-instances"
                 , "these"
                 , "time-compat"
                 , "time-locale-compat"
                 , "time-manager"
                 , "timeit"
                 , "timezone-olson"
                 , "timezone-series"
                 , "tls"
                 , "tls-session-manager"
                 , "torrent"
                 , "transformers-base"
                 , "transformers-compat"
                 , "turtle"
                 , "type-equality"
                 , "typed-process"
                 , "uglymemo"
                 , "unbounded-delays"
                 , "unicode-transforms"
                 , "unix-compat"
                 , "unix-time"
                 , "unliftio"
                 , "unliftio-core"
                 , "unordered-containers"
                 , "utf8-string"
                 , "utility-ht"
                 , "uuid"
                 , "uuid-types"
                 , "vault"
                 , "vector"
                 , "vector-algorithms"
                 , "vector-builder"
                 , "vector-th-unbox"
                 , "void"
                 , "vty"
                 , "wai"
                 , "wai-app-static"
                 , "wai-extra"
                 , "wai-logger"
                 , "warp"
                 , "warp-tls"
                 , "wcwidth"
                 , "wizards"
                 , "word-wrap"
                 , "word8"
                 , "X11"
                 , "X11-xft"
                 , "x509"
                 , "x509-store"
                 , "x509-system"
                 , "x509-validation"
                 , "xml"
                 , "xml-conduit"
                 , "xml-hamlet"
                 , "xml-types"
                 , "xmobar"
                 , "xmonad"
                 , "xmonad-contrib"
                 , "xss-sanitize"
                 , "yaml"
                 , "yesod"
                 , "yesod-core"
                 , "yesod-form"
                 , "yesod-persistent"
                 , "yesod-static"
                 , "zip-archive"
                 , "zlib"
                 ]

flagList :: [(String,String)]
flagList =
  [ -- Don't build hardware-specific optimizations into the binary based on what the
    -- build machine supports or doesn't support.
    ("cryptonite",                     "-support_aesni -support_rdrand -support_blake2_sse")

    -- Don't use the bundled sqlite3 library.
  , ("direct-sqlite",                  "systemlib")

    -- Build the standalone executable and prefer pcre-light, which uses the system
    -- library rather than a bundled copy.
  , ("highlighting-kate",              "executable pcre-light")

    -- Don't use the bundled sass library.
  , ("hlibsass",                       "externalLibsass")

    -- Use the bundled lua library. People expect this package to provide LUA
    -- 5.3, but we don't have that yet in openSUSE.
  , ("hslua",                          "-system-lua")

    -- Allow compilation without having Nix installed.
  , ("nix-paths",                      "allow-relative-paths")

    -- Build the standalone executable.
  , ("texmath",                        "executable")

    -- Enable almost all extensions.
  , ("xmobar",                         "with_thread with_utf8 with_xft with_xpm with_mpris with_dbus with_iwlib with_inotify with_datezone")

    -- Enable additional features
  , ("idris",                          "ffi gmp")

    -- Disable dependencies we don't have.
  , ("invertible",                     "-hlist -piso")

    -- Use the system sqlite library rather than the bundled one.
  , ("persistent-sqlite",              "systemlib")

    -- Since version 6.20170925, the test suite can no longer be run outside of
    -- a checked-out copy of the git repository.
  , ("git-annex",                      "-testsuite")

    -- Compile against the system library, not the one bundled in the Haskell
    -- source tarball.
  , ("cmark",                          "pkgconfig")

    -- Fix build with modern compilers.
  , ("cassava",                        "-bytestring--lt-0_10_4")

    -- Prefer the system's library over the bundled one.
  , ("libyaml",                        "system-libyaml")

    -- Configure a production-like build environment.
  , ("stack",                          "hide-dependency-versions disable-git-info supported-build")

    -- The command-line utility pulls in other dependencies.
  , ("aeson-pretty",                   "lib-only")
  ]

readFlagAssignents :: [(String,String)] -> [(PackageName,FlagAssignment)]
readFlagAssignents xs = [ (fromJust (simpleParse name), readFlagList (words assignments)) | (name,assignments) <- xs ]

readFlagList :: [String] -> FlagAssignment
readFlagList = mkFlagAssignment . map (tagWithValue . noMinusF)
  where
    tagWithValue ('-':fname) = (mkFlagName (lowercase fname), False)
    tagWithValue fname       = (mkFlagName (lowercase fname), True)

    noMinusF :: String -> String
    noMinusF ('-':'f':_) = error "don't use '-f' in flag assignments; just use the flag's name"
    noMinusF x           = x

corePackages :: ConstraintSet
corePackages = [ "array ==0.5.4.0"
               , "base ==4.14.0.0"
               , "binary ==0.8.8.0"
               , "bytestring ==0.10.10.0"
               , "Cabal ==3.2.0.0"
               , "containers ==0.6.2.1"
               , "deepseq ==1.4.4.0"
               , "directory ==1.3.6.0"
               , "exceptions ==0.10.4"
               , "filepath ==1.4.2.1"
               , "ghc ==8.10.1"
               , "ghc-boot ==8.10.1"
               , "ghc-boot-th ==8.10.1"
               , "ghc-compact ==0.1.0.0"
               , "ghc-heap ==8.10.1"
               , "ghc-prim ==0.6.1"
               , "ghci ==8.10.1"
               , "haskeline ==0.8.0.0"
               , "hpc ==0.6.1.0"
               , "hsc2hs ==0.68.7"
               , "integer-gmp ==1.0.3.0"
               , "libiserv ==8.10.1"
               , "mtl ==2.2.2"
               , "parsec ==3.1.14.0"
               , "pretty ==1.1.3.6"
               , "process ==1.6.8.2"
               , "rts ==1.0"
               , "stm ==2.5.0.0"
               , "template-haskell ==2.16.0.0"
               , "terminfo ==0.4.1.4"
               , "text ==1.2.3.2"
               , "time ==1.9.3"
               , "transformers ==0.5.6.2"
               , "unix ==2.7.2.2"
               , "xhtml ==3000.2.2.1"
               ]
