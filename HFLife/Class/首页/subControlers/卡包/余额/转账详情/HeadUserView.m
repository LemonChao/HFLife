//
//  HeadUserView.m
//  HFLife
//
//  Created by sxf on 2019/4/18.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "HeadUserView.h"

@implementation HeadUserView
{
    UIImageView *headImageView;
    
    UILabel *nameLabel;
}
-(id)init{
    self = [super init];
    if (self) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    headImageView = [UIImageView new];
    headImageView.image = MMGetImage(@"barCode_icon");
    [self addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(WidthRatio(51));
    }];
    MMViewBorderRadius(headImageView, WidthRatio(51)/2, 0, [UIColor whiteColor]);
    
    nameLabel = [UILabel new];
    nameLabel.text = @"*家驹";
    nameLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    nameLabel.textColor = HEX_COLOR(0x333333);
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(61));
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(HeightRatio(26));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
}
-(void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_imageURL] placeholderImage:MMGetImage(@"barCode_icon")];
}
-(void)setName:(NSString *)name{
    _name = name;
    nameLabel.text = _name;
}
@end
