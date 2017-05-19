MAKEFLAGS = --no-print-directory

CHPL = chpl

TARGETS = \
	parmMultiply \
	matrixMultiply \
	disMM \


REALS = $(TARGETS:%=%_real)

default: all

all: $(TARGETS)

clean: FORCE
	rm -f $(TARGETS) $(REALS)

%: %.chpl
	$(CHPL) $< -o $@ 

FORCE:
