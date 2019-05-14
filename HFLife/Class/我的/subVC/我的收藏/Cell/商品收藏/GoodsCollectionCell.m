//
//  GoodsCollectionCell.m
//  HanPay
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "GoodsCollectionCell.h"

@implementation GoodsCollectionCell
{
    UIImageView *iconImageView;
    //标题
    UILabel *titleLabel;
    //数量
    UILabel *numberLabel;
    //价格
    UILabel *priceLabel;
}
+ (instancetype)GoodsCollectionCellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"GoodsCollectionCell";
    GoodsCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[GoodsCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsCollectionCell"];
    }
    MMViewBorderRadius(cell, WidthRatio(10), 0, [UIColor clearColor]);
    return cell;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    iconImageView = [UIImageView new];
    iconImageView.backgroundColor = MMRandomColor;
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(43));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(19));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-HeightRatio(19));
        make.width.mas_equalTo(WidthRatio(147));
    }];
    
    titleLabel = [UILabel new];
    titleLabel.numberOfLines = 2;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->iconImageView.mas_right).offset(WidthRatio(32));
        make.top.mas_equalTo(self->iconImageView.mas_top).offset(HeightRatio(8));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(30));
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    priceLabel = [UILabel new];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->iconImageView.mas_right).offset(WidthRatio(32));
        make.bottom.mas_equalTo(self->iconImageView.mas_bottom).offset(-HeightRatio(13));
        make.height.mas_equalTo(HeightRatio(26));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    numberLabel = [UILabel new];
    numberLabel.textColor = HEX_COLOR(0xB8B8B8);
    numberLabel.font = [UIFont systemFontOfSize:WidthRatio(19)];
    [self.contentView addSubview:numberLabel];
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->iconImageView.mas_right).offset(WidthRatio(32));
        make.top.mas_equalTo(self->iconImageView.mas_top).offset(HeightRatio(94));
        make.height.mas_equalTo(HeightRatio(19));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
}
-(void)layoutSubviews
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews)
            {
                if ([view isKindOfClass: [UIImageView class]]) {
                    UIImageView *image=(UIImageView *)view;
                    if (self.selected) {
                        image.image=[UIImage imageNamed:@"xuanzhong"];
                    }else{
                        image.image=[UIImage imageNamed:@"meixuanzhong"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews)
            {
                if ([view isKindOfClass: [UIImageView class]]) {
                    UIImageView *image=(UIImageView *)view;
                    if (!self.selected) {
                        image.image=[UIImage imageNamed:@"meixuanzhong"];
                    }
                }
            }
        }
    }
    
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    titleLabel.text = _titleString;
}
-(void)setNumber:(NSString *)number{
    _number = number;
    numberLabel.text = _number;
    
}
-(void)setPrice:(NSString *)price{
    _price = price;
    priceLabel.text = _price;
}

- (void)setImg:(NSString *)img {
    _img = img;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil];
}
@end
