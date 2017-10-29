//
//  TFVC.m
//  TTT
//
//  Created by chenbowen on 2017/10/23.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "TFVC.h"
#import "CustomerTextField.h"

@interface TFVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textF;
@end

@implementation TFVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    CustomerTextField *ff = [[CustomerTextField alloc]initWithFrame:CGRectMake(0, 400, 300, 50)];
    ff.backgroundColor = [UIColor redColor];
    ff.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:ff];
    
    self.textF.delegate = self;
    
    ff.delegate = self;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

@end
