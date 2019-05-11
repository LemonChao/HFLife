
/*~!
 | @FUNC  占位符
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>

@interface UITextField (Placeholder)

//1.0 修改placeholder文本颜色
- (void)placeholerColor:(UIColor *)color;

//1.1 修改placeholder字体
- (void)placeholerFont:(UIFont *)font;

/**
 控制placeHolder的位置

 @param bounds <#bounds description#>
 */
//-(void)placeholderRectForBounds:(CGRect)bounds;


/**
 控制编辑文本的位置

 @param bounds <#bounds description#>
 */
//-(void)editingRectForBounds:(CGRect)bounds;
@end
