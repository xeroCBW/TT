//
//  UserCell.m
//  TT
//
//  Created by chenbowen on 2017/10/6.
//  Copyright © 2017年 yiyou. All rights reserved.
//

#import "UserCell.h"

@interface UserCell ()

//用户等登录账号
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

//用户的头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCellAction)];
    
    [self.contentView addGestureRecognizer:tap];
    
}


//-(void)setAuthModel:(AuthModel *)authModel{
//    
//    _authModel = authModel;
//    
//    NSString *string = @"";
//    
//    if (authModel.loginAccountType == LoginAccountTypePhone) {
//        string = authModel.phone;
//    }else if (authModel.loginAccountType == LoginAccountTypeAccount){
//        string = authModel.account;
//        if([string containsString:@"tt"]){//截取掉前面的tt
//            string = [string stringByReplacingOccurrencesOfString:@"tt" withString:@""];
//        }
//    }
//    self.phoneLabel.text = string;
//    
//    [self.iconImageView setImageWithAvatarForAccount:authModel.account cornerRadius:self.iconImageView.frame.size.height * 0.5];
//    
//}


- (IBAction)deltetAction:(UIButton *)sender {
    
    
    if (self.deleteAction) {
        
        self.deleteAction();
    }
}



- (void)tapCellAction{
    
    if (self.tapAction) {
        self.tapAction();
    }
}

@end
