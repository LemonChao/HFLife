//
//  YYb_HF_CollReusableView.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYb_HF_CollReusableView : UICollectionReusableView
@property(nonatomic, strong) UILabel *textLabel;

@end

@interface YYb_HF_HotCollReusableView : UICollectionReusableView
@property(nonatomic, strong) UILabel *textLabel;
@property(nonatomic, strong) UIImageView *imageV;

@end

NS_ASSUME_NONNULL_END
