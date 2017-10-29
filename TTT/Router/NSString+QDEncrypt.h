//
//  NSObject+QDEncrypt.h
//  QDEwallet
//
//  Created by chenbowen on 2017/1/18.
//  Copyright © 2017年 QD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QDEncrypt)
/**
 *  使用DES加密
 *
 *  @param key 加密Key
 *
 *  @return 返回DES加密后的字符串
 */
- (NSString *)DESEncryptWithKey:(NSString *)key;

/**
 *  使用DES解密
 *
 *  @param key 解密Key
 *
 *  @return 返回DES解密后的字符串
 */
- (NSString *)DESDecryptWithKey:(NSString *)key;

/** base64加密 */
- (NSString *)qd_base64EncodedString;
/** base64解密 */
- (NSString *)qd_base64DecodedString;
/** base64解密Data */
- (NSData *)qd_base64DecodedData;

/** MD5加密 */
- (NSString *)qd_md5String;
/** MD5加密后base64 */
- (NSString *)qd_md5_base64String;

@end
