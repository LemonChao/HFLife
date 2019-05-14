//
//  NearFoodDelegateManage.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/14.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <Foundation/Foundation.h>
//cell相关
#import "FoodClassifyCell.h"
#import "FoodAdvertisingCell.h"
#import "FoodPreferentialCell.h"
//VC视图相关
#import "NearDiscountCouponVC.h"
#import "DiscountCouponVC.h"
#import "NewStoresPreferential.h"
#import "TakeOutVC.h"
#import "PreorderTableVC.h"
#import "FoodPreferentialCell.h"
#import "HotPotVC.h"
#import "BuffetVC.h"
#import "Cake_MilkyTeaVC.h"
#import "WKWebViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NearFoodDelegateManage : NSObject<FoodClassifyDelegate,FoodPreferentialDelegate>
+ (NearFoodDelegateManage *)shareInstance;
@property (nonatomic,strong)UIViewController *superVC;
@end

NS_ASSUME_NONNULL_END
