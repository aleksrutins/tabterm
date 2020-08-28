# tabterm
## A tabbed terminal for Linux using GTK, Vala and VTE
### Installation
#### Dependencies
- Vala
- gio-2.0 >= 2.50
- gtk+-3.0 >= 3.22
- vte-2.91
#### Building
```sh
$ meson builddir
$ ninja -C builddir
$ sudo ninja -C builddir install
```
There should now be a `tabterm` entry in your app menu.
### Configuration
All configuration entries are documented in GSettings under /com/github/munchkinhalfling/tabterm (com.github.munchkinhalfling.tabterm on the command line)
### Why __another__ terminal for Linux?
I wanted a GTK-based terminal with tabs in the titlebar, so as to use the space well, and I couldn't find one, so I made one.