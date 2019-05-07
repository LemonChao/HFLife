
/*~!
 | @FUNC  计算label宽高
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>

@interface UILabel (FitSize)

//1.0 根据当前label的字体和文本计算需要最小宽度
- (CGFloat)fitWidth;

//1.1 根据当前label的字体和文本计算需要最小高度
- (CGFloat)fitHeight;

@end
