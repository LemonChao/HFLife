//
//  JQBmOcrManager.h
//  JiuQu
//
//  Created by kk on 2017/5/28.
//  Copyright © 2017年 JiuQuBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <AipOcrSdk/AipOcrSdk.h>
@protocol ocrDelegate <NSObject>

@optional


-(void)jq_ocrOnIdCardSuccessful:(id)result;


-(void)jq_ocrOnBankCardSuccessful:(id)result;


-(void)jq_ocrOnGeneralSuccessful:(id)result;


-(void)jq_ocrOnFail:(NSError *)error;



@end





@interface LYBmOcrManager : NSObject





@property (nonatomic,weak)id<ocrDelegate>delegate;



/**
 初始化方法

 @return <#return value description#>
 */
+(instancetype)ocrShareManaer;

/**
 环境配置
 */
-(void)configOcr;



/**
 <#Description#>

 @param cardType CardTypeIdCardFont 身份证正面
                 CardTypeIdCardBack 身份证反面
                 bankCardOCROnline  银行卡反面
 */
- (void) presentAcrVCWithType:(CardType) cardType complete:(void (^)(id result, UIImage *image))successHandler;

/**
 跳转不同的控制器

 @param type 认证类型
 @param delegate 代理
 @return <#return value description#>
 */
//-(UIViewController *)configWithOpenPageFromType:(CardType)type delegate:(id<AipOcrDelegate>)delegate;

@end
