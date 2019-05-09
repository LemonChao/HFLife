
//
//  UIView+alertView.m
//  DoLifeApp
//
//  Created by sxf_pro on 2018/7/13.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import "UIView+alertView.h"
@implementation UIView (alertView)
//添加一个一个view
- (void)showAlertViewToViewImageTYpe:(alertView_type)alertType msg:(NSString *)msg forView:(view_type)isView imageCenter:(CGFloat)centerY errorBlock:(void(^)(void))errorBlock{
    //添加到view
    if (isView == TYPE_VIEW) {
        alertView * av = [[alertView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        av.msg = msg;
        av.viewImageType = alertType;
        av.callBack = errorBlock;
        if (centerY == 0) {
            //不设置
        }else{
            av.imageCenterY = centerY;
        }
        if ([self isKindOfClass:[UITableView class]]) {
            UITableView *table = (UITableView *)self;
            table.backgroundView = av;
        }else if ([self isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *)self;
            collectionView.backgroundView = av;
        }else if([self isKindOfClass:[UIWebView class]]) {
            UIWebView *web = (UIWebView *)self;
            NSString *path = [[NSBundle mainBundle] pathForResource:@"empoty" ofType:@"html"];
            NSURL *url = [NSURL URLWithString:path];
//            [web loadHTMLString:@" " baseURL:url];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [web loadRequest:request];
            [self addSubview:av];
        }else{
            [self addSubview:av];
        }
    }   
}
//添加一个contoll
- (void)showAlertViewToViewImageTYpe:(alert_type)alertType msg:(NSString *)msg forView:(view_type)isView control:(UIViewController *)vc errorBlock:(void(^)(void))errorBlock{
    //添加到view
    if (isView == TYPE_VIEW) {
        errorAlertViewViewController *errorVC = [[errorAlertViewViewController alloc] init];
        errorVC.view.frame = self.bounds;
        [self addSubview:errorVC.view];
        errorVC.msg = msg;
        errorVC.imageType = alertType;
        errorVC.callBack = errorBlock;
        [vc addChildViewController:errorVC];
    }
}

- (void) removeAlertView{
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *table = (UITableView *)self;
        table.backgroundView = nil;
    }else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        collectionView.backgroundView = nil;
    }else{
        for (int i = 0; i < self.subviews.count; i++) {
            if ([self.subviews[i] isKindOfClass:[alertView class]]) {
                UIView *vvv = self.subviews[i];
                [vvv removeFromSuperview];
            }
        }
//        for (int i = 0; i < self.subviews.count; i++) {
//            if ([self.subviews[i] isKindOfClass:[errorAlertViewViewController class]]) {
//                UIView *vvv = self.subviews[i];
//                [vvv removeFromSuperview];
//            }
//        }
    }
}

@end
