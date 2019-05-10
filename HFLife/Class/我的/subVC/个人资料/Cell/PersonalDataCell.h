//
//  PersonalDataCell.h
//  HanPay
//
//  Created by 张海彬 on 2019/1/18.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalDataCell : UITableViewCell

/**
   标题
 */
@property (nonatomic,copy)NSString *titleString;

/**
 副标题
 */
@property (nonatomic,copy)NSString *subtitleString;

/**
 图片的名字
 */
@property (nonatomic,copy)NSString *imageName;

/**
 图片
 */
@property (nonatomic,strong)UIImage *image;

/**
 是否隐藏箭头
 */
@property (nonatomic,assign)BOOL isArrowHiden;
@end

NS_ASSUME_NONNULL_END
