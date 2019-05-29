//
//  SXF_HF_payMoneyTabHeader.h
//  HFLife
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_payMoneyTabHeader : UIView
@property (nonatomic, strong)void(^barCodeClick)(UIImage *image, NSString *barCodeStr);
- (void)setDataForView:(id)data;
@end

NS_ASSUME_NONNULL_END
