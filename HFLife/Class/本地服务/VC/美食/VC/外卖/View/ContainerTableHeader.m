//
//  ContainerTableHeader.m
//  HanPay
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "ContainerTableHeader.h"

@interface ContainerTableHeader ()

@end

@implementation ContainerTableHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.imageView];
        self.rightbgView = [UIView new];
        [self addSubview:self.rightbgView];
        [self addSubview:self.titleLable];
        [self.rightbgView addSubview:self.countLable];
        [self.rightbgView addSubview:self.arrowImage];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(13);
            make.size.mas_equalTo(CGSizeMake(2, 15));
        }];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.imageView.mas_right).offset(15);
            make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH/2);
        }];
        
        [self.rightbgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-13);
            make.height.equalTo(self);
            make.width.mas_equalTo(150);
        }];
        
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightbgView);
            make.centerY.equalTo(self.rightbgView);
            make.size.mas_equalTo(CGSizeMake(12, 12));
        }];
        
        [self.countLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightbgView);
            make.right.equalTo(self.arrowImage.mas_left).offset(-18);
        }];
        
    }
    return self;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:MMGetImage(@"waimai_shu")];
    }
    return _imageView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.textColor = [UIColor blackColor];
        _titleLable.font = [UIFont boldSystemFontOfSize:17];
        
    }
    return _titleLable;
}

- (UILabel *)countLable {
    if (!_countLable) {
        _countLable = [UILabel new];
        _countLable.textColor = HEX_COLOR(0x999999);
        _countLable.font = [UIFont systemFontOfSize:11];
    }
    return _countLable;
}

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waimai_sousuo"]];
    }
    return _arrowImage;
}

@end
