if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name"
	exit 2
fi

subject=$1
count=1

while read func; do
	echo -ne $func > functest.txt
	../milu -f functest.txt -m ../operators.txt $count.c >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo $func
	fi
done < ../chamber/$subject/func$count.txt
