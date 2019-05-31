//
//  UILabelEdgeInsets.m
//  HFLife
//
//  Created by zchao on 2019/5/29.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "UILabelEdgeInsets.h"

@implementation UILabelEdgeInsets

//- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
//
//    UIEdgeInsets insets = self.edgeInsets;
//    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
//                    limitedToNumberOfLines:numberOfLines];
//
//    rect.origin.x    -= insets.left;
//    rect.origin.y    -= insets.top;
//    rect.size.width  += (insets.left + insets.right);
//    rect.size.height += (insets.top + insets.bottom);
//
//    return rect;
//}
//
//- (void)drawTextInRect:(CGRect)rect {
//    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
//}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize
{
    CGSize size = [super intrinsicContentSize];
    size.height += (self.edgeInsets.top  + self.edgeInsets.bottom);
    size.width  += (self.edgeInsets.left + self.edgeInsets.right);
    return size;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize newSize = [super sizeThatFits:size];
    newSize.height += (self.edgeInsets.top + self.edgeInsets.bottom);
    newSize.width  += (self.edgeInsets.left + self.edgeInsets.right);
    return newSize;
}

-(void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
