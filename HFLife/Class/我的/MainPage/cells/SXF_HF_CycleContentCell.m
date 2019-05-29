
//
//  SXF_HF_CycleContentCellTableViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_CycleContentCell.h"

@interface SXF_HF_CycleContentCell ()

@property (nonatomic, strong)UIImageView *bgImageV;

@end


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
    self.contentView.backgroundColor = [UIColor clearColor];
    self.bgImageV = [UIImageView new];
    self.bgImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.bgImageV];
    self.bgImageV.image = MY_IMAHE(@"余额底图_00000");
    self.contentView.backgroundColor = [UIColor clearColor];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.contentView);
    }];
}

@end
