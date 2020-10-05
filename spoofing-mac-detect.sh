#! /usr/bin/bash

for file in `ls -1 *.pcap`; do
	
	MACS=`tshark -r $file -T fields -Y ip -e ip.src -e eth.src | sort | uniq | tr "\t" " "`
	echo "$MACS" > "$file"_MACS.txt
	echo "############################################################################"
	echo "Searching for IP addresses with duplicate MAC addresses"
	echo "Results will output in *_MAC_Spoofing_Results.txt file"
	echo "############################################################################"
	RESULTS=`awk '{if (x[$1]) { x_count[$1]++; print $0; if (x_count[$1] == 1) { print x[$1] } } x[$1] = $0}' "$file"_MACS.txt`
	echo "$RESULTS" > "$file"_MAC_Spoofing_Results.txt
done 
