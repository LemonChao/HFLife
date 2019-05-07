//
//  SelectCheckDateViewController.h
//  DFCalendar
//
//  Created by Macsyf on 16/12/7.
//  Copyright © 2016年 ZhouDeFa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "BaseViewController.h"


@interface SelectCheckDateViewController : BaseViewController

@property(nonatomic,copy) void(^selectCheckDateBlock)(NSString *startDate,NSString *endDate,NSString *days);

@end
