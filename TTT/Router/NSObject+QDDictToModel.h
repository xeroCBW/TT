//
//  NSObject+QDDictToModel.h
//  QDEwallet
//
//  Created by chenbowen on 2017/2/10.
//  Copyright © 2017年 QD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (QDDictToModel)

- (BOOL)qd_modelSetWithDictionary:(NSDictionary *)dict;

- (BOOL)qd_modelSetWithJSON:(id)json;

+ (instancetype)qd_modelWithJSON:(id)json;

+ (instancetype)qd_modelWithDictionary:(NSDictionary *)dictionary;

@end

@interface NSObject (QDModelToDict)
/** 转换成json对象,默认是NSArray和NSDictionary*/
- (id)qd_modelToJSONObject;

- (NSString *)qd_modelDescription;

/** 将对象转换成json以data形式存在*/
- (NSData *)qd_modelToJSONData;
/** 将对象转换成字符串 */
- (NSString *)qd_modelToJSONString;


/**
 Decode the receiver's properties from a decoder.
 
 @param aDecoder  An archiver object.
 
 @return self
 */
- (id)qd_modelInitWithCoder:(NSCoder *)aDecoder;
/**
 Encode the receiver's properties to a coder.
 
 @param aCoder  An archiver object.
 */
- (void)qd_modelEncodeWithCoder:(NSCoder *)aCoder;

@end
