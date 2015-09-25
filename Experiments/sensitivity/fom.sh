if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name"
	exit 0
fi

subject=$1
count=1

while read src; do
	echo "$src $count.c"
	gcc -E -o $count.c ../chamber/$subject/src/$src
	../milu -i $count.c
	((count=count+1))
done < ../chamber/$subject/srcList.txt
