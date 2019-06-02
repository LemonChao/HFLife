///
//  ShareProductInfoView.m
//  HuoJianJiSong
//
//  Created by Apple on 2017/12/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ShareProductInfoView.h"
//#import "UIButton+Helper.h"
#import "UIButton+EdgeInsets.h"


@interface ShareProductInfoView()
{
    UIView *bgView;
    UIImageView *sharingImageView;
}

@end


@implementation ShareProductInfoView

+(void)shareBtnClick:(SSDKPlatformType)shareType ShareImage:(id)shareImage title:(NSString *)title url:(NSString *)url context:(NSString *)context shareBtnClickBlock:(void(^)(BOOL isSucceed,NSString *msg))shareBtnClickBlock{
    if (shareType == SSDKPlatformSubTypeQQFriend) {
        if (![QQApiInterface isQQInstalled]) {
            if (shareBtnClickBlock) {
                shareBtnClickBlock(NO,@"您没有安装QQ");
            }
            return;
        }
    }else if (shareType == SSDKPlatformSubTypeQZone)
    {
        if (![QQApiInterface isQQInstalled]) {
            if (shareBtnClickBlock) {
                shareBtnClickBlock(NO,@"您没有安装QQ");
            }
            return;
        }
        
        
    }else if (shareType == SSDKPlatformSubTypeWechatTimeline){
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
            if (shareBtnClickBlock) {
                shareBtnClickBlock(NO,@"您没有安装微信");
            }
            return;
        }
        
       
    }else{
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
            if (shareBtnClickBlock) {
                shareBtnClickBlock(NO,@"您没有安装微信");
            }
            return;
        }
    }
    __block  BOOL isSucceed = false;
    __block  NSString *msg = @"";
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

        [shareParams SSDKSetupShareParamsByText:context
                                         images:shareImage
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto
         ];

    [ShareSDK share:shareType //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....}];
         
         if (state == SSDKResponseStateSuccess) {
             isSucceed = YES;
             msg = @"分享成功";
             //                 [weakSelf ShowAlertWithMessage:@"分享成功"];
         }else if (state == SSDKResponseStateFail){
             isSucceed = NO;
             msg = @"分享失败";
//                              [weakSelf ShowAlertWithMessage:@"分享失败"];
         }else if (state == SSDKResponseStateCancel){
             isSucceed = NO;
             msg = @"分享已取消";
             //                 [weakSelf ShowAlertWithMessage:@"分享已取消"];
         }
         if (shareBtnClickBlock) {
             shareBtnClickBlock(isSucceed,msg);
         }
     }];
}




@end
