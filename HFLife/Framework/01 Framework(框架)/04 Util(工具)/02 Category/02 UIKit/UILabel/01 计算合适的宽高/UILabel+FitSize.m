
#import "UILabel+FitSize.h"

@implementation UILabel (FitSize)

//1.0 根据当前label的字体和文本计算需要最小宽度
- (CGFloat)fitWidth {
    CGSize size = [self.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil]];
    return size.width + 1;
}

//1.1 根据当前label的字体和文本计算需要最小高度
- (CGFloat)fitHeight {
    CGSize size = [self.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName, nil]];
    return size.height;
}

@end
