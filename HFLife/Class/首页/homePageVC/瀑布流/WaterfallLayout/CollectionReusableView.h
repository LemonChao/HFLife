//
//  CollectionReusableView.h
//  Example
//
//  Created by nhope on 2018/4/28.
//  Copyright © 2018年 xiaopin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableView : UICollectionReusableView
@property (nonatomic, strong)UIButton *moreBtn;
@property(nonatomic, strong) UILabel *textLabel;
@property (nonatomic, copy)void(^clickHeaderBtnCallback)(void);
@end
