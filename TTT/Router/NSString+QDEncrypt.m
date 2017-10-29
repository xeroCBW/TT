//
//  NSObject+QDEncrypt.m
//  QDEwallet
//
//  Created by chenbowen on 2017/1/18.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "NSString+QDEncrypt.h"
#import "NSString+JKEncrypt.h"
#import "NSString+JKBase64.h"
#import "NSString+JKHash.h"

@implementation NSString (QDEncrypt)

static NSString *const kKey = @"12345678";

- (NSString *)DESEncryptWithKey:(NSString *)key {
    if (key.length == 0) {
        key = kKey;
    }
    
    return [self jk_encryptedWithDESUsingKey:key andIV:[key dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)DESDecryptWithKey:(NSString *)key {
    if (key.length == 0) {
        key = kKey;
    }
    
    return [self jk_decryptedWithDESUsingKey:key andIV:[key dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)qd_base64EncodedString {
    return self.jk_base64EncodedString;
}

- (NSString *)qd_base64DecodedString {
    return self.jk_base64DecodedString;
}

- (NSData *)qd_base64DecodedData {
    return self.jk_base64DecodedData;
}

- (NSString *)qd_md5String {
    return self.jk_md5String;
}

- (NSString *)qd_md5_base64String {
    return self.jk_md5_base64String;
}

@end
