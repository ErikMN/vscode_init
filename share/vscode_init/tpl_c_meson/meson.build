# https://mesonbuild.com/Reference-manual.html
project(
  'xxxxxxxxx',
  ['c' ],
  version : '0.0.1',
  license : [ 'MIT' ],
  meson_version : '>= 0.58.0',
  default_options : [ 'warning_level=1', # 3
                      'werror=false',
                      'buildtype=debugoptimized' ]) # debugoptimized

# The compiler:
cc = meson.get_compiler('c')

common_flags = [
  '-DMESON'
]

final_flags = [
  '-fvisibility=hidden',
  '-Werror=suggest-attribute=format',
  '-Wsign-compare',
  '-Wpointer-arith',
  '-Wpointer-sign',
  '-Wformat',
  '-Wformat-security',
  '-Wimplicit-fallthrough',
  '-Wmissing-braces',
  '-Wtype-limits',
  '-Wvariadic-macros',
  '-Wmaybe-uninitialized',
  '-Wno-missing-field-initializers',
  '-Wno-unused-parameter',
  '-Wno-pedantic',
  '-Wold-style-declaration',
  '-Wdeprecated-declarations',
  '-Wunused-result',
  '-Wno-format-truncation',
]

final_cc_flags = common_flags + final_flags + [
  '-DNDEBUG'
]

debug_cc_flags = common_flags + [
  '-DDEBUG',
  '-g3'
]

# https://mesonbuild.com/Build-options.html
if get_option('buildtype') == 'debug'
  add_project_arguments('-fsanitize=address', language : 'c')
  add_project_link_arguments('-fsanitize=address', language : 'c')
  add_project_arguments(cc.get_supported_arguments(debug_cc_flags), language: 'c')
else
  add_project_arguments(cc.get_supported_arguments(final_cc_flags), language: 'c')
endif

prefix = get_option('prefix') # /usr/local
datadir = get_option('datadir') # share
sysconfdir = get_option('sysconfdir') # /etc

# https://mesonbuild.com/Configuration.html
cdata = configuration_data()
cdata.set('PACKAGE', '"my_package"')
cdata.set_quoted('SYSCONFDIR', prefix / sysconfdir)
cdata.set_quoted('DATADIR', datadir)

configure_file(output : 'config.h', configuration : cdata)

# https://mesonbuild.com/Include-directories.html
incdir = include_directories('.')

sources = [
  'main.c'
]

# https://mesonbuild.com/Dependencies.html
# mylib_dep = dependency('mylib', version: '>=100')

# -lm
math_dep = cc.find_library('m', required : true)

xxxxxxxxx_exe = executable('xxxxxxxxx',
  sources,
  dependencies : [math_dep],
  include_directories : incdir,
  install : true
)
