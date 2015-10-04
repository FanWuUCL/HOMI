if [ $# -lt 3 ]; then
        echo "Invoke script followed with subject name, population size, generation"
        exit 2
fi

subject=$1
populationSize=$2
generation=$3

#clean up
rm -rf population*

java -cp ../searchEngine.jar executable.GenerateRandom ../sensitivity/template.txt $populationSize population/
./evalAll.sh $subject
mv population population0

genIndex=0

while [ $genIndex -lt $generation ]; do
	echo Generation $genIndex
	java -cp ../searchEngine.jar executable.Evolve ../sensitivity/template.txt population$genIndex/ $populationSize population/
	./evalAll.sh $subject
	((genIndex=genIndex+1))
	mv population population$genIndex
done
