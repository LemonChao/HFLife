//
//  ZCShopCouponsCell.m
//  HFLife
//
//  Created by zchao on 2019/5/27.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCouponsCell.h"

@implementation ZCShopCouponsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *cornerBGView = [UITool viewWithColor:[UIColor whiteColor]];
        [cornerBGView addShadowForViewColor:GeneralRedColor offSet:CGSizeMake(0, 2) shadowRadius:3 cornerRadius:ScreenScale(5) opacity:0.1];
        
        [self.contentView addSubview:cornerBGView];
        [cornerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).inset(ScreenScale(0));
            make.left.right.equalTo(self.contentView).inset(ScreenScale(12));
            make.bottom.equalTo(self.contentView).inset(ScreenScale(20));
        }];
        
    }
    
    return self;
}

@end
