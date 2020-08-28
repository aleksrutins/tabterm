namespace Tabterm { 
    class AppTerminal : Vte.Terminal {
        public string command;
        private int _pid;
        public int pid() {return _pid;}
        private void initProps() {
            var settings = new Settings("com.github.munchkinhalfling.tabterm");
            Gdk.RGBA rgbaBg = Gdk.RGBA();
            Gdk.RGBA rgbaFg = Gdk.RGBA();
            rgbaBg.parse(settings.get_string("background"));
            rgbaFg.parse(settings.get_string("foreground"));
            set_color_background(rgbaBg);
            set_color_foreground(rgbaFg);
            set_font(Pango.FontDescription.from_string(settings.get_string("font")));
            settings.changed["background"].connect(() => {
                rgbaBg.parse(settings.get_string("background"));
                set_color_background(rgbaBg);
            });
            settings.changed["foreground"].connect(() => {
                rgbaFg.parse(settings.get_string("foreground"));
                set_color_foreground(rgbaFg);
            });
            settings.changed["font"].connect(() => {
                set_font(Pango.FontDescription.from_string(settings.get_string("font")));
            });
        }
        public AppTerminal () {
            initProps();
            command = GLib.Environment.get_variable ("SHELL");
        }
        public void spawn() {
            try {
			    this.spawn_sync (
				    Vte.PtyFlags.DEFAULT,
				    GLib.Environment.get_variable("HOME"),
				    new string[] { command }, /* command */
				    null,    /* additional environment */
				    0,       /* spawn flags */
				    null,    /* child setup */
				    out _pid
				    );
		    } catch (GLib.Error e) {
			    stderr.printf ("Error: %s\n", e.message);
                Process.exit(1);
            }
        }
    }
}