
//
//  UIView+ChainTypeView.m
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIView+ChainTypeView.h"

@implementation UIView (ChainTypeView)
- (UIView *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
    
}
- (UIView *(^)(CGRect bounce))setBounce{
    return ^(CGRect bounce){
        self.bounds = bounce;
        return self;
    };
}

- (UIView *(^)(UIColor *color))setBackgroundColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGFloat cornerRadius))setCornerRadius{
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}
- (UIView *(^)(CGFloat boardWidth))setBoardWidth{
    return ^(CGFloat boardWidth){
        self.layer.borderWidth = boardWidth;
        return self;
    };
}
- (UIView *(^)(UIColor *boardColor))setBoardColor{
    return ^(UIColor *boardColor){
        self.layer.borderColor = boardColor.CGColor;
        return self;
    };
}


@end
