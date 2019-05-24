//
//  YYB_HF_changeAccountCell.h
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYB_HF_changeAccountCell : UITableViewCell
/** 头像 */

@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
/** 选中icon */

@property (strong, nonatomic) IBOutlet UIImageView *cheackIcon;
/** 账号 */

@property (strong, nonatomic) IBOutlet UILabel *accountLabel;

@end

NS_ASSUME_NONNULL_END
