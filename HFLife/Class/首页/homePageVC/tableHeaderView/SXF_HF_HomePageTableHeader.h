//
//  SXF_HF_HomePageTableHeader.h
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_HomePageTableHeader : UIView
@property (nonatomic, strong)void(^selectedHeaderBtn)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
