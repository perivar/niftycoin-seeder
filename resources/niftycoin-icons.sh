#!/bin/bash -e

# change the following variables to match your new coin
PNG_FILE="nlogo.png"
SVG_FILE="nlogo.svg"

ICO_FOLDER="res/icons"
PIX_FOLDER="pixmaps"
TMP_FOLDER="tmp"

mkdir -p $TMP_FOLDER
mkdir -p $ICO_FOLDER
mkdir -p $PIX_FOLDER

# copy main png
cp $PNG_FILE $ICO_FOLDER/bitcoin.png

# ICO NORMAL with transparent background
convert -resize x16 -gravity center -crop 16x16+0+0 -flatten -colors 256 -background transparent $PNG_FILE $TMP_FOLDER/output-16x16.ico
convert -resize x32 -gravity center -crop 32x32+0+0 -flatten -colors 256 -background transparent $PNG_FILE $TMP_FOLDER/output-32x32.ico
convert -resize x48 -gravity center -crop 48x48+0+0 -flatten -colors 256 -background transparent $PNG_FILE $TMP_FOLDER/output-48x48.ico
convert $TMP_FOLDER/output-16x16.ico $TMP_FOLDER/output-32x32.ico $TMP_FOLDER/output-48x48.ico $ICO_FOLDER/bitcoin.ico

# ICO GREEN with transparent background
convert -resize x16 -gravity center -crop 16x16+0+0 -flatten -colors 256 -background transparent -alpha off -fuzz 50% -fill "rgb(90,180,70)" -opaque "#000000" -alpha on $PNG_FILE $TMP_FOLDER/color-output-16x16.ico
convert -resize x32 -gravity center -crop 32x32+0+0 -flatten -colors 256 -background transparent -alpha off -fuzz 50% -fill "rgb(90,180,70)" -opaque "#000000" -alpha on $PNG_FILE $TMP_FOLDER/color-output-32x32.ico
convert -resize x48 -gravity center -crop 48x48+0+0 -flatten -colors 256 -background transparent -alpha off -fuzz 50% -fill "rgb(90,180,70)" -opaque "#000000" -alpha on $PNG_FILE $TMP_FOLDER/color-output-48x48.ico
convert $TMP_FOLDER/color-output-16x16.ico $TMP_FOLDER/color-output-32x32.ico $TMP_FOLDER/color-output-48x48.ico $ICO_FOLDER/bitcoin_testnet.ico

# GREEN Splash PNG
convert -flatten -colors 256 -background transparent -alpha off -fuzz 50% -fill "rgb(90,180,70)" -opaque "#000000" -alpha on $PNG_FILE $ICO_FOLDER/niftycoin_splash.png

# ICO, PNG and XPM share pixmaps
convert -resize x16 -gravity center -crop 16x16+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin16.png
convert -resize x16 -gravity center -crop 16x16+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin16.xpm
convert -resize x32 -gravity center -crop 32x32+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin32.png
convert -resize x32 -gravity center -crop 32x32+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin32.xpm
convert -resize x64 -gravity center -crop 64x64+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin64.png
convert -resize x64 -gravity center -crop 64x64+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin64.xpm
convert -resize x128 -gravity center -crop 128x128+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin128.png
convert -resize x128 -gravity center -crop 128x128+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin128.xpm
convert -resize x256 -gravity center -crop 256x256+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin256.png
convert -resize x256 -gravity center -crop 256x256+0+0 -flatten -colors 256 -background transparent $PNG_FILE $PIX_FOLDER/bitcoin256.xpm
