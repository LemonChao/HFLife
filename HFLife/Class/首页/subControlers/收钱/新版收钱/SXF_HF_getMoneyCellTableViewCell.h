//
//  SXF_HF_getMoneyCellTableViewCell.h
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_getMoneyCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIImageView *titltImageV;

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLb;
@property (nonatomic, assign)BOOL cellType;
@end

NS_ASSUME_NONNULL_END
