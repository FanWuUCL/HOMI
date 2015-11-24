if [ $# -lt 4 ]; then
        echo "Invoke script followed with subject name, population size, generation, and repetition times"
        exit 2
fi

subject=$1
populationSize=$2
generation=$3
repTimes=$4

cd chamber
runIndex=0
while [ $runIndex -lt $repTimes ]; do
	./run.sh $subject $populationSize $generation
	((runIndex=runIndex+1))
done
cd ..
