#while true;
#do
	#xsetroot -name " [   $(date | cut -d' ' -f1,2,3) ] [   $(date | cut -d' ' -f4,5) ] [ 墳$(pactl get-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo | sed -n 1p | cut -d"/" -f4)] [  "$(cat /sys/class/power_supply/BAT0/capacity)"] [  $(free -m | sed -n 2p | cut -d" " -f21,22)]"
#  xsetroot -bg blue -fg black -name "$(date +%c)"
#  sleep 1
#done

#!/bin/sh

yt(){
    ytsubs=$(cat ~/.cache/ytcount)
    echo "Subscribers:$ytsubs"
}

batt() {
  bat=$(cat /sys/class/power_supply/BAT0/capacity)
  emot="🔋"
  echo "$emot $bat"
}

vol(){
	vo=$(pactl get-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo | cut -d"/" -f2 | head -n1)
	vf=$(echo $vo)
	vmot="🔉"
	echo "$vmot $vf"
}

dat() {

#time=$(date +"%b %d, %R")

time=$(date +%d-%h-%Y-%A)
datemot="📅"

echo "$datemot $time"

}

tame() {
	ta=$(date +%I:%M)
	tmot="⏰"
	echo "$tmot $ta"
}


while true
do
    xsetroot -name "$(yt) | $(dat) | $(tame) | $(vol) | $(batt) "
done 

