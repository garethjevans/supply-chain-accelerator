.PHONY: test build-all-options build-default-options clean

test: clean build-all-options build-default-options

build-all-options:
	./build-local.sh all-options

build-default-options:
	./build-local.sh default-options

clean:
	rm -fr generated

