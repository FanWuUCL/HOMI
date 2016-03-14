if [ $# -lt 1 ]; then
	echo "Invoke script followed with subject name"
	exit 2
fi

subject=$1

for exp in data/$1*; do
	echo $exp
	rm -rf $exp/all.csv
	for generation in $exp/population*; do
	  if [[ $generation = *population0 ]]; then
	  	continue;
	  fi
	  cat $generation/newProperty.txt >> $exp/all.csv
	  while read line; do
	  	pos=`expr index "$line" :`
	  	echo old ${line:$pos} >> $exp/all.csv
	  done < $generation/oldPopulation.txt
	done
done
