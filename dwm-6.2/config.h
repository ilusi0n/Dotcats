/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>
#include "include_patches.h"

#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 8;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10", "Noto Color Emoji:style=Regular"  };
static const char dmenufont[]       = "Inconsolata:size=12";

#define BLUE   "#00BFFF"
#define WHITE  "#cdcdcd"
#define BLACK  "#000000"
#define ORANGE "#ff8c00"
#define RED    "#ff0000"
#define GRAY   "#666666"
#define PURPLE "#BF5FFF"
#define LIGHT_GREEN "#76EE00"
#define LIGHT_BLUE "#7DC1CF"
#define AZURE "#80d9d8"
#define LIGHT_ORANGE "#FFA07A"
#define LIGHT_GREEN2 "#78AB46"


static const char *colors[][12]      = {
	/*               fg         		bg         border   */
	[SchemeNorm] = { WHITE, 		  BLACK, 	  BLACK },
	[SchemeSel]  = { ORANGE, 		  BLACK,   	  BLACK },
	[SchemeWarn] = { GRAY, 			  BLACK, 	  BLACK },
	[SchemeUrgent] ={ RED, 			  BLACK,      BLACK },
	[SchemeCol1] = { ORANGE, 		  BLACK,   	  BLACK },
	[SchemeCol2] = { LIGHT_GREEN, 	  BLACK,      BLACK },
	[SchemeCol3] = { PURPLE, 		  BLACK,   	  BLACK },
	[SchemeCol4] = { LIGHT_BLUE, 	  BLACK,      BLACK },
	[SchemeCol5] = { AZURE, 		  BLACK,      BLACK },
	[SchemeCol6] = { LIGHT_ORANGE, 	  BLACK,      BLACK },
	[SchemeCol7] = { LIGHT_GREEN2, 	  BLACK,      BLACK },
	[SchemeCol8] = { WHITE, 		  BLACK,      BLACK },
	[SchemeCol9] = { WHITE, 		  BLACK,      BLACK },
};


/* tagging */
static const char *tags[] = { "cmd", "www", "im", "mail", "dev", "media", "vm", "doc" };

static const Rule rules[] = {
	/* class               instance    title       tags mask     isfloating  	monitor */
	{ "Firefox",           NULL,       NULL,       1 << 1,       False,         -1 },
	{ "Opera",             NULL,       NULL,       1 << 1,       False,         -1 },
	{ "Skype",             NULL,       NULL,       1 << 2,       False,         -1 },
	{ "Viber",             NULL,       NULL,       1 << 2,       False,         -1 },
	{ "Pidgin",            NULL,       NULL,       1 << 2,       False,         -1 },
	{ "Thunderbird",       NULL,       NULL,       1 << 3,       False,         -1 },
	{ "Gmpc",              NULL,       NULL,       1 << 5,       False,         -1 },
	{ "VirtualBox",        NULL,       NULL,       1 << 6,       False,         -1 },
	{ "Thunar",            NULL,       NULL,       1 << 5,       False,         -1 },
	{ "File-roller",       NULL,       NULL,       1 << 5,       False,         -1 },
	{ "Qbittorrent",       NULL,       NULL,       1 << 5,       False,         -1 },
	{ "Tixati",            NULL,       NULL,       1 << 5,       False,         -1 },
	{ "Evince",            NULL,       NULL,       1 << 7,       False,         -1 },
	{ "Qpdfview",          NULL,       NULL,       1 << 7,       False,         -1 },
	{ "plugin-container",  NULL,       NULL,       1 << 1,       True,          -1 },
	{ "Eclipse",           NULL,       NULL,       1 << 4,       False,         -1 },
	{ "Eclipse",           NULL,       NULL,       1 << 4,       False,         -1 },
    { "Spotify", 		   NULL,  	   NULL,       1 << 5,       True,        	-1 },
    { "Google-chrome", 	   NULL,  	   NULL,       1 << 1,       False,   		0 },

};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
/* 0 */	{ "[]=",      tile },    /* first entry is default */
/* 1 */	{ "><>",      NULL },    /* no layout function means floating behavior */
/* 2 */	{ "[M]",      monocle },
///* 3 */	{ "TTT",      bstack },
///* 4 */	{ "===",      bstackhoriz },
		{ NULL,       NULL },
};

