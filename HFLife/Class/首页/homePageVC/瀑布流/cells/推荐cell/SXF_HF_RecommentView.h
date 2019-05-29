//
//  SXF_HF_RecommentView.h
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_RecommentView : UIView
@property (nonatomic, strong) void(^selectedItem)(NSInteger indexPath, id value);

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong)void(^activityBtnCallback)(NSString *urlStr);
@end

NS_ASSUME_NONNULL_END
