//
//  QDRouter.m
//  QDRouterDemo
//
//  Created by chenbowen on 2017/5/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDRouter.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+QDDictToModel.h"


//#import "NSObject+QDDictToModel.h"

NSString *const QDStoryBoardNameKey = @"QDStoryBoardNameKey";
NSString *const QDStoryBoardIdentifierKey = @"QDStoryBoardIdentifierKey";

#define ROUTE_NOT_FOUND_FORMAT @"No route found for URL %@"
#define INVALID_CONTROLLER_FORMAT @"Your controller class %@ needs to implement either the static method %@"

@interface UINavigationController (QDRouter)
/** 键值池 */
@property (nonatomic, strong) NSMutableArray *keyCache;

@end

@interface QDRouterBaseOption : NSObject
/** 绑定类 */
@property (nonatomic, strong) Class openClass;
/** 绑定类默认参数 */
@property (nonatomic, strong) NSDictionary *defaultParams;

@end

@implementation QDRouterBaseOption

@end

@interface QDRouterParams : NSObject
/** 基本设置 */
@property (nonatomic, strong) QDRouterBaseOption *baseOption;
/** 额外参数 */
@property (nonatomic, strong) NSDictionary *extraParams;

@property (nonatomic, strong, readonly) NSDictionary *controllerParams;

- (instancetype)initWithBaseOption:(QDRouterBaseOption *)baseOption extraParams: (NSDictionary *)extraParams;

@end

@implementation QDRouterParams

- (instancetype)initWithBaseOption:(QDRouterBaseOption *)baseOption extraParams: (NSDictionary *)extraParams {
    if (self = [super init]) {
        self.baseOption = baseOption;
        self.extraParams = extraParams;
    }
    return self;
}

- (NSDictionary *)controllerParams {
    NSMutableDictionary *controllerParams = [NSMutableDictionary dictionaryWithDictionary:self.baseOption.defaultParams];
    [controllerParams addEntriesFromDictionary:self.extraParams];
    return controllerParams;
}

@end

@interface QDRouter ()

@property (nonatomic, strong) NSDictionary *routerConfig;

@property (nonatomic, strong) NSMutableDictionary *routes;

@property (nonatomic, strong) NSMutableDictionary *cachedRoutes;

@property (nonatomic,strong) QDRouterPresentOption * lastPresentOption;

@end

@implementation QDRouter

+ (instancetype)sharedRouter {
    static QDRouter *_sharedRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRouter = [[QDRouter alloc] init];
        _sharedRouter.ignoresExceptions = YES;
    });
    return _sharedRouter;
}

