if [ $# -lt 1 ]; then
        echo "Invoke script followed with subject name"
        exit 2
fi

subject=$1
srcIndex=1
while read src; do
	cp sensitivity/$srcIndex.c chamber/$subject/src/$src
	((srcIndex=srcIndex+1))
done < chamber/$subject/srcList.txt
