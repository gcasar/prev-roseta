.PHONY=mmix %.run %.exec
XSLDIR=$(ROOT)xsl

CC=java -jar prev.jar --xsldir=$(XSLDIR)
ASM=mmixware/mmixal
RUN=mmixware/mmix

mmix:
	git clone https://gitlab.lrz.de/mmix/mmixware.git mmixware
	(cd mmixware && make basic)

%.run: %.mmo
	$(RUN) $<

%.exec: %.prev
	$(CC) --phase=exec $<

%.mmo : %.mms
	$(ASM) $<

%.mms : %.prev
	$(CC) --phase=build $<

%.imcode.xml : %.prev
	$(CC) --phase=imcode --loggedphases=imcode $<

%.frames.xml : %.prev
	$(CC) --phase=frames --loggedphases=frames $<

%.seman.xml : %.prev
	$(CC) --phase=seman --loggedphases=seman $<

%.abstr.xml	: %.prev
	$(CC) --phase=abstr --loggedphases=abstr $<

%.synan.xml	: %.prev
	$(CC) --phase=synan --loggedphases=synan $<

%.lexan.xml	: %.prev
	$(CC) --phase=lexan --loggedphases=lexan $<

clean:
	find . -name \*.xml -type f -delete
	find . -name \*.mmo -type f -delete
	find . -name \*.mms -type f -delete
