﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Windows10SetupScript.Classes
{
    internal static class CONST
    {
        internal static readonly string W10SS_GitHub = "https://github.com/farag2/Windows-10-Setup-Script";

        internal static readonly string LANG_EN = "en";
        internal static readonly string LANG_RU = "ru";

        internal static readonly string PS_EXTENSION = ".ps1";

        internal static readonly string Hamburger_MaxWidth_RU = "panelHamburgerRuMaxWidth";
        internal static readonly string Hamburger_MaxWidth_EN = "panelHamburgerEnMaxWidth";

        internal static readonly string ToggleSwitch_State_RU_ON = "ToggleSwitchStateRuOn";
        internal static readonly string ToggleSwitch_State_RU_OFF = "ToggleSwitchStateRuOff";
        internal static readonly string ToggleSwitch_State_EN_ON = "ToggleSwitchStateEnOn";
        internal static readonly string ToggleSwitch_State_EN_OFF = "ToggleSwitchStateEnOff";

        internal static readonly string Animation_Hamburger_REOPEN = "animationHamburgerReOpenPanel";
        internal static readonly string Animation_Hamburger = "animationHamburgerPanel";

        internal static readonly string Resources_Dictionaries_TAGS = "/Resource/tags.xaml";

        internal static readonly int Window_MinHeight = 728;
                
        internal static readonly string Ofd_Ext = "w10ss";
        internal static readonly string Ofd_Filter = $"Win10 Setup Script Settings (*.{Ofd_Ext})|*.{Ofd_Ext}";
        internal static readonly string Ofd_FileName = null;

        internal static readonly string Sfd_FileName = $"*.{Ofd_Ext}";
        internal static readonly string InfoPanel_WarningTriangle = "iconInfoPanelWarningTriangle";
        internal static readonly object InfoPanel_NoPsFilesFound = "textInfoPanelPsFilesNotFound";

        internal static readonly int Win10_Major = 10;
        internal static readonly int Win10_Build = 15063;
    }
}