//
//  YYB_HF_SearchResultCell.h
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//  美食搜索cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_SearchResultCell : UITableViewCell
@property(nonatomic, strong) UIImageView *imageV;//图片
@property(nonatomic, strong) UILabel *titleL;//名称
@property(nonatomic, strong) UILabel *priceL;//人均消费
@property(nonatomic, strong) UILabel *addressL;//地址
@property(nonatomic, strong) UILabel *cashL;//

@end

NS_ASSUME_NONNULL_END
