//
//  UIImageView+ChainTypeImageView.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "UIImageView+ChainTypeImageView.h"

@implementation UIImageView (ChainTypeImageView)

- (UIImageView *(^)(CGRect frame))setFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
    
}
- (UIImageView *(^)(CGRect bounce))setBounce{
    return ^(CGRect bounce){
        self.bounds = bounce;
        return self;
    };
}

- (UIImageView *(^)(UIColor *color))setBackgroundColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

- (UIImageView *(^)(CGFloat cornerRadius))setCornerRadius{
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}
- (UIImageView *(^)(CGFloat boardWidth))setBoardWidth{
    return ^(CGFloat boardWidth){
        self.layer.borderWidth = boardWidth;
        return self;
    };
}
- (UIImageView *(^)(UIColor *boardColor))setBoardColor{
    return ^(UIColor *boardColor){
        self.layer.borderColor = boardColor.CGColor;
        return self;
    };
}

- (UIImageView *(^)(UIImage *image))setImage{
    return ^(UIImage *image){
        self.image = image;
        return self;
    };
}
- (UIImageView *(^)(UIViewContentMode contentMode))setImgContentMode{
    return ^(UIViewContentMode contentMode){
        self.contentMode = contentMode;
        return self;
    };
}


@end
