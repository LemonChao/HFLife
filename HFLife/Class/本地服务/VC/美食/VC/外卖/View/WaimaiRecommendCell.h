//
//  WaimaiRecommendCell.h
//  HanPay
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaimaiRecommendCell : UITableViewCell

@end

@interface WaimaiRecommendSubView : UIButton
@property(strong,nonatomic) UIButton *typeButton;
@property(strong,nonatomic) UILabel *nameLabel;
@property(strong,nonatomic) UILabel *descriptionLabel;

@end

NS_ASSUME_NONNULL_END
