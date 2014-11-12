# adapted from z1lt0id https://github.com/z1lt0id/awesome/blob/master/thecat.sh

#!/bin/bash

f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'
inv=$'\e[7m'

gtkrc="$HOME/.gtkrc-2.0"
GtkTheme=$( grep "gtk-theme-name" "$gtkrc" | cut -d\" -f2 )
GtkIcon=$( grep "gtk-icon-theme-name" "$gtkrc" | cut -d\" -f2 )
GtkFont=$( grep "gtk-font-name" "$gtkrc" | cut -d\" -f2 )

function wm {

	if [ "$(pidof awesome)" ]
  		then
     		echo $(awesome -v | head -1)
	elif [ "$(pidof dwm)" ]
		then
			echo "Suzie's dwm"
	else
		echo "ask Suzie"
	fi

}

KERNEL=$(uname -r)
PACKAGES=$(pacman -Q | wc -l)
FPACKAGES=$(pacman -Qqm | wc -l)
RAM=$(free -h |awk '/Mem:/ { print $3 }')

# Other

function root
{
	echo -e "$(df -h | awk '/sda4/ {print $3}') / $(df -h | awk '/sda4/{print $2}')"
}

function data
{
	echo -e "$(df -h | awk '/sda7/ {print $3}') / $(df -h | awk '/sda7/{print $2}')"
}

function home
{
	echo -e "$(df -h | awk '/sda6/ {print $3}') / $(df -h | awk '/sda6/{print $2}')"
}

function var
{
	echo -e "$(df -h | awk '/sda5/ {print $3}') / $(df -h | awk '/sda5/{print $2}')"
}


cat << EOF   
$bld                                           
$f7                                                  
$f7                    .c0N.   .'c.                  $H the$f4 Suzie's$f1 cat
$f7         'Okdl:'  ;OMMMMKOKNMMW:;o0l  .'.          
$f7         ;MMMMMMWWMMMMMMMMMMMMMMMMMXKWMMK         $f6 $USER $f7@ $f1$HOSTNAME
$f7         'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK         
$f7          NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO         $f2 Shell     »$f4 bash
$f7          dMMMMMMMMMMMMMMMMMMMMMMMMMMMMM:         $f2 Editor    »$f4 $EDITOR
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM.         $f2 Packages  »$f4 $PACKAGES $f1($FPACKAGES)$NC
$f7          'MMMMMMMMMMMMMMMMMMMMMMMMMMMMM;         $f2 Ram       »$f4 $RAM$NC
$f7          lMMMMM  MMMMMMMMMM  MMMMMMMMMM,         $f2 Root      »$f4 $(root)
$f7          KMMMMM  MMMMMMMMMM  MMMMMMMMMM.         $f2 Home      »$f4 $(home)
$f7         ;WMMMMMkNMMMMMMMMMMONMMMMMMMMMW:         $f2 Data      »$f4 $(data)
$f7       oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO        $f2 Var       »$f4 $(var)
$f7      .,cxKWMMMMMMMMMMMMMMMMMMMMMMMMMMMXdxo        
$f7         ;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMM:          
$f7        .::,  .;ok0NMMMMWNK0kdoc;'  'cxK0         $f1 Kernel »$f4 $KERNEL$NC
$f1                   .:cc:;;.                        WM »$f4 $(wm)
$f1                   .o0MMMK'                        @  »$f7 Arch Linux
$f1                     xMMM:                         
$f1                     KMMMl                        
$f1                    .MMMMo                        
$f1                    ,MMMMx                        
$f1                    oMMMMx                        
$f1                    OMMMMO                        $f2 Be optimistic$f7, you idiot!
$f1                    .OMMMd                                                
$f1                      :Nl       

EOF
