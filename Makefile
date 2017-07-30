PREFIX = /usr/local

.PHONY: all custom install uninstall clean mrproper

# Default keybinds are to media keys.
all: mrproper xonard xonarctl

# Calling "make custom" will make the xonar knob send special keystrokes.
# See the README about how to bind them to custom controls.
custom: mrproper xonard-custom xonarctl
	mv xonard-custom xonard

#Giant scroll wheel
scroller: mrproper xonard-scroller xonarctl
	mv xonard-scroller xonard

xonard-custom-opts = -D KEYBIND_CUSTOM=1
xonard-scroller-opts = -D KEYBIND_SCROLLER=1

xonard xonard-custom xonard-scroller: xonard.c
	gcc -Wall $(CFLAGS) $($@-opts) -o $@ $^

xonarctl: xonarctl.c
	gcc -Wall $(CFLAGS) -o $@ $^

install: xonard xonarctl uninstall
	cp -a 16-asus-xonar-u1.rules /etc/udev/rules.d/
	cp -a 16-asus-xonar-u1.sh /etc/pm/sleep.d/
	cp -a xonard $(DESTDIR)$(PREFIX)/bin/xonard
	cp -a xonarctl $(DESTDIR)$(PREFIX)/bin/xonarctl

uninstall:
	rm -rf /etc/udev/rules.d/16-asus-xonar-u1.rules
	rm -rf /etc/pm/sleep.d/16-asus-xonar-u1.sh
	killall -q xonard | true
	rm -rf $(DESTDIR)$(PREFIX)/bin/xonard
	rm -rf $(DESTDIR)$(PREFIX)/bin/xonarctl

clean:
	rm -rf *.o

mrproper: clean
	rm -f xonard
	rm -f xonarctl
