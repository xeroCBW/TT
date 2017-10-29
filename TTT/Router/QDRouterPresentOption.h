//
//  QDRouterPresentOption.h
//  QDRouterDemo
//
//  Created by chenbowen on 2017/5/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDRouterPresentOption : NSObject

/**
 @return A new instance of `QDRouterPresentOption` with its properties explicitly set
 @param presentationStyle The `UIModalPresentationStyle` attached to the mapped `UIViewController`
 @param transitionStyle The `UIModalTransitionStyle` attached to the mapped `UIViewController`
 @param isRoot The boolean `shouldOpenAsRootViewController` property is set to
 @param isModal The boolean that sets a modal presentation format
 */
+ (instancetype)optionWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                            transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     isRoot: (BOOL)isRoot
                                    isModal: (BOOL)isModal
                                 isAnimated: (BOOL)animated
                           shouldDismissWeb: (BOOL)shouldDismissWeb
                      asChildViewController:(BOOL)asChildViewController;

+ (instancetype)option;

+ (instancetype)optionAsModal;

- (QDRouterPresentOption *)modal;

- (QDRouterPresentOption *)withPresentationStyle:(UIModalPresentationStyle)style;

- (QDRouterPresentOption *)withTransitionStyle:(UIModalTransitionStyle)style;

- (QDRouterPresentOption *)root;

- (QDRouterPresentOption *)withAnimated:(BOOL)animated;

//是否先移除过渡页面(中间的webViewController,并没有加到navigationController中)
- (QDRouterPresentOption *)withShouldDismissWeb:(BOOL)shouldDismissWeb;

- (QDRouterPresentOption *)withAsChildViewController:(BOOL)asChildViewController;

@property (nonatomic, assign, getter=isModal) BOOL modal;

@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;

@property (nonatomic, assign) UIModalTransitionStyle transitionStyle;

@property (nonatomic, assign) BOOL shouldOpenAsRootViewController;

@property (nonatomic, assign, getter=isAnimated) BOOL animated;
/** 是否先关闭跳转进来的H5 */
@property (nonatomic, assign) BOOL shouldDismissWeb;
/** 是否作为子控制器 */
@property (nonatomic, assign) BOOL asChildViewController;

@end
