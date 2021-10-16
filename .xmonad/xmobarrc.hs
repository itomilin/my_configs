Config {
   -- appearance
     font        = "xft:DejaVu Sans Mono: size=9: bold: antialias=true"
   , bgColor     = "#002b36" -- black color -- "#000000"
   , fgColor     = "#ffffff"
   , position    = TopSize C 100 20
   , border      = NoBorder
   , borderColor = "#646464"

   -- layout
   , sepChar  = "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = "%StdinReader%}{\
                \%uptime1%\
                \|%ULLI%\
                \|%coretemp%\
                \|%battery%\
                \|%memory%\
                \|%date%\
                \|%volume%\
                \|%kbd%"
--                \%currency%\

   -- general behavior
   , lowerOnStart     = True    -- send to bottom of window stack on start
   , hideOnStart      = False   -- start with window unmapped (hidden)
   , allDesktops      = True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest     = False   -- choose widest display (multi-monitor)
   , persistent       = True    -- enable/disable hiding (True = disabled)

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoff
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands =
        -- weather monitor
        [ Run Weather "ULLI" [ "--template", "<skyCondition>\
                                             \<fc=#4682B4><tempC></fc>°\
                                             \<fc=#4682B4><rh></fc>%\
                                             \<fc=#4682B4><pressure></fc>hPa"
                             ] 36000

        -- network activity monitor (dynamic interface resolution)
        , Run DynNetwork     [ "--template" , "<dev>: <tx>kB/s|<rx>kB/s"
                             , "--Low"      , "1000"       -- units: B/s
                             , "--High"     , "5000"       -- units: B/s
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

        -- cpu activity monitor
        , Run MultiCpu       [ "--template" , "Cpu: <total0>%|<total1>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

        -- cpu core temperature monitor
        -- core0 is package temp ( average )
        , Run CoreTemp       [ "--template" , "<core0>°"
        -- |<core1>°C|<core2>°C|<core3>°C|<core4>°C"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 50

        -- memory usage monitor
        , Run Memory         [ "--template" , "<used>"
                             , "--Low"      , "200"        -- units: %
                             , "--High"     , "7000"        -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

        -- battery monitor
        , Run Battery        [ "--template" , "<acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkgreen"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o", "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O", "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i", "<fc=#006000>Charged</fc>"
                             ] 50

        -- time and date indicator
        --   (%F = y-m-d date, %a = day of week, 12h format %IMSp = h:m:s time)
        , Run Date           "<fc=#ABABAB>%a %I:%M:%S%p %d-%m-%Y</fc>" "date" 10

        -- keyboard layout indicator
        , Run Kbd            [ ( "us", "<fc=#00FF00>US</fc>" )
                             , ( "ru", "<fc=#00FF00>RU</fc>" )
                             ]
        -- workspace indicator
        , Run StdinReader

--        , Run Com "/bin/python3" [ "/home/tomilin/.xmonad/scripts/parse.py"
--                                 ] "currency" 36000 -- 60min refresh

        , Run PipeReader "/home/$USER/.xmonad/scripts/volume-info" "volume"

        , Run Com "/bin/bash" [ "/home/tomilin/.xmonad/scripts/getUptime.sh"
                              ] "uptime1" 36000
        ]
   }
