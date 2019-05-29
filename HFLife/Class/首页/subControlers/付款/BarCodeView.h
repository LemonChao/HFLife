//
//  BarCodeView.h
//  HFLife
//
//  Created by sxf on 2019/4/12.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BarCodeView : UIView
-(instancetype)initImage:(UIImage *)image withCodeStr:(NSString *)code;
@end

NS_ASSUME_NONNULL_END
