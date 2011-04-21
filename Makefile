CC=clang
LLVM_FLAGS=-arch i386 -c -D_FORTIFY_SOURCE=0 -emit-llvm -Iupskirt/src -Iupskirt/render
EMS=emscripten/emscripten.py
JS_ENGINE=d8

all:		upskirt_ems.js

.PHONY:		all clean

upskirt_ems.js: upskirt.ll
	$(EMS) $^ $(JS_ENGINE) > $@

upskirt.ll: markdown.ll.o array.ll.o buffer.ll.o xhtml.ll.o js_wrap.ll.o
	llvm-link $^ | llvm-dis -show-annotations > $@

# housekeeping
clean:
	rm -f *.o
	rm -f upskirt.ll upskirt_ems.js

# generic object compilations
%.ll.o: upskirt/src/%.c
	$(CC) $(LLVM_FLAGS) -o $@ $<

xhtml.ll.o: upskirt/render/xhtml.c
	$(CC) $(LLVM_FLAGS) -o $@ $<

js_wrap.ll.o: js_wrap.c
	$(CC) $(LLVM_FLAGS) -o $@ $<

