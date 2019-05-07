//
//  ChooseLocationView.h
//  ChooseLocation
//
//  Created by Sekorm on 16/8/22.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseLocationView : UIView

@property (nonatomic, copy) NSString * address;

@property (nonatomic, copy) void(^chooseFinish)();
/** 传进来用的城市code*/
@property (nonatomic,copy) NSString * areaCode;

/** 选择好以后的code*/
@property (nonatomic,copy) NSString * chooseCode;
@end
