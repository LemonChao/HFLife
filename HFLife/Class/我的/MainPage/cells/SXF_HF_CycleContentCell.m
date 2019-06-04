
//
//  SXF_HF_CycleContentCellTableViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_CycleContentCell.h"

@interface SXF_HF_CycleContentCell ()



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
    self.contentView.backgroundColor = [UIColor clearColor];
    
    
    
    self.titleLb           = [UILabel new];
    self.subTitleLb        = [UILabel new];
    self.moneyLb           = [UILabel new];
    self.gifImageV         = [UIImageView new];
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.subTitleLb];
    [self.contentView addSubview:self.moneyLb];
    [self.contentView addSubview:self.gifImageV];
    
    self.titleLb.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:19];
    self.subTitleLb.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    self.moneyLb.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:23];
    self.moneyLb.adjustsFontSizeToFitWidth = YES;
    self.titleLb.textColor = self.moneyLb.textColor = self.subTitleLb.textColor = [UIColor whiteColor];
    self.titleLb.hidden = self.subTitleLb.hidden = YES;
    self.moneyLb.textAlignment = NSTextAlignmentCenter;
}

- (void)setIndex:(NSInteger)index{
    //播放不同的动画
    
    
    NSString *iamgePath;
    NSArray *imageName = @[@"mian余额", @"mian可兑换", @"mian富权"];
    
    self.gifImageV.image = MY_IMAHE(([NSString stringWithFormat:@"%@.gif", imageName[index]]));
    
    iamgePath = [[NSBundle mainBundle] pathForResource:imageName[index] ofType:@"gif"];
    
    
    if (index == 1) {
        //可兑换
        [self.gifImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(-10));
            make.right.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(10));
        }];
    }else{
        [self.gifImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(-10));
            make.right.left.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.moneyLb.mas_bottom);
        }];
    }
    
    
    
    
    
    //    NSData  *imageData = [NSData dataWithContentsOfFile:iamgePath];
    //    self.animImageV.image = [UIImage sd_animatedGIFWithData:imageData];
    
//    NSString *name = [NSString stringWithFormat:@"%@.gif", imageName[index]];
//    //获取最后一帧 并赋值
//    UIImage *image = [self.gifImageV getImagesFormGif:name].lastObject;
//    self.gifImageV.image = image;
    
//    [self.gifImageV playGifImagePath:iamgePath repeatCount:1];
}



- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.contentView);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(40));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImageV.mas_top).offset(ScreenScale(50));
        make.left.mas_equalTo(self.bgImageV.mas_left).offset(ScreenScale(10));
        make.right.mas_equalTo(self.bgImageV.mas_right).offset(ScreenScale(-10));
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(-20));
        make.height.mas_equalTo(ScreenScale(16));
        make.centerX.mas_equalTo(self.moneyLb.mas_centerX);
    }];
    
//    [self.gifImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(-10));
//        make.right.left.mas_equalTo(self.contentView);
//        make.top.mas_equalTo(self.moneyLb.mas_bottom).offset(ScreenScale(10));
//    }];
}

@end
