//
//  YYB_HF_LocaColumnCollectionCell.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface YYB_HF_LocaColumnCollectionCell : UICollectionViewCell

@property(nonatomic, copy) void (^selectColumnIndex)(NSIndexPath *index);
- (void)reFreshData:(NSArray *)dataArr;//数据源
@end
@interface YYB_HF_LocaColumnCollectionCellItem : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *title;
@end

NS_ASSUME_NONNULL_END
