//
//  DLNavigationTransition.m
//  DLRightPanGestureBack
//
//  Created by vera on 16/5/16.
//  Copyright © 2016年 vera. All rights reserved.
//

#import "DLNavigationTransition.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface UINavigationController (Transition)<UIGestureRecognizerDelegate>

//@property (nonatomic, weak) UINavigationController *navigationController;
- (void)transitionPanGestureDidLoad;

@end

@interface DLNavigationTransition ()<UIGestureRecognizerDelegate>

@end

@implementation DLNavigationTransition

/**
 *  启动右滑pop
 */
+ (void)enableNavigationTransitionWithPanGestureBack
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method viewDidLoadMethod = class_getInstanceMethod([UINavigationController class], @selector(viewDidLoad));
        Method transitionPanGestureDidLoadMethod = class_getInstanceMethod([UINavigationController class], @selector(transitionPanGestureDidLoad));
        
        method_exchangeImplementations(viewDidLoadMethod, transitionPanGestureDidLoadMethod);
        
    });
}

@end


@implementation UINavigationController (Transition)

- (void)transitionPanGestureDidLoad
{    
    if ([self isKindOfClass:[UINavigationController class]])
    {
        
        [self transitionPanGestureDidLoad];

        
        //1.获取系统interactivePopGestureRecognizer对象的target对象
        id target = self.interactivePopGestureRecognizer.delegate;
        //2.创建滑动手势，taregt设置interactivePopGestureRecognizer的target，所以当界面滑动的时候就会自动调用target的action方法。
        //handleNavigationTransition是私有类_UINavigationInteractiveTransition的方法，系统主要在这个方法里面实现动画的。
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
        [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
        //3.设置代理
        pan.delegate = self;
        //4.添加到导航控制器的视图上
        [self.view addGestureRecognizer:pan];
        
        //5.禁用系统的滑动手势
        self.interactivePopGestureRecognizer.enabled = NO;
       
    }
}

#pragma mark - 滑动开始会触发

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    
     // Ignore when no view controller is pushed into the navigation stack.
    if (self.viewControllers.count<=1) {
        return NO;
    }
//    if ([self.viewControllers.lastObject isKindOfClass:[ShoppingCartViewController class]]) {
//        return NO;
//    }
    // Ignore pan gesture when the navigation controller is currently in transition.
//    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
//        return NO;
//    }
//    if ([self.viewControllers.lastObject isKindOfClass:[CommitOrderViewController class]]) {
//        return NO;
//    }
 
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    BOOL isLeftToRight = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;
    CGFloat multiplier = isLeftToRight ? 1 : - 1;
    if ((translation.x * multiplier) <= 0) {
        return NO;
    }
    return YES;
}


@end
