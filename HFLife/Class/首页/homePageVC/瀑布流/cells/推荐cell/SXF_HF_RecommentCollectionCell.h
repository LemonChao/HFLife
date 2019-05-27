//
//  SXF_HF_RecommentCollectionCell.h
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>




NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    itemType_first,
    itemType_two,
    itemType_three,
    itemType_foure,
    itemType_five,
} itemType;
@interface SXF_HF_RecommentCollectionCell : UICollectionViewCell
- (void)setDataForCell:(homeListModel *)model;
@end

NS_ASSUME_NONNULL_END
