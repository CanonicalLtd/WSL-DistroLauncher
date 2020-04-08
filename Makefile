all: store-submission/logo.png
	$(MAKE) -C DistroLauncher-Appx/Assets/
	$(MAKE) -C DistroLauncher/images/

store-submission/logo.png: DistroLauncher-Appx/Assets/cof_orange_hex.svg
	inkscape -f '$<' -D -w 300 -e $@
