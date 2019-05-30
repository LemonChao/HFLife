//
//  SXF_HF_HomePageModel.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_HomePageModel.h"

@implementation SXF_HF_HomePageModel

@end

@implementation homeListModel
@end
@implementation homeActivityModel
@end

@implementation incomeRecord
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    NSLog(@"sub   :  %@", key);
    if ([key isEqualToString:@"log"]) {
        NSArray *modelArr = [HR_dataManagerTool getModelArrWithArr:value withClass:[subIncomeRecord class]];
        [self setValue:modelArr forKeyPath:@"logModelArr"];
    }
}

@end
@implementation subIncomeRecord

@end




@implementation bankListModel

@end


@implementation reciveModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    NSLog(@"sub   :  %@", key);
    if ([key isEqualToString:@"log"]) {
        NSArray *modelArr = [HR_dataManagerTool getModelArrWithArr:value withClass:[subReciveModel class]];
        [self setValue:modelArr forKeyPath:@"logModelArr"];
    }
}


@end
@implementation subReciveModel

@end

@implementation introListModel

@end

@implementation mainScrollModel
@end

@implementation noticeModel
@end
