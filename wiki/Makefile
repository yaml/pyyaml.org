ALL_MARKDOWN = $(shell find . -name '*.md')
ALL_HTML = $(ALL_MARKDOWN:.md=.html)

default:

update: $(ALL_HTML)

%.html: %.md
	pandoc \
	    --standalone \
	    --self-contained \
	    --from=markdown+smart \
	    --css=normalize.css \
	    --css=pandoc.css \
	    $< -o $@

clean:
	rm -f $(ALL_HTML)
