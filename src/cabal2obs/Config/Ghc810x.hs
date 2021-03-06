{-# LANGUAGE OverloadedLists #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Config.Ghc810x ( ghc810x ) where

import Config.ForcedExecutables
import Oracle.Hackage ( )
import Types
import MyCabal

import Control.Monad
import Data.Map.Strict ( fromList, toList )
import Data.Maybe
import Development.Shake

ghc810x :: Action PackageSetConfig
ghc810x = do
  let compiler = "ghc-8.10.2"
      flagAssignments = fromList (readFlagAssignents flagList)
      forcedExectables = forcedExectableNames
      corePackages = ghcCorePackages
  packageSet <- fromList <$>
                  forM (toList constraintList) (\(pn,vr) ->
                    (,) pn <$> askOracle (PackageVersionConstraint pn vr))
  pure (PackageSetConfig {..})

{-
targetPackages :: ConstraintSet
targetPackages   = [ "alex >=3.2.5"
                   , "cabal-install ==3.2.*"
                   , "cabal2spec >=2.6"
                   , "cabal-plan"
                   , "distribution-opensuse >= 1.1.1"
                   , "git-annex"
                   , "happy >=1.19.12"
                   , "hledger", "hledger-ui", "hledger-interest"
                   , "hlint"
                   , "ghcid"
                   , "pandoc >=2.9.2.1"
                   , "pandoc-citeproc >=0.17"
                   , "postgresql-simple"    -- needed by emu-incident-report
                   , "SDL >=0.6.6.0"        -- Dmitriy Perlow <dap.darkness@gmail.com> needs the
                   , "SDL-image >=0.6.2.0"  -- SDL packages for games/raincat.
                   , "SDL-mixer >=0.6.3.0"
                   , "shake"
                   , "ShellCheck >=0.7.1"
                   , "weeder"
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
 -}

constraintList :: ConstraintSet
constraintList = [ "adjunctions"
                 , "aeson"
                 , "aeson-pretty"
                 , "aeson-yaml"
                 , "alex"
                 , "algebraic-graphs"
                 , "alsa-core"
                 , "alsa-mixer"
                 , "annotated-wl-pprint"
                 , "ansi-terminal"
                 , "ansi-wl-pprint"
                 , "appar"
                 , "ascii-progress"
                 , "asn1-encoding"
                 , "asn1-parse"
                 , "asn1-types"
                 , "assoc"
                 , "async"
                 , "atomic-write"
                 , "attoparsec"
                 , "attoparsec-iso8601"
                 , "auto-update"
                 , "aws"
                 , "base-compat"
                 , "base-compat-batteries"
                 , "base-noprelude"
                 , "base-orphans"
                 , "base-prelude"
                 , "base16-bytestring < 1"      -- cabal-plan-0.7.1.0 doesn't accept the new version yet
                 , "base64-bytestring"
                 , "basement"
                 , "bencode"
                 , "bifunctors"
                 , "bindings-uname"
                 , "bitarray"
                 , "blaze-builder"
                 , "blaze-html"
                 , "blaze-markup"
                 , "bloomfilter"
                 , "boxes"
                 , "brick"
                 , "bsb-http-chunked"
                 , "byteable"
                 , "byteorder"
                 , "bytestring-builder"
                 , "c2hs"
                 , "cabal-doctest"
                 , "cabal-install"
                 , "cabal-plan"
                 , "cabal2spec"
                 , "call-stack"
                 , "case-insensitive"
                 , "cassava"
                 , "cassava-megaparsec"
                 , "cborg"
                 , "cborg-json"
                 , "cereal"
                 , "charset"
                 , "cipher-aes"
                 , "citeproc"
                 , "clientsession"
                 , "clock"
                 , "cmark-gfm"
                 , "cmdargs"
                 , "colour"
                 , "commonmark"
                 , "commonmark-extensions"
                 , "commonmark-pandoc"
                 , "comonad"
                 , "concurrent-output"
                 , "conduit"
                 , "conduit-combinators"
                 , "conduit-extra"
                 , "config-ini"
                 , "connection"
                 , "constraints"
                 , "contravariant"
                 , "control-monad-free"
                 , "cookie"
                 , "cpphs"
                 , "cprng-aes"
                 , "crypto-api"
                 , "crypto-cipher-types"
                 , "crypto-random"
                 , "cryptohash"
                 , "cryptohash-conduit"
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
                 , "data-fix"
                 , "DAV"
                 , "dbus"
                 , "dec"
                 , "Decimal"
                 , "dhall"
                 , "dhall-json"
                 , "dhall-yaml"
                 , "Diff"
                 , "digest"
                 , "disk-free-space"
                 , "distribution-opensuse"
                 , "distributive"
                 , "dlist"
                 , "doclayout"
                 , "doctemplates"
                 , "dotgen"
                 , "double-conversion"
                 , "easy-file"
                 , "echo"
                 , "ed25519"
                 , "edit-distance"
                 , "either"
                 , "email-validate"
                 , "emojis"
                 , "enclosed-exceptions"
                 , "entropy"
                 , "erf"
                 , "errors"
                 , "extensible-exceptions"
                 , "extra"
                 , "fail"
                 , "fast-logger"
                 , "fdo-notify"
                 , "feed"
                 , "fgl"
                 , "file-embed"
                 , "filelock"
                 , "filemanip"
                 , "filepath-bytestring"
                 , "filepattern"
                 , "filtrable"
                 , "fingertree"
                 , "foldl"
                 , "foundation"
                 , "free"
                 , "fsnotify"
                 , "generic-deriving"
                 , "generic-lens"
                 , "generic-lens-core"
                 , "ghc-lib-parser-ex"
                 , "ghc-paths"
                 , "ghcid"
                 , "git-annex"
                 , "git-lfs"
                 , "githash"
                 , "gitrev"
                 , "Glob"
                 , "hackage-security"
                 , "haddock-library"
                 , "half"
                 , "happy"
                 , "hashable"
                 , "hashtables"
                 , "haskell-lexer"
                 , "heaps"
                 , "hi-file-parser"
                 , "hinotify"
                 , "hjsmin"
                 , "hledger"
                 , "hledger-interest"
                 , "hledger-lib"
                 , "hledger-ui"
                 , "hlint"
                 , "hostname"
                 , "hourglass"
                 , "hpack"
                 , "hs-bibutils"
                 , "hscolour"
                 , "hsemail"
                 , "hslogger"
                 , "hslua"
                 , "hslua-module-system"
                 , "hslua-module-text"
                 , "hspec"
                 , "hspec-core"
                 , "hspec-discover"
                 , "hspec-expectations"
                 , "hspec-smallcheck"
                 , "HsYAML"
                 , "HsYAML-aeson"
                 , "html"
                 , "HTTP"
                 , "http-api-data"
                 , "http-client"
                 , "http-client-restricted"
                 , "http-client-tls"
                 , "http-conduit"
                 , "http-date"
                 , "http-types"
                 , "http2"
                 , "HUnit"
                 , "hxt"
                 , "hxt-charproperties"
                 , "hxt-regex-xmlschema"
                 , "hxt-unicode"
                 , "IfElse"
                 , "indexed-profunctors"
                 , "infer-license"
                 , "integer-logarithms"
                 , "intern"
                 , "invariant"
                 , "iproute"
                 , "ipynb"
                 , "iso8601-time"
                 , "iwlib"
                 , "jira-wiki-markup"
                 , "js-dgtable"
                 , "js-flot"
                 , "js-jquery"
                 , "JuicyPixels"
                 , "kan-extensions"
                 , "language-c"
                 , "language-javascript"
                 , "lens"
                 , "lens-family-core"
                 , "libmpd"
                 , "libxml-sax"
                 , "libyaml"
                 , "lifted-async"
                 , "lifted-base"
                 , "liquid-fixpoint"
                 , "liquidhaskell"
                 , "logict"
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
                 , "mintty"
                 , "mmorph"
                 , "monad-control"
                 , "monad-logger"
                 , "monad-loops"
                 , "mono-traversable"
                 , "mountpoints"
                 , "mustache"
                 , "mwc-random < 0.15"  -- needs latest randomn, which many packages not support yet (2020-08-04)
                 , "neat-interpolation"
                 , "netlink"
                 , "network"
                 , "network-bsd"
                 , "network-byte-order"
                 , "network-info"
                 , "network-multicast"
                 , "network-uri < 2.7.0.0 || > 2.7.0.0"
                 , "old-locale"
                 , "old-time"
                 , "Only"
                 , "open-browser"
                 , "optics"
                 , "optics-core"
                 , "optics-extra"
                 , "optics-th"
                 , "optional-args"
                 , "optparse-applicative"
                 , "optparse-simple"
                 , "pandoc"
                 , "pandoc-citeproc"
                 , "pandoc-types"
                 , "parallel"
                 , "parsec-class"
                 , "parsec-numbers"
                 , "parser-combinators"
                 , "parsers"
                 , "path"
                 , "path-io"
                 , "path-pieces"
                 , "pem"
                 , "persistent"
                 , "persistent-sqlite"
                 , "persistent-template < 2.8.3.0"      -- https://github.com/yesodweb/persistent/issues/1101
                 , "polyparse"
                 , "postgresql-libpq"
                 , "postgresql-simple"
                 , "pretty-hex"
                 , "pretty-show"
                 , "pretty-simple"
                 , "prettyprinter"
                 , "prettyprinter-ansi-terminal"
                 , "primitive"
                 , "profunctors"
                 , "psqueues"
                 , "QuickCheck"
                 , "quickcheck-io"
                 , "random <1.2"        -- don't update yet (2020-07-07)
                 , "refact"
                 , "reflection"
                 , "regex-applicative"
                 , "regex-applicative-text"
                 , "regex-base"
                 , "regex-compat"
                 , "regex-pcre-builtin"
                 , "regex-posix"
                 , "regex-tdfa"
                 , "repline"
                 , "resolv"
                 , "resource-pool"
                 , "resourcet"
                 , "retry"
                 , "rfc5051"
                 , "rio"
                 , "rio-orphans"
                 , "rio-prettyprint"
                 , "safe"
                 , "safe-exceptions"
                 , "SafeSemaphore"
                 , "sandi"
                 , "scientific"
                 , "SDL"
                 , "SDL-image"
                 , "SDL-mixer"
                 , "securemem"
                 , "semialign"
                 , "semigroupoids"
                 , "semigroups"
                 , "serialise"
                 , "setenv"
                 , "setlocale"
                 , "SHA"
                 , "shake"
                 , "shakespeare"
                 , "ShellCheck"
                 , "shelltestrunner"
                 , "shelly"
                 , "silently"
                 , "simple-sendfile"
                 , "singleton-bool"
                 , "skein"
                 , "skylighting"
                 , "skylighting-core"
                 , "smallcheck"
                 , "socks"
                 , "split"
                 , "splitmix"
                 , "StateVar"
                 , "stm-chans"
                 , "store-core"
                 , "streaming-commons"
                 , "strict"
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
                 , "test-framework"
                 , "test-framework-hunit"
                 , "texmath"
                 , "text-conversions"
                 , "text-format"
                 , "text-manipulate"
                 , "text-metrics"
                 , "text-short"
                 , "text-zipper"
                 , "tf-random"
                 , "th-abstraction"
                 , "th-compat"
                 , "th-expand-syns"
                 , "th-lift"
                 , "th-lift-instances"
                 , "th-orphans"
                 , "th-reify-many"
                 , "th-utilities"
                 , "these"
                 , "time-compat"
                 , "time-locale-compat"
                 , "time-manager"
                 , "timeit"
                 , "timezone-olson"
                 , "timezone-series"
                 , "tls"
                 , "tls-session-manager"
                 , "topograph"
                 , "torrent"
                 , "transformers-base"
                 , "transformers-compat"
                 , "turtle"
                 , "type-equality"
                 , "typed-process"
                 , "uglymemo"
                 , "unbounded-delays"
                 , "unicode-transforms"
                 , "uniplate"
                 , "unix-compat"
                 , "unix-time"
                 , "unliftio"
                 , "unliftio-core"
                 , "unordered-containers"
                 , "uri-encode"
                 , "utf8-string"
                 , "utility-ht"
                 , "uuid"
                 , "uuid-types"
                 , "vault"
                 , "vector"
                 , "vector-algorithms"
                 , "vector-binary-instances"
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
                 , "weeder"
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
  , ("xmobar",                         "all_extensions")

    -- Enable additional features
  , ("idris",                          "ffi gmp")

    -- Disable dependencies we don't have.
  , ("invertible",                     "-hlist -piso")

    -- Use the system sqlite library rather than the bundled one.
  , ("persistent-sqlite",              "systemlib")

    -- Make sure we're building with the test suite enabled.
  , ("git-annex",                      "testsuite")

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

    -- Build the standalone executable for skylighting.
  , ("skylighting",                    "executable")
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

ghcCorePackages :: PackageSet
ghcCorePackages = [ "array-0.5.4.0"
                  , "base-4.14.1.0"
                  , "binary-0.8.8.0"
                  , "bytestring-0.10.10.0"
                  , "Cabal-3.2.0.0"
                  , "containers-0.6.2.1"
                  , "deepseq-1.4.4.0"
                  , "directory-1.3.6.0"
                  , "exceptions-0.10.4"
                  , "filepath-1.4.2.1"
                  , "ghc-8.10.2"
                  , "ghc-boot-8.10.2"
                  , "ghc-boot-th-8.10.2"
                  , "ghc-compact-0.1.0.0"
                  , "ghc-heap-8.10.2"
                  , "ghc-prim-0.6.1"
                  , "ghci-8.10.1"
                  , "haskeline-0.8.0.0"
                  , "hpc-0.6.1.0"
                  , "hsc2hs-0.68.7"
                  , "integer-gmp-1.0.3.0"
                  , "libiserv-8.10.2"
                  , "mtl-2.2.2"
                  , "parsec-3.1.14.0"
                  , "pretty-1.1.3.6"
                  , "process-1.6.9.0"
                  , "rts-1.0"
                  , "stm-2.5.0.0"
                  , "template-haskell-2.16.0.0"
                  , "terminfo-0.4.1.4"
                  , "text-1.2.3.2"
                  , "time-1.9.3"
                  , "transformers-0.5.6.2"
                  , "unix-2.7.2.2"
                  , "xhtml-3000.2.2.1"
                  ]
