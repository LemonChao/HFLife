//
//  SXF_HF_addCardSectionHeaderView.h
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXF_HF_addCardSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong)void(^clickSectionHeaderCallBack)(void);
- (void)setDataForView:(id)data;
@end
