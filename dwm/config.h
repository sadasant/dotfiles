/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            = "-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*";
static const char normbordercolor[] = "#121212"; // 233
static const char normbgcolor[]     = "#121212"; // 233
static const char normfgcolor[]     = "#585858"; // 240
static const char selbordercolor[]  = "#1C1C1C"; // 234
static const char selbgcolor[]      = "#262626"; // 235
static const char selfgcolor[]      = "#FFFFFF"; // 255
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            True,        -1 },
 	{ "Firefox",  NULL,       NULL,       0,            False,       -1 },
// 	{ "Firefox",  NULL,       NULL,       1 << 8,       False,       -1 },
	{ "Xmessage", NULL,       NULL,       ~0,           True,        -1 },
};

/* layout(s) */
static const float mfact      = 0.55;  /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;     /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */ // Set this to false to remove the gap at the bottom.

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "urxvt", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },   // dmenu
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },    // open termnial
	{ MODKEY,                       XK_b,      togglebar,      {0} },                // toggle bar
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },         // focus next
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },         // focus previous
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },         // level of horizontal / vertical split
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },         // level of horizontal / vertical split
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },       // depending on the incmaster, expands or contacts windows
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },       // depending on the incmaster, expands or contacts windows
	{ MODKEY,                       XK_Return, zoom,           {0} },                // Switch ho's in the main window
	{ MODKEY,                       XK_Tab,    view,           {0} },                // Switch between the current and the last visited window
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },                // Kills the window
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} }, // Tiling mode
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} }, // Fixed mode?
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} }, // Maximised mode
	{ MODKEY,                       XK_space,  setlayout,      {0} },                // Switch modes
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },                // Switch floating mode
//	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },        // View n desktop
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },        // Move current window to n desktop (0 for all)
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },         // Don't know!! D:
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },         // Don't know!! D:
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },         // Don't know!! D:
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },         // Don't know!! D:
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
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

