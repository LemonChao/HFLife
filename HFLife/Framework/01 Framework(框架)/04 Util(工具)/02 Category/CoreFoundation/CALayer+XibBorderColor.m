//
//  CALayer+XibBorderColor.m
//  HFLife
//
//  Created by zchao on 2019/2/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "CALayer+XibBorderColor.h"

@implementation CALayer (XibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end
