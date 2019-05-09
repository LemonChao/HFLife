//
//  YYB_HF_guessLikeTableViewCell.h
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_guessLikeTableViewCell : UITableViewCell
@property(nonatomic, copy) NSString *setNameStr;
@property(nonatomic, copy) NSString *setAdLabelStr;
@property(nonatomic, copy) NSString *setDistanceStr;
@property(nonatomic, copy) NSString *setPriceStr;
@property(nonatomic, copy) NSString *setOldPriceStr;
@property(nonatomic, copy) NSString *setConcessionMoneyStr;

@end

/** 右边图片cell */

@interface YYB_HF_guessLikeTableViewCellRightPic : UITableViewCell
@property(nonatomic, copy) NSString *setNameStr;
@property(nonatomic, copy) NSString *setDistanceStr;
@property(nonatomic, copy) NSString *setPriceStr;
@property(nonatomic, copy) NSString *setOldPriceStr;
@property(nonatomic, copy) NSString *setConcessionMoneyStr;
@end
NS_ASSUME_NONNULL_END
