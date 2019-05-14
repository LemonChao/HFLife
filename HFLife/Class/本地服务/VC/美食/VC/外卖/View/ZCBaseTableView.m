//
//  ZCBaseTableView.m
//  HanPay
//
//  Created by mac on 2019/2/19.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "ZCBaseTableView.h"

@implementation ZCBaseTableView

//返回YES，则可以多个手势一起触发方法，返回NO则为互斥（比如外层UIScrollView名为mainScroll内嵌的UIScrollView名为subScroll，当我们拖动subScroll时，mainScroll是不会响应手势的（多个手势默认是互斥的），当下面这个代理返回YES时，subScroll和mainScroll就能同时响应手势，同时滚动，这符合我们这里的需求）
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
    //    return self.support;
    
}

@end
