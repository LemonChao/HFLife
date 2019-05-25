//
//  YYB_HF_guessLikeCollectionViewCell.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_guessLikeCollectionViewCell : UICollectionViewCell
@property(nonatomic, copy) NSString *setNameStr;
@property(nonatomic, copy) NSString *setAdLabelStr;
@property(nonatomic, copy) NSString *setDistanceStr;
@property(nonatomic, copy) NSString *setPriceStr;
@property(nonatomic, copy) NSString *setOldPriceStr;
@property(nonatomic, copy) NSString *setConcessionMoneyStr;
@property(nonatomic, strong) NSArray *setImageArr;//图片数组
@end
@interface YYB_HF_guessLikeCollectionViewCellRightPic : UICollectionViewCell

@property(nonatomic, copy) NSString *setNameStr;
@property(nonatomic, copy) NSString *setDistanceStr;
@property(nonatomic, copy) NSString *setPriceStr;
@property(nonatomic, copy) NSString *setOldPriceStr;
@property(nonatomic, copy) NSString *setConcessionMoneyStr;
@property(nonatomic, copy) NSString *setImageUrl;//右边图片
@end

NS_ASSUME_NONNULL_END
