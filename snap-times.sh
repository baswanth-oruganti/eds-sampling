#!/bin/bash

## This script extracts snapshot times from EDS such that RMSD between chosen consecutive frames lie within a narrow range: say 0.45-0.60 Å. Play with these limits in order to find optimal values


rm snap-time-mtd.txt
low_limit=0.45
up_limit=0.60 

for ((i=1; i<=501; i=$j))
do
  # check RMSD to target; if it is smaller than lower limit then we are done
  echo 3 3 | gmx rms -f pdb/$(($i-1)).pdb -s active-"6".pdb -o test.xvg
  rm '#'*
  rmsd=$(tail -1 test.xvg | awk '{print $2*10}')
  check=$(echo "$rmsd > $low_limit" | bc)
  if [ $check == 1 ] 
  then
   j=$(awk -v low="$low_limit" -v up="$up_limit" -v frame="$i" 'BEGIN {RS=""; FS="\n"} NR==frame {for(k=frame;k<=NF;k++){ if($k>=low && $k<=up){print k; break} } } END{}' rmsd-matrix/matrix.txt)
   echo $rmsd
   echo $(($i-1)) >> snap-times.txt
  else
   break
  fi
done

