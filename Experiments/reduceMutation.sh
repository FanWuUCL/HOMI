if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name"
	exit 2
fi

subject=$1
cwd=`pwd`

#clean up
cp operators_A.txt operators.txt
rm -rf chamber/population*
java -cp ./searchEngine.jar analyse.ReduceMutation $subject.pareto.all.txt chamber/

cd chamber
index=0
while [ -d population$index ]; do
	echo population$index
	mv population$index population
	./evalAll.sh $subject
	mv population population$index
	((index=index+1))
done
cd ..
