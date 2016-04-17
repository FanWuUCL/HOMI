if [ $# -lt 1 ]; then
        echo "Invoke script followed with subject name"
        exit 2
fi

subject=$1

cp -r ${subject}_population_for_deep chamber/population
cd chamber
cp libmalloc.so libmalloc.so.bkp

cp ../${subject}_malloc/libmalloc.so0 libmalloc.so
./evalAll.sh $subject
cp population/newProperty.txt population/property.0

cp ../${subject}_malloc/libmalloc.so1 libmalloc.so
./evalAll.sh $subject
cp population/newProperty.txt population/property.1

cp ../${subject}_malloc/libmalloc.so0 libmalloc.so
./evalAll.sh $subject
cp population/newProperty.txt population/property.2

cp libmalloc.so.bkp libmalloc.so
