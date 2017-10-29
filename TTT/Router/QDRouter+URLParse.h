//
//  QDRouter+URLParse.h
//  QDEwallet
//
//  Created by chenbowen on 2017/6/16.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "QDRouter.h"

@interface QDRouter (URLParse)
/** Scheme */
@property (nonatomic, copy) NSString *scheme;
/** Host */
@property (nonatomic, copy) NSString *host;
/** SignSalt */
@property (nonatomic, copy) NSString *signSalt;

- (void)setupScheme:(NSString *)scheme host:(NSString *)host signCheck:(NSString *)signCheck;

- (NSString *)signWithMapKey:(NSString *)mapKey params:(NSDictionary *)params;

- (BOOL)canOpenURL:(NSURL *)url;

- (void)openURL:(NSURL *)url routerCallBack:(QDRouterCallBackBlock)routerCallBack;

- (void)openURL:(NSURL *)url presentOption:(QDRouterPresentOption *)presentOption routerCallBack:(QDRouterCallBackBlock)routerCallBack;


@end
