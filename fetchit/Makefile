CC = gcc

LUA_PC = $(shell (pkg-config --exists lua5.4 && echo lua5.4) || \
				 				 (pkg-config --exists lua-5.4 && echo lua-5.4) || \
				 				 (pkg-config --exists lua && echo lua))

ifeq ($(LUA_PC),)
$(error could not find a lua 5.4 pkg-config package)
endif

CFLAGS = $(shell pkg-config --cflags $(LUA_PC)) -I src -Wall -Wextra -O2
LIBS = $(shell pkg-config --libs $(LUA_PC))

TARGET = build/fetchit

SRC = src/main.c \
      src/dispatcher.c \
      src/util.c \
      $(wildcard src/modules/*.c)

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

CONFIG_DST = $(HOME)/.config/fetchit

all:
	@mkdir -p build
	$(CC) $(SRC) $(CFLAGS) -o $(TARGET) $(LIBS)

install: all
	@echo "installing fetchit to $(DESTDIR)$(BINDIR)"
	@mkdir -p $(DESTDIR)$(BINDIR)
	@cp $(TARGET) $(DESTDIR)$(BINDIR)/fetchit

install-config:
	@echo "copying default config to $(CONFIG_DST)"
	@mkdir -p $(CONFIG_DST)
	@cp -rn config/* $(CONFIG_DST)/ || true

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/fetchit

clean:
	rm -rf build
