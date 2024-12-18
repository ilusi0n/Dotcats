/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 256
/*
 * if you want to change buffer size for each segment,
 * then change `BUFF_SZ` in util.h
 */


/*
 * function            description                     argument (example)
 *
 * battery_perc        battery percentage              battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_state       battery charging state          battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * battery_remaining   battery remaining HH:MM         battery name (BAT0)
 *                                                     NULL on OpenBSD/FreeBSD
 * cpu_perc            cpu usage in percent            NULL
 * cpu_freq            cpu frequency in MHz            NULL
 * datetime            date and time                   format string (%F %T)
 * disk_free           free disk space in GB           mountpoint path (/)
 * disk_perc           disk usage in percent           mountpoint path (/)
 * disk_total          total disk space in GB          mountpoint path (/")
 * disk_used           used disk space in GB           mountpoint path (/)
 * entropy             available entropy               NULL
 * gid                 GID of current user             NULL
 * hostname            hostname                        NULL
 * ipv4                IPv4 address                    interface name (eth0)
 * ipv6                IPv6 address                    interface name (eth0)
 * kernel_release      `uname -r`                      NULL
 * keyboard_indicators caps/num lock indicators        format string (c?n?)
 *                                                     see keyboard_indicators.c
 * keymap              layout (variant) of current     NULL
 *                     keymap                          (interval must be 1)
 * load_avg            load average                    NULL
 * netspeed_rx         receive network speed           interface name (wlan0)
 * netspeed_tx         transfer network speed          interface name (wlan0)
 * num_files           number of files in a directory  path
 *                                                     (/home/foo/Inbox/cur)
 * ram_free            free memory in GB               NULL
 * ram_perc            memory usage in percent         NULL
 * ram_total           total memory size in GB         NULL
 * ram_used            used memory in GB               NULL
 * run_command         custom shell command            command (echo foo)
 * swap_free           free swap in GB                 NULL
 * swap_perc           swap usage in percent           NULL
 * swap_total          total swap size in GB           NULL
 * swap_used           used swap in GB                 NULL
 * temp                temperature in degree celsius   NULL on OpenBSD and Linux
 *                                                     thermal zone on FreeBSD
 *                                                     (tz0, tz1, etc.)
 * uid                 UID of current user             NULL
 * uptime              system uptime                   NULL
 * username            username of current user        NULL
 * vol_perc            OSS/ALSA volume in percent      mixer file (/dev/mixer)
 * wifi_perc           WiFi signal in percent          interface name (wlan0)
 * wifi_essid          WiFi ESSID                      interface name (wlan0)
 *
 * EXTRA INFO:
 *
 * - every arg must ends with `END`
 *
 * - if you want to run function once (for example `hostname`),
 *   then set interval to `ONCE`
 *
 * EXTRA CONFIGS IN:
 *   - battery.c
 *   - volume.c
 */

/* for usleep */
#define _SEC *1000
#define _MIN *(60 _SEC)
#define _HR  *(60 _MIN)

#define ONCE ((unsigned int) -1)  /* to run */

// #define BLUE   "#00BFFF"
// #define WHITE  "#cdcdcd"
// #define BLACK  "#000000"
// #define ORANGE "#ff8c00"
// #define RED    "#ff0000"
// #define GRAY   "#666666"
// #define PURPLE "#BF5FFF"
// #define LIGHT_GREEN "#76EE00"
// #define LIGHT_BLUE "#7DC1CF"
// #define AZURE "#80d9d8"
// #define LIGHT_ORANGE "#FFA07A"
// #define LIGHT_GREEN2 "#78AB46"

static const char pulse_volume[] = "if [[ $(pamixer --get-mute) == 'true' ]]; then echo ; else echo  $(pamixer --get-volume)%; fi";
static const char weather[] = "awk '/$/' /tmp/weather";
static const char pacupdates[] = "awk '/$/' /tmp/pacupdates";

static struct arg_t args[] = {
	/* function format          argument */
	{ run_command,		    "^c#666666^[  ^c#00BFFF^ %s^c#666666^  ] ",        pacupdates,     		 20 _SEC, END },
	{ disk_perc,		    "^c#666666^[  ^c#BF5FFF^ %s%%^c#666666^  ] ",	    "/home/lanikai/Data",    60 _SEC, END },
	{ run_command,		    "^c#666666^[  ^c#7DC1CF^%s^c#666666^  ] ",	        weather,        		 20 _SEC, END },
	{ battery_perc,		    "^c#666666^[  ^c#76EE00^ %s%%^c#666666^  ] ",	    "BAT1",         		 30 _SEC, END },
	{ temp,		            "^c#666666^[  ^c#ff8c00^ %s^c#666666^  ] ",	    "/sys/class/thermal/thermal_zone0/temp", 2 _SEC, END },
	{ cpu_perc,		        "^c#666666^[  ^c#BF5FFF^ %s%%^c#666666^  ] ",	    NULL,          2 _SEC, END},
	{ run_command,		    "^c#666666^[  ^c#7DC1CF^ %s^c#666666^  ] ",	        pulse_volume,  2 _SEC, END },
	{ datetime,		        "^c#666666^[  ^c#76EE00^ %s^c#666666^  ]",	        "%a %b %d, %R", 1 _SEC, END },
	{ kernel_release,		"^c#666666^[  ^c#00BFFF^%s^c#666666^  ]",	        NULL,           ONCE, END },
};
