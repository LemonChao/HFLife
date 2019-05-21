//
//  SXF_HF_ItemsViewCell.h
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_ItemsViewCell : UICollectionViewCell
@property (nonatomic ,strong) void(^selectItemBlock)(NSInteger index);
@property (nonatomic, strong)NSArray *itemDataSourceArr;
@end

NS_ASSUME_NONNULL_END
