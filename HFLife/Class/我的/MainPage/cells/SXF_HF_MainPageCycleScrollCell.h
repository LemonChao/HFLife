//
//  SXF_HF_MainPageCycleScrollCell.h
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_MainPageCycleScrollCell : UITableViewCell
@property (nonatomic ,strong) void(^selectItemBlock)(NSInteger index);

@property (nonatomic ,strong) NSArray *modelArr;
@end

NS_ASSUME_NONNULL_END
