
//
//  myCenterCollectionViewCell.m
//  DeliveryOrder
//
//  Created by mac on 2019/3/9.
//  Copyright © 2019 LeYuWangLuo. All rights reserved.
//

#import "myCenterCollectionViewCell.h"
@interface myCenterCollectionViewCell()

@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UILabel *titleLb;



@end
@implementation myCenterCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)addChildrenViews{
    self.imageV = [[UIImageView alloc] init];
    self.titleLb = [UILabel new];
    
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLb.font = MyFont(12);
    self.titleLb.textColor = HEX_COLOR(0x131313);
    
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLb];
}



- (void)setTitleForCell:(NSString *)title image:(NSString *)image{
    self.titleLb.text = title;
    self.imageV.image = [UIImage imageNamed:image];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(11));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(ScreenScale(52));
        make.height.mas_equalTo(ScreenScale(47));
    }];

    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.imageV.mas_bottom).offset(ScreenScale(3));
    }];
}


@end
