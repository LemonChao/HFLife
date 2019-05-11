//
//  CALayer+XibBorderColor.h
//  HFLife
//
//  Created by zchao on 2019/2/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (XibBorderColor)
- (void)setBorderColorWithUIColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
