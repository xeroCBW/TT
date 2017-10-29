//
//  AppDelegate.m
//  TTT
//
//  Created by chenbowen on 2017/10/21.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "AppDelegate.h"
#import "EnvironmentManager.h"
#import "ViewController.h"
#import "QDRouter.h"
#import "QDRouterConst.h"
#import "QDConfig.h"
#import "QDRouter+URLParse.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [[EnvironmentManager sharedInstance]initConfig];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController *tabBar = (UIViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"tabBar"];
  
    self.window.rootViewController = tabBar;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRootVC) name:@"changeRootVC" object:nil];
    
    
    //注册路由
    [self registerUrlRouter];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)changeRootVC{
        
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ViewController *yourController = (ViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:yourController];
    
    [UIView transitionWithView:yourController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:^(BOOL finished) {
        
        self.window.rootViewController = navi;
    }];

}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(id)annotation
{
    return [[QDRouter sharedRouter] canOpenURL:url];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString*, id> *)options
{
    return [[QDRouter sharedRouter] canOpenURL:url];
}


- (void)registerUrlRouter
{
    [[QDRouter sharedRouter] setupScheme:QDURLScheme host:QDURLHost signCheck:QDURLSignSalt];
    
    /**
     *  注册函数，可以避免暴露函数名
     */
    
    //        // 性能控件
    //        [QDURLRouter mapKeyword:@"performance"
    //                       toAction:@selector(enablePerformanceTest)];
    //        // 运行环境
    //        [QDURLRouter mapKeyword:@"runenv"
    //                       toAction:@selector(switchRuntimeEnvironment:)];
    
    [QDRouter sharedRouter].tabBarMapKeys = @[RouterFortune, RouterInvestIndex, RouterMallHome];
    
    UITabBarController *vc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav =  (UINavigationController *)vc.childViewControllers.firstObject;
    [QDRouter sharedRouter].navigationController = nav;
    
    [QDRouter sharedRouter].payControlMapKeys = @[RouterWagePlan, RouterInvestPay, RouterShakeMoneyInCash, RouterShakeMoneyOutCash, RouterConfirmOrder, RouterBookInvestDetail, RouterPaymentControl, RouterRedEnvelopeWithdraw, RouterShopCar, RouterProductDetails, RouterPayCodeSetting, RouterSmartInvestDailsIndex];
    
    [QDRouter sharedRouter].webMapKeys = @[RouterOpenWeb, RouterEasyComsume, RouterMallEnjoy, RouterMallHome, RouterEmployeeLoan];
    
    [QDRouter sharedRouter].baseWebMapKey = RouterOpenWeb;
    
    [QDRouter sharedRouter].navigationControllerClass = NSClassFromString(@"UINavigationController");
    
    [[QDRouter sharedRouter].routerConfig enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull vcString, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            @autoreleasepool {
                NSMutableDictionary *vcDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)obj];
                if (vcDict[@"RouterIdentifier"] && [vcDict[@"RouterIdentifier"] isKindOfClass:[NSString class]]) {
                    if (vcDict[@"StoryboardName"] && [vcDict[@"StoryboardName"] isKindOfClass:[NSString class]]) {
                        vcDict[QDStoryBoardNameKey] = vcDict[@"StoryboardName"];
                    }
                    
                    if (vcDict[@"StoryboardIdentifier"] && [vcDict[@"StoryboardIdentifier"] isKindOfClass:[NSString class]]) {
                        vcDict[QDStoryBoardIdentifierKey] = vcDict[@"StoryboardIdentifier"];
                    }
                    
                    [[QDRouter sharedRouter] map:vcDict[@"RouterIdentifier"] toController:NSClassFromString(vcString) defaultParams:vcDict];
                }
            }
        }
    }];
}

@end
