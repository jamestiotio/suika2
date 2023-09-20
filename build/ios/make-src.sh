#!/bin/sh

set -eu

TARGET=ios-src

# Remove the target directory.
rm -rf "$TARGET"

# Create the target directory.
mkdir "$TARGET"

# Copy the base files.
COPY_LIST="\
	suika \
	suika.xcodeproj \
"
for f in $COPY_LIST; do
    cp -R "$f" "$TARGET/";
done
rm "$TARGET/suika/data01.arc"

# Change the source code paths in the project file.
sed -i 's|../../src/|src/|g' -i "$TARGET/suika.xcodeproj/project.pbxproj"

# Copy the Suika2 source files.
mkdir "$TARGET/src"
COPY_LIST="\
	anime.c \
	anime.h \
	aunit.c \
	aunit.h \
	cmd_anime.c \
	cmd_bg.c \
	cmd_bgm.c \
	cmd_cha.c \
	cmd_chapter.c \
	cmd_ch.c \
	cmd_chs.c \
	cmd_click.c \
	cmd_gosub.c \
	cmd_goto.c \
	cmd_gui.c \
	cmd_if.c \
	cmd_load.c \
	cmd_message.c \
	cmd_pencil.c \
	cmd_return.c \
	cmd_se.c \
	cmd_set.c \
	cmd_setconfig.c \
	cmd_setsave.c \
	cmd_shake.c \
	cmd_skip.c \
	cmd_switch.c \
	cmd_video.c \
	cmd_vol.c \
	cmd_wait.c \
	cmd_wms.c \
	conf.c \
	conf.h \
	drawglyph.h \
	drawimage.h \
	event.c \
	event.h \
	file.h \
	file.c \
	glrender.c \
	glrender.h \
	glyph.c \
	glyph.h \
	gui.c \
	gui.h \
	history.c \
	history.h \
	image.c \
	image.h \
	log.c \
	log.h \
	main.c \
	main.h \
	mixer.c \
	mixer.h \
	muladdpcm.h \
	iosmain.m \
	platform.h \
	readimage.c \
	readjpeg.c \
	save.c \
	save.h \
	scalesamples.h \
	scbuf.c \
	scbuf.h \
	script.c \
	script.h \
	seen.c \
	seen.h \
	stage.c \
	stage.h \
	suika.h \
	types.h \
	vars.c \
	vars.h \
	wave.c \
	wave.h \
	wms_core.c \
	wms_core.h \
	wms.h \
	wms_impl.c \
	wms_lexer.yy.c \
	wms_parser.tab.c \
	wms_parser.tab.h \
"
for f in $COPY_LIST; do
    cp "../../src/$f" "$TARGET/src/$f";
done

# Deploy libroot.
wget 'https://suika2.com/dl/libroot-ios.tar.gz'
tar xzf libroot-ios.tar.gz -C "$TARGET"

# Make a zip file.
#zip -r ios-src.zip "$TARGET"
