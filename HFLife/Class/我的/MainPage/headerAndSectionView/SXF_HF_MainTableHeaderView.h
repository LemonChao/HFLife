//
//  SXF_HF_MainTableHeaderView.h
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_MainTableHeaderView : UIView
- (void)reSetData;
@property(nonatomic, strong) MemberInfoModel *memberInfoModel;
@end

NS_ASSUME_NONNULL_END
