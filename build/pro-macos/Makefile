include ../common.mk

FILES_MACOS = \
	pro-macos/main.m \
	pro-macos/AppDelegate.h \
	pro-macos/AppDelegate.m \
	pro-macos/ViewController.h \
	pro-macos/ViewController.m \
	pro-macos/GameView.h \
	pro-macos/GameView.m \
	../../src/apple/aunit.h \
	../../src/apple/aunit.c \
	../../src/apple/GameRenderer.h \
	../../src/apple/GameShaderTypes.h \
	../../src/apple/GameViewControllerProtocol.h \
	../../src/apple/GameRenderer.m \
	../../src/apple/GameShaders.metal

main: suika2.dmg

suika2.dmg: libroot $(SRCS_MAIN) $(HDRS_MAIN) $(FILES_MACOS)
	@echo "Building Suika2 Pro.app"
	@rm -rf build
	@xcodebuild -quiet -scheme pro-macos -project pro-macos.xcodeproj -configuration Release -archivePath `pwd`/build/Release/pro-macos.xcarchive archive
	@xcodebuild -quiet -exportArchive -archivePath `pwd`/build/Release/pro-macos.xcarchive -exportOptionsPlist export-options.plist
	@rm -rf "build/Release/Suika2 Pro.app"
	@until \
		xcodebuild -quiet -exportNotarizedApp -archivePath `pwd`/build/Release/pro-macos.xcarchive -exportPath `pwd`/build/Release; \
	do \
		echo "waiting..."; \
		sleep 10; \
	done
	@rm -rf tmp *.dmg
	@mkdir tmp
	@cp -Ra "build/Release/Suika2 Pro.app" "tmp/Suika2 Pro.app"
	@create-dmg \
		--volname "Suika2 Installer" \
		--background "installer_background.png" \
		--window-pos 200 120 \
		--window-size 800 400 \
		--icon-size 100 \
		--icon "Suika2 Pro.app" 200 190 \
		--app-drop-link 600 185 \
		--format UDBZ \
		"suika2.dmg" \
		"tmp"

libroot:
	./build-libs.sh

build-only:
	@xcodebuild -quiet -scheme pro-macos -project pro-macos.xcodeproj -configuration Release -archivePath `pwd`/build/Release/pro-macos.xcarchive build

clean:
	@rm -rf build suika2.dmg libroot-mac.tar.gz libroot
