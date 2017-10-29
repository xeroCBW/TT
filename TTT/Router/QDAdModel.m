//
//  QDAdModel.m
//  QDEwallet
//
//  Created by zhoudl on 2017/1/23.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "QDAdModel.h"
#import "NSObject+QDDictToModel.h"

@implementation QDAdModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {

        [self qd_modelInitWithCoder:aDecoder];
    }
    return self ;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [self qd_modelEncodeWithCoder:aCoder];
}

@end

@implementation QDAdPresentOption

- (instancetype)init {
    if (self = [super init]) {
        self.animated = YES;
        self.isPush = YES;
        self.hasRefresh = YES;
        self.needShare = YES;
    }
    return self;
}

+ (instancetype)option {
    return [[self alloc] init];
}

- (QDAdPresentOption *)withNeedShare:(BOOL)needShare {
    self.needShare = needShare;
    return self;
}

- (QDAdPresentOption *)withHasRefresh:(BOOL)hasRefresh {
    self.hasRefresh = hasRefresh;
    return self;
}

- (QDAdPresentOption *)withIsPush:(BOOL)isPush {
    self.isPush = isPush;
    return self;
}

- (QDAdPresentOption *)withAnimated:(BOOL)animated {
    self.animated = animated;
    return self;
}

@end
