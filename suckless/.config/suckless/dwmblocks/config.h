//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {"","sb-music",       5,		12},
	{" ",  "sb-volume",	    0,		10},
	{"󰀠 ", "alarm",         0,		9},
	//{"",   "sb-forecast",	1800,	8},
	{"󰏖 ", "sb-packages",	500,    7},
	{"", "sb-internet",   10,		6},
	{"", "sb-battery",    10,		5},
	{"󰋊 ", "sb-disk",	    60,		4},
	{" ", "sb-cpu",	    2,		3},
	{"󰧑 ", "sb-memory",	    1,		2},
	{"󰥔 ", "sb-clock",      1,		1},

};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = " | ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
