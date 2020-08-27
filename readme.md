# tabterm
## A tabbed terminal for Linux using GTK, Vala and VTE
### Installation
#### Dependencies
- Vala
- gio-2.0 >= 2.50
- gtk+-3.0 >= 3.22
- libvte
#### Building
```sh
$ meson builddir
$ ninja -C builddir
$ sudo ninja -C builddir install
```
There should now be a `tabterm` entry in your app menu. If there is not, run:
```sh
$ sudo desktop-file-install tabterm.desktop
```
### Why __another__ terminal for Linux?
I wanted a GTK-based terminal with tabs in the titlebar, so as to use the space well, and I couldn't find one, so I made one.