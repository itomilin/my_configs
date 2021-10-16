import XMonad
import System.IO
import XMonad.Core
import qualified XMonad.StackSet as W

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers -- doFullFloat
import XMonad.Hooks.SetWMName     -- fix java app forexample - duino ide
--import XMonad.Hooks.DynamicLog

import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
--import XMonad.Layout.Spiral
import XMonad.Layout.ThreeColumns

import XMonad.Actions.NoBorders
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce    -- spawnOnce
import XMonad.Util.Run(spawnPipe)



-- guid https://github.com/vicfryzel/xmonad-config/blob/master/xmonad.hs
-- https://www.stackage.org
-- https://wiki.haskell.org/Xmonad/Config_archive
-- https://bbs.archlinux.org/viewtopic.php?id=219960
-- http://scripts.inf.ua/?p=272
altMask           = mod1Mask
localScriptsPath  = "/home/$USER/.xmonad/scripts/"
screenshotPath    = "$HOME/Pictures/$(date \"+%Y_%B_%d-%H%M%S\").png"
xclip             = " -e 'xclip -selection c -t image/png < $f'"

printFullScreen = "scrot -q 100 " ++ screenshotPath ++ xclip
printArea       = "sleep 0.3; scrot -s -q 100 " ++ screenshotPath ++ xclip
testNotify      = " && /usr/bin/notify-send \"Notify\" \"...shot...\" -u LOW"
getVolume       = localScriptsPath ++ "getVolume.sh"


layouts = avoidStruts $
    Tall 1 ( 3 / 100 ) ( 1 / 2 )            |||
--    Mirror ( Tall 1 (3/100) (1/2) ) |||
--    Full                            |||
    ThreeColMid 1 ( 2 / 100 ) ( 1 / 2 )
--    spiral (6/7)) |||
--    noBorders (fullscreenFull Full)

myLayout = smartBorders
         $ mkToggle ( NOBORDERS ?? FULL ?? EOT )
         $ layouts


myWorkspaces =
    [ "1"
    , "2"
    , "3"
    , "4"
    , "5"
    ] ++ map show [ 6..9 ]


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/tomilin/.xmonad/xmobarrc.hs"
    xmonad $ defaults
        { manageHook      = manageDocks <+> myManageHook
        , handleEventHook = handleEventHook def <+> docksEventHook
        , logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput  = hPutStrLn xmproc
            , ppCurrent = xmobarColor "red" ""
            , ppSep     = "  "
            , ppTitle   = xmobarColor "red" "" . shorten 50
            }
        }


keyBinds =
    [ (( 0, 0x1008ff13 ), spawn $ "/usr/bin/amixer -c 0 -- sset \
                                   \ Master playback 2%+ && "   ++ getVolume  )
    , (( 0, 0x1008ff11 ), spawn $ "/usr/bin/amixer -c 0 -- sset \
                                   \ Master playback 2%- && "   ++ getVolume  )
    , (( 0, 0x1008ff12 ), spawn $ "/usr/bin/amixer set Master \
                                   \ toggle && "                ++ getVolume  )
    , (( altMask .|. shiftMask, 0x33 ), spawn $ printFullScreen ++ testNotify )
    , (( altMask .|. shiftMask, 0x34 ), spawn $ printArea       ++ testNotify )
    , (( mod4Mask, 0x66 ), sendMessage $ Toggle FULL                          )
    , (( mod4Mask, xK_b ), sendMessage $ ToggleStruts                         )
    , (( mod4Mask, xK_l ), spawn "/usr/bin/dm-tool lock"        )
    ]


defaults = def
    { terminal           = "xfce4-terminal"
    , modMask            = mod4Mask
    , borderWidth        = 3
    , normalBorderColor  = "#000000"
    , focusedBorderColor = "#099e73"--"magenta" --"#4dff6a"
    , clickJustFocuses   = False
    , focusFollowsMouse  = False
    , manageHook         = manageDocks <+> myManageHook <+> fullscreenManageHook
    , workspaces         = myWorkspaces
    , startupHook        = myStartupHook
    , layoutHook         = myLayout
    , handleEventHook    = fullscreenEventHook
--    , logHook            = myLogHook
    } `additionalKeys` keyBinds


-- https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/XMonad-Doc-Extending.html
myManageHook = composeAll
    [ className =? "Xfce4-terminal"  --> doShift "1"
--    , className =? "Firefox-esr"     --> doShift "2"
    , className =? "Gvim"            --> doShift "3"
    , className =? "TelegramDesktop" --> doShift "4" <+> doFloat -- <+> doSideFloat NW
    , className =? "Microsoft Teams - Preview" --> doShift "4" <+> doFloat
    , className =? "Thunar"          --> doShift "5"
    , className =? "QtCreator"       --> doShift "3"
    , className =? "TeamViewer"      --> doFloat
    , className =? "Pavucontrol"     --> doCenterFloat
    , className =? "feh"             --> doCenterFloat
    , className =? "Gedit"           --> doCenterFloat
    , className =? "Xpdf"            --> doCenterFloat
    , className =? "XTerm"           --> doCenterFloat

--    , className =? "jetbrains-idea-ce" --> doShift "6"
--    , className =? "Nvidia-settings" --> doCenterFloat

    -- Intercept windown and make fullscreen
    --, isFullscreen                   --> ( doF W.focusUp <+> doFullFloat )
    , className =? "vlc"             --> doCenterFloat
    , netName =? "Picture-in-Picture" --> doSideFloat SE
    , isFullscreen                   --> doCenterFloat
    , isDialog                       --> doSideFloat C
    ] where netName = stringProperty "_NET_WM_NAME"


--myLogHook = return ()


myStartupHook = do
--    spawnOnce "firefox"
--    spawnOnce "xfce4-terminal --initial-title \"myTerm2\""
--    spawnOnce "xfce4-terminal --initial-title \"myTerm1\""
--    spawnOnce "thunar"
--    spawnOnce "gvim"
--    spawnOnce "telegram"
    spawnOnce "/usr/bin/disable_touchpad"
    spawnOnce $ localScriptsPath ++ "battery_low_power.py"
    spawnOnce $ localScriptsPath ++ "getVolume.sh"
    spawnOnce "trayer --edge top --tint 0x002b36 --alpha 0 \
               \ --transparent true --width 10 --height 20"
    setWMName "LG3D" -- continue setWMname package
-- xautolock -time 1 -locker "dm-tool lock" -notify 10 -notifier "notify-send -t 100 -u critical 'Locking in 10 seconds'"
