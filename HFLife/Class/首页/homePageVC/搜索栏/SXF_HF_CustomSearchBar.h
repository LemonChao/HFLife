//
//  SXF_HF_CustomSearchBar.h
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_CustomSearchBar : UIView
@property (nonatomic, copy)void(^topBarBtnClick)(NSInteger tag);
@end

NS_ASSUME_NONNULL_END
