if [ $# -lt 1 ]; then
	echo "Invoke script with a subject name"
	exit 0
fi

subject=$1
cwd=`pwd`

echo preparing $subject

cp -r ../Subjects/$subject/ chamber/
cp ../Subjects/$subject/subjectSetting.h ../memory/src/
cd ../memory/src
rm -f memory
make
if [ -f memory ]; then
	cp memory $cwd/chamber/
else
	echo compiling memory failed.
	exit 0
fi
cd $cwd


