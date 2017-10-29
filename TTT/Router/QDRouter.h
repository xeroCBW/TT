//
//  QDRouter.h
//  QDRouterDemo
//
//  Created by chenbowen on 2017/5/25.
//  Copyright © 2017年 chenbowen. All rights reserved.
//

#import "QDRouterPresentOption.h"

typedef NSString *(^QDRouterCallBackBlock)(id result);

extern NSString *const QDStoryBoardNameKey;
extern NSString *const QDStoryBoardIdentifierKey;

@interface UIViewController (QDRouter)

+ (id)viewControllerWithRouterParams:(NSDictionary *)parmas;

/** H5回调 */
@property (nonatomic, copy) QDRouterCallBackBlock routerCallBack;

@end

@interface QDRouter : NSObject

+ (instancetype)sharedRouter;

/** 当前导航栏 */
@property (nonatomic, weak) UINavigationController *navigationController;
/** 是否忽略错误 */
@property (nonatomic, assign) BOOL ignoresExceptions;
/** 需跳转特殊处理的TabBar控制器 */
@property (nonatomic, strong) NSArray *tabBarMapKeys;
/** 需特殊处支付控件相关控制器 */
@property (nonatomic, strong) NSArray *payControlMapKeys;
/** Web特殊拼接参数相关控制器 */
@property (nonatomic, strong) NSArray *webMapKeys;
/** Web控制器基类(需与plist同步) */
@property (nonatomic, copy) NSString *baseWebMapKey;
/** 导航栏类 */
@property (nonatomic, assign) Class navigationControllerClass;
/** Router配置 */
@property (nonatomic, strong, readonly) NSDictionary *routerConfig;
/** 配置池 */
@property (nonatomic, readonly) NSMutableDictionary *routes;

#pragma mark - Map 注册控制器
- (void)map:(NSString *)format toController:(Class)controllerClass;
- (void)map:(NSString *)format toController:(Class)controllerClass defaultParams:(NSDictionary *)defaultParams;

#pragma mark - Open & Pop
- (void)openExternal:(NSString *)url;
- (void)open:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption extraParams:(NSDictionary *)extraParams routerCallBack:(QDRouterCallBackBlock)routerCallBack;
- (void)openWeb:(NSString *)url extraParams:(NSDictionary *)extraParams presentOption:(QDRouterPresentOption *)presentOption;
- (void)pop;

@end

/************************ NSObject+QDRouterOpen ***************************/

@interface NSObject (QDRouterOpen)
#pragma mark - Open 打开控制器
- (void)open:(NSString *)url;

- (void)open:(NSString *)url extraParams:(NSDictionary *)extraParams;

- (void)open:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption;

- (void)open:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption extraParams:(NSDictionary *)extraParams routerCallBack:(QDRouterCallBackBlock)routerCallBack;

#pragma mark - OpenWeb 打开H5
- (void)openWeb:(NSString *)url;

- (void)openWeb:(NSString *)url extraParams:(NSDictionary *)extraParams;

- (void)openWeb:(NSString *)url presentOption:(QDRouterPresentOption *)presentOption;

- (void)openWeb:(NSString *)url extraParams:(NSDictionary *)extraParams presentOption:(QDRouterPresentOption *)presentOption;

#pragma mark - Pop 返回
- (void)pop;

- (void)popToRoot;

- (BOOL)popToUrl:(NSString *)url;

- (BOOL)popToPaymentControlOriginURL;


@end

