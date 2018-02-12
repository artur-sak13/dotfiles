#!/bin/sh
SYS=$(uname -s)
FULL=▓
EMPTY=░
EOL=▒ 
SIZE=7
C0="#000000"
C1="#222222"
C2="#1C596E"
C3="#B3291C"
C4="#3A3A3A"
C5="#efefef"
C6="#878787"
C7="#8787af"

draw()
{
	perc=$1
	SIZE=$2
	inc=$(( perc * SIZE / 100 ))
	out=
	thiscolor=
	for v in `seq 0 $(( SIZE - 1 ))`; do
		test "$v" -le "$inc"   \
		&& out="${out}#[fg=$C1]${FULL}" \
		|| out="${out}#[fg=$C1]${EMPTY}"
	done
	echo $out
}
temp()
{
	if [ "$SYS" == "Darwin" ]; then
		temp=$(istats cpu temp --value-only | awk '{s=$1} END {print int(s)}')
	else
		temp=$(sensors | awk '/Core\ 0/ {gsub(/\+/,"",$3); gsub(/\..+/,"",$3); print $3}')
	fi

	tempColor=$C0
	case 1 in
		$((temp <= 50)))
			tempColor=$C2
			;;
		$((temp >= 75)))
			tempColor=$C3
			;;
	esac
	echo "#[fg=$tempColor]${temp}°c"
	
}
bat() {
	echo $(istats battery charge --value-only)"%"
}
cpu()
{
	if [ "$SYS" == "Darwin" ]; then
		ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f", s}'
	else
		CPU_USE=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
		echo $(printf "%.0f" $CPU_USE)
	fi

}
mem()
{
	if [ "$SYS" == "Darwin" ]; then
		ps -A -o %mem | awk '{s+=$1} END {print int(s)}'
	else
		free | awk '/Mem:/ {print int($3/$2 * 100.0)}'
	fi
}
clock()
{
	mtime=$(date +'%H:%M')
	myear=$(date +'%Y-%m-')
	mday=$(date +'%d')
	echo "#[fg=$C5]#[bg=$C4] $mtime #[fg=$C6]$myear#[fg=$C5]$mday #[fg=$C6]$EOL"
}
front()
{
	echo "#[bg=$C7]#[fg=$C1]▓░"
}
CPU_INFO=`cpu`
RAM_INFO=`mem`
echo `front` `bat` `draw $RAM_INFO 4` `temp` `draw $CPU_INFO 7` `clock`