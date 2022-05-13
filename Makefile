SVG = emma-watson-wandless.svg
PNG = $(SVG).png
JPEG = $(SVG).jpg
WEBP = $(SVG).webp

THIRD_PERSON_SVG = emma-watson-wandless--3rd-tense.svg
THIRD_PERSON_PNG = $(THIRD_PERSON_SVG).png
THIRD_PERSON_JPEG = $(THIRD_PERSON_SVG).jpg
THIRD_PERSON_WEBP = $(THIRD_PERSON_SVG).webp

NOBRANDING_PERSON_SVG = emma-watson-wandless--3rd-tense--wo-hashtag-and-username.svg
NOBRANDING_PERSON_PNG = $(NOBRANDING_PERSON_SVG).png
NOBRANDING_PERSON_JPEG = $(NOBRANDING_PERSON_SVG).jpg
NOBRANDING_PERSON_WEBP = $(NOBRANDING_PERSON_SVG).webp

DPI = 72
SHIRT_SVG = emma-watson-wandless--3rd-tense--a4-shirt.svg
SHIRT_SVG_EXP_BASE = $(SHIRT_SVG)--$(DPI)dpi
SHIRT_PNG = $(SHIRT_SVG_EXP_BASE).png
SHIRT_JPEG = $(SHIRT_SVG_EXP_BASE).jpg
SHIRT_WEBP = $(SHIRT_SVG_EXP_BASE).webp

WIDTH_SHIRT_SVG_EXP_BASE = $(SHIRT_SVG)--width
WIDTH_SHIRT_PNG = $(WIDTH_SHIRT_SVG_EXP_BASE).png
WIDTH_SHIRT_WEBP = $(WIDTH_SHIRT_SVG_EXP_BASE).webp

PHOTO_BASE = d5au0ao-20c1308d-c41b-4723-b561-ad7a6dade3a8
PHOTO_INTERIM1 = $(PHOTO_BASE)-step1.png
PHOTO_DEST = $(PHOTO_BASE).jpg

WIDTH = 600

all: $(PNG) $(JPEG) $(WEBP) $(PHOTO_DEST) $(THIRD_PERSON_PNG) $(THIRD_PERSON_WEBP) $(THIRD_PERSON_JPEG) $(THIRD_PERSON_PNG)
all: $(NOBRANDING_PERSON_PNG) $(NOBRANDING_PERSON_WEBP) $(NOBRANDING_PERSON_JPEG) $(NOBRANDING_PERSON_PNG)
all: $(SHIRT_PNG)
all: $(WIDTH_SHIRT_PNG)
all: $(WIDTH_SHIRT_WEBP)

$(PNG): $(SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=$(WIDTH) $<
	optipng $@

$(WEBP): $(PNG)
	gm convert $< $@

$(JPEG): $(PNG)
	gm convert $< $@

$(SHIRT_PNG): $(SHIRT_SVG) $(PHOTO_DEST)
	inkscape --export-type=png --export-filename=$@ --export-dpi=$(DPI) --export-area-page $<
	optipng $@

$(THIRD_PERSON_PNG): $(THIRD_PERSON_SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=$(WIDTH) $<
	optipng $@

$(THIRD_PERSON_WEBP): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(THIRD_PERSON_JPEG): $(THIRD_PERSON_PNG)
	gm convert $< $@

$(WIDTH_SHIRT_PNG): $(SHIRT_SVG) $(PHOTO_DEST)
	inkscape --export-type=png --export-filename=$@ --export-width=$(WIDTH) --export-area-page $<
	optipng $@

$(WIDTH_SHIRT_WEBP): $(WIDTH_SHIRT_PNG)
	gm convert $< $@

$(NOBRANDING_PERSON_PNG): $(NOBRANDING_PERSON_SVG) $(PHOTO_DEST)
	inkscape --export-png=$@ --export-width=$(WIDTH) $<
	optipng $@

$(NOBRANDING_PERSON_WEBP): $(NOBRANDING_PERSON_PNG)
	gm convert $< $@

$(NOBRANDING_PERSON_JPEG): $(NOBRANDING_PERSON_PNG)
	gm convert $< $@

$(PHOTO_INTERIM1): $(PHOTO_BASE).webp
	gm convert -crop 2560x1177 $< $@

$(PHOTO_DEST): $(PHOTO_INTERIM1)
	gm convert $< $@

clean:
	rm -f emma-*.svg.png emma-*.svg.jpg emma-*.svg.webp

viewshirt: $(SHIRT_PNG)
	gwenview $<

upload_shirt: $(SHIRT_PNG)
	sky -x up $<

# upload: all
#	rsync --progress -v -a --inplace human-hacking-field-guide-logo.svg hhfg-ad.svg hhfg-ad.svg.png $(__HOMEPAGE_REMOTE_PATH)/hhfg-graphics-demo/

%.show:
	@echo "$* = $($*)"
