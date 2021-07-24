/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const int startwithgaps[]    = { 1 };	/* 1 means gaps are used by default, this can be customized for each tag */
static const unsigned int gappx[]   = { 12 };   /* default gap between windows in pixels, this can be customized for each tag */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 24;       /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const char *fonts[]          = { "noto sans:size=10", "Font Awesome 5 Free Solid:style=Solid:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static const unsigned int systraypinning = 1;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 4;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
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
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { WHITE, BLACK, BLACK },
	[SchemeSel]  = { AZURE, BLACK,  AZURE  },
};

/* tagging */
static const char *tags[] = { "cdm", "www", "im", "mail", "dev", "media", "vm", "doc" };

static const Rule rules[] = {
	/* class               instance    title       tags mask     isfloating   monitor */
	{ "Firefox",           NULL,       NULL,       1 << 1,       False,       -1 },
	{ "VirtualBox",        NULL,       NULL,       1 << 6,       False,       -1 },
	{ "Pcmanfm",           NULL,       NULL,       1 << 5,       False,       -1 },
	{ "File-roller",       NULL,       NULL,       1 << 5,       False,       -1 },
	{ "Evince",            NULL,       NULL,       1 << 7,       False,       -1 },
	{ "Qpdfview",          NULL,       NULL,       1 << 7,       False,       -1 },
	{ "plugin-container",  NULL,       NULL,       1 << 1,       True,        -1 },
    { "Spotify", 		   NULL,  	   NULL,       1 << 5,       True,        -1 },
    { "Google-chrome", 	   NULL,  	   NULL,       1 << 1,       False,	 	  0 },

};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int decorhints  = 1;    /* 1 means respect decoration hints */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};


static const char *const autostart[] = {
	"feh", "--bg-scale", "/mnt/Data/Wallpapers/moon.jpg", NULL,
	"slstatus", NULL,
	NULL /* terminate */
};

/* key definitions */
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },


#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", WHITE, "-nf", WHITE, "-sb", WHITE, "-sf", WHITE, NULL };

static const char *launcher[] = { "rlaunch", NULL };
static const char *touchpadcmd[] = { "/bin/sh", "/home/ilusi0n/.scripts/touchpad_toggle", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *chrome[]   = { "google-chrome-stable", NULL, "Google-chrome-stable" };
static const char *file[]  = { "pcmanfm", NULL };
static const char *gvim[]     = { "gvim", NULL };
static const char *upvol[] = { "/bin/sh", "/home/ilusi0n/.scripts/sound", "up", NULL };
static const char *downvol[] = { "/bin/sh", "/home/ilusi0n/.scripts/sound", "down", NULL };
static const char *upbri[] = { "light", "-A", "10", NULL };
static const char *downbri[] = { "light", "-U", "10", NULL };
static const char *print[] = { "/bin/sh", "/home/ilusi0n/.scripts/print",NULL};
static const char *lock[]  = { "/bin/sh", "/home/ilusi0n/.scripts/lock", NULL };
static const char *togglevol[] = { "/bin/sh", "/home/ilusi0n/.scripts/sound", "toggle", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ ALTKEY,                       XK_c,      spawn,     	   {.v = chrome } },
	{ ALTKEY,                       XK_2,      spawn,          {.v = file } },
	{ ALTKEY,                       XK_g,      spawn,          {.v = gvim } },
    { ALTKEY,                       XK_z,      spawn,          {.v = touchpadcmd } },
	{ ALTKEY,                       XK_m,      spawn,          {.v = togglevol } },
	{ ControlMask|ALTKEY,           XK_l,      spawn,          {.v = lock } },
	{ ControlMask,                  XK_Up,     spawn,          {.v = upvol} },
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
	{ MODKEY,                       XK_u,      focusurgent,    {0} },
	{ MODKEY,                       XK_space,  cyclelayout,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,           			XK_Left,   shiftviewclients, { .i = -1 } },
    { MODKEY,           			XK_Right,  shiftviewclients, { .i = +1 } },
	{ MODKEY,             			XK_g,  	   setgaps,        {.i = GAP_TOGGLE} },
	{ MODKEY,                       XK_y,      togglefullscreen, {0} },
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
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[0]} },
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
	{ ClkClientWin,         MODKEY,         Button1,        moveorplace,  	{.i = 1} },
};

