SEJDA_DOWNLOAD_URL := https://github.com/torakiki/sejda/releases/download/v2.6/sejda-console-2.6-bin.zip

.PHONY: install clean

install:
	$(eval TMP := $(shell mktemp))
	wget -O $(TMP) $(SEJDA_DOWNLOAD_URL)
	unzip $(TMP)
	mv sejda-console-* sejda

clean:
	rm -rf "2016-09-24 Das Spektakel"/*
	git checkout -- "2016-09-24 Das Spektakel"
