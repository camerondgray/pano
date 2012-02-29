# Created by Panotools::Script 0.26

.PHONY : all images pto pointless pointless_mk mk qtvr hdr

all : images

pto : NaN/ptest-*.pto

mk : NaN/ptest-*.pto.mk

pointless : NaN/ptest-*.pointless.pto

pointless_mk : NaN/ptest-*.pointless.pto.mk

images : NaN/ptest-*.tif

qtvr : NaN/ptest-*.mov

hdr : 

MAKE_EXTRA_ARGS = clean
MAKE_EXTRA_ARGS_SHELL = clean
HUGINDATADIR = /usr/share/hugin
HUGINDATADIR_SHELL = /usr/share/hugin
PTO2MK = pto2mk
PTO2MK_SHELL = pto2mk
MATCHNSHIFT = match-n-shift
MATCHNSHIFT_SHELL = match-n-shift
PTOANCHOR = ptoanchor
PTOANCHOR_SHELL = ptoanchor

# Create a pointless project file from a list of photos
NaN/ptest-*.pointless.pto : NaN/ptest /Users/camerondgray/dev/images/sv/*.jpeg
	$(MATCHNSHIFT_SHELL) --output NaN/ptest-*.pointless.pto --projection 0 --fov 90 NaN/ptest /Users/camerondgray/dev/images/sv/*.jpeg


# Create a Makefile to make a finished project from a pointless project
NaN/ptest-*.pointless.pto.mk : NaN/ptest-*.pointless.pto
	$(PTOANCHOR_SHELL) --makefile NaN/ptest-*.pointless.pto.mk --output NaN/ptest-*.pto NaN/ptest-*.pointless.pto


# Create a finished .pto project
NaN/ptest-*.pto : NaN/ptest-*.pointless.pto.mk
	$(MAKE) -e -f NaN/ptest-*.pointless.pto.mk all $(MAKE_EXTRA_ARGS_SHELL)


# Create a .pto.mk Makefile from a finished project file
NaN/ptest-*.pto.mk : NaN/ptest-*.pto
	$(PTO2MK_SHELL) -o NaN/ptest-*.pto.mk -p NaN/ptest-* NaN/ptest-*.pto


# Rules for all possible output images

# Normal seam blended output
NaN/ptest-*.tif : NaN/ptest-*.pto NaN/ptest-*.pto.mk NaN/ptest /Users/camerondgray/dev/images/sv/*.jpeg
	$(MAKE) -e -f NaN/ptest-*.pto.mk NaN/ptest-*.tif $(MAKE_EXTRA_ARGS_SHELL)


# Exposure fused then seam blended output
NaN/ptest-*_fused.tif : NaN/ptest-*.pto NaN/ptest-*.pto.mk NaN/ptest /Users/camerondgray/dev/images/sv/*.jpeg
	$(MAKE) -e -f NaN/ptest-*.pto.mk NaN/ptest-*_fused.tif $(MAKE_EXTRA_ARGS_SHELL)


# Seam blended then fused output
NaN/ptest-*_blended_fused.tif : NaN/ptest-*.pto NaN/ptest-*.pto.mk NaN/ptest /Users/camerondgray/dev/images/sv/*.jpeg
	$(MAKE) -e -f NaN/ptest-*.pto.mk NaN/ptest-*_blended_fused.tif $(MAKE_EXTRA_ARGS_SHELL)


# HDR merged then seam blended output
NaN/ptest-*_hdr.exr : NaN/ptest-*.pto NaN/ptest-*.pto.mk NaN/ptest /Users/camerondgray/dev/images/sv/*.jpeg
	$(MAKE) -e -f NaN/ptest-*.pto.mk NaN/ptest-*_hdr.exr $(MAKE_EXTRA_ARGS_SHELL)


# Rules for secondary output (QTVR, little planets etc...)

# Normal seam blended output
NaN/ptest-*.mov NaN/ptest-*-sky.jpg NaN/ptest-*-planet.jpg NaN/ptest-*-mercator.jpg : NaN/ptest-*.pto NaN/ptest-*.pto.mk NaN/ptest-*.tif
	$(MAKE) -e -f $(HUGINDATADIR_SHELL)/Makefile.equirect.mk equirect_all equirect_clean PTO=NaN/ptest-*.pto FUSED_SUFFIX=


# Exposure fused then seam blended output
NaN/ptest-*_fused.mov NaN/ptest-*_fused-sky.jpg NaN/ptest-*_fused-planet.jpg NaN/ptest-*_fused-mercator.jpg : NaN/ptest-*.pto NaN/ptest-*.pto.mk NaN/ptest-*_fused.tif
	$(MAKE) -e -f $(HUGINDATADIR_SHELL)/Makefile.equirect.mk equirect_all equirect_clean PTO=NaN/ptest-*.pto FUSED_SUFFIX=_fused


# Seam blended then fused output
NaN/ptest-*_blended_fused.mov NaN/ptest-*_blended_fused-sky.jpg NaN/ptest-*_blended_fused-planet.jpg NaN/ptest-*_blended_fused-mercator.jpg : NaN/ptest-*.pto NaN/ptest-*.pto.mk NaN/ptest-*_blended_fused.tif
	$(MAKE) -e -f $(HUGINDATADIR_SHELL)/Makefile.equirect.mk equirect_all equirect_clean PTO=NaN/ptest-*.pto FUSED_SUFFIX=_blended_fused

Makefile : NaN/ptest /Users/camerondgray/dev/images/sv/*.jpeg
	/usr/local/bin/panostart --output\  NaN/ptest --projection 0 --fov 90 --nostacks --loquacious /Users/camerondgray/dev/images/sv/*.jpeg

