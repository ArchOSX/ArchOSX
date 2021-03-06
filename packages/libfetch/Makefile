prefix = /opt/arch
DESTDIR =
DEBUG = false
FETCH_WITH_INET6 = true
FETCH_WITH_OPENSSL = true

WARNINGS = -Wall -Wstrict-prototypes -Wsign-compare -Wchar-subscripts \
	   -Wpointer-arith -Wcast-align
CFLAGS   = -O2 -pipe -I. -fPIC $(WARNINGS) \
	   -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGE_FILES

CFLAGS	+= -DFTP_COMBINE_CWDS -DNETBSD

ifeq ($(strip $(FETCH_WITH_INET6)), true)
CFLAGS+=	-DINET6
endif

ifeq ($(strip $(FETCH_WITH_OPENSSL)), true)
CFLAGS+=	-DWITH_SSL
LDFLAGS=	-L/opt/arch/lib -lc -lssl -lcrypto
endif

ifeq ($(strip $(DEBUG)), true)
CFLAGS += -g -DDEBUG
else
CFLAGS += -UDEBUG
endif

CC = gcc
LD = ld
AR = ar
RANLIB = ranlib
INSTALL = install -c -D

OBJS= fetch.o common.o ftp.o http.o file.o
INCS= fetch.h common.h
GEN = ftperr.h httperr.h
MAN = libdownload.3

#pretty print!
E = @/bin/echo
Q = @

#all: libfetch.so libfetch.a
all: libfetch.dylib libfetch.a
        $(E) "  built with:  " $(CFLAGS)
.PHONY: all

%.o: %.c $(INCS) $(GEN)
	$(E) "  compile   " $@
	$(Q) $(CC) $(CFLAGS) -c $<

ftperr.h: ftp.errors Makefile errlist.sh
	$(E) "  generate  " $@
	$(Q) ./errlist.sh ftp_errlist FTP ftp.errors > $@

httperr.h: http.errors Makefile errlist.sh
	$(E) "  generate  " $@
	$(Q) ./errlist.sh http_errlist HTTP http.errors > $@

#libfetch.so: $(GEN) $(INCS) $(OBJS)
#	$(E) "  build     " $@
#	$(Q) rm -f $@
#	$(Q) $(LD) $(LDFLAGS) *.o -o $@
#	$(E) "  built with:  " $(CFLAGS)

libfetch.dylib: $(GEN) $(INCS) $(OBJS)
	$(E) "  build     " $@
	$(Q) rm -f $@
	$(Q) $(LD) -dylib -install_name ${prefix}/lib/$@ $(LDFLAGS) *.o -o $@


libfetch.a: $(GEN) $(INCS) $(OBJS)
	$(E) "  build     " $@
	$(Q) rm -f $@
	$(Q) $(AR) rcs $@ *.o
	$(Q) $(RANLIB) $@
	$(E) "  built with:  " $(CFLAGS)

clean:
	$(E) "  clean     "
	$(Q) rm -f libfetch.dylib libfetch.a *.o $(GEN)
.PHONY: clean

install: all
	$(Q) $(INSTALL) -m 755 libfetch.dylib $(DESTDIR)$(prefix)/lib/libfetch.dylib
	$(Q) $(INSTALL) -m 644 libfetch.a $(DESTDIR)$(prefix)/lib/libfetch.a
	$(Q) $(INSTALL) -m 644 fetch.h $(DESTDIR)$(prefix)/include/fetch.h
	$(Q) $(INSTALL) -m 644 fetch.3 $(DESTDIR)$(prefix)/share/man/man3/fetch.3
.PHONY: install

uninstall:
	$(Q) rm -f $(DESTDIR)$(prefix)/lib/libfetch.dylib
	$(Q) rm -f $(DESTDIR)$(prefix)/lib/libfetch.a
	$(Q) rm -f $(DESTDIR)$(prefix)/include/fetch.h
	$(Q) rm -f $(DESTDIR)$(prefix)/share/man/man3/fetch.3
.PHONY: uninstall
