#!/bin/bash
echo "0. Preparing"
rm -rf deb
mkdir builds

echo "1. Building file structure"
mkdir deb
mkdir deb/private
mkdir deb/private/var
mkdir deb/private/var/mobile
mkdir deb/private/var/mobile/Library
mkdir deb/private/var/mobile/Library/Widgets
mkdir deb/private/var/mobile/Library/Widgets/Backgrounds

echo "2. Copying files"
cp -r DEBIAN deb/DEBIAN
cp -r backgroundArt deb/private/var/mobile/Library/Widgets/Backgrounds/backgroundArt

echo "3. Packaging"
gfind . -name ".DS_Store" -delete;
cd deb
gfind . -type f ! -regex '.*.hg.*' ! -regex '.*?debian-binary.*' ! -regex '.*?DEBIAN.*' -printf '%P ' | xargs md5sum > DEBIAN/md5sums
cd ..
dpkg -b deb/ builds/"com.thelmgn.backgroundArt-builtat-$(date '+%Y%m%d-%H%M%S').deb"

echo "4. Cleaning..."
rm -rf deb
