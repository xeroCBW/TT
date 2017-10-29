//
//  QDAboutTVC.m
//  TTT
//
//  Created by chenbowen on 2017/10/29.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDAboutTVC.h"
#import <YYModel.h>
#import "QDRouter.h"


@interface QDAboutTVC ()

@end

@implementation QDAboutTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"点击消失...";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"---------%s---------",__func__);
    
    NSLog(@"model:%@",_model.yy_modelToJSONString);
    NSLog(@"intPara:%d",_intPara);
    NSLog(@"stringPara:%@",_stringPara);
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.routerCallBack) {
        
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"点击我会执行callBackBlock,改变title哦" message:@"" preferredStyle:0];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:0 handler:^(UIAlertAction * _Nonnull action) {
            
            self.routerCallBack(nil);
            [self.navigationController popViewControllerAnimated:YES];
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [vc addAction:action];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    
}

@end
