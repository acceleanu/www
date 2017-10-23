# Daily misc commands

- find when the xorg config has been changed last
```
find /usr -ctime -30 | grep X11
```
- found that /usr/share/X11/xorg.conf.d/90-keyboard-layout.conf has been changed
so recall now that the keyboard has been set back to us after the security update.
Had to change to gb:
```
 Option "XkbLayout" "gb"
```


