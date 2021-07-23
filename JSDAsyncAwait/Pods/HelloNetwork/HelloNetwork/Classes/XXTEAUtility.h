/*
 *  Utility.h
 *  inCarTime
 *
 *  Created by PippoTan on 11-7-5.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef UTILITY_H
#define UTILITY_H
#endif

#include "MacTypes.h"

bool xTEADecryptWithKey(const char *crypt, unsigned int crypt_len,const char key[16], char *plain, unsigned int * plain_len);
bool xTEAEncryptWithKey(const char *plain, unsigned int plain_len, const char key[16], char *crypt, unsigned int * crypt_len );

