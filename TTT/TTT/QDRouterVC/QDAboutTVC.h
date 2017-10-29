//
//  QDAboutTVC.h
//  TTT
//
//  Created by chenbowen on 2017/10/29.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface QDAboutTVC : UIViewController


/**设置参数*/
@property (nonatomic ,copy) NSString *stringPara;


/** intPara*/
@property (nonatomic ,assign) int intPara;

/** model模型*/
@property (nonatomic ,strong) Model *model;



@end
