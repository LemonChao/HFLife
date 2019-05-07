


#import <Foundation/Foundation.h>

@protocol HRBaseProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <HRBaseProtocol>)viewModel;
//1.0 初始化数据
- (void)hr_initializeData;
//1.1 布局控件
- (void)hr_configUI;
//1.2 刷新控件
- (void)hr_refreshUI;
//1.3绑定数据
-(void)hr_bingViewModel;

@end
