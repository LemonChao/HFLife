//
//  ZCShopClassifyLeftCell.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopClassifyLeftCell.h"

@interface ZCShopClassifyLeftCell ()

@property(nonatomic, strong) UIImageView *imgView;

@property(nonatomic, strong) UIButton *titleButton;

@end

@implementation ZCShopClassifyLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleButton];
        [self.contentView addSubview:self.imgView];
        
        [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView).inset(WidthRatio(5));
        }];

        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(ScreenScale(3), ScreenScale(20)));
        }];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.imgView.hidden = !selected;
    self.titleButton.selected = selected;
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : RGBA(245, 245, 245, 1);
}

//- (void)setModel:(ZCClassifyModel *)model {
//    [self.titleButton setTitle:model.category_name forState:UIControlStateSelected];
//    [self.titleButton setTitle:model.category_name forState:UIControlStateNormal];
//}



- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:GeneralRedColor]];
    }
    return _imgView;
}

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UITool wordButton:@"品牌推荐" titleColor:ImportantColor font:SystemFont(14) bgColor:[UIColor clearColor]];
        [_titleButton setTitleColor:GeneralRedColor forState:UIControlStateSelected];
        _titleButton.userInteractionEnabled = NO;
    }
    return _titleButton;
}@end
