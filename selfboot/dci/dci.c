/* DCi Dreamcast CD image tool by Jules 
   date : 21st Of November 2000         
   email : jules.dc@gmx.net             
 
   1.0
   - first release.

   1.0a 
   - fixed serious fread() bug       
   
   1.1 
   - no longer loads entire cd image into memory,
     so now you can patch cd images which size is
	 bigger then your RAM size.
   - removed "create new patched image" feature 
     so now you can only patch the image, not create new patched one.
     this was removed to due to the lack of time & the "not load
	 cd image into memory" feature.
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define version "1.1"

FILE* fpIPBIN;
FILE* fpCDIMAGE;

insert_ipbin(char* ipbin, char* cd_image);
int image_sector_size = 2336; // nero / default
int image_start_pos = 8; // nero / default


void main(int argc, char* argv[2])
{

	if(argc != 3)
	{
		printf("DCi %s - Dreamcast CD image tool by Jules\n", version);
		printf("Usage: dci <bootdata> <cd image>\n");
		printf("Inserts <bootdata> (ip.bin) into a cd image.\n");
		printf("<cd image> extension sets image format. *.nrg for nero & *.iso for iso9660.\n");
		printf("Example: dci ip.bin demo.nrg\n");
		printf("Website: http://jules.rules.it");
	
	}

	
	if(argc == 3)
	{
		insert_ipbin(argv[1],argv[2]);
	}
}







insert_ipbin(char* ipbin, char* cd_image)
{

	char* pIPBIN;
	int i, ipbin_size, cdimage_size;
	fpos_t ipbin_pos, cdimage_pos;
	char tmp[3];
	
	if(strlen(cd_image) <= 3)
	{
		printf("%s filename is too short.", cd_image);
		return -1;
	}
	else
	{
	
	for(i=0;i < 4; i++)
	{
		tmp[i]=cd_image[(strlen(cd_image)-3+i)];
	}
		
		if(!strcmp((strupr(tmp)),"NRG")) 
		{
			// already defined.
		}
			else
			{
				if(!strcmp((strupr(tmp)),"ISO"))
				{
				image_sector_size=2048;
				image_start_pos=0;
				}
				else
				{
					printf("File extension %s not supported.\n",strupr(tmp));
				}
			}
	
	}
	
	
	if(!(fpIPBIN = fopen( ipbin, "rb" )))
	{	
		printf("Could not open file for reading : %s", ipbin);
		return -1;
	}

	if(!(fpCDIMAGE = fopen( cd_image, "r+b")))
	{
		printf("Could not open file for read : %s", cd_image);
		return -1;
	}

		
	
	fseek(fpCDIMAGE, 0, SEEK_END);
	cdimage_size = ftell(fpCDIMAGE);

	fseek(fpIPBIN, 0, SEEK_END);
	ipbin_size = ftell(fpIPBIN);
	
	if(ipbin_size != 32768)
	{
		printf("%s is not 32678 bytes long",ipbin);
		return -1;
	}

		/*
    smallest supported sector size = 2048
	32768/2048 = 16
	32768 = ip.bin size.
	*/

	if(cdimage_size < (16*image_sector_size))
	{
		printf("%s size is too small!", cd_image);
		return -1;
	}
		
	if(!(pIPBIN = (unsigned char*)malloc(ipbin_size)))
	{
		printf("Could not allocate %s", ipbin);
		return -1;
	}

	fseek(fpCDIMAGE, 0, SEEK_SET);
	fseek(fpIPBIN, 0, SEEK_SET);

	

	fread(pIPBIN, 32768 ,1, fpIPBIN);


	ipbin_pos=0;
	cdimage_pos=image_start_pos;
	
	/* the input function 
	
	nero image sector size = 2336
	- first 8 bytes = header
	- all bytes after 2048+8 = footer
	- between 8 & 2048+8 = data

	iso9660 sector size    = 2048

	Thanks to loser for information and help.
	http://www.loser-console.com

   */
	for(i=0;i < (32768/2048); i++)
	{
		fsetpos( fpCDIMAGE, &cdimage_pos );
		fwrite(pIPBIN+ipbin_pos, sizeof( char ), 2048, fpCDIMAGE);
		ipbin_pos+=2048;
		cdimage_pos+=image_sector_size;
	
	}	

	fclose( fpIPBIN );
	fclose( fpCDIMAGE );
	free( pIPBIN );
	printf("%s succesfully patched.\n", cd_image);

	return 0;
}