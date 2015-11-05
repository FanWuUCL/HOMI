if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name, and (optional) dir to the source files, e.g. 'src/'"
	exit 2
fi

if [ $# -gt 1 ]; then
	srcDir=$2
else
	srcDir=""
fi
subject=$1
cwd=`pwd`
srcL="srcList.txt"
funCov="funcov.txt"
funcTmp="func.txt"

cd ../Subjects/$subject/src/

count=0
rm -rf $srcL
for file in `ls ./$srcDir`; do
	if [[ $file = *.c ]]; then
		gcov -f ${srcDir}$file > $funCov
		rm -rf $funcTmp
		flag=0
		while read line; do
			if [[ $line = Function* ]]; then
				funcName=${line:10:$((${#line}-11))}
				read line
				if [[ ! $line = *0.00%* ]]; then
					echo $funcName >> $funcTmp
					flag=1
				fi
			elif [[ $line = File* ]]; then
				echo $line
				break
			fi
		done < $funCov
		if [ $flag -eq 1 ]; then
			count=$(($count+1))
			echo $srcDir$file >> $srcL
			cp $funcTmp ../func$count.txt
			if [ -d $cwd/chamber/$subject ]; then
				cp $funcTmp $cwd/chamber/$subject/func$count.txt
			fi
		fi
	fi
done
cp $srcL ../$srcL
if [ -d $cwd/chamber/$subject ]; then
	cp $srcL $cwd/chamber/$subject/$srcL
fi

cd $cwd
