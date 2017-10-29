//
//  Model1.h
//  TTT
//
//  Created by chenbowen on 2017/10/29.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model2.h"

@interface Model1 : NSObject

/** */
@property (nonatomic ,copy) NSString *model1String;

/** model1*/
@property (nonatomic ,strong) Model2 *model2;

@end
