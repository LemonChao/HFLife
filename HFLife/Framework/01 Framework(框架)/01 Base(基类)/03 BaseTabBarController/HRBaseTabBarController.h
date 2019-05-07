

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HRTabBarItemStatus) {
    HRTabBarItemStatusSelected, //选中状态
    HRTabBarItemStatusDefault, //默认状态
};

@interface HRBaseTabBarController : UITabBarController

//初始化方法
- (instancetype)initWithChildViewControllerNames:(NSArray<NSString *> *)names;

//设置标题
- (void)itemTitles:(NSArray <NSString *> *)titles;

//设置标题（链式）
- (HRBaseTabBarController *(^)(NSArray<NSString *> *titles))setupItemTitls;

//设置Item图片（链式）
- (HRBaseTabBarController *(^)(NSArray<NSString *> *imagesDeault,NSArray<NSString *> *imagesSelected))setupItemImagesStatusDefault;

//设置标题属性
- (void)itemsTitleColor:(UIColor *)color status:(HRTabBarItemStatus)status;

//设置标题属性默认（链式）
- (HRBaseTabBarController *(^)(NSDictionary *))setupItemsAttarStatusDefault;

//设置标题属性选中（链式）
- (HRBaseTabBarController *(^)(NSDictionary *))setupItemsAttarStatusSelected;

//item标题颜色不一致
- (void)itemTitleColor:(UIColor *)color atIndex:(NSInteger)idx status:(HRTabBarItemStatus)status;



@end
