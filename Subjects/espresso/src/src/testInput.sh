for case in `ls ../Input/`; do
	./espresso -t ../Input/$case > null.txt
done
