//
//  PreorderTableCell.m
//  HanPay
//
//  Created by zchao on 2019/2/22.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "PreorderTableCell.h"
#import "YYStarView.h"
@interface PreorderTableCell ()

@property (weak, nonatomic) IBOutlet YYStarView *starView;
//包间可定
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
//环境好
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//价钱
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//距离
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
//团购
@property (weak, nonatomic) IBOutlet UILabel *bulkLabel;
//订座信息
@property (weak, nonatomic) IBOutlet UILabel *reservationLabel;

@end

@implementation PreorderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.leftLabel.layer.borderColor = HEX_COLOR(0x999999).CGColor;
    self.rightLabel.layer.borderColor = HEX_COLOR(0x999999).CGColor;
    
    self.starView.type = StarViewTypeShow;
    self.starView.starSize = CGSizeMake(WidthRatio(22), WidthRatio(22));
    self.starView.starSpacing = WidthRatio(10);
    self.starView.starScore = 4;

}
-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_dataDict[@"photo"]] placeholderImage:MMGetImage(@"")];
    self.titleLabel.text = [NSString judgeNullReturnString:_dataDict[@"food_name"]];
    self.priceLabel.text = MMNSStringFormat(@"¥%@/人",[NSString judgeNullReturnString:_dataDict[@"price"]]);
    self.distanceLabel.text = [NSString judgeNullReturnString:_dataDict[@"distance"]];
    if ([_dataDict[@"food_cate"] isKindOfClass:[NSArray class]]) {
        NSArray *array = _dataDict[@"food_cate"];
        NSString *content = @"";
        for (NSString *str in array) {
            content = MMNSStringFormat(@"%@ %@",content,str);
        }
        self.bulkLabel.text = content;
    }else{
        self.bulkLabel.text = @"";
    }
    
    if ([_dataDict[@"coupon"] isKindOfClass:[NSArray class]]) {
        NSArray *array = _dataDict[@"coupon"];
        NSString *content = @"";
        for (NSString *str in array) {
            content = MMNSStringFormat(@"%@ %@",content,str);
        }
        self.reservationLabel.text = content;
    }else{
        self.reservationLabel.text = @"";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)reservation:(UIButton *)sender {
    if (self.reservationBlock) {
        self.reservationBlock(self.dataDict);
    }
}

@end
