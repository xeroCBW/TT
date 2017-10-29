//
//  InfoVC.m
//  TTT
//
//  Created by chenbowen on 2017/10/29.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "InfoVC.h"
#import "NSDictionary+String.h"



@interface InfoVC ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation InfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    
    self.textView.text = dict.cc_json;
    
}


@end
