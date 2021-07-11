#define NUMCOLORS       11
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },
    
static const unsigned int tagspacing = 1;       /* space between tags */
static const unsigned int tagpadding = 5;      /* inner padding of tags */
static const unsigned int taglinepx = 2;        /* height of tag underline */
static const unsigned int systrayspacing = 1;   /* systray spacing */
static const Bool showsystray = True;           /* false means no systray */
static const unsigned int gappx = 8;            /* gaps between windows */
static const unsigned int borderpx = 1;         /* border pixel of windows */
static const unsigned int snap = 32;            /* snap pixel */
static const Bool showbar = True;               /* false means no bar */
static const Bool topbar = True;                /* false means bottom bar */
static const float mfact = 0.50;                /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;                   /* number of clients in master area */
static const Bool resizehints = False;          /* true means respect size hints in tiled resizals */
//static const char font[] = "-*-tamsynmod-medium-r-*-*-18-*-*-*-*-*-*-*";
static const char font[]          = { "monospace:size=10" };


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

static const char colors[NUMCOLORS][ColLast][13] = {
/* border  foreground  background */
  {  BLACK, WHITE,    BLACK },  // 1 = normal
  {  ORANGE,  WHITE,    BLACK },  // 2 = selected
  {  BLACK, RED,     BLACK },  // 3 = urgent
  {  BLACK, GRAY,    BLACK },  // 4 = occupied
  {  BLACK, ORANGE,  BLACK },
  {  BLACK, LIGHT_GREEN,   BLACK },
  {  BLACK, PURPLE,  BLACK },
  {  BLACK, LIGHT_BLUE,  BLACK },
  {  BLACK, AZURE,  BLACK },
  {  BLACK, LIGHT_ORANGE,  BLACK },
  {  BLACK, BLUE,  BLACK },
};

static const Layout layouts[] = {
    /* symbol   gaps    arrange */
    { "[T]",    True, tile },	
    { "[Bs]",   True, bstack },
    { "[M]",    False, monocle },
    { "[G]",    True, gaplessgrid },
    { "[F]",    False,  NULL },
};

static const Tag tags[] = {
  /* name      layout         mfact    nmaster */
  { "cmd",     &layouts[0],   -1,      -1 },
  { "www",     &layouts[2],   -1,      -1 },
  { "im",      &layouts[2],   -1,      -1 },
  { "mail",    &layouts[0],   -1,      -1 },
  { "dev",     &layouts[0],   -1,      -1 },
  { "media",   &layouts[0],   -1,      -1 },
  { "vm",      &layouts[2],   -1,      -1 },
  { "doc",     &layouts[2],   -1,      -1 },

};

static const Rule rules[] = {
	/* class               instance    title       tags mask     isfloating isCenter  	monitor */
	{ "Firefox",           NULL,       NULL,       1 << 1,       False,     False,     -1 },
	{ "Opera",             NULL,       NULL,       1 << 1,       False,     False,     -1 },
	{ "Skype",             NULL,       NULL,       1 << 2,       False,     False,     -1 },
	{ "Viber",             NULL,       NULL,       1 << 2,       False,     False,     -1 },
	{ "Pidgin",            NULL,       NULL,       1 << 2,       False,     False,     -1 },
	{ "Thunderbird",       NULL,       NULL,       1 << 3,       False,     False,     -1 },
	{ "Gmpc",              NULL,       NULL,       1 << 5,       False,     False,     -1 },
	{ "VirtualBox",        NULL,       NULL,       1 << 6,       False,     False,     -1 },
	{ "Pcmanfm",           NULL,       NULL,       1 << 5,       False,     False,     -1 },
	{ "File-roller",       NULL,       NULL,       1 << 5,       False,     False,     -1 },
	{ "Qbittorrent",       NULL,       NULL,       1 << 5,       False,     False,     -1 },
	{ "Tixati",            NULL,       NULL,       1 << 5,       False,     False,     -1 },
	{ "Evince",            NULL,       NULL,       1 << 7,       False,     False,     -1 },
	{ "Qpdfview",          NULL,       NULL,       1 << 7,       False,     False,     -1 },
	{ "plugin-container",  NULL,       NULL,       1 << 1,       True,      False,     -1 },
	{ "Eclipse",           NULL,       NULL,       1 << 4,       False,     False,     -1 },
	{ "Eclipse",           NULL,       NULL,       1 << 4,       False,     False,     -1 },
    { "Spotify", 		   NULL,  	   NULL,       1 << 5,       True,      False,     -1 },
    { "Google-chrome", 	   NULL,  	   NULL,       1 << 2,       False,		False,   	0 },

};

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *launcher[] = { "rlaunch", NULL };
static const char *touchpadcmd[] = { "/bin/sh", "/home/ilusi0n/.scripts/touchpad_toggle", NULL };
static const char *termcmd[]  = { "alacritty", NULL };
static const char *chrome[]   = { "google-chrome-stable", NULL, "Google-chrome-stable" };
static const char *thunar[]  = { "thunar", NULL };
static const char *qbittorrent[]  = { "qbittorrent", NULL };
static const char *gvim[]     = { "gvim", NULL };
static const char *lock[]  = { "/bin/sh", "/home/ilusi0n/.scripts/lock", NULL };
static const char *upvol[] = { "/bin/sh", "/home/ilusi0n/.scripts/sound", "up", NULL };
static const char *downvol[] = { "/bin/sh", "/home/ilusi0n/.scripts/sound", "down", NULL };
static const char *upbri[] = { "light", "-A", "10", NULL };
static const char *downbri[] = { "light", "-U", "10", NULL };
static const char *print[] = { "/bin/sh", "/home/ilusi0n/.scripts/print",NULL};

#include <X11/XF86keysym.h>

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ ALTKEY,                       XK_c,      runorraise,     {.v = chrome } },
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
	{ MODKEY,                       XK_u,      focusurgent,    {0} },
	{ MODKEY,                       XK_space,  nextlayout,     {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,           			XK_Left,   cycle,          {.i = -1} },
    { MODKEY,           			XK_Right,  cycle,          {.i = +1} },
	{ MODKEY|ShiftMask,             XK_Left,   tagcycle,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Right,  tagcycle,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Up,     pushup,         {0} },
    { MODKEY|ShiftMask,             XK_Down,   pushdown,       {0} },
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
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[0]} },
	{ ClkStatusText,        0,              Button4,        spawn,          {.v = upvol } },
	{ ClkStatusText,        0,              Button1,        focusstack,     {.i = -1} },
	{ ClkStatusText,        0,              Button3,        nextlayout,     {0} },
	{ ClkStatusText,        0,              Button5,        spawn,          {.v = downvol } },	
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkClientWin,         MODKEY,         Button1,        tilemovemouse,  {0}	},
};
