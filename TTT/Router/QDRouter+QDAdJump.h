//
//  QDRouter+QDAdJump.h
//  QDEwallet
//
//  Created by chenbowen on 2017/6/12.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "QDRouter.h"

@class QDAdModel;
@class QDAdPresentOption;

@interface QDRouter (QDAdJump)

@end

@interface NSObject (QDAdJump)
/** 广告位跳转 */
- (void)openAdsWithAdModel:(QDAdModel *)adModel;
/** 广告位跳转及其跳转形式 */
- (void)openAdsWithAdModel:(QDAdModel *)adModel option:(QDAdPresentOption *)option;

@end
