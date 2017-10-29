//
//  UserCell.h
//  TT
//
//  Created by chenbowen on 2017/10/6.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteButtonAction)(void);
typedef void(^TapAction)(void);




@interface UserCell : UITableViewCell

/** 删除按钮事件*/
@property (nonatomic ,strong) DeleteButtonAction deleteAction;

/** 点击cell*/
@property (nonatomic ,strong) TapAction tapAction;
///** 用户手机号*/
//@property (nonatomic ,copy) NSString *phone;


/** model*/
//@property (nonatomic ,strong) AuthModel *authModel;

@end
