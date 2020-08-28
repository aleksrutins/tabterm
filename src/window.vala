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
		[GtkChild]
		Gtk.Button rmTerminal;

		private int curTerm = 0;

		public Window (Gtk.Application app) {
			Object (application: app);
			addTerminal.clicked.connect(newTerminal);
			rmTerminal.clicked.connect(remTerminal);
			terminals.set_transition_type(Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
			newTerminal();
		}

		public void remTerminal() {
			AppTerminal term = (AppTerminal)terminals.get_visible_child();
			List<weak Gtk.Widget> childList = terminals.get_children();
			int newIndex = childList.index(term) - 1;
			terminals.set_visible_child_full("term" + newIndex.to_string(), CROSSFADE);
			Posix.kill(term.pid(), 1);
			terminals.remove(term);
			if(terminals.get_children().length() == 0) {
				Process.exit(0);
			}
		}

		public void newTerminal() {
			var term = new AppTerminal();
			term.spawn();
			string title = term.get_window_title() != null && term.window_title != "" ? term.window_title : term.command;
			terminals.add_titled(term, "term" + curTerm.to_string(), title);
			show_all();
			terminals.set_visible_child_full("term" + curTerm.to_string(), CROSSFADE);
			term.window_title_changed.connect(() => {
				terminals.child_set_property(term, "title", term.window_title);
			});
            curTerm++;
		}
	}
}
