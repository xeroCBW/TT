//
//  CustomerTextField.m
//  TTT
//
//  Created by chenbowen on 2017/10/23.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "CustomerTextField.h"


//
@interface CustomerTextField()


/** 自定义删除按钮*/
@property (nonatomic ,strong) UIButton *deleteButton;

@end

@implementation CustomerTextField



- (instancetype)init
{
    self = [super init];
    if (self) {
        

        [self setUpRightView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpRightView];
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self setUpRightView];
}



#pragma mark - constrctor


-(void)setDeleteButtonImage:(UIImage *)deleteButtonImage{
    
    _deleteButtonImage = deleteButtonImage;
    
    [self.deleteButton setBackgroundImage:deleteButtonImage forState:UIControlStateNormal];
}


#pragma mark - 设置初始位置
-(CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.bounds.size.width-40, 0, 40, self.bounds.size.height);
}

#pragma mark - lazy

-(UIButton *)deleteButton{
    
    if (_deleteButton == nil) {

        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, self.bounds.size.height)];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _deleteButton.backgroundColor = [UIColor lightGrayColor];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteButton;
}


#pragma mark - private


- (void)setUpRightView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.bounds.size.height)];
    
    [view addSubview:self.deleteButton];
    
    self.rightView = view;
    self.rightViewMode = UITextFieldViewModeAlways;
    
     [self addTarget:self action:@selector(handleTextLength) forControlEvents:UIControlEventAllEvents];
    
    //一开始设置为隐藏
    self.deleteButton.hidden = YES;
    
}

- (void)handleTextLength{
    
    if (self.text.length>=1) {
        
        self.deleteButton.hidden = NO;
        
    }else{
        
        self.deleteButton.hidden = YES;
        
    }
    
    if(!self.editing) {
        
        self.deleteButton.hidden = YES;
    }
}

-(void)deleteAction:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        [self.delegate textFieldShouldClear:self];
    }
    
    self.text = @"";
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    
    if(self.text.length == 0) {
        
        self.deleteButton.hidden = YES;
    }
    
    [self becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:UITextFieldTextDidChangeNotification object:self];
}

@end
