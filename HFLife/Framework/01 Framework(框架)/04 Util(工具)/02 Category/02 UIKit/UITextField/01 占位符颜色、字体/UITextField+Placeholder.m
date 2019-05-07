

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

//1.0 修改placeholder文本颜色
- (void)placeholerColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

//1.1 修改placeholder字体
- (void)placeholerFont:(UIFont *)font {
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}




@end
