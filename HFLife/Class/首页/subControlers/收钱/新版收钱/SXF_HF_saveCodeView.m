
//
//  SXF_HF_saveCodeView.m
//  HFLife
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_saveCodeView.h"

@interface SXF_HF_saveCodeView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLb;






@property (nonatomic, weak)IBOutlet UILabel *leveLb;
@property (nonatomic, weak)IBOutlet UIImageView *topHeaderView;
@property (nonatomic, weak)IBOutlet UILabel *subTitleLb;
@property (nonatomic, weak)IBOutlet UIImageView *codeImageV;
@property (nonatomic, weak)IBOutlet UIView *codeBgView;
@property (nonatomic, weak)IBOutlet UILabel *nameLb;
@property (nonatomic, weak)IBOutlet UILabel *bottomlb;
@end

@implementation SXF_HF_saveCodeView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)setDataForView:(id )code{
    self.codeImageV.image = [SGQRCodeObtain generateQRCodeWithData:[NSString stringWithFormat:@"%@", code] size:self.codeImageV.bounds.size.width logoImage:[UIImage imageNamed:@"logo"] ratio:0.3];
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
