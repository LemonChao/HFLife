
//
//  SXF_HF_getMoneyTabHeaderView.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_getMoneyTabHeaderView.h"

@interface SXF_HF_getMoneyTabHeaderView ()

@end

@implementation SXF_HF_getMoneyTabHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SXF_HF_getMoneyTabHeaderView class]) owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}


@end
