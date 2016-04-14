if [ $# -lt 1 ]; then
        echo "Invoke script followed with subject name"
        exit 2
fi

subject=$1

cd chamber

for mut in `ls population`;do
	if [ -d population/$mut ]; then
		srcIndex=1
		while read src; do
			if [ -f population/$mut/$srcIndex.mid.txt ]; then
				rm -rf milu_output population/$mut/$srcIndex.c population/$mut/$srcIndex.diff
				../milu --mut-strategy=restore --mid_path population/$mut/$srcIndex.mid.txt -f $subject/func$srcIndex.txt -m ../sensitivity/op$srcIndex.txt --debug=src ../sensitivity/$srcIndex.c > population/$mut/$srcIndex.c
				if [ -f milu_output/mutants/1/src/$srcIndex.c ]; then
					diff -U 0 population/$mut/$srcIndex.c milu_output/mutants/1/src/$srcIndex.c >> population/$mut/$srcIndex.diff
				fi
			fi
			((srcIndex=srcIndex+1))
		done < $subject/srcList.txt
	fi
done

cd ..
