//
//  ContainerTableHeader.h
//  HanPay
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContainerTableHeader : UITableViewHeaderFooterView

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UIView *rightbgView;
@property(nonatomic,strong) UILabel *countLable;
@property(nonatomic,strong) UIImageView *arrowImage;

@end

NS_ASSUME_NONNULL_END
