if [ $# -lt 1 ]; then
        echo "Invoke script followed with subject name"
        exit 2
fi

subject=$1

rm -rf population/newProperty.txt

for mut in `ls population`;do
	if [ -d population/$mut ]; then
		srcIndex=1
		while read src; do
			if [ -f population/$mut/$srcIndex.mid.txt ]; then
				rm -rf milu_output
				../milu --mut-strategy=restore --mid_path population/$mut/$srcIndex.mid.txt -m ../operators.txt ../sensitivity/$srcIndex.c
				if [ -f milu_output/mutants/1/src/$srcIndex.c ]; then
					cp milu_output/mutants/1/src/$srcIndex.c $subject/src/$src
				fi
			fi
			((srcIndex=srcIndex+1))
		done < $subject/srcList.txt
		echo -ne '.'
		read usrTime sysTime memory correct <<< $(./eval.sh $subject 0)
        time=$(echo "$usrTime+$sysTime" | bc)
        echo $mut $time $memory $correct >> population/newProperty.txt
        ## restore the original subject sources
        while read src; do
        	cp ../../Subjects/$subject/src/$src $subject/src/$src
		done < $subject/srcList.txt
	fi
done
echo -ne '\n'
