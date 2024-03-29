if [ $# -lt 1 ]; then
	echo "Invoke script followed by subject name"
	exit 0
fi

subject=$1

gcc -shared -fPIC -O3 -o libmalloc.so malloc.c

cp libmalloc.so $subject/src/libmalloc.so
cd $subject/src
make clean
make
cd ../../

if [ -f $subject/src/$subject ]; then
	cp $subject/src/$subject subject
elif [ -f $subject/src/src/$subject ]; then
	cp $subject/src/src/$subject subject
else
	echo Cannot find the subject
	exit 1
fi
cp $subject/subjectSetting.h src/subjectSetting.h
cp $subject/testcases.txt testcases.txt
if [ -d testcases ]; then
	rm -r testcases
fi

cp -r $subject/testcases .

if [ ! -d curr ]; then
	mkdir curr
fi
	
cd src
make
cp memory ../memory
cd ..

./memory
