//
//  CustomerTextField.h
//  TTT
//
//  Created by chenbowen on 2017/10/23.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
/*使用装者方法,将删除按钮增强*/
@interface CustomerTextField : UITextField


/** 删除按钮图片*/
@property (nonatomic ,strong)IBInspectable UIImage *deleteButtonImage;

@end
