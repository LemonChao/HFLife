//
//  UITextField+ChainTypeTextField.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "UITextField+ChainTypeTextField.h"

@implementation UITextField (ChainTypeTextField)






- (UITextField *(^)(NSString *text))setText{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}


- (UITextField *(^)(UIColor *color))setTextColor{
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}

- (UITextField *(^)(UIFont *font))setFont{
    return ^(UIFont *font){
        self.font = (UIFont *)font;
        
        return self;
    };
}
- (UITextField *(^)(CGFloat fontSize))setFontSize{
    return ^(CGFloat fontSize){
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
        
    };
}
- (UITextField *(^)(NSTextAlignment textAlignment))setTextAligement{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UITextField *(^)(NSString *placeholder))setPlaceholder{
    return ^(NSString *placeholder){
        self.placeholder = placeholder;
        return self;
    };
}

- (UITextField *(^)(UIColor *color))setPlaceholderColor{
    return ^(UIColor *color){
        [self setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        return self;
    };
}
- (UITextField *(^)(UIFont *font))setPlaceholderFont{
    return ^(UIFont *font){
        [self setValue:font forKeyPath:@"_placeholderLabel.font"];
        return self;
    };
}


- (UITextField *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
    
}
- (UITextField *(^)(CGRect bounce))setBounce{
    return ^(CGRect bounce){
        self.bounds = bounce;
        return self;
    };
}

- (UITextField *(^)(UIColor *color))setBackgroundColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

- (UITextField *(^)(CGFloat cornerRadius))setCornerRadius{
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}
- (UITextField *(^)(CGFloat boardWidth))setBoardWidth{
    return ^(CGFloat boardWidth){
        self.layer.borderWidth = boardWidth;
        return self;
    };
}
- (UITextField *(^)(UIColor *boardColor))setBoardColor{
    return ^(UIColor *boardColor){
        self.layer.borderColor = boardColor.CGColor;
        return self;
    };
}

@end
