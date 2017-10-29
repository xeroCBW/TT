//
//  ComboVC.m
//  TTT
//
//  Created by chenbowen on 2017/10/21.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "ComboVC.h"
#import "UserContainerCell.h"

@interface ComboVC ()

/** */
@property (nonatomic ,strong) NSMutableArray *userArray;

@end

@implementation ComboVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.bounces = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [super numberOfSectionsInTableView:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    
    if (indexPath.section == 1) {
        
        UserContainerCell *cell = [[UserContainerCell alloc]init];
        
        cell.dataSourceArray = self.userArray;
        
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
        return [super tableView:tableView indentationLevelForRowAtIndexPath:path];
    }
    
    
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 1) {
        
        
      return self.userArray.count * 44;
    }
    
    return  48;
}

#pragma mark - lazy

-(NSMutableArray *)userArray{
    
    
    if (_userArray == nil) {
        
        
        _userArray = [NSMutableArray array];
        
        [_userArray addObject: @""];
        [_userArray addObject: @""];
        [_userArray addObject: @""];
    }
    
    return _userArray;
}

@end
