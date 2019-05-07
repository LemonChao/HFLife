
#import "HRBaseNavigationController.h"

@interface HRBaseNavigationController ()

@end

@implementation HRBaseNavigationController

#pragma mark - initlize (初始化函数，只会被调用一次)
+ (void)initialize{
    
}

#pragma mark -life cycle (生命周期函数)
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

#pragma mark - ---------- Protocol Methods -----------




#pragma mark -overide(重写父类)
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
    }
    [super pushViewController:viewController animated:animated];
}


@end
