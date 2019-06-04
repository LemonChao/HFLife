//
//  UILabel+atributeText.h
//  HFLife
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (atributeText)


/**
 给UILabel设置行间距和字间距

 @param lineSpace <#lineSpace description#>
 */
-(void)setLabelWithLineSpace:(CGFloat)lineSpace;
-(void)setLabelAtrbuteLineSpace:(CGFloat)lineSpace atribute:(NSDictionary *)atri;
@end

NS_ASSUME_NONNULL_END
