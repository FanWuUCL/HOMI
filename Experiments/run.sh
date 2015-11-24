if [ $# -lt 3 ]; then
        echo "Invoke script followed with subject name, population size, generation"
        exit 2
fi

subject=$1
populationSize=$2
generation=$3
initialSize=1000
timeFile="timeStamps.txt"

#clean up
rm -rf population*
date > $timeFile

echo Initialising population
echo Initialising population >> $timeFile
date
java -cp ../searchEngine.jar executable.GenerateRandom ../sensitivity/template.txt $initialSize population/
./evalAll.sh $subject
mv population population0

genIndex=0

while [ $genIndex -lt $generation ]; do
	echo Generation $genIndex
	date
	date >> $timeFile
	echo Generation $genIndex >> $timeFile
	java -cp ../searchEngine.jar executable.Evolve ../sensitivity/template.txt population$genIndex/ $populationSize population/
	./evalAll.sh $subject
	((genIndex=genIndex+1))
	mv population population$genIndex
done

date
date >> $timeFile

saveDir=$1`date +%Y%m%d%H%M`
echo "Saving results to data/$saveDir"
if [ ! -d ../data ]; then
	mkdir ../data
fi
if [ -d ../data/$saveDir ]; then
	rm -rf ../data/$saveDir
fi
mkdir ../data/$saveDir
cp -r population* ../data/$saveDir/
cp $timeFile ../data/$saveDir/$timeFile
cp ../sensitivity/template.txt ../data/$saveDir/template.txt
