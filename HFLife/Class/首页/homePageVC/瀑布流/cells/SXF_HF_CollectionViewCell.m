//
//  CollectionViewCell.m
//  Example
//
//  Created by nhope on 2018/4/28.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import "SXF_HF_CollectionViewCell.h"

@interface SXF_HF_CollectionViewCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic ,strong) UIImageView *imageV;
@property (nonatomic ,strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic ,strong) UILabel *time1;
@property (nonatomic, strong) UILabel *time2;
@property (nonatomic ,strong) UIImageView *incoderImageV;
@property (nonatomic, strong)UIView *cycleView;
@end


@implementation SXF_HF_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.backgroundColor = [UIColor whiteColor];
    
    self.bgView = [UIView new];
    self.imageV = [UIImageView new];
    self.titleLb = [UILabel new];
    self.subTitle = [UILabel new];
    self.incoderImageV = [UIImageView new];
    self.time1 = [UILabel new];
    self.time2 = [UILabel new];
    self.cycleView = [UIView new];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.imageV];
    [self.bgView addSubview:self.titleLb];
    [self.bgView addSubview:self.subTitle];
    [self.bgView addSubview:self.incoderImageV];
    [self.bgView addSubview:self.time1];
    [self.bgView addSubview:self.time2];
    [self.bgView addSubview:self.cycleView];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.incoderImageV.image = [UIImage imageNamed:@"homePage更多"];
    self.imageV.image = [UIImage imageNamed:@"homeLoge"];
    self.titleLb.font = FONT(12);
    self.titleLb.textColor = HEX_COLOR(0x131313);
    self.subTitle.font = FONT(12);
    self.subTitle.textColor = HEX_COLOR(0x131313);
    self.time1.font = FONT(12);
    self.time1.textColor = HEX_COLOR(0x868686);
    self.time2.font = FONT(12);
    self.time2.textColor = HEX_COLOR(0x868686);
    self.cycleView.backgroundColor = colorCA1400;
    self.cycleView.layer.cornerRadius = ScreenScale(4);
    
    
    self.cycleView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCell)];
//    [self.bgView addGestureRecognizer:tap];
    
    
//    self.titleLb.text = @"生活缴费：电费缴费成功";
//    self.subTitle.text = @"转账：你的好友梧桐给你转账了";
//    self.time1.text = @"36分钟前";
//    self.time2.text = @"25分钟前";
    
}
- (void)setModelArr:(NSArray<noticeModel *> *)modelArr{
    _modelArr = modelArr;
    //赋值
    if (modelArr.count == 1) {
        self.subTitle.hidden = self.time2.hidden = YES;
        [self.titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY); make.left.mas_equalTo(self.imageV.mas_right).offset(ScreenScale(10));
            make.height.mas_equalTo(12);
            make.width.lessThanOrEqualTo(@(ScreenScale(200)));
        }];
        
        noticeModel *model = modelArr.firstObject;
        NSLog(@"时间%@", [NSDate timestampSwitchTime:[model.addtime integerValue] dateFormat:DateFormatStr]);
        self.titleLb.text = [NSString stringWithFormat:@"%@:%@", [self getTitle:model] , model.body];
        self.time1.text = [NSDate intervalSinceNow:[NSString stringWithFormat:@"%@", model.addtime ? model.addtime : @""]];
    }else if (modelArr.count > 1){
        
        self.subTitle.hidden = self.time2.hidden = NO;
        [self.titleLb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageV.mas_top); make.left.mas_equalTo(self.imageV.mas_right).offset(ScreenScale(10));
            make.height.mas_equalTo(12);
            make.width.lessThanOrEqualTo(@(ScreenScale(200)));
        }];
        
        
        noticeModel *model = modelArr.firstObject;
        self.titleLb.text = [NSString stringWithFormat:@"%@:%@", [self getTitle:model] , model.body];
        self.time1.text = [NSDate intervalSinceNow:[NSString stringWithFormat:@"%@", model.addtime ? model.addtime : @""]];
        
        noticeModel *model2 = modelArr[1];
        self.subTitle.text = [NSString stringWithFormat:@"%@:%@", [self getTitle:model2] , model2.body];
        self.time2.text = [NSDate intervalSinceNow:[NSString stringWithFormat:@"%@", model2.addtime ? model2.addtime : @""]];
    }
    [self layoutIfNeeded];
    
}

- (NSString *)getTitle:(noticeModel *)model{
    if ([model.type integerValue] == 1) {
        return @"汉富助手";
    }else if ([model.type integerValue] == 2){
        return @"汉富助手";
    }else if ([model.type integerValue] == 3){
        return @"生活缴费";
    }else{
        return @"汉富助手";
    }
}

- (void) clickCell{
    NSLog(@"点击cell");
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-ScreenScale(12));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(6));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(6));
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(ScreenScale(10));
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.height.mas_equalTo(ScreenScale(36));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageV.mas_top).priorityLow(); make.left.mas_equalTo(self.imageV.mas_right).offset(ScreenScale(10));
        make.height.mas_equalTo(12);
        make.width.lessThanOrEqualTo(@(ScreenScale(200)));
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_left);
        make.bottom.mas_equalTo(self.imageV.mas_bottom);
    }];
    
    [self.incoderImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-ScreenScale(10));
        make.width.mas_equalTo(ScreenScale(9));
        make.height.mas_equalTo(ScreenScale(16));
        make.centerY.mas_equalTo(self.imageV.mas_centerY);
    }];
    
    [self.time1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_right).offset(ScreenScale(10));
        make.centerY.mas_equalTo(self.titleLb);
    }];
    
    [self.time2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.subTitle.mas_right).offset(ScreenScale(10));
        make.centerY.mas_equalTo(self.subTitle);
    }];
    
    [self layoutIfNeeded];
    
    self.bgView.layer.cornerRadius = 5;
    [self.bgView addShadowForViewColor:HEX_COLOR(0x808080) offSet:CGSizeMake(-1,2) shadowRadius:3 cornerRadius:5 opacity:0.3];
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.incoderImageV.mas_left).offset(ScreenScale(-10));
        make.centerY.mas_equalTo(self.incoderImageV.mas_centerY);
        make.width.height.mas_equalTo(ScreenScale(8));
    }];
    
}


@end
