###########################
Mistype autocomplete source
###########################

This is a WIP of a plugin that replaces your keyboard input with alternative
keyboard layout you have.

Inside there is a unicode codepoints table from EN to RUS keyboard and vice
versa. The script transliterates the input text with the help of ``lua-utf8``
library, which you'll have to compile by yourself and put it into where it
should be, so that ``require'lua-utf8'`` would not fail. The transliterated
text is pushed to autocomplete menu of ``mistype``.

The behaviour of this plugin is not exactly as I want it to, but it seems
thats mostly the behaviour of ``nvim-cmp``.

Anyway, play with it as you like, and MR if you want to.

Made on the basis of https://github.com/cpkio/cmp-source-template
