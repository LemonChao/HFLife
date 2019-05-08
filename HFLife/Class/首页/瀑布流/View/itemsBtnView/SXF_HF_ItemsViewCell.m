
//
//  SXF_HF_ItemsViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_ItemsViewCell.h"

#import "myCenterCollectionView.h"

@interface SXF_HF_ItemsViewCell()

@property (nonatomic ,strong) myCenterCollectionView *collectionV;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation SXF_HF_ItemsViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (void)addChildrenViews{
   
    
    self.bgView = [UIView new];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.collectionV = [[myCenterCollectionView alloc] init];
    [self.bgView addSubview:self.collectionV];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.bgView);
    }];
    
    
    [self layoutIfNeeded];
    self.collectionV.layer.cornerRadius = 5;
    self.collectionV.layer.masksToBounds = YES;
    self.collectionV.clipsToBounds = YES;
    //HEX_COLOR(0x808080)
    [self.bgView addShadowForViewColor:HEX_COLOR(0x808080) offSet:CGSizeMake(-1, 2) shadowRadius:3 cornerRadius:5 opacity:0.3];
    
    
    self.collectionV.layer.cornerRadius = 5;
    self.collectionV.masksToBounds = YES;
    self.collectionV.clipsToBounds = YES;
    
}

@end
