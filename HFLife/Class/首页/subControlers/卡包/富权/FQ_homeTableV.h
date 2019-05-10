//
//  FQ_homeTableV.h
//  HanPay
//
//  Created by mac on 2019/4/20.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FQ_homeTableV : UIView
@property (nonatomic, strong)void(^selectedBtn)(NSInteger index);

- (void)setDataForView:(id)dataSource;
@end

NS_ASSUME_NONNULL_END
