//
//  ZCShopClassifyModel.h
//  HFLife
//
//  Created by zchao on 2019/5/16.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZCShopClassifyListChildModel : BaseModel
@property(nonatomic, copy) NSString *gc_id;
@property(nonatomic, copy) NSString *gc_name;

@end

@interface ZCShopClassifyListModel : BaseModel

@property(nonatomic, copy) NSString *gc_id;
@property(nonatomic, copy) NSString *gc_name;
@property(nonatomic, copy) NSString *brand_pic;
@property(nonatomic, copy) NSArray <__kindof ZCShopClassifyListModel*>*child;

/** 最底级model使用 字体对齐 */
@property(nonatomic, strong) NSIndexPath *indexPath;
/** section是否应该展开 */
@property(nonatomic, assign, getter=isSelect) BOOL select;

@end

@interface ZCShopClassifyModel : BaseModel

@property(nonatomic, copy) NSString *gc_name;

@property(nonatomic, copy) NSArray <__kindof ZCShopClassifyListModel*>*class_list;

@end

NS_ASSUME_NONNULL_END
