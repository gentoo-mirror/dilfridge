
/* Find how deeply inside an .RPM the real data is */
/* kept, and report the offset in bytes */

/* Wouldn't it be a lot more sane if we could just untar these things? */

#include <stdlib.h>
#include <stdio.h>

/* These offsets keep getting bigger, so we're going to just bite a 2MB */
/* chunk of RAM right away so that we have enough.  Yeah, horrible */
/* quick and dirty implementation, but hey -- it gets the job done. */

#define RPMBUFSIZ 3145728

main()
{
	char *buff = malloc(RPMBUFSIZ),*eb,*p;
	for (p = buff, eb = buff + read(0,buff,RPMBUFSIZ); p < eb; p++)
	{

		/* gzip format */
		if (*p == '\037' && p[1] == '\213' && p[2] == '\010') 
		{
			printf("%ld\n",p - buff);
			exit(0);
		}

		/* bzip2 format */
		else if (*p == 'B' && p[1] == 'Z' && p[2] == 'h' )
		{
			printf("%ld\n",p - buff);
			exit(0);
		}

		/* LZMA files; both LZMA_Alone and LZMA utils formats. The LZMA_Alone
		* format is used by the LZMA_Alone tool from LZMA SDK. The LZMA utils
		* format is the default format of LZMA utils 4.32.1 and later. */

		/* LZMA utils format */
		else if (*p == '\377' && p[1] == 'L' &&
			 p[2] == 'Z' && p[3] == 'M' &&
			 p[4] == 'A' && p[5] == '\000')
		{
			printf("%ld\n",p - buff);
			exit(0);
		}

		/* The LZMA_Alone format has no magic bytes, thus we
		* need to play a wizard. This can give false positives,
		* thus the detection below should be removed when
		* the newer LZMA utils format has got popular. */
//		else if (*p == 0x5D && p[1] == 0x00 &&
		else if (*p == '\135' &&
			 p[5] == '\377' && p[6] == '\377' &&
			 p[7] == '\377' && p[8] == '\377' &&
			 p[9] == '\377' && p[10] == '\377' &&
			 p[11] == '\377' && p[12] == '\377')

/*			((p[10] == 0x00 && p[11] == 0x00 &&
			  p[12] == 0x00) ||
			 (p[5] == 0xFF && p[6] == 0xFF &&
			  p[7] == 0xFF && p[8] == 0xFF &&
			  p[9] == 0xFF && p[10] == 0xFF &&
			  p[11] == 0xFF && p[12] == 0xFF)))
*/		{
			printf("%ld\n",p - buff);
			exit(0);
		}
	}
        exit(1);
}
