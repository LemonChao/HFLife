//
//  RichRightRecordCell.h
//  HFLife
//
//  Created by sxf on 2019/4/20.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichRightRecordCell : UITableViewCell

/**
 标题array（最大三个）先设置这个属相，在设置valueArray属性
 */
@property (nonatomic,strong)NSArray *titleArray;

/**
 数值，数目和标题数一样
 */
@property (nonatomic,strong)NSArray *valueArray;

/**
 标题值是否醒目
 */
@property (nonatomic,assign)BOOL isMarked;
@end

NS_ASSUME_NONNULL_END
