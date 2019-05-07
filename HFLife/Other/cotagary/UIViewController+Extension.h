//
//  UIViewController+Extension.h
//  TFC
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Developer.h"
@interface UIViewController (Extension)
- (UIViewController *)topViewController;
- (UIImage *)imageWithOriImageName:(NSString *)imageName;
@end
