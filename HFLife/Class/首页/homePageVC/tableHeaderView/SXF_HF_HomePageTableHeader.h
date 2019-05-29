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
@property (nonatomic, assign)CGFloat scrollY;//头部滑动的位置
@property (nonatomic, strong)void(^appearCallback)(CGFloat alpha, BOOL isAppear);
@property (nonatomic, strong)NSString *myFQ;
@property (nonatomic, strong)NSNumber *fqPrice;
@property (nonatomic, strong)NSNumber *peopleNum;
@end

NS_ASSUME_NONNULL_END
