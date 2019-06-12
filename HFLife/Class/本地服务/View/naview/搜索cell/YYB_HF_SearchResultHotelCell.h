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
@property(nonatomic, strong) UIImageView *addressIconV;//d位置图标
@property(nonatomic, strong) UILabel *addressL;//地址
@property(nonatomic, strong) UILabel *pingjiaL;//评价
@property(nonatomic, strong) UILabel *consume_minL;//最低消费
@property(nonatomic, strong) UILabel *minL;//起

@property(nonatomic, strong) UIView *starBg;//星星
@property(nonatomic, strong) UIView *starSel;//、、
@property(nonatomic, assign) NSInteger starNum;//

@end

NS_ASSUME_NONNULL_END
