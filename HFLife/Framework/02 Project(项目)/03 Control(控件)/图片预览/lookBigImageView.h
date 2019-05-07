//
//  lookBigImageView.h
//  huzhu
//
//  Created by CTD－JJP on 17/3/18.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lookBigImageView : UIView
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UILabel *alertLabel;

@property (nonatomic ,strong) UIView *bgView;
- (void) setBgViewColor:(UIColor *)color;
- (UIView *)getColor:(UIColor *)color;
- (void)show;
@end
