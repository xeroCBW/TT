//
//  Model.h
//  TTT
//
//  Created by chenbowen on 2017/10/29.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model1.h"

@interface Model : NSObject



/** */
@property (nonatomic ,copy) NSString *modelString;

/** model1*/
@property (nonatomic ,strong) Model1 *model1;

@end
