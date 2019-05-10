//
//  CardPackageCell.h
//  HFLife
//
//  Created by sxf on 2019/1/22.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardPackageCell : UITableViewCell
/** 标题*/
@property (nonatomic,copy) NSString *titleString;
/** 说明*/
@property (nonatomic,copy) NSString *explainString;
/** 内容*/
@property (nonatomic,copy) NSString *contentString;

@property (nonatomic,copy) NSString *bgName;
@end

NS_ASSUME_NONNULL_END
