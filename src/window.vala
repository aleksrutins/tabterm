/* window.vala
 *
 * Copyright 2020 munchkinhalfling
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Tabterm {
	[GtkTemplate (ui = "/com/github/munchkinhalfling/tabterm/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		[GtkChild]
		Gtk.Stack terminals;
		[GtkChild]
		Gtk.Button addTerminal;

		int curTerm = 0;

		public Window (Gtk.Application app) {
			Object (application: app);
			addTerminal.clicked.connect(newTerminal);
			terminals.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
		}

		public void newTerminal() {
            var term = new Vte.Terminal();
            var command = GLib.Environment.get_variable ("SHELL");
		    try {
			    term.spawn_sync (
				    Vte.PtyFlags.DEFAULT,
				    GLib.Environment.get_variable("HOME"),
				    new string[] { command }, /* command */
				    null,    /* additional environment */
				    0,       /* spawn flags */
				    null,    /* child setup */
				    null     /* child pid */
				    );
		    } catch (GLib.Error e) {
			    stderr.printf ("Error: %s\n", e.message);

		    }
            terminals.add_titled(term, "term" + curTerm.to_string(), "Terminal " + curTerm.to_string());
            stdout.printf("New terminal: " + curTerm.to_string() + "\n");
            show_all();
            curTerm++;
		}
	}
}
