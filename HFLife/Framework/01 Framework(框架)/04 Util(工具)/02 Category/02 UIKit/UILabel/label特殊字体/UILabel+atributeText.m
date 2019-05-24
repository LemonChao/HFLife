
//
//  UILabel+atributeText.m
//  HFLife
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "UILabel+atributeText.h"

@implementation UILabel (atributeText)
//给UILabel设置行间距和字间距

-(void)setLabelWithLineSpace:(CGFloat)lineSpace {
    if (self.text) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = lineSpace; //设置行间距
        //    paraStyle.paragraphSpacing = 2.0;//字间距
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        //设置字间距 NSKernAttributeName:@1.5f
        NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                              };
        
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.text attributes:dic];
        self.attributedText = attributeStr;
    }
}
@end
