# Slackware maintenance
```
slackpkg update
slackpkg upgrade-all
ntpdate pool.ntp.org
```
# Given a file name find the package it belongs to
grep -rni libX11-xcb.la /var/log/packages/

# iPhone photo backup
## Get all 
```
gphoto2 --port=usb: -R -P
```

## Remove all
```
gphoto2 --port=usb: -R -D
```


# Linux record
```
PREFIX="$1"

while [ true ];
do
	DATE=$(date +%Y%m%d_%H%M%S)
	file_name="${PREFIX}_${DATE}.png"
	sleep 5; xwd  -root | convert - "$file_name"
done
```

# Fix keyboard layout after xorg upgrade

```
setxkbmap -layout gb
xmodmap ~/.Xmodmap
```

- edit /usr/X11/share/X11/xorg.conf.d/90-keyboard-layout.conf and replace XkbLayout->'us' with 'gb' 

# Extract text from pdf
```
gs -sDEVICE=txtwrite -o output.txt input.pdf
```

# Convert images to pdf
```
convert *.jpg output.pdf
```

# Paste clipboard selection into file
xclip
- p = primary (term)
- s = secondary 
- c = clipboard (browser)

```
xclip -o > output.txt
xclip -o -selection p > output.txt
xclip -o -selection s > output.txt
xclip -o -selection c > output.txt
# Set clipboard content from file
```
cat file.txt | xclip -i -selection c
```
# copy from term clipboard to browser clipboard
```
xclip -o -selection p | xclip -i -selection c
```

# write dvd iso image
```
growisofs -dvd-compat -speed=2 -Z /dev/sr0=/path/to/iso
```

# write cd iso image
```
modprobe sg
cdrecord -scanbus
cdrecord -v speed=4 dev=0,2,3 path/to/iso
```


# extract audio from video a file
```
ffmpeg -i in.mp4 -vn -acodec libvorbis out.ogg
```

# zero padded index
```
i=1
while [ $i -lt 11 ];
do
        ipadded="00$i"
        idx=${ipadded:${#ipadded}-2}
        echo "${idx}"
        ((i++))
done
```




