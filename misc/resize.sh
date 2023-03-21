#!/bin/sh

for img in "$@"; do
    [ $(identify -ping -format "%[fx:w]\n" "$img" ) -gt 1080 ] &&
        mogrify -verbose -resize "1080x>" "$img"
done
