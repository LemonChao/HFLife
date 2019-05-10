
//
//  SXF_HF_CycleContentCellTableViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_CycleContentCell.h"

@implementation SXF_HF_CycleContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    
    return self;
}
- (void)addChildrenViews{
    self.contentView.backgroundColor = [UIColor orangeColor];
}
@end
