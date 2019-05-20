//
//  NearFoodDelegateManage.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/14.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearFoodDelegateManage.h"

@implementation NearFoodDelegateManage
static NearFoodDelegateManage *manager = nil;
+ (NearFoodDelegateManage *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
#pragma mark 美食分类代理
-(void)clickColumnClassificationIndexPath:(NSIndexPath *)indexPath dataModel:(id)dataModel{
//    if (indexPath.row == 0) {
//        [self.superVC.navigationController pushViewController:[[DiscountCouponVC alloc]init] animated:YES];
//    }else if (indexPath.row == 1){
//         [self.superVC.navigationController pushViewController:[[NearDiscountCouponVC alloc]init] animated:YES];
//    }else if (indexPath.row == 2) {
//        [self.superVC.navigationController pushViewController:[PreorderTableVC new] animated:YES];
//    }else if (indexPath.row == 3){
//        [self.superVC.navigationController pushViewController:[[NewStoresPreferential alloc]init] animated:YES];
//    }else if (indexPath.row == 4){
//        [self.superVC.navigationController pushViewController:[[TakeOutVC alloc]init] animated:YES];
//    }else if (indexPath.row == 5){
////        [self.superVC.navigationController pushViewController:[[TakeOutVC alloc]init] animated:YES];
//    }else if (indexPath.row == 6){
//        [self.superVC.navigationController pushViewController:[[HotPotVC alloc]init] animated:YES];
//    }else if (indexPath.row == 7){
//        [self.superVC.navigationController pushViewController:[[BuffetVC alloc]init] animated:YES];
//    }else if (indexPath.row == 8){
//        [self.superVC.navigationController pushViewController:[[Cake_MilkyTeaVC alloc]init] animated:YES];
//    }
    if (![NSString isNOTNull:dataModel]) {
            // 类名
        NSString *class = dataModel;
        const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
            // 从一个字串返回一个类
        Class newClass = objc_getClass(className);
        if (!newClass)
        {
                // 创建一个类
            Class superClass = [NSObject class];
            newClass = objc_allocateClassPair(superClass, className, 0);
                // 注册你创建的这个类
            objc_registerClassPair(newClass);
        }
            // 创建对象
        id instance = [[newClass alloc] init];
        BaseViewController *vc = (BaseViewController *)instance;
        [self.superVC.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark 优惠套餐详情
-(void)clickRecommendedGoodsDataModel:(id)dataModel{
    if ([dataModel isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)dataModel;
        WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
        wkWebView.isNavigationHidden = YES;
        wkWebView.urlString = [NSString judgeNullReturnString:dict[@"url"]];
        [self.superVC.navigationController pushViewController:wkWebView animated:YES];
    }
    
//    NSString *city = [MMNSUserDefaults objectForKey:selectedCity];
//    NSString *coupon_id = MMNSStringFormat(@"%@",dict[@"coupon_id"]);
//    wkWebView.fileName = @"foodDetail";
   
//    wkWebView.jointParameter = MMNSStringFormat(@"?coupon_id=%@&city_name=%@",coupon_id,city);
//            wkWebView.urlString = [NSString judgeNullReturnString:dict[@"url"]];
//    wkWebView.urlString = @"http://192.168.0.177:5500/html/foodDetail.html?product_id=6&city_name=郑州";
//    [self.superVC.navigationController pushViewController:wkWebView animated:YES];
}
@end
