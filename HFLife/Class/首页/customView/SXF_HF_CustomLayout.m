//
//  customLayout.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_CustomLayout.h"

@implementation SXF_HF_CustomLayout


- (instancetype)init{
    if (self = [super init]) {
       
    }
    
    return self;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (void)prepareLayout{
    //布局
    
    
    
    
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    return proposedContentOffset;
}

@end