- (id)init {
    if ((self = [super init])) {
        self.routes = [NSMutableDictionary dictionary];
        self.cachedRoutes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary *)routerConfig {
    if (!_routerConfig) {
        _routerConfig = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QDRouterConfig.plist" ofType:nil]];
    }
    return _routerConfig;
}

- (void)pop {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)popToUrl:(NSString *)url {
    if ([self.navigationController.keyCache containsObject:url]) {
        NSInteger index = [self.navigationController.keyCache indexOfObject:url];
        if (index < self.navigationController.childViewControllers.count) {
            self.navigationController.keyCache = [self.navigationController.keyCache subarrayWithRange:NSMakeRange(0, index)].mutableCopy;
            [self.navigationController popToViewController:self.navigationController.childViewControllers[index] animated:YES];
            return YES;
        }
    }
    return NO;
}

- (BOOL)popToPaymentControlOriginURL {
    for (NSString *key in self.navigationController.keyCache) {
        if ([self.payControlMapKeys containsObject:key]) {
            return [self popToUrl:key];
        }
    }
    
    return NO;
}

- (void)map:(NSString *)format toController:(Class)controllerClass {
    [self map:format toController:controllerClass defaultParams:nil];
}

- (void)map:(NSString *)format toController:(Class)controllerClass defaultParams:(NSDictionary *)defaultParams {
    QDRouterBaseOption *baseOption = [self.routes objectForKey:format];
    if (!baseOption || ![baseOption isKindOfClass:[QDRouterBaseOption class]]) {
        baseOption = [[QDRouterBaseOption alloc]init];
    }
    baseOption.openClass = controllerClass;
    baseOption.defaultParams = defaultParams;
    [self.routes setObject:baseOption forKey:format];
}

- (void)openExternal:(NSString *)url {
    NSURL *aURL = [NSURL URLWithString:url];
    if ([[UIApplication sharedApplication] canOpenURL:aURL]) {
        
        [[UIApplication sharedApplication] openURL:aURL options:[NSDictionary dictionary] completionHandler:nil];
    }
}

- (void)open:(NSString *)url {
    [self open:url presentOption:nil extraParams:nil routerCallBack:nil];
}

- (void)open:(NSString *)url extraParams:(NSDictionary *)extraParams {
    [self open:url presentOption:nil extraParams:extraParams routerCallBack:nil];
}

- (void)open:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption {
    [self open:url presentOption:presentOption extraParams:nil routerCallBack:nil];
}


- (void)open:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption extraParams:(NSDictionary *)extraParams routerCallBack:(QDRouterCallBackBlock)routerCallBack {
    
    //先删除原来加载webView的VC;重新设置navigationController的栈
    //再进行跳转:openViewController
    if (self.lastPresentOption.shouldDismissWeb && self.navigationController.childViewControllers.count > 1 && [self.navigationController.topViewController isKindOfClass:NSClassFromString(@"QDBaseWebViewController")]) {
        NSMutableArray *childViewControllers = self.navigationController.childViewControllers.mutableCopy;
        //移除webViewController:先copy一份,然后再进行setter
        [childViewControllers removeLastObject];

        [self.navigationController setViewControllers:childViewControllers.copy];
    }
    
    if ([self.tabBarMapKeys containsObject:url]) {
        NSInteger index = [self.tabBarMapKeys indexOfObject:url];
        [self setTabarIndex:(int)index];
        return;
    }
    
    if (!presentOption) {
        presentOption = [QDRouterPresentOption option];
    }

    [presentOption qd_modelSetWithJSON:extraParams];
    self.lastPresentOption = presentOption;
    
    QDRouterParams *params = [self routerParamsForUrl:url extraParams:extraParams];
    
    if (!self.navigationController) {
        if (self.ignoresExceptions) {
            return;
        }
        
        @throw [NSException exceptionWithName:@"NavigationControllerNotProvided"
                                       reason:@"Router#navigationController has not been set to a UINavigationController instance"
                                     userInfo:nil];
    }
    
    //开始至空,否者每次都有block
    self.navigationController.routerCallBack = NULL;
    if (routerCallBack) {
        self.navigationController.routerCallBack = routerCallBack;
    }
    
    UIViewController *controller = [self controllerForRouterParams:params presentOption:presentOption];
    
    [self openViewController:controller presentOption:presentOption];
}

- (QDRouterParams *)routerParamsForUrl:(NSString *)url extraParams: (NSDictionary *)extraParams {
    if (!url) {
        if (self.ignoresExceptions) {
            return nil;
        }
        @throw [NSException exceptionWithName:@"RouteNotFoundException"
                                       reason:[NSString stringWithFormat:ROUTE_NOT_FOUND_FORMAT, url]
                                     userInfo:nil];
    }
    
    if ([self.cachedRoutes objectForKey:url] && !extraParams) {
        return [self.cachedRoutes objectForKey:url];
    }
    
    if (self.routes[url] && [self.routes[url] isKindOfClass:[QDRouterBaseOption class]]) {
        QDRouterBaseOption *baseOption = self.routes[url];
        QDRouterParams *openParams = [[QDRouterParams alloc] initWithBaseOption:baseOption extraParams:extraParams];
        
        if (!openParams) {
            if (self.ignoresExceptions) {
                return nil;
            }
            @throw [NSException exceptionWithName:@"RouteNotFoundException"
                                           reason:[NSString stringWithFormat:ROUTE_NOT_FOUND_FORMAT, url]
                                         userInfo:nil];
        }
        
        [self.cachedRoutes setObject:openParams forKey:url];
        return openParams;
    }
    
    return nil;
}

- (UIViewController *)controllerForRouterParams:(QDRouterParams *)params presentOption:(QDRouterPresentOption *)presentOption {
    SEL controllerClassSelector = sel_registerName("viewControllerWithRouterParams:");
    UIViewController *controller = nil;
    Class controllerClass = params.baseOption.openClass;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([controllerClass respondsToSelector:controllerClassSelector]) {
        controller = [controllerClass performSelector:controllerClassSelector withObject:[params controllerParams]];
    }
#pragma clang diagnostic pop
    if (!controller) {
        if (self.ignoresExceptions) {
            return controller;
        }
        @throw [NSException exceptionWithName:@"RoutableInitializerNotFound"
                                       reason:[NSString stringWithFormat:INVALID_CONTROLLER_FORMAT, NSStringFromClass(controllerClass), NSStringFromSelector(controllerClassSelector)]
                                     userInfo:nil];
    }
    
    controller.modalTransitionStyle = presentOption.transitionStyle;
    controller.modalPresentationStyle = presentOption.presentationStyle;
    
    if (self.navigationController.routerCallBack) {
        controller.routerCallBack = self.navigationController.routerCallBack;
    }
    
    return controller;
}

- (void)openViewController:(UIViewController *)viewController presentOption:(QDRouterPresentOption *)presentOption {
    if (presentOption.asChildViewController) {
        if (![self.navigationController.topViewController.childViewControllers containsObject:viewController]) {
            [self.navigationController.topViewController addChildViewController:viewController];
            [self.navigationController.topViewController.view addSubview:viewController.view];
        }
        return;
    }
    
    if (presentOption.isModal) {
        if ([viewController.class isSubclassOfClass:UINavigationController.class]) {
            [self.navigationController.topViewController presentViewController:viewController animated:presentOption.isAnimated completion:nil];
        } else {
            if (!self.navigationControllerClass) {
                self.navigationControllerClass = NSClassFromString(@"UINavigationController");
            }
            id navigationController = [[self.navigationControllerClass alloc] initWithRootViewController:viewController];
            if ([navigationController isKindOfClass:[UINavigationController class]]) {
                UINavigationController* nav = (UINavigationController *)navigationController;
                nav.modalPresentationStyle = viewController.modalPresentationStyle;
                nav.modalTransitionStyle = viewController.modalTransitionStyle;
                nav.routerCallBack = viewController.routerCallBack;
                [self.navigationController.topViewController presentViewController:navigationController animated:presentOption.animated completion:nil];
            }
        }
    } else if (presentOption.shouldOpenAsRootViewController) {
        [self.navigationController setViewControllers:@[viewController] animated:presentOption.isAnimated];
    }else if (presentOption.shouldDismissWeb) {
        [self.navigationController addChildViewController:viewController];
        [viewController view];
    }else {
        [self.navigationController pushViewController:viewController animated:presentOption.isAnimated];
    }
}

- (void)openWeb:(NSString *)url {
    [self openWeb:url extraParams:nil presentOption:nil];
}

- (void)openWeb:(NSString *)url extraParams:(NSDictionary *)extraParams {
    [self openWeb:url extraParams:extraParams presentOption:nil];
}

- (void)openWeb:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption {
    [self openWeb:url extraParams:nil presentOption:presentOption];
}

- (void)openWeb:(NSString *)url extraParams:(NSDictionary *)extraParams presentOption:(QDRouterPresentOption *)presentOption {
    if (url.length) {
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:extraParams];
        [params addEntriesFromDictionary:@{@"url" : url}];
        [self open:self.baseWebMapKey presentOption:presentOption extraParams:params routerCallBack:nil];
    }
}

