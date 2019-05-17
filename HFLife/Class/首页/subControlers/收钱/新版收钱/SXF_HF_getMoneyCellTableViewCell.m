
//
//  SXF_HF_getMoneyCellTableViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_getMoneyCellTableViewCell.h"

@interface SXF_HF_getMoneyCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *firstCellView;
@property (weak, nonatomic) IBOutlet UIView *secondCellView;


@end

@implementation SXF_HF_getMoneyCellTableViewCell


- (void)setCellType:(BOOL)cellType{
    _cellType = cellType;
    self.firstCellView.hidden = cellType;
    self.secondCellView.hidden = !cellType;
}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
