# Cromemco-boot-rom

This project documents the process I used to get an assembly file for the
Cromemco 16fdc boot rom.

The rom is welded to the p.c. board and to its rather difficult to read with the
programmer.  I used the DM command to dump the rom to the console.  I had consol
logging on, so in the end I had a file with the dump in it.

Then...  I wrote a really hasty program to read the dump file and convert it to
binary.  With that I was able to use z80dasm to creat an ascii file of the code.
That was then edited and the result is sent back through z88-z80asm to produce
a binary.  etc....  

Need to get the file linked and then do a binary diff to make certain the files
match.

From there, its study the code and put in some comments.  

I'd like to get to the point where I can create a new boot image and replace
the one on the fdc card.  I'm thinking that booting off of John Monahan Dual IDE
board.  That would be just to cool.

Anyway for now we just hack on.

