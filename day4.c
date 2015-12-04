#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#if defined(__APPLE__)
#  define COMMON_DIGEST_FOR_OPENSSL
#  include <CommonCrypto/CommonDigest.h>
#  define SHA1 CC_SHA1
#else
#  include <openssl/md5.h>
#endif

#define SAFETY 100000

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

int main(int argc, char **argv) {
    char *output = str2md5("hello", strlen("hello"));
    printf("%s\n", output);
    free(output);
    return 0;
}


int findMinNum(const char *key, int numZeroes) {
    for(int i = 0; i < SAFETY; i++) {
        //TODO stuff
    }

    return -1;
}