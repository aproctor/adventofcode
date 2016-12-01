#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#if defined(__APPLE__)
#  define COMMON_DIGEST_FOR_OPENSSL
#  include <CommonCrypto/CommonDigest.h>
#  define SHA1 CC_SHA1
#else
#  include <openssl/md5.h>
#endif

#define SAFETY 10000000
#define BUFF_SIZE 40

//MD5 solution courtesy of http://stackoverflow.com/questions/7627723/how-to-create-a-md5-hash-of-a-string-in-c
char *str2md5(const char *str, int length) {
    int n;
    MD5_CTX c;
    unsigned char digest[16];
    char *out = (char*)malloc(33);

    MD5_Init(&c);

    while (length > 0) {
        if (length > 512) {
            MD5_Update(&c, str, 512);
        } else {
            MD5_Update(&c, str, length);
        }
        length -= 512;
        str += 512;
    }

    MD5_Final(digest, &c);

    for (n = 0; n < 16; ++n) {
        snprintf(&(out[n*2]), 16*2, "%02x", (unsigned int)digest[n]);
    }

    return out;
}

int findMinNum(const char *key, int numZeroes) {
    char buffer[BUFF_SIZE] = "";

    printf("Searching for first to match <%i> 0's with key <%s>...\n", numZeroes, key);

    for(int i = 0; i < SAFETY; i++) {
        sprintf(buffer, "%s%i", key, i);


        char *output = str2md5(buffer, strlen(buffer));


        bool allZeroes = true;
        for(int j = 0; j < numZeroes; j++) {
            allZeroes = (allZeroes && output[j] == '0');
        }
        if(allZeroes) {
            printf("Found <%s> at <%i>\n", output, i);
            free(output);
            return i;
        }

        free(output);
    }

    printf("Not found, try increasing SAFETY size, currently <%i>\n",SAFETY);

    return -1;
}

int main(int argc, char **argv) {

    findMinNum("ckczppom", 5);

    findMinNum("ckczppom", 6);

    return 0;
}



