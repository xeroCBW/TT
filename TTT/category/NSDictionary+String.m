//
//  NSDictionary+String.m
//  TTT
//
//  Created by chenbowen on 2017/10/29.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "NSDictionary+String.h"

@implementation NSDictionary (String)


-(NSString *)cc_json{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



@end
