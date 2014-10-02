#!/bin/bash

# process-video
# mpinner
# 
# to be run repeatedly for making videos into small images

. /boot/uboot/env.sh


VIDEO_DIR=$THUMB_DRIVE/video
INCOMING_DIR=$VIDEO_DIR/incoming
LOCK_FILE=$VIDEO_DIR/lock/
VIDEO_EXT=mp4
VIDEO_FILE_PATTERN=$INCOMING_DIR/*.$VIDEO_EXT
QUEUE_DIR=$VIDEO_DIR/playlist/
DONE_DIR=$VIDEO_DIR/backup/


#test for thumbdrive dir
if [ ! -d "$THUMB_DRIVE" ]; then
    echo "Thumb Drive not found at $THUMB_DRIVE!"
    exit 1
fi
#test for video dir
if [ ! -d "$VIDEO_DIR" ]; then
    echo "Video Directory not found at $VIDEO_DIR!"
    exit 1
fi

if [ ! -d "$INCOMING_DIR" ]; then
  mkdir -p $INCOMING_DIR
  if [ ! -d "$INCOMING_DIR" ]; then
      echo "Video Incoming Directory not found!"
      exit 1
    fi
fi

if [ ! -d "$QUEUE_DIR" ]; then
  mkdir -p $QUEUE_DIR
  if [ ! -d "$QUEUE_DIR" ]; then
      echo "Video Queue Directory not found!"
      exit 1
    fi
fi

if [ ! -d "$DONE_DIR" ]; then
	mkdir -p $DONE_DIR
	if [ ! -d "$DONE_DIR" ]; then
   		echo "Video Done Directory not found!"
    	exit 1
    fi
fi

#test for new files
shopt -s nullglob
FILES=`echo $VIDEO_FILE_PATTERN`
if [[ -z $FILES ]]; then 
    # todo if silent
    #echo "No new videos found"
    exit 1
fi


# New videos !!

# set lock
if mkdir $LOCK_FILE; then
  echo "Locking succeeded" >&2
else
  echo "Lock failed - exit" >&2
  exit 1
fi


#process all videos into image queues
for video in $FILES; do 

  filename=$(basename "$video")
  name=`echo $filename | cut -d'.' -f1`;
  echo $name;

  #process video
  echo "/usr/local/bin/ffmpeg -i $video -vf scale=60:24 -r 15 -f image2 $DONE_DIR$name%03d.png"
  time /usr/local/bin/ffmpeg -i $video -vf scale=60:24 -r 15 -f image2 $QUEUE_DIR$name%06d.png

  #move to done
  mv $video $DONE_DIR

done


#remove lock
rm -r $LOCK_FILE

sudo killall -r video

