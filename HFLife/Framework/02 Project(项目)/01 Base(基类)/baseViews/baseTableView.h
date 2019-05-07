
#import <UIKit/UIKit.h>

@interface baseTableView : UITableView

@property (nonatomic ,copy) void (^refreshHeaderBlock)(void);//下啦
@property (nonatomic ,copy) void (^refreshFooterBlock)(void);//上啦
@property (nonatomic ,copy) void (^complateBlock)(void);//无更多数据block
@property (nonatomic ,assign) NSInteger page;

@property (nonatomic ,strong) MJRefreshFooter *footer;


@property (nonatomic ,assign) BOOL activityGifHeader;//是否激活 动画刷新 默认yes
@property (nonatomic ,strong) NSString *gifSourceName;//动画图片名字

- (void) endRefreshData;
@end
