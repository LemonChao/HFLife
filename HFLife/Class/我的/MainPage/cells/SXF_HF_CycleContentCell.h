//
//  SXF_HF_CycleContentCellTableViewCell.h
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_CycleContentCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *bgImageV;
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *subTitleLb;
@property (nonatomic, strong)UILabel *moneyLb;
@property (nonatomic, strong)UIImageView *gifImageV;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, strong)NSString *gifName;

@property (nonatomic, strong)UIImageView *customImage;
@end

NS_ASSUME_NONNULL_END
