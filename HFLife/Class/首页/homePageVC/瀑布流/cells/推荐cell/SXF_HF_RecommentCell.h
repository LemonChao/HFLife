//
//  SXF_HF_RecommentCell.h
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_RecommentCell : UICollectionViewCell
@property (nonatomic, strong) void(^selectedItem)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