- (void)setTabarIndex:(int)index {
    id orginNavigationController = self.navigationController;
    self.navigationController.tabBarController.selectedIndex = index;
    [orginNavigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - lazy

-(UINavigationController *)navigationController{
    
    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    NSUInteger index = tab.selectedIndex;
    UINavigationController *nav = (UINavigationController *)[tab.viewControllers objectAtIndex:index];
    
    return nav;
}

@end

#pragma mark - UIViewController (QDRouter)
@implementation UIViewController (QDRouter)

+ (void)load {
    Method originalMethod1 = class_getInstanceMethod([self class], @selector(dismissViewControllerAnimated:completion:));
    Method swizzledMethod1 = class_getInstanceMethod([self class], @selector(qdRouterDismissViewControllerAnimated:completion:));
    
    Method originalMethod2 = class_getInstanceMethod([self class], @selector(presentViewController:animated:completion:));
    Method swizzledMethod2 = class_getInstanceMethod([self class], @selector(qdRouterPresentViewController:animated:completion:));
    
    method_exchangeImplementations(originalMethod1, swizzledMethod1);
    method_exchangeImplementations(originalMethod2, swizzledMethod2);
}

- (void)qdRouterDismissViewControllerAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if ([self isKindOfClass:[UINavigationController class]] && ![self isKindOfClass:[UIImagePickerController class]]) {
        UINavigationController *nav = (UINavigationController *)self;
        [QDRouter sharedRouter].navigationController = nav;
    }else if ([self.presentingViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)self.presentingViewController;
        if ([tab.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tab.selectedViewController;
            [QDRouter sharedRouter].navigationController = nav;
        }
    }else if ([self.presentingViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self.presentingViewController;
        [QDRouter sharedRouter].navigationController = nav;
    }
    
    [self qdRouterDismissViewControllerAnimated:animated completion:completion];
}

- (void)qdRouterPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[UINavigationController class]] && ![viewControllerToPresent isKindOfClass:[UIImagePickerController class]]) {
        [QDRouter sharedRouter].navigationController = (UINavigationController *)viewControllerToPresent;
    }
    [self qdRouterPresentViewController:viewControllerToPresent animated:flag completion:completion];
}


