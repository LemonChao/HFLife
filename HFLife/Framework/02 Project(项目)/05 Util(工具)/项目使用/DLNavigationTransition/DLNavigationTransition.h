//
//  DLNavigationTransition.h
//  DLRightPanGestureBack
//
//  Created by vera on 16/5/16.
//  Copyright © 2016年 vera. All rights reserved.
//
/**
 使用这个类的时候如果底层视图是UIScrollView的话，那么手势会冲突，
 所以说，要解决手势冲突问题
 方法：
 写一个继承于UIScrollView的类例如叫BaseScrollView
 然后在.m文件里重写方法
 -(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
 {
        // 首先判断otherGestureRecognizer是不是系统pop手势
        if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
            // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
            if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
                return YES;
            }
        }
 
        return NO;
 }
 */
#import <Foundation/Foundation.h>

@interface DLNavigationTransition : NSObject

/**
 *  启动右滑pop
 */
+ (void)enableNavigationTransitionWithPanGestureBack;

@end
