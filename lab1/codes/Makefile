CC = iverilog

all: CPU.out

define _test
	@cp ./testdata/instruction_$(1).txt ./instruction.txt
	@./CPU.out >/dev/null
	diff ./output.txt ./testdata/output_$(1).txt
endef

test: CPU.out
	$(call _test,1)
	$(call _test,2)
	$(call _test,3)

CPU.out:
	$(CC) *.v -o $@

.PHONY: clean
clean:
	rm -rf CPU.out CPU.vcd instruction.txt output.txt
