.PHONY: compile test deps

SRC_FILES := $(basename $(shell find fnl -type f -name "*.fnl" ! -name "macros.fnl" | cut -d'/' -f2-))

compile:
	rm -rf lua
	for f in $(SRC_FILES); do \
		mkdir -p lua/$$(dirname $$f); \
		deps/Fennel/fennel scripts/internal/compile.fnl fnl/$$f.fnl > lua/$$f.lua; \
	done
	mkdir -p lua/aniseed/deps
	cp fnl/aniseed/macros.fnl lua/aniseed
	cp deps/Fennel/fennel.lua lua/aniseed/deps/fennel.lua
	cp deps/Fennel/fennelview.lua lua/aniseed/deps/fennelview.lua
	cp deps/nvim.lua/lua/nvim.lua lua/aniseed/deps/nvim.lua

test:
	SUFFIX="test/fnl/foo.fnl" scripts/test.sh

deps:
	# TODO Set Fennel to a tag >v0.5.0 when released.
	scripts/dep.sh bakpakin Fennel 28af6c4377942f368585a4233714fb30d0c4ad16
	scripts/dep.sh norcalli nvim.lua 5d57be0b6eea6c06977b1c5fe0752da909cf4154
	cd deps/Fennel && make fennel
