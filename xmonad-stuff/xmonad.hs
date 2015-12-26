import XMonad
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , startupHook = setWMName "LG3D"
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
	, modMask = mod4Mask
        } `additionalKeys`
	  [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
            ((0                     , 0x1008FF11), spawn "amixer -D pulse set Master 2%-"),
            ((0                     , 0x1008FF13), spawn "amixer -D pulse set Master 2%+"),
            ((0                     , 0x1008FF12), spawn "amixer -D pulse set Master toggle")
	  ]
