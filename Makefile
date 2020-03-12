# Makefile -- build recipe for perm.
# Author: Luis Colorado <luiscoloradourcola@gmail.com>
# Date: Tue Mar 10 05:31:54 EET 2020
# Copyright: (C) 2020 Luis Colorado.  All rights reserved.
# License: BSD

targets     = perm perm.1.gz
toclean     = $(targets)
RM         ?= rm -f
GZIP       ?= gzip -v
USR        ?= `id -u`
GRP        ?= `id -g`
prefix     ?= $(HOME)
bindir     ?= $(prefix)/bin
datadir    ?= $(prefix)/share
mandir     ?= $(datadir)/man
man1dir    ?= $(mandir)/man1
fperm      ?= 644
xperm      ?= 711


perm_objs   = perm.o
toclean    += $(perm_objs)

all: $(targets)
clean:
	$(RM) $(toclean)
install: $(targets)
	-$(INSTALL) -d $(bindir)
	-$(INSTALL) -d $(man1dir)
	-$(INSTALL) -o $(USR) -g $(GRP) -m $(xperm) perm $(bindir)/perm
	-$(INSTALL) -o $(USR) -g $(GRP) -m $(fperm) perm.1.gz $(man1dir)/perm.1.gz
deinstall:
	-$(RM) $(bindir)/perm $(man1dir)/perm.1.gz

.SUFFIXES: .1 .1.gz

.1.1.gz:
	$(GZIP) <$< >$@

perm: $(perm_deps) $(perm_objs)
	$(CC) $(LDFLAGS) -o $@ $($@_objs)
