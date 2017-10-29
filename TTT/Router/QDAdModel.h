//
//  QDAdModel.h
//  QDEwallet
//
//  Created by zhoudl on 2017/1/23.
//  Copyright © 2017年 QD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDAdModel : NSObject <NSCoding>

/** 标题 */
@property (nonatomic, copy) NSString *Title;
/** 副标题*/
@property (nonatomic, copy) NSString *SubTitle;
/** 分组标题*/
@property (nonatomic, copy) NSString *GroupTitle;
/** 广告ID */
@property (nonatomic, copy) NSString *Id;
/** 图片Url */
@property (nonatomic, copy) NSString *ImagePath;
@property (nonatomic, strong) NSNumber *Type;
@property (nonatomic, strong) NSNumber *AdType;
/** 商品ID或者项目id */
@property (nonatomic, copy) NSString *ItemId;
/** 对应钱端活动管理的活动编号 */
@property (nonatomic, copy) NSString *ActivityNo;
/** 是否需要登录 */
@property (nonatomic, assign) BOOL IsNeedLogin;
/** 启动广告展示时间 */
@property (nonatomic, strong) NSNumber *DelayTime;
/** 摇钱宝利率 */
@property (nonatomic, copy) NSString *YQBRate_sf;
/** 平台编号： 1、小企业E家 2、CTB项目 */
@property (nonatomic, copy) NSString *AssetNo;
/** 链接 */
@property (nonatomic, copy) NSString *LinkAddr;
/** 功能类型(不能识别德代表未知，按普通跳转处理)：1 车险分期  2 员工贷 3员工现金贷 */
@property (nonatomic, strong) NSNumber *GModuleType;
/** 0表示首次 1表示每次 */
@property (nonatomic, strong) NSNumber *ShowRate;
/**
 *  0是无限，1是仅一次
 */
@property (nonatomic ,assign) int ShowType;
/** 返回类型: 1=返回进入肖像认真入口方案 2=返回错误页面方案 */
@property (nonatomic, copy) NSString *BackType;
/** 业务数据ID(以后的公共支付组件) */
@property (nonatomic, copy) NSString *BusinessDataId;   
@property (nonatomic, copy) NSString *DefaultIndex;
/** 商品订单类型 */
@property (nonatomic, copy) NSString *ProductType;

@end

@interface QDAdPresentOption : NSObject
/** 是否需要分享，默认有分享 */
@property (nonatomic, assign) BOOL needShare;
/** 是否有刷新重载，默认有刷新 */
@property (nonatomic, assign) BOOL hasRefresh;
/** 是否以push的形式，默认push */
@property (nonatomic, assign) BOOL isPush;
/** 是否有动画效果，默认有动画效果 */
@property (nonatomic, assign) BOOL animated;

+ (instancetype)option;

- (QDAdPresentOption *)withNeedShare:(BOOL)needShare;

- (QDAdPresentOption *)withHasRefresh:(BOOL)hasRefresh;

- (QDAdPresentOption *)withIsPush:(BOOL)isPush;

- (QDAdPresentOption *)withAnimated:(BOOL)animated;

@end
