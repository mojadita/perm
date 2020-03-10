# Makefile -- build recipe for perm.
# Author: Luis Colorado <luiscoloradourcola@gmail.com>
# Date: Tue Mar 10 05:31:54 EET 2020
# Copyright: (C) 2020 Luis Colorado.  All rights reserved.
# License: BSD

targets		= perm
toclean		= $(targets)
RM		   ?= rm -f

perm_objs	= perm.o
toclean	   += $(perm_objs)

all: $(targets)
clean:
	$(RM) $(toclean)

perm: $(perm_deps) $(perm_objs)
	$(CC) $(LDFLAGS) -o $@ $($@_objs)
