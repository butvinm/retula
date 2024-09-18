.PHONY: build
build:
	mkdir -p build
	rlmake -d src --tmp-dir build src/Retula.ref -o build/retula


.PHONY: test
test: build
	python tests/rere.py replay tests/test.list


.PHONY: test
test-record: build
	python tests/rere.py record tests/test.list
