.PHONY: build
build:
	mkdir -p build
	rlmake --tmp-dir build Retula.ref -o build/retula


.PHONY: run
run: build
	./build/retula inc.rtl


.PHONY: test
test: build
	python tests/rere.py replay tests/test.list
