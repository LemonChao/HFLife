//
//  SXF_HF_KeyBoardView.h
//  HFLife
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_KeyBoardView : UIView
@property (nonatomic, strong)UILabel *msgLb;
@property (nonatomic, assign)BOOL editingEable;
@property (nonatomic, strong)void(^passwordCallback)(NSString *password);
@end

NS_ASSUME_NONNULL_END
