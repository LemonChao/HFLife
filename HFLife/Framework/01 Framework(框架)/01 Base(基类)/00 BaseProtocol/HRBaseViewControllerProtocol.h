

#import <Foundation/Foundation.h>

@protocol HRBaseViewControllerProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <HRBaseViewControllerProtocol>)viewModel;
#pragma mark 布局UI
- (void)hr_configUI;
//3.2 刷新网络请求
- (void)hr_refreshRequest;

- (void)hr_bindViewModel;

- (void)hr_getNewData;

@end
