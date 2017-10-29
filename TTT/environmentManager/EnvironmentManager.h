//
//  EnvironmentManager.h
//  TTT
//
//  Created by chenbowen on 2017/10/26.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnvironmentManager : NSObject

/** 环境*/
@property (nonatomic ,assign) BOOL enbleLabel;
/** DISTRIBUTION*/
@property (nonatomic ,assign) BOOL distribution;

+ (instancetype)sharedInstance;



- (void)initConfig;

@end
