//
//  ZCShopOrderViewModel.h
//  HFLife
//
//  Created by zchao on 2019/5/31.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

//"user_id": 17,
//"user_name": "15537171501",
//"avatar": "https://wx.qlogo.cn/mmopen/vi_32/LgG2mmWRVUxJonrexQlw5UUYMaicfSD3BibdL34RTurXCW0BY93cGNUCdwp47jlzz8iaKeowuabjteJb1nbeS561g/132",
//"level_name": "0",
//"favorites_store": 2,
//"favorites_goods": 0,
//"order_nopay_count": "5",
//"order_noreceipt_count": "2",
//"order_notakes_count": "0",
//"order_noeval_count": "1",
//"return_goods": "0"
@interface ZCShopOrderModel : BaseModel

@property(nonatomic, copy) NSString *user_id;
@property(nonatomic, copy) NSString *user_name;
@property(nonatomic, copy) NSString *avatar;
/** 会员等级 */
@property(nonatomic, copy) NSString *level_name;
/** 店铺收藏 */
@property(nonatomic, copy) NSString *favorites_store;
/** 商品收藏 */
@property(nonatomic, copy) NSString *favorites_goods;

@end







@interface ZCShopOrderViewModel : BaseViewModel

@property(nonatomic, strong) RACCommand *orderCenterCmd;

@property(nonatomic, strong) ZCShopOrderModel *model;

@end








NS_ASSUME_NONNULL_END
