if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name"
	exit 2
fi

subject=$1
count=1
cwd=`pwd`
senFile="sensitivity.txt"
rm -f $senFile

while read src; do
	echo "$src $count.c"
	gcc -E -o $count.c ../chamber/$subject/src/$src
	../milu -i $count.c >/dev/null 2>&1
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
