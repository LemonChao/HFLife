//
//  SXF_HF_CustomSearchBar.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_CustomSearchBar.h"

@interface SXF_HF_CustomSearchBar()

@property (nonatomic, strong)UIView *searchBgView;
@property (nonatomic, strong)UIImageView *searchImageV;
@property (nonatomic, strong)UILabel *seatchTitle;

@end



@implementation SXF_HF_CustomSearchBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.seatchTitle    = [UILabel new];
    self.searchBgView   = [UIView new];
    self.searchImageV   = [UIImageView new];
    
    [self addSubview:self.searchBgView];
    [self addSubview:self.searchImageV];
    [self addSubview:self.seatchTitle];
    
    self.seatchTitle.font = MyFont(13);
    self.seatchTitle.textColor = [UIColor colorWithHexString:@"#1D1B1B"];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
