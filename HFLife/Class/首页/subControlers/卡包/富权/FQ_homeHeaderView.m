//
//  FQ_homeHeaderView.m
//  HFLife
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "FQ_homeHeaderView.h"

@interface FQ_homeHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *recodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *ownerMoneyLb;//持有

@property (nonatomic, weak)IBOutlet UILabel *static_coin_bn_Lb;//富权可兑换成的余额

//可兑换
@property (weak, nonatomic) IBOutlet UILabel *canExchangeLb;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstriant;

@property (nonatomic, assign)BOOL canExchange;
@end


@implementation FQ_homeHeaderView





- (void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
    //更新数据源
    if ([dataSource isKindOfClass:[NSDictionary class]]) {
        if ([dataSource[@"data"] isKindOfClass:[NSDictionary class]] && [dataSource[@"data"][@"coin"] isKindOfClass:[NSDictionary class]]) {
            self.ownerMoneyLb.text = dataSource[@"data"][@"coin"][@"static_coin"];
            self.canExchangeLb.text = dataSource[@"data"][@"coin"][@"dynamic_dh"];
            self.static_coin_bn_Lb.text = [NSString stringWithFormat:@"≈%@（元）", dataSource[@"data"][@"coin"][@"static_coin_bn"] ?dataSource[@"data"][@"coin"][@"static_coin_bn"] : @"0" ];
        }
    }
    
    
}







- (void)awakeFromNib{
    [super awakeFromNib];
    self.recodeBtn.layer.borderWidth = 1;
    self.recodeBtn.backgroundColor = [UIColor whiteColor];
    [self.recodeBtn setTitleColor:HEX_COLOR(0xFF8B1A) forState:UIControlStateNormal];
    self.recodeBtn.layer.borderColor = HEX_COLOR(0xFF8B1A).CGColor;
    
    self.leadingConstriant.constant = WidthRatio(25);
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (IBAction)recoderBtnClick:(UIButton *)sender {
    !self.clickBtn ? : self.clickBtn(1);
}

- (IBAction)exchangeBtnClick:(UIButton *)sender {
    !self.clickBtn ? : self.clickBtn(0);
}
- (IBAction)getOutBtnClick:(UIButton *)sender {
    !self.clickBtn ? : self.clickBtn(2);
}




@end
