for case in `ls ../hard_examples/`; do
	./espresso ../hard_examples/$case > null.txt
done
