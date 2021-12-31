while true;
do
	xsetroot -name " [ $(date | cut -d' ' -f1,2,3,7) ] [ $(date | cut -d' ' -f4,5) ] [ $(pactl get-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo | sed -n 1p | cut -d"/" -f4)] [  "$(cat /sys/class/power_supply/BAT0/capacity)"] [  $(free -m | sed -n 2p | cut -d" " -f21,22)/$(free -m | sed -n 2p | cut -d" " -f13) ]"
done
