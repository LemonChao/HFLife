//
//  ZCExclusiveRecommendModel.h
//  HFLife
//
//  Created by zchao on 2019/5/14.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCExclusiveRecommendModel : BaseModel
//"goods_id": "100108",
//"goods_name": "牛逼登封灯 大",
//"goods_price": "666.00",
//"goods_fan_price": "300.00",
//"goods_image": "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/store/shop/80f2ba7d33274742cf97e02ded6d5032.jpg",
//"width": "430",
//"height": "430"

@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *goods_name;
@property(nonatomic, copy) NSString *goods_price;
@property(nonatomic, copy) NSString *goods_fan_price;
@property(nonatomic, copy) NSString *goods_image;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
/** imageViewH 图片高度 */
@property(nonatomic, assign) CGFloat viewHeight;
/** 显示商品价格 */
@property(nonatomic, copy) NSAttributedString *attPrice;
@end

NS_ASSUME_NONNULL_END
