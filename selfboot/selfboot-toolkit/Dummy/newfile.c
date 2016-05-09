// newfile.c

#include <stdlib.h>
#include <stdio.h>

void main(int argc, char** argv)
{
	FILE* fp = NULL;
	char* name =  "00DUMMY.DAT";
	unsigned int size = 0;

	if (argc<2)
	{
		printf("Usage: newfile <size in bytes> [filename]\n");
		exit(-1);
	}

	size = atoi(argv[1]);
	if (argc==3)
		name = argv[2];

	printf("Creating file...");

	fp = fopen(name, "wb");
	fseek(fp,size-1,SEEK_SET);
	fputc('\0',fp);
	fclose(fp);

	printf("Done.\n");

}
