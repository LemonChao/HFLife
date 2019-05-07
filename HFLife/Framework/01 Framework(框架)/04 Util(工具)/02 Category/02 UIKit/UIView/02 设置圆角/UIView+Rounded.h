
/*~!
 | @FUNC  View设置圆角
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>

@interface UIView (Rounded)


/**
 设置圆角

 @param radius <#radius description#>
 */
- (void)roundedCorners:(CGFloat)radius;

/**
 添加指定位置 制定大小圆角
 */
- (void)addCornerWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
@end
