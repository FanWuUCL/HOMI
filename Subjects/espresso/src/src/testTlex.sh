for case in `ls ../tlex/`; do
	./espresso ../tlex/$case > null.txt
done
