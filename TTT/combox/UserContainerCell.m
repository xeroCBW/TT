//
//  UserContainerCell.m
//  TTT
//
//  Created by chenbowen on 2017/10/21.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "UserContainerCell.h"
#import "UserCell.h"

@interface UserContainerCell ()<UITableViewDelegate,UITableViewDataSource>

/** tableView*/
@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation UserContainerCell



- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)layoutSubviews{
    
    
    [super layoutSubviews];
    
    
    self.tableView.frame = self.contentView.bounds;
}



#pragma mark - delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataSourceArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell" forIndexPath:indexPath];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tapAction) {
        self.tapAction();
    }
    
    return [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - lazy
-(UITableView *)tableView{
    
    
    if (_tableView == nil) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        [tableView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
        
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


#pragma mark - setter
-(void)setDataSourceArray:(NSArray *)dataSourceArray{
    
    _dataSourceArray = dataSourceArray;
    
    [self.tableView reloadData];
}

@end
