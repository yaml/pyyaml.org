.PHONY: all

MD = $(shell find . -name '*.md')
HTML = $(MD:.md=.html)

all: $(HTML)

%.html: %.md
	pandoc --standalone --self-contained --smart --css normalize.css --css pandoc.css $< -o $@

clean:
	rm -f $(HTML)
