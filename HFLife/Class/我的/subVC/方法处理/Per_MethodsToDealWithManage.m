//
//  Per_MethodsToDealWithManage.m
//  HFLife
//
//  Created by sxf on 2019/1/19.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "Per_MethodsToDealWithManage.h"
//#import "HP_GetPersonalDataNetApi.h"
//#import "HP_CollectionListNetApi.h"
//#import "HP_BindBankCardNetApi.h"
//#import "HP_RemoveBindNetApi.h"
//#import "HP_GetAddressListNetApi.h"
//#import "HP_AddAddressNetApi.h"
//#import "HP_EditorAddressNetApi.h"
//#import "HP_DeleteAddressNetApi.h"
//#import "HP_MyCollectionNetApi.h"
//#import "HP_LoginPasswordSetUpNetApi.h"
//#import "HP_ModifyBindPhoneVC.h"
//#import "HP_ModifyPayPasswordNetApi.h"
#import "JPUSHService.h"
@implementation Per_MethodsToDealWithManage
{
    //身份信息字典
    NSMutableDictionary *identity_dict;
    
    //身份信息确认
    NSMutableDictionary *identity_confirm_parameter;
    //我的收藏
//    HP_MyCollectionNetApi *mycollect;
    
    BOOL isAlias;
}
+(instancetype)sharedInstance{
    static Per_MethodsToDealWithManage *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [Per_MethodsToDealWithManage new];
    });
    return instance;
}
#pragma mark 获取个人资料
-(void)getPersonalData:(SuccessBlock)successBlock{
    
    
    /*
    
    HP_GetPersonalDataNetApi *getPerNetApi = [[HP_GetPersonalDataNetApi alloc]init];
    getPerNetApi.isHiddenLoading = YES;
    [getPerNetApi startWithoutCacheCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_GetPersonalDataNetApi *getPerRequest = (HP_GetPersonalDataNetApi *)request;
        if ([getPerRequest getCodeStatus]== 1) {
            NSDictionary *dict = [getPerRequest getContent];
            [UserCache setUserPic:dict[@"img"]];
            [UserCache setUserNickName:dict[@"nickname"]];
            [UserCache setUserName:dict[@"username"]];
            [UserCache setUserRealName:dict[@"truename"]];
            [UserCache setUserPhone:dict[@"hide_phone"]];
            [UserCache setUserId:MMNSStringFormat(@"%@",dict[@"uid"])];
            [UserCache setUserXinXi:MMNSStringFormat(@"%@",dict[@"rz_status"])];
            [UserCache setUserTradePassword:MMNSStringFormat(@"%@",dict[@"pay_status"])];
            [UserCache setUserPassword:MMNSStringFormat(@"%@",dict[@"set_passwd"])];
            [UserCache setUserInviteCode:dict[@"invite_code"]];
            [UserCache setUserLevelInfo:dict[@"level_info"]];
            if (!self->isAlias) {
                NSString *bieMing = [NSString stringWithFormat:@"HL_%@",[UserCache getUserId]];
                NSLog(@"设置的别名 %@",bieMing);
                [JPUSHService setAlias:bieMing completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"rescode: %ld, \nseq: %ld, \nalias: %@\n", (long)iResCode, (long)seq , iAlias);
                    self->isAlias = YES;
                } seq:0];
            }
            
            
            successBlock(@(YES));
            //            [weakSelf valueInitialize];
            
        }else if ([getPerRequest getCodeStatus]== -1) {
            successBlock(@(NO));
            [WXZTipView showCenterWithText:@"登录已过期"];
            [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
        }else {
            successBlock(@(NO));
            [WXZTipView showCenterWithText:@"个人信息未获取成功"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        successBlock(@(NO));
        [WXZTipView showCenterWithText:@"个人信息未获取成功"];
    }];
     
     */
}
#pragma mark 获取绑定的支付方式
-(void)getPaymentMethodsList:(SuccessBlock)successBlock{
    
    /*
    HP_CollectionListNetApi *getPersonal = [[HP_CollectionListNetApi alloc]init];
    [getPersonal startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_CollectionListNetApi *getPersonalRequest = (HP_CollectionListNetApi *)request;
        if ([getPersonalRequest getCodeStatus] == 1) {
            NSDictionary *dataDict = [getPersonalRequest getContent];
            NSMutableArray *arrar_one = [NSMutableArray array];
            NSMutableArray *arrar_two = [NSMutableArray array];
            NSArray *dataArray = dataDict[@"bank"];
            if (![NSString isNOTNull:MMNSStringFormat(@"%@",dataDict[@"ali"])]) {
                [arrar_two addObject:MMNSStringFormat(@"%@",dataDict[@"ali"])];
            }
            if ([dataArray isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in dataArray) {
//                    NSString *bank_name = dict[@"bank_name"];
                    [arrar_one addObject:dict];
                }
            }
            
            successBlock(@[arrar_one,arrar_two]);
        }else{
            successBlock(@(NO));
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
		[WXZTipView showCenterWithText:@"数据获取失败"];
        successBlock(@(NO));
    }];
     
     */
}
#pragma mark 绑定收款方式
-(void)bindBankCardPayWayParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    
    /*
    
    HP_BindBankCardNetApi *binban = [[HP_BindBankCardNetApi alloc]initWithParameter:parameter];
    [binban startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_BindBankCardNetApi *binbanRequest = (HP_BindBankCardNetApi *)request;
        if ([binbanRequest getCodeStatus] == 1) {
            Success(@(YES));
            
        }else{
            Success(@(NO));
        }
        [WXZTipView showCenterWithText:[binbanRequest getMsg]];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"绑定失败"];
    }];
     
     */
}
#pragma mark 解除绑定收款方式
-(void)removeBindCollectionWayParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    
    /*
    
    HP_RemoveBindNetApi *remove = [[HP_RemoveBindNetApi alloc]initWithParameter:parameter];
    [remove startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_RemoveBindNetApi *binbanRequest = (HP_RemoveBindNetApi *)request;
        if ([binbanRequest getCodeStatus] == 1) {
            Success(@(YES));
        }else{
            Success(@(NO));
        }
        [WXZTipView showCenterWithText:[binbanRequest getMsg]];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"解除绑定失败"];
    }];
     
     */
}
#pragma mark 获取地址列表
-(void)getAddressListSuccessBlock:(SuccessBlock)Success{
    
    /*
    
    HP_GetAddressListNetApi *getAddress = [[HP_GetAddressListNetApi alloc]init];
    [getAddress startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_GetAddressListNetApi *getAddressRequest = (HP_GetAddressListNetApi *)request;
        if ([getAddressRequest getCodeStatus]==1) {
            NSArray *addressArray = [getAddressRequest getContent];
            if ([addressArray isKindOfClass:[NSArray class]]) {
                NSMutableArray *mutableArr = [NSMutableArray array];
                for (NSDictionary *dict in addressArray) {
                    AddressModel *address = [[AddressModel alloc]init:dict];
                    [mutableArr addObject:address];
                }
                 Success(mutableArr);
            }else{
                Success(@(NO));
                [WXZTipView showCenterWithText:@"暂无地址数据"];
            }
        }else{
            Success(@(NO));
            [WXZTipView showCenterWithText:@"暂无地址数据"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"地址列表获取失败"];
    }];
     
     */
}
#pragma mark 添加地址
-(void)addAddressParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    
    /*
    
    HP_AddAddressNetApi *addAddr = [[HP_AddAddressNetApi alloc]initWithParameter:parameter];
    [addAddr startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_AddAddressNetApi *addAddrrequest = (HP_AddAddressNetApi *)request;
        if ([addAddrrequest getCodeStatus]==1) {
            [WXZTipView showCenterWithText:@"地址添加成功"];
            Success(@(YES));
        }else{
            [WXZTipView showCenterWithText:@"地址添加失败"];
            Success(@(NO));
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [WXZTipView showCenterWithText:@"地址添加失败"];
        Success(@(NO));
    }];
     
     */
}
#pragma mark 编辑地址
-(void)editorAddressParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    /*
    HP_EditorAddressNetApi *editor = [[HP_EditorAddressNetApi alloc]initWithParameter:parameter];
    [editor startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_EditorAddressNetApi *editorRequest = (HP_EditorAddressNetApi *)request;
        if ([editorRequest getCodeStatus] == 1) {
            Success(@(YES));
        }else{
            Success(@(NO));
        }
        [WXZTipView showCenterWithText:[editorRequest getMsg]];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"地址信息修改失败"];
    }];
     
     */
}
#pragma mark 删除地址
-(void)deleteAddressParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    
    /*
    
    HP_DeleteAddressNetApi *delete = [[HP_DeleteAddressNetApi alloc]initWithParameter:parameter];
    [delete startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_DeleteAddressNetApi *deleteRequest = (HP_DeleteAddressNetApi *)request;
        if ([deleteRequest getCodeStatus] == 1) {
            if (Success) {
                Success(@(YES));
            }
            
        }else{
            if (Success) {
                Success(@(NO));
            }
        }
        [WXZTipView showCenterWithText:[deleteRequest getMsg]];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (Success) {
            Success(@(NO));
        }
        [WXZTipView showCenterWithText:@"地址信息删除失败"];
    }];
     
     */
}
#pragma mark 获取收藏数据
-(void)getMyCollectioSuccessBlock:(SuccessBlock)Success{
    
    /*
    
    if (!mycollect) {
        mycollect = [[HP_MyCollectionNetApi alloc]init];
    }
    [mycollect startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_MyCollectionNetApi *mycollectRequest = (HP_MyCollectionNetApi *)request;
    	
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (Success) {
            Success(@(NO));
        }
        [WXZTipView showCenterWithText:@"商品数据暂未获取到"];
    }];
     
     */
}
#pragma mark 修改头像
-(void)updateHeadImageView:(UIImage *)headImage{
    
    /*
    
    NSDictionary *imageDict = @{@"pic":headImage};
    [NetWorkHelper setRequestTimeoutInterval:20.0];
    [[WBPCreate sharedInstance]showWBProgress];
    [NetWorkHelper uploadImagesWithURL:MMNSStringFormat(@"%@?w=user&t=edit_pic",GDP_BASEURL) parameters:nil names:nil images:nil imagesDict:imageDict fileNames:nil imageScale:0.5 imageType:@"jpg" progress:^(NSProgress *progress) {
        
    } success:^(BOOL isOk, id responseObject) {
        [[WBPCreate sharedInstance] hideAnimated];
        if (isOk) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSString *status = MMNSStringFormat(@"%@",data[@"status"]);
            if ([status integerValue] == -1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
            }else if([status integerValue] == 1){
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
            }else{
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
            }
            
            
        }else{
            [WXZTipView showCenterWithText:responseObject duration:3];
        }
    }];
     
     */
    
    
}
#pragma mark 实名认证
//身份信息的完善（第一步）
-(void)identityInformationCompletiondict:(NSDictionary *)dict{
    if (dict == nil) {
        [WXZTipView showCenterWithText:@"请填写身份信息"];
    }else{
        identity_dict = [NSMutableDictionary dictionaryWithDictionary:dict];
        [self.superVC.navigationController pushViewController:[[CertificatePhoto alloc]init] animated:YES];
    }
}
//身份证拍照并上传
-(void)idCardPhotographVerify:(NSDictionary *)dict requestEnd:(void (^)(void))requestEnd{
//    [identity_dict setDictionary:dict];
    
    /*
    
    [NetWorkHelper setRequestTimeoutInterval:20.0];
    [NetWorkHelper openNetworkActivityIndicator:YES];
    [NetWorkHelper uploadImagesWithURL:MMNSStringFormat(@"%@?w=user&t=auth",GDP_BASEURL) parameters:identity_dict names:nil images:nil imagesDict:dict fileNames:nil imageScale:0.5 imageType:@"jpg" progress:^(NSProgress *progress) {
        
    } success:^(BOOL isOk, id responseObject) {

        requestEnd();
        NSLog(@"responseObject = %@",responseObject);
        if (isOk) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSString *status = MMNSStringFormat(@"%@",data[@"status"]);
            if ([status integerValue] == -1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
            }else if([status integerValue] == 1){
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
                [UserCache setReviewStatus:@"3"];
               [self.superVC.navigationController pushViewController:[[ReviewResultsVC alloc]init] animated:YES];
            }else{
                [WXZTipView showCenterWithText:data[@"msg"] duration:3];
            }
            
            
        }else{
            [WXZTipView showCenterWithText:responseObject duration:3];
        }
    }];
     
     */
    
}
#pragma mark ====修改登录密码====
-(void)ModifyLoginPasswordParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    
    /*
    
    HP_LoginPasswordSetUpNetApi *loginPas = [[HP_LoginPasswordSetUpNetApi alloc]initWithParameter:parameter];
    [loginPas startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_LoginPasswordSetUpNetApi *loginPasRequest =(HP_LoginPasswordSetUpNetApi *) request;
        if ([loginPasRequest getCodeStatus]==1) {
            Success(@(YES));
            [WXZTipView showCenterWithText:@"密码修改成功"];
        }else{
            Success(@(NO));
            [WXZTipView showCenterWithText:@"密码修改失败"];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"密码修改失败"];
    }];
     
     */
}

