if [ $# -lt 1 ]; then
	echo "Invoke script followed with subject name"
	exit 2
fi

subject=$1
rm -rf all.csv all.txt

for exp in data/$1*; do
	echo $exp
	rm -rf $exp/all.csv $exp/pareto.csv $exp/pareto.txt
	java -cp ./searchEngine.jar analyse.ParetoFront $exp/
	cat $exp/pareto.txt >> all.txt
done

java -cp ./searchEngine.jar analyse.ParetoFront all.txt
mv pareto.txt $subject.pareto.txt
