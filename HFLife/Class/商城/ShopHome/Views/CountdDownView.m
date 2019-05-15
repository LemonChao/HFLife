//
//  CountdDownView.m
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "CountdDownView.h"

@interface ShopCountLabel : UILabel

@end


@interface CountdDownView ()

@property(nonatomic, strong) UILabel *hourLable;
@property(nonatomic, strong) UILabel *minuteLable;
@property(nonatomic, strong) UILabel *secondLable;

@end
@implementation CountdDownView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hour = self.minute = self.second = @"00";
        self.hourLable = [[ShopCountLabel alloc] init];
        self.minuteLable = [[ShopCountLabel alloc] init];
        self.secondLable = [[ShopCountLabel alloc] init];
        UILabel *colonLab1 = [UITool labelWithText:@":" textColor:GeneralRedColor font:SystemFont(12)];
        UILabel *colonLab2 = [UITool labelWithText:@":" textColor:GeneralRedColor font:SystemFont(12)];
        
        UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.hourLable,colonLab1,self.minuteLable,colonLab2,self.secondLable]];
        stackView.axis = UILayoutConstraintAxisHorizontal;
        stackView.alignment = UIStackViewAlignmentFill;
        stackView.distribution = UIStackViewDistributionFill;
        stackView.spacing = 2.f;
        
        [self addSubview:stackView];
        [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setTimeInteval:(NSTimeInterval)timeInteval {
    _timeInteval = timeInteval;
    NSInteger intervalInt = timeInteval;
    self.hour = [NSString stringWithFormat:@"%02ld", intervalInt/3600];
    self.minute = [NSString stringWithFormat:@"%02ld",(intervalInt%3600)/60];
    self.second = [NSString stringWithFormat:@"%02ld",intervalInt%60];
    
    self.hourLable.text = self.hour;
    self.minuteLable.text = self.minute;
    self.secondLable.text = self.second;
}


@end

@implementation ShopCountLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.text = @"00";
        self.textColor = [UIColor whiteColor];
        self.font = SystemFont(13);
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = RGBA(202,20,0,0.8);
        self.clipsToBounds = YES;
    }
    return self;
}



- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    self.layer.cornerRadius = (size.height+ScreenScale(5))/2;
    return CGSizeMake(size.width+ScreenScale(16), size.height+ScreenScale(5));
}

@end


