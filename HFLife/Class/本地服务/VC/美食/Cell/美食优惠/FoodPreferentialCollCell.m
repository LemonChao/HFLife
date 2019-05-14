//
//  FoodPreferentialCollCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/12.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "FoodPreferentialCollCell.h"
@interface FoodPreferentialCollCell ()
/** 图片*/
@property (nonatomic, strong) UIImageView *imgView;

/**
 标题
 */
@property (nonatomic, strong) UILabel *title;

/**
 月售
 */
@property (nonatomic, strong) UILabel *salesLabel;

/**
 价格
 */
@property (nonatomic, strong) UILabel *priceLabel;
@end
@implementation FoodPreferentialCollCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        UIImageView *bgImageView =[UIImageView new];
        bgImageView.image = MMGetImage(@"taocankuang");
        [self.contentView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        [self initView];
    }
    return self;
}

- (void)initView {
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = MMGetImage(@"mianshi");
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imgView];
    
    self.title = [[UILabel alloc] init];
    self.title.text = @"泰式咖喱牛肉饭";
    self.title.textColor = [UIColor blackColor];
    self.title.font = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(25)];
    [self.contentView addSubview:self.title];
    
    self.salesLabel =  [[UILabel alloc] init];
    self.salesLabel.text = @"月售 100";
    
    self.salesLabel.textColor = HEX_COLOR(0xa9a9a9);
    self.salesLabel.font = [UIFont systemFontOfSize:WidthRatio(21)];
    [self.contentView addSubview:self.salesLabel];
    
    
    self.priceLabel =  [[UILabel alloc] init];
    self.priceLabel.text = @"￥29.9";
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.font = [UIFont systemFontOfSize:WidthRatio(29)];
    [self.contentView addSubview:self.priceLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
        //    self.imgView.frame = CGRectMake(0, 0, WidthRatio(72), WidthRatio(72));
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(15));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(15));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(15));
        make.height.mas_equalTo(HeightRatio(210));
    }];
    MMViewBorderRadius(self.imgView, WidthRatio(15), 1,HEX_COLOR(0xebebeb));

    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_bottom).offset(HeightRatio(14));
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(15));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(15));
        make.height.mas_equalTo(HeightRatio(25));
    }];
    
    [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).offset(HeightRatio(25));
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(15));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(15));
        make.height.mas_equalTo(HeightRatio(21));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).offset(HeightRatio(18));
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(15));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(15));
        make.height.mas_equalTo(HeightRatio(29));
    }];
    
}
-(void)setDataModel:(id)dataModel{
    _dataModel = dataModel;
    NSLog(@"dataModel : %@", dataModel);
    if ([_dataModel isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)_dataModel;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:MMNSStringFormat(@"%@", dict[@"photo"] ? dict[@"photo"] : @"http://www")] placeholderImage:MMGetImage(@"")];
        self.title.text = MMNSStringFormat(@"%@",dict[@"product_name"] ? dict[@"product_name"] : @"");
        self.salesLabel.text = MMNSStringFormat(@"月售 %@",dict[@"month_num"] ? dict[@"month_num"] : @"");
        self.priceLabel.text = MMNSStringFormat(@"￥%@",dict[@"price"] ? dict[@"price"] : @"");
    }
}
@end