#pragma mark - 设置VC的值
+ (id)viewControllerWithRouterParams:(NSDictionary *)parmas {
    id vc = nil;
    if (parmas[QDStoryBoardNameKey] && [parmas[QDStoryBoardNameKey] isKindOfClass:[NSString class]]) {
        NSString *storyBoardName = parmas[QDStoryBoardNameKey];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
        if (parmas[QDStoryBoardIdentifierKey] && [parmas[QDStoryBoardIdentifierKey] isKindOfClass:[NSString class]]) {
            vc = [storyboard instantiateViewControllerWithIdentifier:parmas[QDStoryBoardIdentifierKey]];
        }else {
            vc = [storyboard instantiateInitialViewController];
        }
    }else {
        vc = [[self alloc] init];
    }
    
    if (vc && parmas.allKeys.count) {
        //设置vc的参数,省去原来的media
        //会出发setter方法
        [vc qd_modelSetWithJSON:parmas];
    }
    
    return vc;
}

- (void)setRouterCallBack:(QDRouterCallBackBlock)routerCallBack {
    objc_setAssociatedObject(self, @selector(routerCallBack), routerCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (QDRouterCallBackBlock)routerCallBack {
    return objc_getAssociatedObject(self, _cmd);
}

@end

#pragma mark - UINavigationController (QDRouter)
@implementation UINavigationController (QDRouter)

+ (void)load {
    Method originalMethod1 = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod1 = class_getInstanceMethod([self class], @selector(qdRouterPushViewController:animated:));
    
    Method originalMethod2 = class_getInstanceMethod([self class], @selector(popViewControllerAnimated:));
    Method swizzledMethod2 = class_getInstanceMethod([self class], @selector(qdRouterPopViewControllerAnimated:));
    
    method_exchangeImplementations(originalMethod1, swizzledMethod1);
    method_exchangeImplementations(originalMethod2, swizzledMethod2);
}

- (void)qdRouterPushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self handleIdentifier:^(NSString *identifier) {
        [self.keyCache addObject:identifier];
    }];
    [self qdRouterPushViewController:viewController animated:animated];
}

- (UIViewController *)qdRouterPopViewControllerAnimated:(BOOL)animated {
    id lastVC = [self qdRouterPopViewControllerAnimated:animated];
    [self handleIdentifier:^(NSString *identifier) {
        if ([self.keyCache containsObject:identifier]) {
            [self.keyCache removeObject:identifier];
        }
    }];
    return lastVC;
}

