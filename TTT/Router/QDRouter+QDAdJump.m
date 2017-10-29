//
//  QDRouter+QDAdJump.m
//  QDEwallet
//
//  Created by chenbowen on 2017/6/12.
//  Copyright © 2017年 QD. All rights reserved.
//

#import "QDRouter+QDAdJump.h"


#import "NSURL+JKParam.h"
#import "NSString+QDEncrypt.h"
#import "NSString+JKURLEncode.h"
#import "QDAdModel.h"

//#import "NSObject+QDShakeMoneyAccessInfo.h"
//#import "QDRedEnvelopeDefine.h"
//#import "MallDefine.h"


@implementation QDRouter (QDAdJump)

- (void)openAdsWithAdModel:(QDAdModel *)adModel option:(QDAdPresentOption *)option {
    if (!adModel) {
        return;
    }
    
    if (!option) {
        option = [QDAdPresentOption option];
    }
    
    NSString *trimStr = [adModel.LinkAddr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    adModel.LinkAddr = trimStr;
    
    //是否需要强制登录
//    if (adModel.IsNeedLogin && ![QDAPPInfo sharedInfo].isLogined) {
//        [self openLogin];
//        return;
//    }
    
//    if (adModel.isNotEmpty) {
//        QDGModuleType moduleType = (QDGModuleType)adModel.GModuleType.integerValue;
//        QDADJumpType jumpType = (QDADJumpType)adModel.Type.integerValue;
//
//        NSString *mapKey;
//        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//
//        switch (moduleType) {
//            case QDGModuleTypeVehicleInsurance: {
//                {
//                    NSString *goToUrl = [kCarHomeURL replaceUrl];
//                    if (jumpType == QDGlobalH5JumpTypeSpecificModuleH5) {
//                        goToUrl = trimStr;
//                    }
//
//                    mapKey = RouterOpenWeb;
//                    parameters[@"url"] = goToUrl;
//                    //                    QDVehicleInsuranceVC *vehicleInsuranceVC = [[QDVehicleInsuranceVC alloc] initWithURL:goToUrl];
//                    //                    vehicleInsuranceVC.changedTitleByWeb = YES;
//                    //                    vehicleInsuranceVC.canResponseToUrlClick = YES;
//                    //                    vehicleInsuranceVC.needRefreshButton = NO;
//                }
//                break;
//            }
//            case QDGModuleTypeEmployeeLoan: {
//                {
//                    NSString *mobile = [QDAPPInfo sharedInfo].isLogined ? [QDAPPInfo sharedInfo].Mobile : @"";
//                    NSString *IMEI = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//                    IMEI = [IMEI stringByReplacingOccurrencesOfString:@"-" withString:@""];
//                    IMEI = [IMEI compressStringByLength:20];
//                    // 拼上电话号码
//                    if ([QDAPPInfo sharedInfo].isLogined && [QDAPPInfo sharedInfo].Mobile.isNotEmpty) {
//                        IMEI = [IMEI stringByAppendingString:[QDAPPInfo sharedInfo].Mobile];
//                    }
//                    NSString *encryptStr = [[NSString stringWithFormat:@"%@,%@", mobile, IMEI] DESEncryptWithKey:QDDESEncryptKey];
//                    NSString *encodingGoToUrl = encryptStr.jk_urlEncode;
//                    NSString *goToUrl = [NSString stringWithFormat:[kCreditEmployeeLoanURL replaceUrl], encodingGoToUrl];
//
//                    if (jumpType == QDGlobalH5JumpTypeSpecificModuleH5) {
//                        goToUrl = trimStr;
//                    }
//
//                    mapKey = RouterEmployeeLoan;
//                    //                    QDEmployeeLoanVC *employeeLoanVC = [[QDEmployeeLoanVC alloc] initWithURL:goToUrl];
//                    //                    employeeLoanVC.changedTitleByWeb = YES;
//                    //                    employeeLoanVC.canResponseToUrlClick = YES;
//                    //                    employeeLoanVC.needRefreshButton = NO;
//                }
//                break;
//            }
//            case QDGModuleTypeEasyComsume: {
//                {
//                    NSString *mobile = [QDAPPInfo sharedInfo].isLogined ? [QDAPPInfo sharedInfo].Mobile : @"";
//                    NSString *encryptStr = [[NSString stringWithFormat:@"%@", mobile] DESEncryptWithKey:QDDESEncryptKey];
//                    NSString *encodingGoToUrl = encryptStr.jk_urlEncode;
//                    NSString *goToUrl = [NSString stringWithFormat:[kCreditEasyComsumeURL replaceUrl], encodingGoToUrl];
//
//                    if (jumpType == QDGlobalH5JumpTypeSpecificModuleH5) {
//                        goToUrl = trimStr;
//                    }
//
//                    mapKey = RouterEasyComsume;
//                    parameters[@"url"] = goToUrl;
//                }
//                break;
//            }
//        }
//
//        switch (jumpType) {
//            case QDADJumpTypeStoreHome: {
//                {
//                    mapKey = RouterMallHome;
//                }
//                break;
//            }
//            case QDADJumpTypeInvestHome: {
//                {
//                    mapKey = RouterInvestIndex;
//                }
//                break;
//            }
//            case QDADJumpTypeH5: {
//                {
//                    mapKey = RouterOpenWeb;
//                }
//                break;
//            }
////            case QDADJumpTypeOrdinary:
////            {
////                //不作处理
////            }
////                break;
//            case QDADJumpTypeRedEnvelope: {
//                {
//                    mapKey = RouterRedEnvelope;
//                }
//                break;
//            }
//            case QDADJumpTypeInvestProjectDetails: {
//                {
//                    mapKey = RouterInvestProjectDetails;
//                    parameters[@"projectID"] = adModel.ItemId;
//                    parameters[@"assetNo"] = adModel.AssetNo;
//                }
//                break;
//            }
//            case QDADJumpTypeShakeMoney: {
//                {
//                    mapKey = RouterShakemoney;
//                }
//                break;
//            }
//            case QDADJumpTypeProductDetails: {
//                {
//                    mapKey = RouterProductDetails;
//                    parameters[@"productID"] = adModel.ItemId;
//                }
//                break;
//            }
//            case QDADJumpTypeShareActivex: {
//                {
//                    [self.navigationController.topViewController loadShareInfoWithID:adModel.Id shareInfoType:QDShareInfoTypeAdvertise prizeId:nil completionHandler:nil];
//                }
//                break;
//            }
//            case QDADJumpTypeCreditHome: {
//                {
//                    mapKey = RouterManageCredit;
//                }
//                break;
//            }
//            case QDADJumpTypeH5New: {
//                {
//                    mapKey = RouterOpenWeb;
//                }
//                break;
//            }
//            case QDADJumpTypeLogin: {
//                {
//                    if (![QDAPPInfo sharedInfo].isLogined) {
//                        [self openLogin];
//                    }
//                }
//                break;
//            }
//            case QDADJumpTypeRealNameAuthPopUp: {
//                {
//                    __weak typeof(self) weakSelf = self;
//                    [self.navigationController.topViewController showAlertViewWithTitle:nil message:@"为确保账户安全，请先进行实名认证" rightButtonTitle:@"立即认证" leftButtonTitle:@"取消" rightButtonAction:^{
//                        [weakSelf open:RouterBankCardAuthentication extraParams:@{@"originBusinessProcessViewController" : self.navigationController.topViewController}];
//                    } leftButtonAction:nil priortyType:0];
//                }
//                return;
//            }
//            case QDADJumpTypeRealNameAuth: {
//                {
//                    mapKey = RouterBankCardAuthentication;
//                }
//                break;
//            }
//            case QDADJumpTypeShakeMoneyDeposit:{
//                {
//                    __weak typeof(self) weakSelf = self;
//                    [self requestShakeMoneyAccessInfoWithType:ShakeMoneyAccess_In block:^(UIViewController *vc) {
//                        [weakSelf.navigationController pushViewController:vc animated:YES];
//                    }];
//                }
//                break;
//            }
//            case QDADJumpTypeInverstList:{
//                {
//                    mapKey = RouterInvestList;
//                }
//                break;
//            }
////            case QDADJumpTypeShakeMoneyHomeH5: {
////                {
////                //当做默认操作，后面处理
////                }
////                break;
////            }
//            case QDADJumpTypePortraitAuth:{
//                {
//                    // 未实名认证的账号点击“肖像认证”时，弹出需要先进行实名认证的提示
//                    if ([QDAPPInfo sharedInfo].IsCertified)  {
//                        if ([QDAPPInfo sharedInfo].isPortraitAuthed) {
//                            return;
//                        } else {
//                            if ([QDAPPInfo sharedInfo].isFaceRecognitionOutCount) {
//                                mapKey = RouterFaceRecognitionFailure;
//                                parameters[@"errorMessage"] = @"肖像认证次数已达上限,请明天再试";
//                            } else {
//                                mapKey = RouterFaceRecognitionInstructions;
//                            }
//                            break;
//                        }
//                    } else  {
//                        __weak typeof(self) weakSelf = self;
//                        [self.navigationController.topViewController showAlertViewWithTitle:nil message:@"为确保账户安全，请先进行实名认证" rightButtonTitle:@"立即认证" leftButtonTitle:@"取消" rightButtonAction:^{
//                            [weakSelf open:RouterBankCardAuthentication extraParams:@{@"originBusinessProcessViewController" : self.navigationController.topViewController}];
//                        } leftButtonAction:nil priortyType:0];
//                        return;
//                    }
//                }
//            }
//            case QDADJumpTypeCheckPayPassword:{
//                {
//                    if ([QDAPPInfo sharedInfo].HasSetPayPwd) {
//                        mapKey = RouterVerifyPayCode;
//                        parameters[@"type"] = @(VerifyPayCodeTypeOther);
//                        break;
//                    } else {
//                        __weak typeof(self) weakSelf = self;
//                        [self.navigationController.topViewController showAlertViewWithTitle:@"您还没有设置支付密码，请前往设置。" message:nil rightButtonTitle:@"立即设置" leftButtonTitle:@"取消" rightButtonAction:^{
//                            if ([QDAPPInfo sharedInfo].IsCertified) {
//                                //有没有实名认证 和 肖象认证
//                                //去实名认证
//                                id params = @{@"calType" : @(VerifyCodeTypeE_SETPWD)};
//                                [weakSelf open:RouterMyBankCard extraParams:params];
//                            } else {
//                                id params = @{@"calType" : @(VerifyCodeTypeE_SETPWD)};
//                                [weakSelf open:RouterAuthenticate extraParams:params];
//                            }
//                        } leftButtonAction:nil priortyType:0];
//                        return;
//                    }
//                }
//            }
//
//            case QDADJumpTypeBankCardList: {
//                {
//                    mapKey = RouterMyBankCard;
//                }
//                break;
//            }
//            case QDADJumpTypeRegister:{
//                {
//                    mapKey = RouterRegister;
//                    parameters[@"isFromH5"] = @(YES);
//                }
//                break;
//            }
//            case QDADJumpTypeAPPHome:{
//                {
//                    mapKey = RouterFortune;
//                }
//                break;
//            }
//            case QDADJumpTypeNewUserZone:{
//                {
//                    adModel.Type = @(QDADJumpTypeH5);
//                    adModel.LinkAddr = [kNoviceInvestmentURL replaceUrl];
//                    adModel.IsNeedLogin = NO;
//                    [self openAdsWithAdModel:adModel];
//                    return;
//                }
//            }
//            case QDADJumpTypeAppointmentInvest:{
//                {
//                    mapKey = RouterBookInvestHomePage;
//                }
//                break;
//            }
//            case QDADJumpTypeRegularProjectList:{
//                {
//                    mapKey = RouterInvestList;
//                }
//                break;
//            }
//            case QDADJumpTypeChargeCenterPhone:{
//                {
//                    mapKey = RouterChargeCenter;
//                    parameters[@"currentType"] = @(QDProductDetailsPhone);
//                }
//                break;
//            }
//            case QDADJumpTypeChargeCenterOil:{
//                {
//                    mapKey = RouterChargeCenter;
//                    parameters[@"currentType"] = @(QDProductDetailsOilCard);
//                }
//                break;
//            }
//            case QDADJumpTypeOrderDetails:{
//                {
//                    if ((QDMallProductType)adModel.ProductType.integerValue == QDMallProductTypeProduct) {
//                        mapKey = RouterMyOrderInfo;
//                        parameters[@"orderID"] = adModel.ItemId;
//                    }else {
//                        mapKey = RouterWelfareDetails;
//                        parameters[@"orderID"] = adModel.ItemId;
//                    }
//                }
//                break;
//            }
//            case QDADJumpTypeSafeCenter:{
//                {
//                    mapKey = RouterSafeCenter;
//                }
//                break;
//            }
//            case QDADJumpTypeMyCoupon:{
//                {
//                    mapKey = RouterMyAllCoupon;
//                }
//                break;
//            }
////            case QDADJumpTypeContact: {
////                {
////                //这个界面暂时不做
////                }
////                break;
////            }
//            case QDADJumpTypeMyGiftCard:{
//                {
//                    mapKey = RouterGiftCard;
//                }
//                break;
//            }
//            case QDADJumpTypeMyFavority:{
//                {
//                    mapKey = RouterMyFavorite;
//                }
//                break;
//            }
//            case QDADJumpTypeMyOrders:{
//                {
//                    mapKey = RouterMyOrder;
//                }
//                break;
//            }
//            case QDADJumpTypeMyInvest: {
//                {
//                    mapKey = RouterMyInvestIndex;
//                }
//                break;
//            }
//            case QDADJumpTypeShareActivexReadH5: {
//                {
//
//                }
//                break;
//            }
//            case QDADJumpTypeGotoModifyMobileVC:{
//                if ([QDAPPInfo sharedInfo].HasSetPayPwd) {
//                    mapKey = RouterVerifyPayCode;
//                    parameters[@"type"] = @(VerifyPayCodeTypeModifyMobile);
//                    break;
//                }else {
//                    __weak typeof(self) weakSelf = self;
//                    [self.navigationController.topViewController showAlertViewWithTitle:@"您还没有设置支付密码，请前往设置。" message:nil rightButtonTitle:@"立即设置" leftButtonTitle:@"取消" rightButtonAction:^{
//                        if ([QDAPPInfo sharedInfo].IsCertified) {
//                            //有没有实名认证 和 肖象认证
//                            //去实名认证
//                            id params = @{@"calType" : @(VerifyCodeTypeE_SETPWD)};
//                            [weakSelf open:RouterMyBankCard extraParams:params];
//                        } else {
//                            id params = @{@"calType" : @(VerifyCodeTypeE_SETPWD)};
//                            [weakSelf open:RouterAuthenticate extraParams:params];
//                        }
//                    } leftButtonAction:nil priortyType:0];
//                    return;
//                }
//            }
////            case QDADJumpTypeGoBackH5Entrance: {
////                {
////
////                }
////                break;
////            }
//            case QDADJumpTypeGotoPayControls: {
//                {
//
//                }
//                break;
//            }
//            case QDADJumpTypeCommonPayKit: {
//                {
//
//                }
//                break;
//            }
//            case QDADJumpTypePayCodeCenter:{
//                {
//                    mapKey = RouterPayCodeSetting;
//                }
//                break;
//            }
//            case QDADJumpTypeFeedBack:{
//                {
//                    mapKey = RouterFeedBack;
//                }
//                break;
//            }
//            case QDADJumpTypeSpecificModuleH5: {
//                {
//
//                }
//                break;
//            }
//            case QDADJumpTypeWagePlanManageIndex:{
//                {
//                    if ([QDAPPInfo sharedInfo].isLogined)  {
//                        mapKey = RouterWagePlanManage;
//                    } else {
//
//                        //                        __weak typeof(self) weakSelf = self;
//                        //                        QDLoginContentVC *vc=[[QDLoginContentVC alloc]initWithLoginSuccess:^{
//                        //                            QDWagePlanManageViewController *vc = [QDWagePlanManageViewController wagePlanManageVC];
//                        //                            [weakSelf.navigationController pushViewController:vc animated:YES];
//                        //                        }];
//                        //                        vc.MainTab=(UCSMainTabBarVC*)self.tabBarController;
//                        //                        QDNavigationController *navi=[[QDNavigationController alloc]initWithRootViewController:vc];
//                        //                        //有可能接收到的通知弹出弹框,但是已经打开了其他界面,新打开这个界面并没有接收到通知,
//                        //                        //接收到通知界面想presentViewController,但是已经原来界面已经 pressent 一个 VC就无法再presentViewController
//                        //                        //手势密码新建的两个 window 的 VC可能也会接收到 通知然后弹框
//                        //                        [[self topViewController] presentViewController:navi animated:YES completion:nil];
//                        mapKey = RouterLogin;
//                        __weak typeof(self) weakSelf = self;
//                        void(^loginSuccessBlock)() = ^{
//                            [weakSelf open:RouterWagePlanManage];
//                        };
//                        parameters[@"loginSuccessBlock"] = loginSuccessBlock;
//                    }
//                    break;
//                }
//            }
//            case QDADJumpTypeStoreHomeFirstIndex:{
//                {
//                    mapKey = RouterMallHome;
//                }
//                break;
//            }
//
//            case QDADJumpTypeStoreHomeSecondIndex:{
//                {
//                    mapKey = RouterMallEnjoy;
//                }
//                break;
//            }
//            case QDADJumpTypeWagePlanTransitionVC:{
//                {
//                    mapKey = RouterWagePlanTransition;
//                    parameters[@"HasOpenWage"] = @([QDAPPInfo sharedInfo].HasOpenWage);
//                }
//                break;
//            }
//            case QDADJumpTypeIntelligentInvestPayDetails:
//            {//智投宝支付成功详情
//                if (adModel.ItemId.length > 0)
//                {
//                    mapKey = RouterSmartInvestPayDetails;
//                    parameters[@"OrderNo"] = adModel.ItemId;
//                }
//            }
//                break;
//
//            case QDADJumpTypeIntelligentInvestIndex:
//            {//智投宝首页
//                if ([QDAPPInfo sharedInfo].HasOpenSmartInvest)
//                {
//                    mapKey = RouterSmartInvestIndex;
//                }
//                else
//                {
//                    mapKey = RouterSmartInvestTransition;
//                }
//            }
//                break;
//
//            case QDADJumpTypeIntelligentInvestDetails:
//            {//智投宝投资详情页
//                if (adModel.ItemId)
//                {
//                    mapKey = RouterSmartInvestInvestDetails;
//                    parameters[@"OrderNo"] = adModel.ItemId;
//                }
//            }
//                break;
//            default:break;
//        }
//
//        if ([self.webMapKeys containsObject:mapKey] && adModel.LinkAddr.isNotEmpty) {
////            NSString *gotoUrl = @"";
////            /**
////             *  兼容链接存在锚点
////             */
////            NSRange range = [adModel.LinkAddr rangeOfString:@"#"];
////            if (range.length > 0) {
////                NSString *preUrl = [adModel.LinkAddr substringToIndex:range.location];
////                NSString *sufUrl = [adModel.LinkAddr substringFromIndex:range.location];
////                gotoUrl = [[preUrl getSpliceURLWithUniqueID:adModel.ItemId NeedJump:nil] stringByAppendingString:sufUrl];
////            } else {
////                gotoUrl = [adModel.LinkAddr getSpliceURLWithUniqueID:adModel.ItemId NeedJump:nil];
////            }
//
//            if (!parameters[@"url"]) {
//                parameters[@"url"] = adModel.ItemId.isNotEmpty?[[NSURL URLWithString:adModel.LinkAddr] jk_addParameters:@{@"UniqueId" : adModel.ItemId}].absoluteString:adModel.LinkAddr;
//            }
//            parameters[@"hasRefresh"] = @(option.hasRefresh);
//            parameters[@"isPush"] = @(option.isPush);
//            parameters[@"needShare"] = @(option.needShare);
//        }
//
//        if (mapKey.length) {
//            if (option.isPush) {
//                [self open:mapKey presentOption:[[QDRouterPresentOption option] withAnimated:option.animated] extraParams:parameters routerCallBack:nil];
//            }else {
//                [self open:mapKey presentOption:[[QDRouterPresentOption optionAsModal] withAnimated:option.animated] extraParams:parameters routerCallBack:nil];
//            }
//        }
//    }
}

/** 登录操作 */
- (void)openLogin {
    [self open:@"" presentOption:[QDRouterPresentOption optionAsModal]];
}

@end

@implementation NSObject (QDAdJump)

- (void)openAdsWithAdModel:(QDAdModel *)adModel {
    [[QDRouter sharedRouter] openAdsWithAdModel:adModel option:nil];
}

- (void)openAdsWithAdModel:(QDAdModel *)adModel option:(QDAdPresentOption *)option {
    [[QDRouter sharedRouter] openAdsWithAdModel:adModel option:option];
}

@end
