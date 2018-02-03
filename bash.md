# Slackware maintenance
```
slackpkg update
slackpkg upgrade-all
ntpdate pool.ntp.org
```

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
```
xclip -o > output.txt
xclip -o -selection p > output.txt
xclip -o -selection s > output.txt
xclip -o -selection c > output.txt
```
# Set clipboard content from file
cat file.txt | xclip -i -selection c


