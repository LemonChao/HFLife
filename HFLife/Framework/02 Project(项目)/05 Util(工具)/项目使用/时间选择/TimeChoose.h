//
//  CityChoose.h
//  CityChoose
//
//  Created by apple on 17/2/6.
//  Copyright © 2017年 desn. All rights reserved.
//
#import "ViewController.h"
#import <UIKit/UIKit.h>
@interface TimeChoose : UIView
/** 天 */
@property (nonatomic, strong) NSString *day;
/** 时 */
@property (nonatomic, strong) NSString *hour;
/** 分 */
@property (nonatomic, strong) NSString *minute;
/** 标题*/
@property (nonatomic, strong)NSString *title;
/** 是否是今天*/
@property (nonatomic, assign) BOOL isToday;
/** 选择的时间*/
@property (nonatomic, copy) void (^selectDate) (NSString *date);

-(instancetype)initWithFrame:(CGRect)frame isTaday:(BOOL)isTaday;
@end
