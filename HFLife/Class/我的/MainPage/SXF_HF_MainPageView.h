//
//  SXF_HF_MainPageView.h
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_MainPageView : UIView
@property (nonatomic, strong)void(^selectedItemCallback)(NSIndexPath *indexPath);
- (void)reSetHeadData;
@end

NS_ASSUME_NONNULL_END
