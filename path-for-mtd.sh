#!/bin/bash

rm path.pdb
rm mat*
rm *.xvg

# Generate path for metadynamics using times from snap-times.txt

nlines=$(wc -l snap-times.txt | awk '{print $1}')

 for ((line=1; line<=$nlines; line++))  # line is line number of the file snap-times.txt
 do
  time=$(awk -v line="$line" 'NR==line {print}' snap-times.txt)
  echo 1 | gmx  trjconv -s inactive-6.pdb -f ../abl1_ed_fit.xtc -b $time -e $time -o $time.pdb  #extract full protein
  grep CA $time.pdb > $time-ca.pdb
  cat $time-ca.pdb >> path.pdb
  echo "END" >> path.pdb
 done

 # concatenate active structure at the end of the path

echo 1 | gmx  trjconv -s inactive-6.pdb -f active-6.pdb -o active.pdb  #extract full protein
grep CA active.pdb > abl1-ca-active.pdb
cat abl1-ca-active.pdb >> path.pdb
echo "END" >> path.pdb
sed -i 's/1.00  0.00/1.00  1.00/g' path.pdb

sed -i 's/TER//g' path.pdb 
sed -i 's/ENDMDL//g' path.pdb 
sed -i '/^$/d' path.pdb  # Delete Empty lines

