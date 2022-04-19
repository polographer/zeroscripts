START=`date`
echo "started sync at ${START} "  
#cd ~/projects/bulk-downloader-for-reddit
#python3 -m bdfr download ~/downloads/rddownload/ --saved --authenticate --user me --no-dupes --search-existing --file-scheme 'post_{REDDITOR}_{POSTID}'
#cpuuse=$(cat /proc/loadavg | awk '{print $3}'|cut -f 1 -d ".")
cpuuse=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'| cut -f 1 -d "."` 
if [ "$cpuuse" -ge 30 ]; then
	echo "load is too high ${cpuuse}%, aborting"
else
	users=`users | wc -w`
	opts=""
	if [  "$users" -eq "0"  ]; then
		echo "Heavy process started"
		opts="--search-existing"
	fi	
	python3 -m bdfr download ~/Downloads/rddownload2/ --saved --authenticate --user me --no-dupes ${opts} --folder-scheme '{REDDITOR}' --file-scheme '{SUBREDDIT}_{POSTID}'
fi
END=`date`
echo "ended at ${END}"
