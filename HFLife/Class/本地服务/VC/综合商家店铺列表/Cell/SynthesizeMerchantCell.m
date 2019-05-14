//
//  SynthesizeMerchantCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/4/19.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "SynthesizeMerchantCell.h"
#import "ZKCycleScrollView.h"
#import "LocalImageCell.h"
@interface SynthesizeMerchantCell ()<ZKCycleScrollViewDelegate,ZKCycleScrollViewDataSource>
{
    NSArray *_localPathGroup;
}
@property (nonatomic, strong) ZKCycleScrollView *cycleScrollView;
@end
@implementation SynthesizeMerchantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _localPathGroup = @[@"http://static1.pezy.cn/img/2019-02-01/5932241902444072231.jpg", @"http://static1.pezy.cn/img/2019-03-01/1206059142424414231.jpg"];
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    [self.contentView addSubview:({
        _cycleScrollView = [[ZKCycleScrollView alloc] initWithFrame:CGRectMake(0.f,0, SCREEN_WIDTH, HeightRatio(344)-HeightRatio(20))];
        _cycleScrollView.delegate = self;
        _cycleScrollView.dataSource = self;
        _cycleScrollView.hidesPageControl = YES;
        _cycleScrollView.itemSpacing = WidthRatio(25);
        _cycleScrollView.itemSize = CGSizeMake(SCREEN_WIDTH - WidthRatio(25)*2, HeightRatio(344)-HeightRatio(32)*2);
        [_cycleScrollView registerCellNib:[UINib nibWithNibName:@"LocalImageCell" bundle:nil] forCellWithReuseIdentifier:@"LocalImageCell"];
        _cycleScrollView;
    })];
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    _localPathGroup = dataArr;
    [_cycleScrollView reloadData];
}

#pragma mark -- ZKCycleScrollView DataSource
- (NSInteger)numberOfItemsInCycleScrollView:(ZKCycleScrollView *)cycleScrollView
{
    return _localPathGroup.count;
}

- (__kindof ZKCycleScrollViewCell *)cycleScrollView:(ZKCycleScrollView *)cycleScrollView cellForItemAtIndex:(NSInteger)index{
    LocalImageCell *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:@"LocalImageCell" forIndex:index];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_localPathGroup[index]] placeholderImage:MMGetImage(@"waimai_youxuan_topRight")];
    return cell;
}

#pragma mark -- ZKCycleScrollView Delegate
- (void)cycleScrollView:(ZKCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"selected index: %zd", index);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
