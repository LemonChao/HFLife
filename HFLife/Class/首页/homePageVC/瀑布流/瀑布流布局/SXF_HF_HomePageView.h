//
//  collectionFlowLyoutView.h
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_HomePageView : UIView
@property (nonatomic, strong)void (^selectedItem)(NSIndexPath* indexPath, id value);
@property (nonatomic, strong)void(^selectedHeaderBtnBlock)(NSInteger index);

@property (nonatomic, strong)void(^refreshDataCallBack)(NSInteger page);
@property (nonatomic, strong)void(^activityBtnCallback)(NSString *urlStr);
@property (nonatomic, strong)void(^clickSectionHeaderBtn)(NSInteger section);

@property (nonatomic, strong)NSDictionary *dataSourceDict;
@property (nonatomic, strong)NSArray *newsListModelArr;

@property (nonatomic, strong)NSString *myFQ;
@property (nonatomic, strong)NSNumber *fqPrice;
@property (nonatomic, strong)NSNumber *peopleNum;
@property (nonatomic, assign)MJRefreshState state;
- (void) endRefreshData;


/**
 离开暂停轮播
 */
@property (nonatomic, assign)BOOL pausePlay;//暂停、开启

@end

NS_ASSUME_NONNULL_END
