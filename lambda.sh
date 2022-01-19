#!/bin/bash

rm final-rmsd.txt

k=$(wc -l snap-times.txt | awk '{print $1}') # number of snapshots
z=$(($k+1)) # total_structures=n_snapshots+1 as active structure is included at the end

# collect rmsd between the cosecutive snapshots into the file final-rmsd.txt; 
# also collect the RMSD between the each snapshot to the target structure into the file rmsd-tar.xvg; these values should be continuosly decreasing
for ((i=1 ;i<=$z; i++))
do
 awk -v "var=$i" 'NR==var+1 {print}' mat$i.txt >> final-rmsd.txt
 tail -1 mat$i.txt >> rmsd-tar.xvg
done

# calculate lambda using RMSD between consecutive snapshots
awk -v "var=$k" '{sum+=$1*$1} END {print sum, (2.3*(var))/sum}' final-rmsd.txt > lambda.txt

