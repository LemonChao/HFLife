//
//  SXF_HF_getMoneyTabHeaderView.h
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXF_HF_getMoneyTabHeaderView : UIView
@property (nonatomic, strong)void (^clickHeaderBtn)(NSInteger tag);
@property (nonatomic, strong)NSString *money;//设置的金额
- (void)setDataForView:(id)data;
@end
