#!/usr/bin/bash

for i in 1 2 3
do
sed '/^[#$@]/d' ../full/20mus/$i-20mus.xvg > test.xvg
awk '{print $2}' test.xvg > values1.dat
awk '{print $1}' test.xvg > time.dat
sed '/^[#$@]/d' ../tm/20mus/$i-20mus.xvg > test2.xvg
awk '{print $2}' test2.xvg > values2.dat
paste -d '\t' time.dat values1.dat values2.dat > $i-full-tm.dat
done
rm values*.dat
rm time.dat
rm test*.xvg

for i in {1..3}
do	
perl sort_values.pl "$i-full-tm.dat";
mv 1.dat 1-$i.dat;
mv 2.dat 2-$i.dat;
mv 3.dat 3-$i.dat;
mv 4.dat 4-$i.dat;
done

echo "DONE with PERRRLLLLL\n"

for i in 1 2 3
do
for j in {1..4}
do
`cat $j-$i.dat | wc -l >> count-$i.dat`	
done
done

paste -d '\t' count-1.dat count-2.dat count-3.dat > count-all.dat

awk '{ for(i=1; i<=NF;i++) j+=$i; print j/3; j=0 }' count-all.dat > input.dat

python piechart_readin.py input.dat

#awk '(($2 < 0.6 || $2 == 0.6) && ($3 < 0.6 || $3 == 0.6)) {print }' full-tm.dat  > full-tm-le06.dat
#awk '(($2 < 0.6 || $2 == 0.6) && ($3 > 0.6) && ($3 < 1.5 || $3 == 1.5)) {print }' full-tm.dat  > full-tm-le15ge06.dat
#awk '(($2 > 0.6) && ($3 > 1.5)) {print }' full-tm.dat  > full-tm-ge15ge06.dat
#echo "less than 0.6 :" >> $i-ans.txt
#echo " " >> $i-ans.txt
#echo "greater than 1.2 :" >> $i-ans.txt
#awk '$2 > 1.2 {print }' test.xvg  | wc -l >> $i-ans.txt
#rm test.xvg
#done

