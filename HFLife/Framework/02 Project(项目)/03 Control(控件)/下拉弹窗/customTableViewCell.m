//
//  customTableViewCell.m
//  DuDuJR
//
//  Created by mini on 2018/1/2.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import "customTableViewCell.h"

@implementation customTableViewCell



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenView];
    }
    
    return self;
}


- (void) addChildrenView{
    
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
