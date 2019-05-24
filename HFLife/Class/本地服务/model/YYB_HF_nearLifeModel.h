//
//  YYB_HF_nearLifeModel.h
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class EntranceDetail;
@interface YYB_HF_nearLifeModel : BaseModel
//"city_now": "郑州",  //当前城市
//"is_notice": 0,  //是否有消息提醒
////快捷入口
//"entrance": [
//             {
//                 "name": "商家入驻",  //名称
//                 "icon": "https://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/0f5bd26bc57dc12851ce8e61ee472320.png",  //图标
//                 "url": ""   //链接
//             }]


@property(nonatomic, copy) NSString *city_now;
@property(nonatomic, strong) NSNumber *is_notice;
@property(nonatomic, strong) NSArray<EntranceDetail*> *entrance;
////banner图
//"banner": [
//           "http://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/7cb2b6a9bc572736876194418001ee3f.png"]
@property(nonatomic, strong) NSArray *banner;


@end

@interface EntranceDetail : BaseModel
//{
//    "name": "商家入驻",  //名称
//    "icon": "https://hanzhifu2-photos-public.oss-cn-shenzhen.aliyuncs.com/locallife/admin/0f5bd26bc57dc12851ce8e61ee472320.png",  //图标
//    "url": ""   //链接
//}

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *icon;
@property(nonatomic, copy) NSString *url;

@end





NS_ASSUME_NONNULL_END
