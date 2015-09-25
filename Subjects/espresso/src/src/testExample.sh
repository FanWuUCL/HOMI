for case in `ls ../examples/`; do
	./espresso ../examples/$case > null.txt
done
