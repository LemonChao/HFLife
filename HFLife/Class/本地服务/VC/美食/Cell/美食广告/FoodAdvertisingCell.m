//
//  FoodAdvertisingCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/12.
//  Copyright © 2019年 张海彬. All rights reserved.
// 美食广告

#import "FoodAdvertisingCell.h"
#import "SDCycleScrollView.h"
@interface FoodAdvertisingCell ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong) SDCycleScrollView *cycleScroll;
@end
@implementation FoodAdvertisingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
//    self.cycleScroll.frame = CGRectMake(0, HeightRatio(22), SCREEN_WIDTH, HeightRatio(190));
//    self.cycleScroll.backgroundColor = [UIColor clearColor];
//    self.cycleScroll.imageURLStringsGroup = @[@"Foodbanner",@"Foodbanner",@"Foodbanner",@"Foodbanner"];
//    [self.contentView addSubview:self.cycleScroll];
//    self.cycleScroll.hidden = YES;
}
#pragma mark SDCycleScrollViewDelegate 点击图片回调
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"图片点击");
}
#pragma mark 懒加载
-(SDCycleScrollView *)cycleScroll{
    if (_cycleScroll == nil) {
        _cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _cycleScroll.isCustom = YES;
        _cycleScroll.distance = HeightRatio(47);
        _cycleScroll.delegate = self;
        _cycleScroll.tag = -4000;
        _cycleScroll.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    }
    return _cycleScroll;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
