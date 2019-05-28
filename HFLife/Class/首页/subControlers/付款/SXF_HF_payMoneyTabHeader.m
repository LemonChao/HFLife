
//
//  SXF_HF_payMoneyTabHeader.m
//  HFLife
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_payMoneyTabHeader.h"

@interface SXF_HF_payMoneyTabHeader ()
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIImageView *barCodeImgV;
@property (nonatomic, strong)UIImageView *QRCodeImgV;
@property (nonatomic, strong)UILabel *barCodeStrLb;
@end



@implementation SXF_HF_payMoneyTabHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.backgroundColor = colorCA1400;
    self.bgView     = [UIView new];
    self.barCodeImgV = [UIImageView new];
    self.barCodeStrLb = [UILabel new];
    self.QRCodeImgV = [UIImageView new];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.barCodeImgV];
    [self.bgView addSubview:self.barCodeStrLb];
    [self.bgView addSubview:self.QRCodeImgV];
    self.barCodeStrLb.setFontSize(18).setTextColor(colorAAAAAA);
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}
- (void)setDataForView:(id)data{
    [self layoutIfNeeded];
    self.barCodeStrLb.text = @"2828******查看数字";
    self.barCodeImgV.image = [UIImage barcodeImageWithContent:[NSString judgeNullReturnString:@"http://www.baidu.com"] codeImageSize:CGSizeMake(self.barCodeImgV.bounds.size.width, self.barCodeImgV.bounds.size.width) red:0 green:0 blue:0];
    
    self.QRCodeImgV.image = [SGQRCodeObtain generateQRCodeWithData:[NSString stringWithFormat:@"%@", @"http://www.tecent.com"] size:self.QRCodeImgV.bounds.size.width logoImage:[userInfoModel sharedUser].userHeaderImage ratio:0.25];
    
    self.barCodeImgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBarImage)];
    [self.barCodeImgV addGestureRecognizer:tap];
}
- (void)tapBarImage{
    !self.barCodeClick ? : self.barCodeClick(self.barCodeImgV.image);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-12));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(10));
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    
    [self.barCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(ScreenScale(20));
        make.right.mas_equalTo(self.bgView.mas_right).offset(ScreenScale(-20));
        make.top.mas_equalTo(self.bgView.mas_top).offset(ScreenScale(20));
        make.height.mas_equalTo(ScreenScale(100));
    }];
    
    [self.barCodeStrLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.barCodeImgV.mas_bottom).offset(ScreenScale(15));
        make.height.mas_equalTo(ScreenScale(15));
        make.centerX.mas_equalTo(self.barCodeImgV.mas_centerX);
    }];
    
    [self.QRCodeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(ScreenScale(190));
        make.top.mas_equalTo(self.barCodeStrLb.mas_bottom).offset(ScreenScale(27));
        make.centerX.mas_equalTo(self.barCodeImgV.mas_centerX);
    }];
}

@end
