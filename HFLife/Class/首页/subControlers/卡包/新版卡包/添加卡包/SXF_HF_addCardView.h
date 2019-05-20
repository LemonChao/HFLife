//
//  SXF_HF_addCardView.h
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_addCardView : UIView
@property (nonatomic, strong)void(^moreCardCallback)(NSInteger section);
@property (nonatomic, copy)void(^selectRow)(NSIndexPath *indexP);

@end

NS_ASSUME_NONNULL_END
