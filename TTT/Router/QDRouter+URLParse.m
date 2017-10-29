//
//  QDRouter+URLParse.m
//  QDEwallet
//
//  Created by chenbowen on 2017/6/16.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "QDRouter+URLParse.h"

#import "NSString+JKURLEncode.h"
#import "NSString+QDEncrypt.h"
#import "NSURL+JKParam.h"

#import <objc/runtime.h>

@interface NSString (QDRouter)

- (NSString *)appendArguementWithParameters:(NSDictionary *)params;

@end

@implementation QDRouter (URLParse)

NSString *const QDURLParserSeparator = @"_";
NSString *const QDURLParserSignKey   = @"url_check_sign";

- (void)setupScheme:(NSString *)scheme host:(NSString *)host signCheck:(NSString *)signCheck {
    self.scheme = scheme;
    self.host = host;
    self.signSalt = signCheck;
}

- (NSString *)signWithMapKey:(NSString *)mapKey params:(NSDictionary *)params {
    return [self appendSignCheckToUrl:[[[self getNativeBaseUrl] stringByAppendingString:mapKey] appendArguementWithParameters:params]];
}

- (BOOL)canOpenURL:(NSURL *)url {
    if (![url.scheme isEqualToString:self.scheme]) {
        return NO;
    }
    
    if (![url.host isEqualToString:self.host]) {
        return NO;
    }
    
    NSArray *pathComponents = url.pathComponents;
    NSString *mapkey = pathComponents.lastObject;
    if (![self.routes.allKeys containsObject:mapkey]) {
        return NO;
    }
    
    NSDictionary *paramInfo = [url.query jk_dictionaryFromURLParameters];
    
    if (self.signSalt && self.signSalt.length > 0)
    {
        NSMutableString *checkContent = [[NSMutableString alloc] initWithString:mapkey];
        [checkContent appendString:QDURLParserSeparator];
        NSArray *sortKeys = [NSArray arrayWithArray:[self getSortKeysFromDictionaryWithASC:paramInfo]];
        
        NSString *checkSign = nil;
        for (NSString *key in sortKeys)
        {
            if (![key isEqualToString:QDURLParserSignKey])
            {
                [checkContent appendString:key];
                [checkContent appendString:QDURLParserSeparator];
                [checkContent appendString:paramInfo[key]];
                [checkContent appendString:QDURLParserSeparator];
            }
            else
            {
                checkSign = paramInfo[key];
            }
        }
        [checkContent appendString:self.signSalt];
        NSString *content = [[NSString alloc] initWithString:checkContent];
        NSString *contentSign = [content qd_md5String];
        
        return [checkSign isEqualToString:contentSign];
    } else {
        // 不校验签名直接响应
        return YES;
    }
}

- (void)openURL:(NSURL *)url routerCallBack:(QDRouterCallBackBlock)routerCallBack {
    [self openURL:url presentOption:nil routerCallBack:routerCallBack];
}

- (void)openURL:(NSURL *)url presentOption:(QDRouterPresentOption *)presentOption routerCallBack:(QDRouterCallBackBlock)routerCallBack {
    [self open:url.pathComponents.lastObject presentOption:presentOption extraParams:url.jk_parameters routerCallBack:routerCallBack];
}

#pragma mark - Private
- (NSString *)getNativeBaseUrl {
    NSMutableString * urlstring = [NSMutableString stringWithString:self.scheme];
    [urlstring appendString:@"://"];
    [urlstring appendString:self.host];
    [urlstring appendString:@"/"];
    return urlstring.copy;
}

- (NSString *)appendSignCheckToUrl:(NSString *)urlstr {
    NSMutableString * urlstring = [NSMutableString stringWithString:urlstr];
    NSURL * url = [NSURL URLWithString:urlstring];
    NSArray *pathComponents = url.pathComponents;
    NSString *actionName = pathComponents.lastObject;
    NSDictionary *paramInfo = [url.query jk_dictionaryFromURLParameters];
    
    if (self.signSalt && self.signSalt.length > 0)
    {
        /*
         验证签名创建规则如下：
         1.actionName 拼接分隔符，得到初始串;
         2.获取 queryString 参数并转化为字典对象;
         3.获取字典升序 keys 数组，并取出 key-value 键值对
         4.初始串拼接： key 分隔符 value 分隔符
         5.重复步骤4，直到遍历完所有key。注意，当字典对象中已经包含签名字段时直接获取签名，丢弃已拼接字串，直接返回原始URL。
         6.keys 遍历完毕后，最后拼接盐值。
         7.对上述最终拼接字串作 MD5 加密即可得到验证签名。
         */
        NSMutableString *checkContent = [[NSMutableString alloc] initWithString:actionName];
        [checkContent appendString:QDURLParserSeparator];
        NSArray *sortKeys = [NSArray arrayWithArray:[self getSortKeysFromDictionaryWithASC:paramInfo]];
        
        NSString *checkSign = nil;
        for (NSString *key in sortKeys)
        {
            if (![key isEqualToString:QDURLParserSignKey])
            {
                [checkContent appendString:key];
                [checkContent appendString:QDURLParserSeparator];
                [checkContent appendString:paramInfo[key]];
                [checkContent appendString:QDURLParserSeparator];
            }
            else
            {
                checkSign = paramInfo[key];
                break;
            }
        }
        
        if (checkSign)
        {
            // 已经存在sign直接返回
            return urlstr;
        }
        
        [checkContent appendString:self.signSalt];
        NSString *content = [[NSString alloc] initWithString:checkContent];
        NSString *contentSign = [content qd_md5String];
        
        return [url jk_addParameters:@{QDURLParserSignKey:contentSign}].absoluteString;
    }
    else
    {
        return urlstr;
    }
}

/**
 对字典keys升序排序后返回排序的升序Keys数组
 
 @param dict 要排序的字典
 @return 按升序排序的字典keys数组
 */
- (NSArray *)getSortKeysFromDictionaryWithASC:(NSDictionary*)dict
{
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    return sortedArray;
}

#pragma mark - Setters & Getters
- (void)setScheme:(NSString *)scheme {
    objc_setAssociatedObject(self, @selector(scheme), scheme, OBJC_ASSOCIATION_COPY);
}

- (NSString *)scheme {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHost:(NSString *)host {
    objc_setAssociatedObject(self, @selector(host), host, OBJC_ASSOCIATION_COPY);
}

- (NSString *)host {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSignSalt:(NSString *)signSalt {
    objc_setAssociatedObject(self, @selector(signSalt), signSalt, OBJC_ASSOCIATION_COPY);
}

- (NSString *)signSalt {
    return objc_getAssociatedObject(self, _cmd);
}

@end


@implementation NSString (QDRouter)

- (NSString *)appendArguementWithParameters:(NSDictionary *)params {
    __block NSURL *url = [NSURL URLWithString:self];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id _Nonnull value, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSString class]]) {
            if (key.length && [value length]) {
                url = [url jk_addParameters:@{key : value}];
            }
        }else if ([value isKindOfClass:[NSNumber class]]) {
            if (key.length) {
                url = [url jk_addParameters:@{key : [value stringValue]}];
            }
        }
    }];
    return url.absoluteString;
}

@end
