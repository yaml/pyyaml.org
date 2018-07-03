ALL_INDEXES := \
    download \
    download/libyaml \
    download/pysyck \
    download/pyyaml \
    download/pyyaml-legacy \

default:

update: update-wiki update-indexes

update-wiki:
	make -C wiki update

update-indexes:
	./bin/update-index-html.pl $(ALL_INDEXES)
