//
//  CollectionViewController.m
//  TTT
//
//  Created by chenbowen on 2017/10/24.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "CollectionViewController.h"
#import "JPWaterflowLayout.h"

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** */
@property (nonatomic ,strong) UICollectionView *collectionView;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:self.collectionView];
    
    
   
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


#pragma mark - lazy


-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        UICollectionViewLayout *collectionViewLayout = [[JPWaterflowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:collectionViewLayout];
        // 切换布局
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}

@end
