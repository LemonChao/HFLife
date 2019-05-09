//
//  myTopView.h
//  masonry对数组布局
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myTopView : UIView
@property (nonatomic, strong)void(^selectedItem)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
