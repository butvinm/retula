.PHONY: build
build:
	mkdir -p build
	rlc --rich retula.ref -o build/retula


.PHONY: run
run: build
	./build/retula inc.rtl
