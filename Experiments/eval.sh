if [ $# -lt 2 ]; then
	echo "Invoke script followed with subject name, and whether it is the original"
	exit 2
fi

subject=$1

rm -f subject
rm -f $subject/src/$subject
rm -f $subject/src/src/$subject

cd $subject/src
if [ -f configure ] && [ $2 -eq 1 ]; then
	./configure > /dev/null 2>&1
fi
make -s >/dev/null 2>&1
cd ../../

if [ -f $subject/src/$subject ]; then
	cp $subject/src/$subject subject
elif [ -f $subject/src/src/$subject ]; then
	cp $subject/src/src/$subject subject
else
	echo 0 0 0 1
	exit 1
fi

./memory $2
