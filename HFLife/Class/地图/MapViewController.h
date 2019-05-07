//
//  MapViewController.h
//  HanPay
//
//  Created by mac on 2019/2/2.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : BaseViewController

/**
 经度
 */
@property (nonatomic,assign)CGFloat longitude;

/**
 纬度
 */
@property (nonatomic,assign)CGFloat latitude;

/**
 是否标注
 */
@property (nonatomic,assign)BOOL isMark;
@end

NS_ASSUME_NONNULL_END
