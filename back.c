/* convert log dump of eprom into a binary file for z80dism
text looks like this 
C000  F3 18 3C C3  30 C0 C3 04  C5 C3 37 C0  C3 3B C0 C3  s.<C0@C.EC7@C;@C
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE *in;
FILE *out;

unsigned int	j1,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15;
char junk[80];
char buff[80];
int ReadLine()
{
	fgets(buff,80,in);
	return(sscanf(buff,"%4x  %2x %2x %2x %2x  %2x %2x %2x %2x  %2x %2x %2x %2x  %2x %2x %2x %2x %s\n",
	&j1,&b0,&b1,&b2,&b3,&b4,&b5,&b6,&b7,&b8,&b9,&b10,&b11,&b12,&b13,&b14,&b15,junk));
}
void WriteBuf(int stat)
{
	printf("%d %04x %02x %02x %02x %02x  %02x %02x %02x %02x  %02x %02x %02x %02x  %02x %02x %02x %02x %s\n",
	stat,j1,b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,junk);
	fwrite(&b0,1,1,out);
	fwrite(&b1,1,1,out);
	fwrite(&b2,1,1,out);
	fwrite(&b3,1,1,out);
	fwrite(&b4,1,1,out);
	fwrite(&b5,1,1,out);
	fwrite(&b6,1,1,out);
	fwrite(&b7,1,1,out);
	fwrite(&b8,1,1,out);
	fwrite(&b9,1,1,out);
	fwrite(&b10,1,1,out);
	fwrite(&b11,1,1,out);
	fwrite(&b12,1,1,out);
	fwrite(&b13,1,1,out);
	fwrite(&b14,1,1,out);
	fwrite(&b15,1,1,out);
	if(stat != 18) exit(0);
}

Process()
{
int i ;
	for(i=0;i<258;i++){
		WriteBuf(ReadLine());
	}
}
void main()
{
	in = fopen("crom.log.txt","r");
	out = fopen("crom.bin","w");
	Process();
	fclose(in);
	fclose(out);
}
