//
//  NSObject+QDDictToModel.m
//  QDEwallet
//
//  Created by chenbowen on 2017/2/10.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "NSObject+QDDictToModel.h"
#import <YYModel/YYModel.h>

@implementation NSObject (QDDictToModel)

- (BOOL)qd_modelSetWithDictionary:(NSDictionary *)dict {
    return [self yy_modelSetWithDictionary:dict];
}

- (BOOL)qd_modelSetWithJSON:(id)json {
    return [self yy_modelSetWithJSON:json];
}

+ (instancetype)qd_modelWithJSON:(id)json {
    return [self yy_modelWithJSON:json];
}

+ (instancetype)qd_modelWithDictionary:(NSDictionary *)dictionary {
    return [self yy_modelWithDictionary:dictionary];
}

@end

@implementation NSObject (QDModelToDict)

- (id)qd_modelToJSONObject {
    return self.yy_modelToJSONObject;
}

/**  */
- (NSData *)qd_modelToJSONData {
    
    return self.yy_modelToJSONData;
}
/** 将对象转换成字符串 */
- (NSString *)qd_modelToJSONString {
   
    return self.yy_modelToJSONString;
}

/**  */
- (NSString *)qd_modelDescription {
    return self.yy_modelDescription;
}

/**
 Decode the receiver's properties from a decoder.
 
 @param aDecoder  An archiver object.
 
 @return self
 */
- (id)qd_modelInitWithCoder:(NSCoder *)aDecoder{
    
    return [self yy_modelInitWithCoder:aDecoder];
}

/**
 Encode the receiver's properties to a coder.
 
 @param aCoder  An archiver object.
 */
- (void)qd_modelEncodeWithCoder:(NSCoder *)aCoder{
    
    [self yy_modelEncodeWithCoder:aCoder];
}
@end
