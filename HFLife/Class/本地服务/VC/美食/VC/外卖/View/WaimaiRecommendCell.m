//
//  WaimaiRecommendCell.m
//  HanPay
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "WaimaiRecommendCell.h"


@implementation WaimaiRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    
    WaimaiRecommendSubView *leftSubView = [[WaimaiRecommendSubView alloc] init];
    [leftSubView setImage:[UIImage imageNamed:@"waimai_recommend_left"] forState:UIControlStateNormal];
    leftSubView.nameLabel.text = @"10个当地人9个爱";
    leftSubView.descriptionLabel.text = @"城市热卖爆款";
    [leftSubView.typeButton setTitle:@"限量抢购" forState:UIControlStateNormal];
    [leftSubView.typeButton setBackgroundImage:[UIImage imageNamed:@"recommend_leftButtonbg"] forState:UIControlStateNormal];
    
    WaimaiRecommendSubView *rightSubView = [[WaimaiRecommendSubView alloc] init];
    [rightSubView setImage:[UIImage imageNamed:@"waimai_recommend_right"] forState:UIControlStateNormal];
    rightSubView.nameLabel.text = @"每一道都是经典";
    rightSubView.descriptionLabel.text = @"明显同款美食";
    [rightSubView.typeButton setTitle:@"午餐精选" forState:UIControlStateNormal];
    [rightSubView.typeButton setBackgroundImage:[UIImage imageNamed:@"recommend_rightButtonbg"] forState:UIControlStateNormal];

    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[leftSubView,rightSubView]];
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 4;
    stackView.frame = CGRectMake(13, 0, SCREEN_WIDTH-26, 170);
    [self.contentView addSubview:stackView];
}

@end

@interface WaimaiRecommendSubView ()

@end


@implementation WaimaiRecommendSubView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.typeButton];
    [self addSubview:self.nameLabel];
    [self addSubview:self.descriptionLabel];
    
    [self.typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(75, 25));
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.bottom.equalTo(self).offset(-11);
        make.right.equalTo(self).offset(-20);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(24);
        make.bottom.equalTo(self.descriptionLabel.mas_top).offset(-6);
        make.right.equalTo(self).offset(-20);
    }];
    
    
}

- (UIButton *)typeButton {
    if (!_typeButton) {
        _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _typeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _typeButton;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = HEX_COLOR(0x333333);
    }
    return _nameLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.font = [UIFont systemFontOfSize:10];
        _descriptionLabel.textColor = HEX_COLOR(0x999999);
    }
    return _descriptionLabel;
}


@end



