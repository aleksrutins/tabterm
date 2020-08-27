tabterm_sources = [
  'main.vala',
  'window.vala',
]

tabterm_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
  dependency('vte-2.91')
]

gnome = import('gnome')

tabterm_sources += gnome.compile_resources('tabterm-resources',
  'tabterm.gresource.xml',
  c_name: 'tabterm'
)

executable('tabterm', tabterm_sources,
  vala_args: '--target-glib=2.50',  dependencies: tabterm_deps,
  install: true,
)
