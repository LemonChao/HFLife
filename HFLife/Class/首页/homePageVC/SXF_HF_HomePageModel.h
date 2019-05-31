//
//  SXF_HF_HomePageModel.h
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseModel.h"
#import "BalanceRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SXF_HF_HomePageModel : BaseModel

@end


/**
 新闻列表 导航item 轮播  合并model
 
 "id": 3,
 "title": "汉富头条",
 "tuiswitch": 0, //是否推荐
 "image": "/uploads/20190509/d05ed6874894eabea689d0c96da34d38.jpg",
 "addtime": 1557543667,
 "addtime_text": "2019-05-11 11:01:07"
 */
@interface homeListModel : BaseModel
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSNumber *tuiswitch;
@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString *addtime;
@property (nonatomic, strong)NSString *addtime_text;
@property (nonatomic, strong)NSString *iconimage;
@property (nonatomic, strong)NSString *url;//轮播链接、活动链接，item链接
@end

//首页活动列表
@interface homeActivityModel : BaseModel
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSString *body_image;
@property (nonatomic, strong)NSNumber *type;
@property (nonatomic, strong)NSString *btn_url;
@property (nonatomic, strong)NSString *left_url;
@property (nonatomic, strong)NSString *right_url;
@property (nonatomic, strong)NSString *body_msg;
@property (nonatomic, strong)NSString *foot_msg;
@property (nonatomic, strong)NSString *body_color;
@property (nonatomic, strong)NSString *btn_color;
@property (nonatomic, strong)NSString *top_url;
@property (nonatomic, strong)NSString *title_msg;
@property (nonatomic, strong)NSString *left_msg;
@property (nonatomic, strong)NSString *right_msg;
@property (nonatomic, strong)NSString *btn_msg;
@property (nonatomic, strong)NSString *btn_image;
@property (nonatomic, strong)NSString *left_image;
@property (nonatomic, strong)NSString *right_image;




@end



//银行卡列表
@interface bankListModel : BaseModel

@property (nonatomic, strong)NSNumber *ID;//银行卡ID
@property (nonatomic, strong)NSString *bank_name;//银行名称
@property (nonatomic, strong)NSString *bank_card;//银行卡卡号后四位
@property (nonatomic, strong)NSString *bank_icon;

@end

//收款列表model
@class subReciveModel;
@interface reciveModel : BaseModel
@property (nonatomic, strong)NSNumber *log_date_amount;
@property (nonatomic, strong)NSNumber *log_count;
@property (nonatomic, strong)NSString *log_date;
@property (nonatomic ,strong)NSArray <subReciveModel *>*logModelArr;
@end
@interface subReciveModel : BaseModel
@property (nonatomic, strong)NSNumber *real_num;
@property (nonatomic, strong)NSString *createdate;
@property (nonatomic, strong)NSString *createtime;
@property (nonatomic, strong)NSString *pay_username;
@end

//收益记录
@class subIncomeRecord;
@interface incomeRecord : BaseModel
@property (nonatomic, strong)NSString *month;
@property (nonatomic, strong)NSArray <subIncomeRecord *>*logModelArr;
@end

@interface subIncomeRecord : BaseModel
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSNumber *is_add;
@property (nonatomic, strong)NSString *real_num;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *createdate;
@property (nonatomic, strong)NSString *log_class;
@property (nonatomic, strong)NSString *acc_num;//兑换到富权/取出到余额
@end

@interface introListModel : BaseModel
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSString *intro_ask;
@property (nonatomic, strong)NSString *intro_answer;
@end



//我的滚动轮播
@interface mainScrollModel : BaseModel
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *subTitle;
@property (nonatomic, strong)NSString *money;
@end

@interface noticeModel : BaseModel
@property (nonatomic, strong)NSNumber *addtime;
@property (nonatomic, strong)NSString *body;
@property (nonatomic, strong)NSString *foot;
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSNumber *type;
@end


NS_ASSUME_NONNULL_END
