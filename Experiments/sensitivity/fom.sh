if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name"
	exit 2
fi

subject=$1
count=1
cwd=`pwd`
senFile="sensitivity.txt"
#rm -f $senFile

#echo "Configuring available operators for each src file"
#while read src; do
#	echo "$src $count.c"
#	gcc -E -o $count.c ../chamber/$subject/src/$src
#	rm -f op$count.txt
#	while read opr; do
#		echo $opr > operator.txt
#		#echo $opr
#		../milu -m operator.txt $count.c >/dev/null 2>&1
#		if [ $? -eq 0 ]; then
#			echo $opr >> op$count.txt
#		fi
#	done < ../operators.txt
#	((count=count+1))
#done < ../chamber/$subject/srcList.txt
#rm -f operator.txt
#
count=1
echo "Evaluating First Order Mutants"
while read src; do
	echo "$src $count.c"
#	gcc -E -o $count.c ../chamber/$subject/src/$src
#	if [ $count -le 14 ]; then
#		((count=count+1))
#		continue
#	fi
	if [ ! -f op$count.txt ]; then
		((count=count+1))
		continue
	fi
	../milu -i -m op$count.txt $count.c >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		mut=0
		while read line; do
			((mut=mut+1))
			cp milu_output/mutants/$mut/src/$count.c ../chamber/$subject/src/$src
			cd ../chamber
			read usrTime sysTime memory correct <<< $(./eval.sh $subject 0)
			time=$(echo "$usrTime+$sysTime" | bc)
			cd $cwd
			echo $count $line $time $memory $correct >> $senFile
		done < milu_output/mid.txt
		cp ../../Subjects/$subject/src/$src ../chamber/$subject/src/$src
	fi
	((count=count+1))
done < ../chamber/$subject/srcList.txt

java -cp ../searchEngine.jar executable.AnalyseFOM sensitivity.txt template.txt

