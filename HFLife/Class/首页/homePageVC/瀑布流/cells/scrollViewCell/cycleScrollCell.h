//
//  cycleScrollCell.h
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface cycleScrollCell : UICollectionViewCell
@property (nonatomic ,strong) void(^selectItemBlock)(NSInteger index, id value);

@property (nonatomic ,strong) NSArray *modelArr;
@property (nonatomic, assign)BOOL pausePlay;//暂停、开启
@end

NS_ASSUME_NONNULL_END
