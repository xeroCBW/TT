//
//  ViewController.m
//  TTT
//
//  Created by chenbowen on 2017/10/21.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "ViewController.h"
#import "EnvironmentManager.h"
#import <YYModel.h>
#import "NSDictionary+String.h"
#import "InfoVC.h"
#import "ComboVC.h"
#import "TFVC.h"
#import "CollectionViewController.h"

#define GETVC(indentifier) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:indentifier]

@interface ViewController ()


@end

@implementation ViewController




#pragma mark - private
// secondViewController* svc =[[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"secondVCSrorybradID"];



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     ;

    
    if (indexPath.row == 0) {
        
        InfoVC *vc = (InfoVC *)GETVC(@"InfoVC");
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
        
        ComboVC *vc = (ComboVC *)GETVC(@"ComboVC");
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        
      
        
    }else if (indexPath.row == 3){
        
        TFVC *vc = (TFVC *)GETVC(@"TFVC");
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (indexPath.row == 4){
        
        CollectionViewController *vc = (CollectionViewController *)GETVC(@"CollectionViewController");
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}



@end