- (void)handleIdentifier:(void(^)(NSString *))handler {
    if ([QDRouter sharedRouter].routerConfig[NSStringFromClass([self.topViewController class])] && [[QDRouter sharedRouter].routerConfig[NSStringFromClass([self.topViewController class])] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *vcDict = (NSDictionary *)[QDRouter sharedRouter].routerConfig[NSStringFromClass([self.topViewController class])];
        if (vcDict[@"RouterIdentifier"] && [vcDict[@"RouterIdentifier"] isKindOfClass:[NSString class]]) {
            NSString *identifier = (NSString *)vcDict[@"RouterIdentifier"];
            handler(identifier);
        }
    }
}

- (void)setKeyCache:(NSMutableArray *)keys {
    objc_setAssociatedObject(self, @selector(keyCache), keys, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)keyCache {
    NSMutableArray *keys = objc_getAssociatedObject(self, _cmd);
    if (!keys) {
        keys = [NSMutableArray array];
        self.keyCache = keys;
    }
    return keys;
}

@end

#pragma mark - UITabBarController (QDRouter)
@interface UITabBarController (QDRouter)

@end

@implementation UITabBarController (QDRouter)

+ (void)load {
    Method originalMethod1 = class_getInstanceMethod([self class], @selector(setDelegate:));
    Method swizzledMethod1 = class_getInstanceMethod([self class], @selector(qdRouterSetDelegate:));
    
    Method originalMethod2 = class_getInstanceMethod([self class], @selector(setSelectedIndex:));
    Method swizzledMethod2 = class_getInstanceMethod([self class], @selector(qdRouterSetSelectedIndex:));
    
    method_exchangeImplementations(originalMethod1, swizzledMethod1);
    method_exchangeImplementations(originalMethod2, swizzledMethod2);
}

- (void)qdRouterSetDelegate:(id<UITabBarControllerDelegate>)delegate {
    [self qdRouterSetDelegate:delegate];
    
    if (class_addMethod([delegate class], NSSelectorFromString(@"qdDidSelectViewController"), (IMP)qdRouterDidSelectViewController, "v@:@@")) {
        Method didSelectOriginalMethod = class_getInstanceMethod([delegate class], NSSelectorFromString(@"qdDidSelectViewController"));
        Method didSelectSwizzledMethod = class_getInstanceMethod([delegate class], @selector(tabBarController:didSelectViewController:));
        
        method_exchangeImplementations(didSelectOriginalMethod, didSelectSwizzledMethod);
    }
}

void qdRouterDidSelectViewController(id self, SEL _cmd, id tabBarController, id viewController) {
    SEL selector = NSSelectorFromString(@"qdDidSelectViewController");
    ((void(*)(id, SEL, id, id))objc_msgSend)(self, selector, tabBarController, viewController);
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewController;
        [QDRouter sharedRouter].navigationController = nav;
    }
}

- (void)qdRouterSetSelectedIndex:(NSUInteger)selectedIndex {
    [self qdRouterSetSelectedIndex:selectedIndex];
    
    if (self.childViewControllers.count > selectedIndex && [self.childViewControllers[selectedIndex] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = self.childViewControllers[selectedIndex];
        [QDRouter sharedRouter].navigationController = nav;
    }
}

@end

@implementation NSObject (QDRouterOpen)

#pragma mark - Open
- (void)open:(NSString *)url {
    [[QDRouter sharedRouter] open:url];
}

- (void)open:(NSString *)url extraParams:(NSDictionary *)extraParams {
    [[QDRouter sharedRouter] open:url extraParams:extraParams];
}

- (void)open:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption {
    [[QDRouter sharedRouter] open:url presentOption:presentOption];
}

- (void)open:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption extraParams:(NSDictionary *)extraParams routerCallBack:(QDRouterCallBackBlock)routerCallBack {
    [[QDRouter sharedRouter] open:url presentOption:presentOption extraParams:extraParams routerCallBack:routerCallBack];
}

#pragma mark - OpenWeb
- (void)openWeb:(NSString *)url {
    [[QDRouter sharedRouter] openWeb:url];
}

- (void)openWeb:(NSString *)url extraParams:(NSDictionary *)extraParams {
    [[QDRouter sharedRouter] openWeb:url extraParams:extraParams];
}

- (void)openWeb:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption {
    [[QDRouter sharedRouter] openWeb:url presentOption:presentOption];
}

- (void)openWeb:(NSString *)url extraParams:(NSDictionary *)extraParams presentOption:(QDRouterPresentOption *)presentOption {
    [[QDRouter sharedRouter] openWeb:url extraParams:extraParams presentOption:presentOption];
}

#pragma mark - Pop
- (void)pop {
    [[QDRouter sharedRouter] pop];
}

- (void)popToRoot {
    [[QDRouter sharedRouter] popToRoot];
}

- (BOOL)popToUrl:(NSString *)url {
    return [[QDRouter sharedRouter] popToUrl:url];
}

- (BOOL)popToPaymentControlOriginURL {
    return [[QDRouter sharedRouter] popToPaymentControlOriginURL];
}

@end
