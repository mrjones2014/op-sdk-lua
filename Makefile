default: bulid

.PHONY: build
build:
	luarocks build --lua-version=5.1

.PHONY: test
test:
	luarocks test --lua-version=5.1

.PHONY: test-verbose
test-verbose:
	luarocks test --lua-version=5.1 --verbose
