//
//  UILabel+ChainTypeLabel.m
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UILabel+ChainTypeLabel.h"

@implementation UILabel (ChainTypeLabel)
- (UILabel *(^)(NSString *text))setText{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}
- (UILabel *(^)(UIColor *color))setTextColor{
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}

- (UILabel *(^)(UIFont *font))setFont{
    return ^(id font){
        self.font = (UIFont *)font;
        
        return self;
    };
}
- (UILabel *(^)(CGFloat fontSize))setFontSize{
    return ^(CGFloat fontSize){
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

@end
