//
//  RichRightRecordCell.m
//  HFLife
//
//  Created by sxf on 2019/4/20.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "RichRightRecordCell.h"

@implementation RichRightRecordCell
{
    UILabel *_oneTitleLabel;
    UILabel *_oneValueLabel;
    
    UILabel *_twoTitleLabel;
    UILabel *_twoValueLabel;
    
    UILabel *_threeTitleLabel;
    UILabel *_threeValueLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
        self.contentView.clipsToBounds = YES;
    }
    return self;
}
-(void)initWithUI{
    _oneTitleLabel = [UILabel new];
    _oneTitleLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
    _oneTitleLabel.textColor = [UIColor blackColor];
//    _oneTitleLabel.backgroundColor = MMRandomColor;
    [self.contentView addSubview:_oneTitleLabel];
    [_oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(41));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(40));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _oneValueLabel = [UILabel new];
    _oneValueLabel.font = [UIFont systemFontOfSize:WidthRatio(36)];
    _oneValueLabel.textColor = HEX_COLOR(0x333333);
//    _oneValueLabel.backgroundColor = MMRandomColor;
    [self.contentView addSubview:_oneValueLabel];
    [_oneValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->_oneTitleLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(24));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _twoTitleLabel = [UILabel new];
    _twoTitleLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    _twoTitleLabel.textColor = HEX_COLOR(0x999999);
//    _twoTitleLabel.backgroundColor = MMRandomColor;
    [self.contentView addSubview:_twoTitleLabel];
    [_twoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(41));
        make.top.mas_equalTo(self->_oneTitleLabel.mas_bottom).offset(HeightRatio(20));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _twoValueLabel = [UILabel new];
    _twoValueLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    _twoValueLabel.textColor = HEX_COLOR(0x999999);
//    _twoValueLabel.backgroundColor = MMRandomColor;
    [self.contentView addSubview:_twoValueLabel];
    [_twoValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->_twoTitleLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(24));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    
    _threeTitleLabel = [UILabel new];
    _threeTitleLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
    _threeTitleLabel.textColor = HEX_COLOR(0x999999);
//    _threeTitleLabel.backgroundColor = MMRandomColor;
    [self.contentView addSubview:_threeTitleLabel];
    [_threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(41));
        make.top.mas_equalTo(self->_twoTitleLabel.mas_bottom).offset(HeightRatio(20));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _threeValueLabel = [UILabel new];
    _threeValueLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    _threeValueLabel.textColor = HEX_COLOR(0x999999);
//    _threeValueLabel.backgroundColor = MMRandomColor;
    [self.contentView addSubview:_threeValueLabel];
    [_threeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->_threeTitleLabel.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(24));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
}

-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    _oneTitleLabel.hidden = _oneValueLabel.hidden = _titleArray.count==0? YES : NO;
    _twoTitleLabel.hidden = _twoValueLabel.hidden = _titleArray.count>1 ? NO:YES;
    _threeTitleLabel.hidden = _threeValueLabel.hidden = _titleArray.count > 2 ? NO:YES;
    UIView *view = nil;
    if (!_oneTitleLabel.hidden) {
        _oneTitleLabel.text = _titleArray[0];
        view = _oneTitleLabel;
    }
    if (!_twoTitleLabel.hidden) {
        _twoTitleLabel.text = _titleArray[1];
        view = _twoTitleLabel;
    }
    if (!_threeTitleLabel.hidden) {
        _threeTitleLabel.text = _titleArray[2];
        view = _threeTitleLabel;
    }
    [self setupAutoHeightWithBottomView:view bottomMargin:HeightRatio(39)];
}
-(void)setValueArray:(NSArray *)valueArray{
    _valueArray = valueArray;
    if (_valueArray.count>0) {
        _oneValueLabel.text = [NSString judgeNullReturnString:_valueArray[0]];
    }
    if (_valueArray.count>1) {
        _twoValueLabel.text = [NSString judgeNullReturnString:_valueArray[1]];
    }
    if (_valueArray.count>2) {
        _threeValueLabel.text = [NSString judgeNullReturnString:_valueArray[2]];
    }
}
-(void)setIsMarked:(BOOL)isMarked{
    _isMarked = isMarked;
    if (_isMarked) {
        _oneValueLabel.textColor = HEX_COLOR(0xFC823E);
    }else{
        _oneValueLabel.textColor = HEX_COLOR(0x333333);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
