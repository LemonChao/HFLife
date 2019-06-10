//
//  SXF_HF_saveCodeView2.m
//  HFLife
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_saveCodeView2.h"
#import "SGQRCodeObtain.h"
@interface SXF_HF_saveCodeView2 ()
@property (weak, nonatomic) IBOutlet UIImageView *downCodeImgV;
@property (weak, nonatomic) IBOutlet UIImageView *getMoneyCodeImgV;
@end

@implementation SXF_HF_saveCodeView2

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)setDataForView:(id )code downLoadUrl:(NSString *)downLoadStr{
    self.getMoneyCodeImgV.image = [SGQRCodeObtain generateQRCodeWithData:[NSString stringWithFormat:@"%@", code] size:self.getMoneyCodeImgV.bounds.size.width];
    
    self.downCodeImgV.image = [SGQRCodeObtain generateQRCodeWithData:[NSString stringWithFormat:@"%@", downLoadStr] size:self.downCodeImgV.bounds.size.width];
}




@end
