//
//  FQ_homeHeaderView.h
//  HFLife
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FQ_homeHeaderView : UIView
@property (nonatomic, strong)void(^clickBtn)(NSInteger index);
@property (nonatomic, strong)NSDictionary *dataSource;
@end

NS_ASSUME_NONNULL_END
