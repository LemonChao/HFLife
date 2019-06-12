//
//  YYB_HF_HotSearchCollectionCell.m
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_HotSearchCollectionCell.h"

@implementation YYB_HF_HotSearchCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    
    self.title = [[UILabel alloc] init];
    self.title.numberOfLines = 0;
    self.title.font = FONT(15);
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.title];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //    MMViewBorderRadius(self.imgView, WidthRatio(15), 0, [UIColor clearColor]);
    //    self.imgView.backgroundColor = [UIColor redColor];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(ScreenScale(20));
    }];
}
@end
