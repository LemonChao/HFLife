//
//  CountdDownView.h
//  HFLife
//
//  Created by zchao on 2019/5/13.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 倒计时View
@interface CountdDownView : UIView

@property(nonatomic, copy) NSString *hour;
@property(nonatomic, copy) NSString *minute;
@property(nonatomic, copy) NSString *second;

@property(nonatomic, assign) NSTimeInterval timeInteval;

@property(nonatomic, strong) UILabel *hourLable;
@property(nonatomic, strong) UILabel *minuteLable;
@property(nonatomic, strong) UILabel *secondLable;

@end
NS_ASSUME_NONNULL_END
