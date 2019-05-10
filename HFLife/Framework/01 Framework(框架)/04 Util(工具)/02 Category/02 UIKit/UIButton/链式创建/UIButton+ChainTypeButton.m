
//
//  UIButton+ChainTypeButton.m
//  HFLife
//
//  Created by mac on 2019/5/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIButton+ChainTypeButton.h"

@implementation UIButton (ChainTypeButton)


- (UIButton * _Nonnull (^)(NSString *title, UIControlState state))setTitle{
    return ^(NSString *title, UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton *(^)(UIColor *color, UIControlState state))setTitleColor{
    return ^(UIColor *color, UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (UIButton *(^)(UIFont *font))setTitleFont{
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}
- (UIButton *(^)(CGFloat fontSize))setTitleFontSize{
    return ^(CGFloat fontSize){
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (UIButton *(^)(UIImage *image, UIControlState state))setImage{
    return ^(UIImage *image, UIControlState state){
        [self setImage:image forState:state];
        return self;
    };
}
- (UIButton *(^)(UIImage *image, UIControlState state))setBackgroundImage{
    return ^(UIImage *image, UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}



- (UIButton *(^)(UIViewContentMode contentMode))setImgContentMode{
    return ^(UIViewContentMode contentMode){
        self.imageView.contentMode = contentMode;
        return self;
    };
}



- (UIButton *(^)(TouchedButtonCallback touchHandler))addAction
{
    return ^(TouchedButtonCallback touchHandler){
        objc_setAssociatedObject(self, @selector(addAction), touchHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(addActionHandler) forControlEvents:UIControlEventTouchUpInside];
        
        return self;
    };
    
}

- (void)addActionHandler
{
    TouchedButtonCallback block = objc_getAssociatedObject(self, @selector(addAction));
    if (block)
    {
        block();
    }
}





- (UIButton *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
    
}
- (UIButton *(^)(CGRect bounce))setBounce{
    return ^(CGRect bounce){
        self.bounds = bounce;
        return self;
    };
}

- (UIButton *(^)(UIColor *color))setBackgroundColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

- (UIButton *(^)(CGFloat cornerRadius))setCornerRadius{
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}
- (UIButton *(^)(CGFloat boardWidth))setBoardWidth{
    return ^(CGFloat boardWidth){
        self.layer.borderWidth = boardWidth;
        return self;
    };
}
- (UIButton *(^)(UIColor *boardColor))setBoardColor{
    return ^(UIColor *boardColor){
        self.layer.borderColor = boardColor.CGColor;
        return self;
    };
}

@end
