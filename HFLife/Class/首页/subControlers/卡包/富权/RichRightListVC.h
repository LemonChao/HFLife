//
//  RichRightListVC.h
//  HFLife
//
//  Created by sxf on 2019/4/20.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RichRightListVC : BaseViewController
@property (nonatomic,strong)NSArray *cellTitleArray;
@property (nonatomic,strong)NSArray *cellValueArray;
@property (nonatomic, strong)NSString *vcTitle;


/**
 0:收益记录
 1:富权兑换记录
 2:富权取出记录
 */
@property (nonatomic, assign)NSInteger recordType;
@end

NS_ASSUME_NONNULL_END
