//
//  NSURL+Param.m
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "NSURL+JKParam.h"
#import "NSString+JKURLEncode.h"

@implementation NSURL (JKParam)
/**
 *  @brief  url参数转字典
 *
 *  @return 参数转字典结果
 */
- (NSDictionary *)jk_parameters
{
    NSMutableDictionary * parametersDictionary = [NSMutableDictionary dictionary];
    NSArray * queryComponents = [self.query componentsSeparatedByString:@"&"];
    for (NSString * queryComponent in queryComponents) {
        NSString * key = [queryComponent componentsSeparatedByString:@"="].firstObject;
        NSString * value = [[queryComponent substringFromIndex:(key.length + 1)] stringByRemovingPercentEncoding];
        [parametersDictionary setObject:value forKey:key];
    }
    return parametersDictionary;
}
/**
 *  @brief  根据参数名 取参数值
 *
 *  @param parameterKey 参数名的key
 *
 *  @return 参数值
 */
- (NSString *)jk_valueForParameter:(NSString *)parameterKey
{
    return [[self jk_parameters] objectForKey:parameterKey];
}

- (NSURL *)jk_addParameters:(NSDictionary *)parameters
{
    NSMutableString *_add = nil;
    if (NSNotFound != [self.absoluteString rangeOfString:@"?"].location) {
        _add = [NSMutableString stringWithString:@"&"];
    }else {
        _add = [NSMutableString stringWithString:@"?"];
    }
    for (NSString* key in [parameters allKeys]) {
        if ([parameters objectForKey:key] && 0 < [[parameters objectForKey:key] length]) {
            [_add appendFormat:@"%@=%@&",key,[[parameters objectForKey:key] jk_urlEncode]];
        }
    }
    
    NSString *urlWithoutFragment = [self.absoluteString substringToIndex:self.absoluteString.length - (self.fragment.length>0?(self.fragment.length+1):0)];
    NSString *fragment = self.fragment.length > 0 ? [NSString stringWithFormat:@"#%@",self.fragment] : @"";
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",
                                 urlWithoutFragment ,
                                 [_add substringToIndex:[_add length] - 1], fragment]];
}

@end
