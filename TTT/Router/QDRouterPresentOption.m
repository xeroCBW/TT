//
//  QDRouterPresentOption.m
//  QDRouterDemo
//
//  Created by chenbowen on 2017/5/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDRouterPresentOption.h"

@interface QDRouterPresentOption ()

@end

@implementation QDRouterPresentOption

+ (instancetype)optionWithPresentationStyle: (UIModalPresentationStyle)presentationStyle
                            transitionStyle: (UIModalTransitionStyle)transitionStyle
                                     isRoot: (BOOL)isRoot
                                    isModal: (BOOL)isModal
                                 isAnimated: (BOOL)animated
                           shouldDismissWeb: (BOOL)shouldDismissWeb
                      asChildViewController:(BOOL)asChildViewController {
    QDRouterPresentOption *options = [[QDRouterPresentOption alloc] init];
    options.presentationStyle = presentationStyle;
    options.transitionStyle = transitionStyle;
    options.shouldOpenAsRootViewController = isRoot;
    options.modal = isModal;
    options.animated = animated;
    options.shouldDismissWeb = shouldDismissWeb;
    options.asChildViewController = asChildViewController;
    return options;
}

+ (instancetype)option {
    return [self optionWithPresentationStyle:UIModalPresentationFullScreen
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                             isRoot:NO
                                            isModal:NO
                                         isAnimated:YES
                                   shouldDismissWeb:NO
                              asChildViewController:NO];
}

+ (instancetype)optionAsModal {
    return [self optionWithPresentationStyle:UIModalPresentationFullScreen
                                    transitionStyle:UIModalTransitionStyleCoverVertical
                                             isRoot:NO
                                            isModal:YES
                                         isAnimated:YES
                                   shouldDismissWeb:NO
                              asChildViewController:NO];
}

- (QDRouterPresentOption *)modal {
    [self setModal:YES];
    return self;
}
- (QDRouterPresentOption *)withPresentationStyle:(UIModalPresentationStyle)style {
    [self setPresentationStyle:style];
    return self;
}
- (QDRouterPresentOption *)withTransitionStyle:(UIModalTransitionStyle)style {
    [self setTransitionStyle:style];
    return self;
}
- (QDRouterPresentOption *)root {
    [self setShouldOpenAsRootViewController:YES];
    return self;
}
- (QDRouterPresentOption *)withAnimated:(BOOL)animated {
    [self setAnimated:animated];
    return self;
}

- (QDRouterPresentOption *)withShouldDismissWeb:(BOOL)shouldDismissWeb {
    [self setShouldDismissWeb:shouldDismissWeb];
    return self;
}

- (QDRouterPresentOption *)withAsChildViewController:(BOOL)asChildViewController {
    [self setAsChildViewController:asChildViewController];
    return self;
}

@end
