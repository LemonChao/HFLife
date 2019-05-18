//
//  SXF_HF_TimeSelectedView.h
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_TimeSelectedView : UIView
@property (nonatomic, strong)void(^confirmBtnCallback)(NSString *year, NSString *month);
@end

NS_ASSUME_NONNULL_END
