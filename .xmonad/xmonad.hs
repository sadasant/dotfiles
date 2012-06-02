-- Imports
import XMonad
import XMonad.Hooks.DynamicLog

-- The Main Function
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

-- Launch bar
-- myBar = "xmobar"
myBar = "killall -9 conky & xmobar & sleep 5; conky" -- lol this works :D
                                                     -- remember to empty the template in .xmobarrc

-- Custom PP
myPP = xmobarPP { ppCurrent = xmobarColor "#FFFFFF" "" }

-- Key binding to toggle the gap for the bar
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Hooks
myManageHook = composeAll
  [ className =? "Gimp" --> doFloat
  ]

-- Main configuration
myConfig = defaultConfig
  { terminal           = "xterm"
  , modMask            = mod4Mask
  , normalBorderColor  = "#111111"
  , focusedBorderColor = "#333333"
  , manageHook         = myManageHook
  }
