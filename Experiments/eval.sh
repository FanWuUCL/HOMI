if [ $# -lt 2 ]; then
	echo "Invoke script followed with subject name, and whether it is the original"
	exit 0
fi

subject=$1

cd $subject/src
make -s >/dev/null 2>&1
cd ../../

if [ -f $subject/src/$subject ]; then
	cp $subject/src/$subject subject
else
	cp $subject/src/src/$subject subject
fi
cp $subject/testcases.txt testcases.txt

cp -r $subject/testcases .

if [ ! -d curr ]; then
	mkdir curr
fi

./memory $2
