//
//  cycleScrollCell.h
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface cycleScrollCell : UICollectionViewCell
@property (nonatomic ,strong) void(^selectItemBlock)(NSInteger index);

@property (nonatomic ,strong) NSArray *modelArr;
@end

NS_ASSUME_NONNULL_END
