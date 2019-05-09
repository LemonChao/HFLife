//
//  collectionFlowLyoutView.h
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_HomePageView : UIView
@property (nonatomic, strong)void (^selectedItem)(NSIndexPath* indexPath);
@property (nonatomic, strong)void(^selectedHeaderBtnBlock)(NSInteger index);

@property (nonatomic, strong)void(^refreshDataCallBack)(NSInteger page);
- (void) endRefreshData;
@end

NS_ASSUME_NONNULL_END
