//
//  YYB_HF_SearchResultHotelCell.h
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//  酒店搜索cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_SearchResultHotelCell : UITableViewCell
@property(nonatomic, strong) UIImageView *imageV;//图片
@property(nonatomic, strong) UILabel *titleL;//名称
@property(nonatomic, strong) UILabel *scoreL;//评分
@property(nonatomic, strong) UILabel *addressL;//地址
@property(nonatomic, strong) UILabel *cashL;//评价
@end

NS_ASSUME_NONNULL_END