/* key definitions */
#define CONTROLKEY ControlMask
#define MODKEY Mod4Mask     /* Mod 4 --> Super */
#define HOLDKEY 0xffeb	    /* Keysym for Super_L. Check other keysyms with `xev'. */
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", WHITE, "-nf", WHITE, "-sb", WHITE, "-sf", WHITE, NULL };


/* commands */
static const char *launcher[] = { "rlaunch", NULL };
static const char *touchpadcmd[] = { "/bin/sh", "/home/ilusi0n/.scripts/touchpad_toggle", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *chrome[]   = { "google-chrome-stable", NULL, "Google-chrome-stable" };
static const char *firefox[]   = { "firefox", NULL, "firefox" };
static const char *thunar[]  = { "thunar", NULL };
static const char *gvim[]     = { "gvim", NULL };
static const char *lock[]  = { "/bin/sh", "/home/ilusi0n/.scripts/lock", NULL };
static const char *upvol[] = { "/bin/sh", "/home/ilusi0n/.scripts/sound", "up", NULL };
static const char *downvol[] = { "/bin/sh", "/home/ilusi0n/.scripts/sound", "down", NULL };
static const char *upbri[] = { "light", "-A", "10", NULL };
static const char *downbri[] = { "light", "-U", "10", NULL };
static const char *print[] = { "/bin/sh", "/home/ilusi0n/.scripts/print",NULL};


static Key keys[] = {
	/* modifier                     key        function        argument */
	{ ALTKEY,                       XK_c,      spawn,     	   {.v = chrome } },
	{ ALTKEY,                       XK_f,      spawn,     	   {.v = firefox } },
	{ ALTKEY,                       XK_2,      spawn,          {.v = thunar } },
	{ ALTKEY,                       XK_g,      spawn,          {.v = gvim } },
    { ALTKEY,                       XK_z,      spawn,          {.v = touchpadcmd } },
	{ ControlMask|ALTKEY,           XK_l,      spawn,          {.v = lock } },
	{ 0,              XF86XK_AudioRaiseVolume, spawn,          {.v = upvol} },
	{ ControlMask,                  XK_Up,     spawn,          {.v = upvol} },
    { 0,              XF86XK_AudioLowerVolume, spawn,          {.v = downvol} },
	{ ControlMask,                  XK_Down,   spawn,          {.v = downvol} },
	{ MODKEY,                       XK_r,      spawn,          {.v = launcher } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ 0,                            XK_Print,  spawn,          {.v = print } },
    { ControlMask,           		XK_Left,   spawn,          {.v = downbri } },
    { ControlMask,           		XK_Right,  spawn,          {.v = upbri } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ ALTKEY,                       XK_Tab,    focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },	
	{ ControlMask,                  XK_space,  killclient,     {0} },
	{ MODKEY,                       XK_space,  cyclelayout,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,           			XK_Left,   shiftviewclients,          { .i = +1 } },
    { MODKEY,           			XK_Right,  shiftviewclients,          { .i = +1 } },
	{ MODKEY,                       XK_f,      fullscreen,      {0} },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        cyclelayout,    {.i = +1 } },
	{ ClkStatusText,        0,              Button4,        spawn,          {.v = upvol } },
	{ ClkStatusText,        0,              Button1,        focusstack,     {.i = -1} },
	{ ClkStatusText,        0,              Button3,        cyclelayout,    {.i = +1 } },
	{ ClkStatusText,        0,              Button5,        spawn,          {.v = downvol } },	
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

