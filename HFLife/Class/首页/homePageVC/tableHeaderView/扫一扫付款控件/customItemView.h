//
//  customItemView.h
//  masonry对数组布局
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface customItemView : UIView
@property (nonatomic, strong)void(^clickItem)(NSInteger index);
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UIImageView *imageV;
@end

NS_ASSUME_NONNULL_END
