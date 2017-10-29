//
//  UserContainerCell.h
//  TTT
//
//  Created by chenbowen on 2017/10/21.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^UserContainerCellDeleteButtonAction)();
typedef void(^UserContainerCellTapAction)();

@interface UserContainerCell : UITableViewCell


/** */
@property (nonatomic ,strong) NSArray *dataSourceArray;



/** 删除按钮事件*/
@property (nonatomic ,strong) UserContainerCellDeleteButtonAction deleteAction;

/** 点击cell*/
@property (nonatomic ,strong) UserContainerCellTapAction tapAction;

@end
