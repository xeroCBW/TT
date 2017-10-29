//
//  OpenURLTableViewController.m
//  TTT
//
//  Created by chenbowen on 2017/10/29.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "OpenURLTableViewController.h"
#import "QDRouter.h"
#import "Model.h"
#import <YYModel.h>
#import "QDAboutTVC.h"

@interface OpenURLTableViewController ()

@end

@implementation OpenURLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelected....");
    
    Model2 *model2 = [[Model2 alloc]init];
    model2.model2String = @"model2String";
    
    
    Model1 *model1 = [[Model1 alloc]init];
    model1.model1String = @"model1String";
    model1.model2 = model2;
    
    Model *model = [[Model alloc]init];
    model.modelString = @"modelString";
    model.model1 = model1;
    
 
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"stringPara" forKey:@"stringPara"];
    [dict setObject:@(100) forKey:@"intPara"];
    [dict setObject:model forKey:@"model"];
    
    QDRouterPresentOption *option = [QDRouterPresentOption option];
    
    QDRouterCallBackBlock callBack = nil;
    
    if (indexPath.row == 0) {
        
        option = [QDRouterPresentOption optionAsModal];
        
    }else if (indexPath.row == 1){
        
      //不设置,默认是push
        
    }else if (indexPath.row == 2){
        
        __weak typeof(self) weakSelf = self;
        callBack = ^NSString *(id result) {
            
            weakSelf.navigationController.title = @"callBackChangeTitle";
            weakSelf.navigationItem.title = @"callBackChangeTitle";
            
            return  @"";
        };
    }
    
    [[QDRouter sharedRouter]open:@"About" presentOption:option extraParams:dict routerCallBack:callBack];
   
    
}


@end
