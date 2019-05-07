

#import "HRBaseTabBarController.h"

@interface HRBaseTabBarController ()

@end

@implementation HRBaseTabBarController

#pragma mark - ---------- Lifecycle ----------

#pragma mark -init
- (instancetype)initWithChildViewControllerNames:(NSArray<NSString *> *)names
{
    if (self = [super init]) {
        [self configChildViewControllersWithNames:names];
    }
    return self;
}

#pragma mark -life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -private Methods(私有方法)
- (void)configChildViewControllersWithNames:(NSArray<NSString *> *)names
{
    NSMutableArray *childControllers = [NSMutableArray array];
    [names enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Class c = NSClassFromString(obj);
        UIViewController *vc = [[c alloc]init];
        [childControllers addObject:vc];
    }];
    [self setViewControllers:childControllers];
}

- (void)itemTitles:(NSArray <NSString *> *)titles
{
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.tabBarItem.title = titles[idx];
    }];
}

- (HRBaseTabBarController *(^)(NSArray<NSString *> *titles))setupItemTitls
{
    return ^(NSArray <NSString *>*titles){
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.tabBarItem.title = titles[idx];
        }];
        return self;
    };
}

//设置item图片
- (HRBaseTabBarController *(^)(NSArray<NSString *> *imagesDeault,NSArray<NSString *> *imagesSelected))setupItemImagesStatusDefault
{
    return ^(NSArray<NSString *> *imagesDeault,NSArray<NSString *> *imagesSelected){
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.tabBarItem.image = [UIImage imageNamed:imagesDeault[idx]];
            obj.tabBarItem.selectedImage = [[UIImage imageNamed:imagesSelected[idx]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }];
        return self;
    };
}

// 标签标题未选中状态属性
- (void)itemsTitleColor:(UIColor *)color status:(HRTabBarItemStatus)status {
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControlState state = (status == HRTabBarItemStatusSelected) ? UIControlStateSelected : UIControlStateNormal;
        [obj.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:state];
    }];
}
- (HRBaseTabBarController *(^)(NSDictionary *))setupItemsAttarStatusDefault {
    return ^(NSDictionary *iTemAttars) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.tabBarItem setTitleTextAttributes:iTemAttars forState:UIControlStateNormal];
        }];
        return self;
    };
}
- (HRBaseTabBarController *(^)(NSDictionary *))setupItemsAttarStatusSelected {
    return ^(NSDictionary *iTemAttars) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.tabBarItem setTitleTextAttributes:iTemAttars forState:UIControlStateSelected];
        }];
        return self;
    };
}

//标签标题颜色 [不统一]
- (void)itemTitleColor:(UIColor *)color atIndex:(NSInteger)idx status:(HRTabBarItemStatus)status {
    UIViewController *vc = self.childViewControllers[idx];
    UIControlState state = (status == HRTabBarItemStatusDefault) ? UIControlStateNormal : UIControlStateSelected;
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:state];
}

@end
