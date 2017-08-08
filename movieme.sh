#!/bin/sh
#
# MOVIE ME as in: "MOVIE ME AN ANIMATED GIF FROM THIS MOVIE, DAMMIT"
#
# Creates an animated gif from a movie file. Uploads to CloudApp. You must also
# have `gifme` and `cloudapp` in your $PATH.
#
#   $1 - the path to the movie we're converting.
#   $2 - the start time of the finished product.
#        This can be in seconds, or it also accepts the "hh:mm:ss[.xxx]" format.
#   $3 - the duration of the video sequence.
#        This can be in seconds, or it also accepts the "hh:mm:ss[.xxx]" format.
#
# Examples:
#
#   movieme <path> <start-time> <duration>
#   ~/Desktop/dr-strangelove.mp4 23:12 3
#   ~/Desktop/holman-backflip-on-fire.mov 3.9 1.75

# cleanup
rm -rf /tmp/movieme

# create tmp dir
mkdir -p /tmp/movieme

# split the movie into constituent frames
ffmpeg -i "$1" -f image2 -vf "scale=iw*sar:ih" -ss $2 -t $3 -r 7 /tmp/movieme/d-%05d.png

# ANIMATE
gifme /tmp/movieme/* -d 0