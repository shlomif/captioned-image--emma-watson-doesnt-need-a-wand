SVG = emma-watson-wandless.svg
PNG = $(SVG).png
JPEG = $(SVG).jpg

PHOTO_BASE = d5au0ao-20c1308d-c41b-4723-b561-ad7a6dade3a8
PHOTO_DEST = $(PHOTO_BASE).jpg

WIDTH = 400

all: $(PNG) $(JPEG) $(PHOTO_DEST)

$(PNG): $(SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=400 $<
	optipng $@

$(JPEG): $(PNG)
	convert $(PNG) $(JPEG)

$(PHOTO_DEST): $(PHOTO_BASE).webp
	gm convert $< $@

# upload: all
#	rsync --progress -v -a --inplace human-hacking-field-guide-logo.svg hhfg-ad.svg hhfg-ad.svg.png $(__HOMEPAGE_REMOTE_PATH)/hhfg-graphics-demo/
