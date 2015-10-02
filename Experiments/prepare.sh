if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name"
	exit 2
fi

subject=$1
cwd=`pwd`

echo preparing $subject

cp eval.sh chamber/eval.sh
cp -r ../Subjects/$subject/ chamber/
cd chamber
cp $subject/testcases.txt testcases.txt
cp -r $subject/testcases .
if [ ! -d curr ]; then
	mkdir curr
fi
cd ..

cp ../Subjects/$subject/subjectSetting.h ../memory/src/
cd ../memory/src
rm -f memory
make -s
if [ -f memory ]; then
	cp memory $cwd/chamber/
	cd ..
	gcc -shared -fPIC -O3 -o libmalloc.so malloc.c
	cp libmalloc.so $cwd/chamber/
	cp libmalloc.so $cwd/chamber/$subject/src/
	if [ -d $cwd/chamber/$subject/src/src ]; then
		cp libmalloc.so $cwd/chamber/$subject/src/src/
	fi
	cd $cwd/chamber
	./eval.sh $subject 1
else
	echo compiling memory failed.
	exit 1
fi

cd $cwd


