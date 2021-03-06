#!/bin/bash

ISOFILE=$1
KERNEL=$2
KERNELVERSION=$3

KERNELARGS=" "

if [[ $KERNEL == "-k" ]] ; then
    echo "Setting kernel version..."
    KERNELARGS=" --kernel $KERNELVERSION "
fi

# If missing, download latest version of the script that will respin the ISO
if [ ! -f isorespin.sh ]; then
	echo "Isorespin script not found. Downloading it..."
	wget -O isorespin.sh "https://drive.google.com/uc?export=download&id=0B99O3A0dDe67S053UE8zN3NwM2c"
fi

installpackages=""
# Packages that will be installed:
# Streaming and codecs for correct video encoding/play
installpackages+="va-driver-all "
installpackages+="vainfo "
installpackages+="gstreamer1.0-libav "
installpackages+="gstreamer1.0-vaapi "

# for ezgo
installpackages+="vim vim-gtk zenity im-switch chromium-browser language-pack-zh-hant language-pack-zh-hant-base language-pack-gnome-zh-hant language-pack-kde-zh-hant kde-l10n-zhtw firefox firefox-locale-zh-hant "
# fcitx
installpackages+="fcitx-chewing fcitx-googlepinyin fcitx-table-array30 fcitx-table-array30-big fcitx-table-cangjie3 fcitx-table-cangjie5 fcitx-table-boshiamy fcitx-tools "
# sigil, kazam, blender, and ffdiaporama
installpackages+="sigil kazam ffdiaporama "
# kdegames
installpackages+="supertux pingus tuxmath tuxtype "
# office
installpackages+="dia planner gnucash calibre pdfshuffler qtqr dia-shapes "
# edu
installpackages+="arduino gcompris ktuberling anki parley kanagram marble kgeography stellarium kmplot geogebra rocs rkward r-base-core gnumeric kalzium bkchem avogadro "
# painting
installpcakages+="kolourpaint4 inkscape gimp imagemagick gwenview digikam ksnapshot fritzing kruler kcolorchooser "
# video/audio
installpackages+="vlc openshot kdenlive kazam k3b furiusisomount amarok musescore hydrogen audacity lmms kmix "
# networking
installpackages+="ktorrent sylpheed bluedevil krdc sylpheed-i18n "
# games
installpackages+="tuxtype tuxmath palapeli kubrick ksquares knetwalk ksudoku blinken picmi katomic kblackbox kigo kreversi kfourinline bovo gnugo "
# wine
#installpackages+="wine-stable winetricks "

# Packages that will be removed:
# move those packages into ezgo/add-ezgo.sh

chmod +x isorespin.sh
sync;sync;sync

./isorespin.sh -i $ISOFILE \
	$KERNELARGS \
	-p "$installpackages" \
	-f wrapper-ezgo.sh \
	-f ezgo \
	-c wrapper-ezgo.sh
