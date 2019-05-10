//
//  UILabel+ChainTypeLabel.m
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UILabel+ChainTypeLabel.h"

@implementation UILabel (ChainTypeLabel)

+ (UILabel *(^)(void))creat{
    return ^(){
        UILabel *lab = [[UILabel alloc] init];
        return lab;
    };
}

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


- (UILabel *(^)(NSTextAlignment textAlignment))setTextAligement{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}




- (UILabel *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
    
}
- (UILabel *(^)(CGRect bounce))setBounce{
    return ^(CGRect bounce){
        self.bounds = bounce;
        return self;
    };
}

- (UILabel *(^)(UIColor *color))setBackgroundColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

- (UILabel *(^)(CGFloat cornerRadius))setCornerRadius{
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}
- (UILabel *(^)(CGFloat boardWidth))setBoardWidth{
    return ^(CGFloat boardWidth){
        self.layer.borderWidth = boardWidth;
        return self;
    };
}
- (UILabel *(^)(UIColor *boardColor))setBoardColor{
    return ^(UIColor *boardColor){
        self.layer.borderColor = boardColor.CGColor;
        return self;
    };
}

@end
