//
//  QDConfig.h
//  QDSpark
//
//  Created by 周大林 on 16/7/8.
//  Copyright © 2016年 QD. All rights reserved.
//

#ifndef QDConfig_h
#define QDConfig_h

#import <Foundation/Foundation.h>

/**
 *  网络参数
 */
/***************************************************************************/
#define KDevelopmentEnvironmentServerUrl @"https://gatewaytest.qianduan.com/api"
#define KProductionEnvironmentServerUrl  @"https://mgateway.qianduan.com/api"

/** 网关地址*/
#if DEVELOPMENT
#define KGATEWAY_SERVER_URL KDevelopmentEnvironmentServerUrl
#else
#define KGATEWAY_SERVER_URL KProductionEnvironmentServerUrl
#endif
/** 网关接口版本*/
#define KGatewayInterfaceVersion @"4.0.0"

/***************************************************************************/

/**
 *  第三方SDK参数
 */
/***************************************************************************/
/** QQ分享*/
FOUNDATION_EXTERN NSString * const QDQQAppID;
FOUNDATION_EXTERN NSString * const QDQQAppKey;
/** 微信分享*/
FOUNDATION_EXTERN NSString * const QDWXAppKey;
FOUNDATION_EXTERN NSString * const QDWXAppSecret;
/** 微博*/
FOUNDATION_EXTERN NSString * const QDWBAppKey;
/** 极光推送*/
FOUNDATION_EXTERN NSString * const QDJPushAPPKey;
/** 友盟SDK*/
FOUNDATION_EXTERN NSString * const QDUMAnalyticsAppKey;
/** 回调地址*/
FOUNDATION_EXTERN NSString * const QDRedirectURL;

/***************************************************************************/

/**
 *  加密密钥
 */
/***************************************************************************/
FOUNDATION_EXTERN NSString * const QDDESEncryptKey;

/***************************************************************************/

/**
 *  QDSpark URLScheme
 */
/***************************************************************************/
/** 外部唤起APP的URL Scheme*/
FOUNDATION_EXTERN NSString * const QDURLScheme;
/** 外部唤起APP的URL Host*/
FOUNDATION_EXTERN NSString * const QDURLHost;
/** url加盐字串*/
FOUNDATION_EXTERN NSString * const QDURLSignSalt;

/***************************************************************************/

/**
 *  浮层暂时时间
 */
/***************************************************************************/
FOUNDATION_EXTERN NSTimeInterval QDToastTimeInterval;

/***************************************************************************/

/**
 *  登录相关
 */
/***************************************************************************/
/** 服务热线 */
FOUNDATION_EXTERN NSString * const QDHotLine;
/***************************************************************************/
#endif /* QDConfig_h */
