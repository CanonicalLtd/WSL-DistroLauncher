all: wide large smalltile logo

# wide.svg is ubuntu_white-orange(cof)_hex_su.svg with modified height
# (increased) to match 310x150 aspect ratio, and then logo recentered
# along the y-axis. Keeping the balance half-way the ubuntu word, with
# roundel off-balance.
wide: wide.svg
	inkscape -f '$<' -C -w 310 -h 150 -e Wide310x150Logo.scale-100.png
	inkscape -f '$<' -C -w 387 -h 187 -e Wide310x150Logo.scale-125.png
	inkscape -f '$<' -C -w 465 -h 225 -e Wide310x150Logo.scale-150.png
	inkscape -f '$<' -C -w 620 -h 300 -e Wide310x150Logo.scale-200.png
	inkscape -f '$<' -C -w 1240 -h 600 -e Wide310x150Logo.scale-400.png

# large.svg, is wide.svg with height modified to make it square, and
# again logo recentered along the y-axis.
large: large.svg
	inkscape -f '$<' -C -w 310 -e LargeTile.scale-100.png
	inkscape -f '$<' -C -w 387 -e LargeTile.scale-125.png
	inkscape -f '$<' -C -w 465 -e LargeTile.scale-150.png
	inkscape -f '$<' -C -w 620 -e LargeTile.scale-200.png
	inkscape -f '$<' -C -w 1240 -e LargeTile.scale-400.png

# smalltile is simply cof_white-orange_hex.svg 
smalltile: smalltile.svg
	inkscape -f '$<' -C -w 71 -e SmallTile.scale-100.png
	inkscape -f '$<' -C -w 88 -e SmallTile.scale-125.png
	inkscape -f '$<' -C -w 106 -e SmallTile.scale-150.png
	inkscape -f '$<' -C -w 142 -e SmallTile.scale-200.png
	inkscape -f '$<' -C -w 284 -e SmallTile.scale-400.png
	inkscape -f '$<' -C -w 150 -e Square150x150Logo.scale-100.png
	inkscape -f '$<' -C -w 187 -e Square150x150Logo.scale-125.png
	inkscape -f '$<' -C -w 225 -e Square150x150Logo.scale-150.png
	inkscape -f '$<' -C -w 300 -e Square150x150Logo.scale-200.png
	inkscape -f '$<' -C -w 600 -e Square150x150Logo.scale-400.png
	inkscape -f '$<' -C -w 16 -e Square44x44Logo.targetsize-16.png
	inkscape -f '$<' -C -w 24 -e Square44x44Logo.targetsize-24.png
	inkscape -f '$<' -C -w 24 -e Square44x44Logo.targetsize-24_altform-unplated.png
	inkscape -f '$<' -C -w 32 -e Square44x44Logo.targetsize-32.png
	inkscape -f '$<' -C -w 48 -e Square44x44Logo.targetsize-48.png
	inkscape -f '$<' -C -w 256 -e Square44x44Logo.targetsize-256.png

logo: cof_orange_hex.svg
	inkscape -f '$<' -C -w 44 -e Square44x44Logo.scale-100.png
	inkscape -f '$<' -C -w 55 -e Square44x44Logo.scale-125.png
	inkscape -f '$<' -C -w 66 -e Square44x44Logo.scale-150.png
	inkscape -f '$<' -C -w 88 -e Square44x44Logo.scale-200.png
	inkscape -f '$<' -C -w 176 -e Square44x44Logo.scale-400.png
	inkscape -f '$<' -D -w 16 -e Square44x44Logo.altform-unplated_targetsize-16.png
	inkscape -f '$<' -D -w 32 -e Square44x44Logo.altform-unplated_targetsize-32.png
	inkscape -f '$<' -D -w 48 -e Square44x44Logo.altform-unplated_targetsize-48.png
	inkscape -f '$<' -D -w 256 -e Square44x44Logo.altform-unplated_targetsize-256.png
	inkscape -f '$<' -D -w 50 -b white -e StoreLogo.scale-100.png
	inkscape -f '$<' -D -w 63 -b white -e StoreLogo.scale-125.png
	inkscape -f '$<' -D -w 75 -b white -e StoreLogo.scale-150.png
	inkscape -f '$<' -D -w 100 -b white -e StoreLogo.scale-200.png
	inkscape -f '$<' -D -w 200 -b white -e StoreLogo.scale-400.png