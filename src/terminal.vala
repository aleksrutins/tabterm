namespace Tabterm { 
    class AppTerminal : Vte.Terminal {
        public string command;
        private int _pid;
        public int pid() {return _pid;}
        private void initProps() {
            Gdk.RGBA rgbaBg = Gdk.RGBA();
            Gdk.RGBA rgbaFg = Gdk.RGBA();
            rgbaBg.parse("rgba(255,255,230,90)");
            rgbaFg.parse("rgb(0,0,0)");
            set_color_background(rgbaBg);
            set_color_foreground(rgbaFg);
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