/* See LICENSE file for copyright and license details. */


/* appearance */
static const char font[]  = "termsyn:size=10:antialias=true:hinting=true";

#define BLUE   "#00BFFF"
#define WHITE  "#cdcdcd"
#define BLACK  "#000000"
#define ORANGE "#ff8c00"
#define RED    "#ff0000"
#define GRAY   "#999999"
#define PURPLE "#BF5FFF"
#define LIGHT_GREEN "#76EE00"
#define LIGHT_BLUE "#7DC1CF"
#define AZURE "#80d9d8"
#define LIGHT_ORANGE "#FFA07A"


#define NUMCOLORS 10
static const char colors[NUMCOLORS][ColLast][16] = {
  /* border  foreground  background */
  {  BLACK, GRAY,    BLACK },  // 1 = normal
  {  BLUE,  BLUE,    BLACK },  // 2 = selected
  {  BLACK, RED,     BLACK },  // 3 = urgent
  {  BLACK, GRAY,    BLACK },  // 4 = occupied
  {  BLACK, ORANGE,  BLACK },
  {  BLACK, LIGHT_GREEN,   BLACK },
  {  BLACK, PURPLE,  BLACK },
  {  BLACK, LIGHT_BLUE,  BLACK },
  {  BLACK, AZURE,  BLACK },
  {  BLACK, LIGHT_ORANGE,  BLACK },


};

static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 0;        // Gap pixel between windows
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const Bool showsystray       = True;     /* False means no systray */

static const Rule rules[] = {
	/* class               instance    title       tags mask     isfloating   monitor */
	{ NULL,                "Google-chrome",       NULL,       1 << 1,       False,        -1 },
	{ "Firefox",           NULL,       NULL,       1 << 1,       False,        -1 },
	{ "Skype",             NULL,       NULL,       1 << 2,       False,        -1 },
	{ "Pidgin",            NULL,       NULL,       1 << 2,       False,        -1 },
	{ "Thunderbird",       NULL,       NULL,       1 << 3,       False,        -1 },
	{ "Gmpc",              NULL,       NULL,       1 << 5,       False,        -1 },
	{ "VirtualBox",        NULL,       NULL,       1 << 6,       False,        -1 },
	{ "Thunar",            NULL,       NULL,       1 << 5,       False,        -1 },
	{ "File-roller",       NULL,       NULL,       1 << 5,       False,        -1 },
	{ "Qbittorrent",       NULL,       NULL,       1 << 5,       False,        -1 },
	{ "Evince",            NULL,       NULL,       1 << 7,       False,        -1 },
	{ "plugin-container",  NULL,       NULL,       1 << 1,       True,         -1 },
	{ "Eclipse",           NULL,       NULL,       1 << 4,       False,        -1 },
    { "Google-chrome", "crx_nckgahadagoaajjgafhacjanaoiihapd",  NULL,       1 << 2,       False,        -1 },

};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     function */
	{ "[T]",      tile },    /* first entry is default */	
	{ "[Bs]",     bstack },
	{ "[M]",      monocle },
	{ "[G]",      gaplessgrid },
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ .symbol =   NULL,   .arrange = NULL    },
};

static const Tag tags[] = {
  /* name      layout         mfact    nmaster */
  { "cmd",     &layouts[0],   -1,      -1 },
  { "www",     &layouts[0],   -1,      -1 },
  { "im",      &layouts[3],   -1,      -1 },
  { "mail",    &layouts[0],   -1,      -1 },
  { "dev",     &layouts[0],   -1,      -1 },
  { "media",   &layouts[0],   -1,      -1 },
  { "vm",      &layouts[2],   -1,      -1 },
  { "doc",     &layouts[0],   -1,      -1 },

};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "/bin/sh", "/home/ilusi0n/.scripts/dmenu_run", NULL };
static const char *touchpadcmd[] = { "/bin/sh", "/home/ilusi0n/.scripts/touchpad_toggle", NULL };
static const char *termcmd[]  = { "termite", NULL };
static const char *chrome[]   = { "google-chrome-stable", "--disk-cache-dir=/tmp/chrome_cache", NULL };
static const char *firefox[]  = { "firefox", NULL };
static const char *thunar[]   = { "thunar", NULL };
static const char *pidgin[]   = { "nice", "pidgin", NULL };
static const char *gvim[]     = { "gvim", NULL };
static const char *skype[]    = { "nice", "skype", NULL };
static const char *thunderbird[]  = { "thunderbird", NULL };
static const char *gmpc[]  = { "nice", "gmpc", NULL };
static const char *lock[]  = { "i3lock", "-c", "111111", NULL };
static const char *playonlinux[]  = { "nice", "-n", "15","playonlinux", NULL };
/*
static const char *upvol[] = { "amixer", "set", "Master", "5%+", NULL};
static const char *downvol[] = { "amixer", "set", "Master", "5%-", NULL};
static const char *togglevol[] = { "amixer", "set", "Master", "toggle", "-q", NULL};
*/
static const char *upvol[] = { "ponymix", "-d", "0", "increase", "5", NULL };
static const char *downvol[] = { "ponymix", "-d", "0", "decrease", "5", NULL };
static const char *togglevol[] = { "ponymix", "-d", "0", "toggle", NULL};
static const char *print[] = { "/bin/sh", "/home/ilusi0n/.scripts/print",NULL};

#include "nplayout.c"
#include <X11/XF86keysym.h>

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ ALTKEY,                       XK_c,      spawn,          {.v = chrome } },
    { ALTKEY,                       XK_p,      spawn,          {.v = playonlinux } },
	{ ALTKEY,                       XK_f,      spawn,          {.v = firefox } },
	{ ALTKEY,                       XK_m,      spawn,          {.v = gmpc } },
	{ ALTKEY,                       XK_2,      spawn,          {.v = thunar } },
	{ ALTKEY,                       XK_p,      spawn,          {.v = pidgin } },
	{ ALTKEY,                       XK_g,      spawn,          {.v = gvim } },
	{ ALTKEY,                       XK_s,      spawn,          {.v = skype } },
    { ALTKEY,                       XK_z,      spawn,          {.v = touchpadcmd } },
	{ ALTKEY,                       XK_t,      spawn,          {.v = thunderbird } },
	{ ControlMask|ALTKEY,           XK_l,      spawn,          {.v = lock } },
	{ 0,              XF86XK_AudioRaiseVolume, spawn,          {.v = upvol} },
	{ ControlMask,                  XK_Up,     spawn,          {.v = upvol} },
    { 0,              XF86XK_AudioLowerVolume, spawn,          {.v = downvol} },
	{ ControlMask,                  XK_Down,   spawn,          {.v = downvol} },
    { 0,              XF86XK_AudioMute,        spawn,          {.v = togglevol} },
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ 0,                            XK_Print,  spawn,          {.v = print } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ ALTKEY,                       XK_Tab,    focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },	
	{ ControlMask,                  XK_x,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[4]} },
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
	{ MODKEY,                       XK_f,      togglemax,      {0} },
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

#include "tilemovemouse.c"

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[0]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button4,        spawn,          {.v = upvol } },
	{ ClkStatusText,        0,              Button5,        spawn,          {.v = downvol } },	
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkClientWin,         MODKEY,         Button1,        tilemovemouse,  {0} },
	{ ClkWinTitle,          0,              Button1,        focusstack,     {.i = -1 } },
};
