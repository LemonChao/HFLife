//
//  JFLocationSingleton.h
//  HFLife
//
//  Created by mac on 2019/2/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JFLocationSingleton : NSObject
+(instancetype)sharedInstance;
@property (nonatomic, strong)NSArray *locationArray;
@end

NS_ASSUME_NONNULL_END