#pragma mark ====修改手机号=====
-(void)ModifyBindPhoneParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    
    /*
    
    HP_ModifyBindPhoneVC *modify = [[HP_ModifyBindPhoneVC alloc]initWithParameter:parameter];
    [modify startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ModifyBindPhoneVC *modifyRequest =(HP_ModifyBindPhoneVC *) request;
        if ([modifyRequest getCodeStatus]==1) {
            Success(@(YES));
            [WXZTipView showCenterWithText:@"绑定成功"];
        }else{
            Success(@(NO));
//            [WXZTipView showCenterWithText:@"手机号绑定失败"];
            [WXZTipView showCenterWithText:[modifyRequest getMsg]];

        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"手机号绑定失败"];
    }];
     
     */
}

-(void)ModifyBindPhoneNotHeadTokenParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    
    /*
    HP_ModifyBindPhoneVCNotHeadToken *modify = [[HP_ModifyBindPhoneVCNotHeadToken alloc]initWithParameter:parameter];
    [modify startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ModifyBindPhoneVCNotHeadToken *modifyRequest =(HP_ModifyBindPhoneVCNotHeadToken *) request;
        if ([modifyRequest getCodeStatus]==1) {
            Success(@(YES));
            [WXZTipView showCenterWithText:@"绑定成功"];
        }else{
            Success(@(NO));
//            [WXZTipView showCenterWithText:@"手机号绑定失败"];
            [WXZTipView showCenterWithText:[modifyRequest getMsg]];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"手机号绑定失败"];
    }];
     
     */
}

#pragma mark ====修改支付密码前确认支付信息====
-(void)identityInformationConfirmParameter:(NSDictionary *)parameter{
    identity_confirm_parameter = [NSMutableDictionary dictionaryWithDictionary:parameter];
}
#pragma mark ====修改支付密码====
-(void)ModifyPayPasswordParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)Success{
    [identity_confirm_parameter addEntriesFromDictionary:parameter];
    
    
    /*
    HP_ModifyPayPasswordNetApi *modify = [[HP_ModifyPayPasswordNetApi alloc]initWithParameter:identity_confirm_parameter];
    [modify startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        HP_ModifyPayPasswordNetApi *modifyRequest =(HP_ModifyPayPasswordNetApi *) request;
        if ([modifyRequest getCodeStatus]==1) {
            Success(@(YES));
            self->identity_confirm_parameter = nil;
            [WXZTipView showCenterWithText:@"支付密码修改成功"];
        }else{
            Success(@(NO));
//            [WXZTipView showCenterWithText:@"支付密码修改失败"];
            [WXZTipView showCenterWithText:[modifyRequest getMsg]];

        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        Success(@(NO));
        [WXZTipView showCenterWithText:@"支付密码修改失败"];
    }];
     
     */
}
@end
