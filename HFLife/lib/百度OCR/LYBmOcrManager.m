//
//  JQBmOcrManager.m
//  JiuQu
//
//  Created by kk on 2017/5/28.
//  Copyright © 2017年 JiuQuBuy. All rights reserved.
//

#import "LYBmOcrManager.h"
#import "BaseViewController.h"
#define BMAPIKEY        @"xbDn1zITIiX1bGbe0xEWkNXF"

#define BMSECRETKEY     @"hAk1fdz6Xi6VxuVRyqncXa2VQkjFN3a3"

@interface LYBmOcrManager()

@property (nonatomic, copy)void(^resultBlock)(id value ,UIImage *image);
@property (nonatomic, assign)CardType cardType;
@end

static LYBmOcrManager *ocrManager = nil;

@implementation LYBmOcrManager
{
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}
+(instancetype)ocrShareManaer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ocrManager = [[LYBmOcrManager alloc]init];
    });
    return ocrManager;
}


#pragma mark -配置ocr环境
-(void)configOcr
{
    [[AipOcrService shardService] authWithAK:BMAPIKEY andSK:BMSECRETKEY];
    [self configCallback];
}


- (void) presentAcrVCWithType:(CardType) cardType complete:(void (^)(id result, UIImage *image))successHandler{
    self.resultBlock = successHandler;
    self.cardType = cardType;
    UIViewController * vc =
    [AipCaptureCardVC ViewControllerWithCardType:cardType
                                 andImageHandler:^(UIImage *image) {
                                     if (cardType == CardTypeIdCardFont) {
                                         [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                                                      withOptions:nil
                                                                                   successHandler:^(id result){
                                                                                       
                                                                                       if (successHandler) {
                                                                                           successHandler(result, image);
                                                                                       }
                                                                                       self->_successHandler(result);
                                                                                       // 这里可以存入相册
                                                                                       //UIImageWriteToSavedPhotosAlbum(image, nil, nil, (__bridge void *)self);
                                                                                   }
                                                                                      failHandler:self->_failHandler];
                                     }else if (cardType == CardTypeIdCardBack){
                                         [[AipOcrService shardService] detectIdCardBackFromImage:image
                                                                                      withOptions:nil
                                                                                   successHandler:^(id result){
                                                                                       
                                                                                       if (successHandler) {
                                                                                           successHandler(result, image);
                                                                                       }
                                                                                       self->_successHandler(result);
                                                                                       // 这里可以存入相册
                                                                                       //UIImageWriteToSavedPhotosAlbum(image, nil, nil, (__bridge void *)self);
                                                                                   }
                                                                                      failHandler:self->_failHandler];
                                     }else if(cardType == CardTypeBankCard){
                                         [[AipOcrService shardService]detectBankCardFromImage:image successHandler:^(id result) {
                                             if (successHandler) {
                                                 successHandler(result, image);
                                             }
                                             self->_successHandler(result);
                                         } failHandler:self->_failHandler];
                                     }
                                     
                                     
                                 }];
    UIViewController *myVC = [self jsd_getCurrentViewController];
    if ([myVC isKindOfClass:[BaseViewController class]]) {
        BaseViewController *basevc = (BaseViewController *)myVC;
        basevc.customNavBar.hidden = YES;
        [[NSOperationQueue currentQueue] addOperationWithBlock:^{
            [basevc.navigationController presentViewController:vc animated:YES completion:^{
                UINavigationController *navi = [self currentNC];
                NSLog(@"%@   \n%@", navi.view.subviews, navi.navigationBar.subviews);

                dispatch_async(dispatch_get_main_queue(), ^{
                    navi.navigationBarHidden = YES;
                });
            }];
        }];
    }
}
- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        NSLog(@"%@", result);
        NSString *title = @"识别结果";
        NSMutableString *message = [NSMutableString string];
        
        if(result[@"words_result"]){
            if([result[@"words_result"] isKindOfClass:[NSDictionary class]]){
                [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
                    }else{
                        [message appendFormat:@"%@: %@\n", key, obj];
                    }
                    
                }];
            }else if([result[@"words_result"] isKindOfClass:[NSArray class]]){
                for(NSDictionary *obj in result[@"words_result"]){
                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
                        [message appendFormat:@"%@\n", obj[@"words"]];
                    }else{
                        [message appendFormat:@"%@\n", obj];
                    }
                    
                }
            }
            
        }else{
            [message appendFormat:@"%@", result];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//            [WXZTipView showCenterWithText:@"识别成功"];
        }];
        [[weakSelf jsd_getCurrentViewController] dismissViewControllerAnimated:YES completion:nil];
    };
    
    _failHandler = ^(NSError *error){
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
}

//获取当前页面控制器
- (UIViewController *)jsd_getCurrentViewController{
    
    
   
    
    UIViewController* currentViewController = [self jsd_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    if ([currentViewController isKindOfClass:[BaseViewController class]]) {
        BaseViewController *vc = (BaseViewController *)currentViewController;
        vc.customNavBar.hidden = YES;
    }
    return currentViewController;
}


//获取根控制器
- (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}


//根据用户选择类型进行页面的不同跳转
//-(UIViewController *)configWithOpenPageFromType:(CardType)type delegate:(id<AipOcrDelegate>)delegate
//{
//   return  [AipCaptureCardVC ViewControllerWithCardType:type andDelegate:delegate];
//}




- (UINavigationController *)currentNC
{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}

//递归
- (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}



@end
