//
//  CityChooseVC.h
//  HFLife
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CityChooseVCDelegate <NSObject>

- (void)cityChooseName:(NSString *)name;

@end
@interface CityChooseVC : BaseViewController
@property (nonatomic, weak) id<CityChooseVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
