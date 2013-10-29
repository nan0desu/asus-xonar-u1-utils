all: xonard xonarctl

xonard: xonard.c
	gcc -Wall $(CFLAGS) -o $@ $^

xonarctl: xonarctl.c
	gcc -Wall $(CFLAGS) -o $@ $^

install: xonard xonarctl
	cp -a 16-asus-xonar-u1.rules $(DESTDIR)/etc/udev/rules.d/
	cp -a 16-asus-xonar-u1.sh $(DESTDIR)/etc/pm/sleep.d/
	cp -a xonard $(DESTDIR)/usr/bin/
	cp -a xonarctl $(DESTDIR)/usr/bin/

uninstall:
	rm -rf /etc/udev/rules.d/16-asus-xonar-u1.rules
	rm -rf /etc/pm/sleep.d/16-asus-xonar-u1.sh
	rm -rf /usr/local/bin/xonard
	rm -rf /usr/local/bin/xonarctl

clean:
	rm -rf *.o

mrproper: clean
	rm -f xonard
	rm -f xonarctl
