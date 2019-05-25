//
//  YYB_HF_LifeLocaView.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_LifeLocaView : UIView
- (void)loadData;
@property(nonatomic, copy) void (^reFreshData)(YYB_HF_nearLifeModel *nearModel);
@end

NS_ASSUME_NONNULL_END
