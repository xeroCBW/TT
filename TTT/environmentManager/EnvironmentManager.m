//
//  EnvironmentManager.m
//  TTT
//
//  Created by chenbowen on 2017/10/26.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "EnvironmentManager.h"

static EnvironmentManager *_instance;
@interface EnvironmentManager()

@end

@implementation EnvironmentManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
#pragma mark - 设置基本数据


- (void)initConfig{
    
    _distribution = NO;
    _enbleLabel = NO;
}


-(BOOL)enbleLabel{
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"lab" ofType:@"plist"];
    NSMutableDictionary *labDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    NSNumber *value = [labDictionary objectForKey:@"enableLab"];

    return value.boolValue;
}


@end
