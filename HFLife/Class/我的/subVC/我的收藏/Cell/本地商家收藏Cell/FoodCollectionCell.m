//
//  FoodCollectionCell.m
//  HanPay
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "FoodCollectionCell.h"
#import "YYStarView.h"
@implementation FoodCollectionCell
{
    UIImageView *iconImageView;
    UILabel *titleLabel;
        //    星级
    YYStarView *starView;
    //地址
    UILabel *addressLabel;
    //距离
    UILabel *distanceLabel;
}
+ (instancetype)FoodCollectionCellWithTableView:(UITableView *)tableView {
    static NSString *cellId = @"FoodCollectionCell";
    FoodCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[FoodCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FoodCollectionCell"];
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
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->iconImageView.mas_right).offset(WidthRatio(32));
        make.top.mas_equalTo(self->iconImageView.mas_top).offset(HeightRatio(13));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(119));
        make.height.mas_equalTo(HeightRatio(30));
    }];
    
    distanceLabel = [UILabel new];
    distanceLabel.textColor = HEX_COLOR(0xB8B8B8);
    distanceLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [self.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_right);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(HeightRatio(22));
        make.centerY.mas_equalTo(self->titleLabel.mas_centerY);
    }];
    
    starView = [YYStarView new];
    starView.type = StarViewTypeShow;
    starView.starSize = CGSizeMake(WidthRatio(22), WidthRatio(22));
    starView.starSpacing = WidthRatio(8);
    starView.starCount = 5;
    [self.contentView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->iconImageView.mas_right).offset(WidthRatio(32));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(23));
    }];
    
    addressLabel = [UILabel new];
    addressLabel.textColor = HEX_COLOR(0xB8B8B8);
    addressLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->iconImageView.mas_right).offset(WidthRatio(32));
        make.top.mas_equalTo(self->starView.mas_bottom).offset(HeightRatio(22));
        make.height.mas_equalTo(HeightRatio(22));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(27));
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
-(void)setStar_level:(NSInteger)star_level{
    _star_level = star_level;
    starView.starScore = _star_level;
}
-(void)setAddress:(NSString *)address{
    _address = address;
    addressLabel.text = _address;
}
-(void)setDistance:(NSString *)distance{
    _distance = distance;
    distanceLabel.text = _distance;
}
- (void)setImg:(NSString *)img {
    _img = img;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
