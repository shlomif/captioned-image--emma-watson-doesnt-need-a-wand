SVG = emma-watson-wandless.svg
PNG = $(SVG).png
JPEG = $(SVG).jpg
WEBP = $(SVG).webp

THIRD_PERSON_SVG = emma-watson-wandless--3rd-tense.svg
THIRD_PERSON_PNG = $(THIRD_PERSON_SVG).png
THIRD_PERSON_JPEG = $(THIRD_PERSON_SVG).jpg
THIRD_PERSON_WEBP = $(THIRD_PERSON_SVG).webp

PHOTO_BASE = d5au0ao-20c1308d-c41b-4723-b561-ad7a6dade3a8
PHOTO_INTERIM1 = $(PHOTO_BASE)-step1.png
PHOTO_DEST = $(PHOTO_BASE).jpg

WIDTH = 400

all: $(PNG) $(JPEG) $(WEBP) $(PHOTO_DEST) $(THIRD_PERSON_PNG) $(THIRD_PERSON_WEBP) $(THIRD_PERSON_JPEG) $(THIRD_PERSON_PNG)

$(PNG): $(SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=800 $<
	optipng $@

$(WEBP): $(PNG)
	gm convert $< $@

$(JPEG): $(PNG)
	gm convert $< $@

$(THIRD_PERSON_PNG): $(THIRD_PERSON_SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=800 $<
	optipng $@

$(THIRD_PERSON_WEBP): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(THIRD_PERSON_JPEG): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(PHOTO_INTERIM1): $(PHOTO_BASE).webp
	gm convert -crop 2560x1177 $< $@

$(PHOTO_DEST): $(PHOTO_INTERIM1)
	gm convert $< $@

# upload: all
#	rsync --progress -v -a --inplace human-hacking-field-guide-logo.svg hhfg-ad.svg hhfg-ad.svg.png $(__HOMEPAGE_REMOTE_PATH)/hhfg-graphics-demo/
