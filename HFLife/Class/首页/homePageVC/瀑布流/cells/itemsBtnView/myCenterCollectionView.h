//
//  myCenterCollectionView.h
//  DeliveryOrder
//
//  Created by mac on 2019/3/9.
//  Copyright © 2019 LeYuWangLuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface myCenterCollectionView : UIView
@property (nonatomic ,strong) void(^selectedItem)(NSInteger index);
@property (nonatomic, strong)NSArray *dataSourceArr;
@end

NS_ASSUME_NONNULL_END
