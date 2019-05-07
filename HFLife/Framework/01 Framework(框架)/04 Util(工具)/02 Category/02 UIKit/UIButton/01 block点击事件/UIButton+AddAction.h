
/*~!
 | @FUNC  UIButton点击事件（block）
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>

@interface UIButton (AddAction)

//1.0 block方式添加点击事件
- (void)addAction:(void(^)(NSInteger tag))block;

@end
