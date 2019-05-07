
/*~!
 | @FUNC  UIColor转UIImage
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>

@interface UIColor (Image)

//1.0 UIColor转UIImage
- (UIImage *)image;
- (UIImage *(^)())setupImage;

@end
