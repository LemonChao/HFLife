//
//  WaimaiCycleCell.m
//  HanPay
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "WaimaiCycleCell.h"
#import "SDCycleScrollView.h"

@interface WaimaiCycleCell ()<SDCycleScrollViewDelegate>

@property(strong, nonatomic) SDCycleScrollView *cycleView;

@end

@implementation WaimaiCycleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    self.cycleView.imageURLStringsGroup = @[@"Foodbanner",@"Foodbanner",@"Foodbanner",@"Foodbanner"];
    
    [self.contentView addSubview:self.cycleView];
    
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(15, 13, 15, 13));
    }];
}


- (SDCycleScrollView *)cycleView {
    if (!_cycleView) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"Foodbanner"]];
        _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    }
    return _cycleView;
}

@end
