
//
//  touchID_helper.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "touchID_helper.h"
#import <LocalAuthentication/LocalAuthentication.h>
@implementation touchID_helper


//https://www.jianshu.com/p/8a8899c5e7ed

+ (void) showTouchIDshowType:(id)showtype complate:(void (^)(BOOL success, NSError * _Nullable error))result{
    //判断指纹解锁是否可用,没有API, 使用can来判断(与相机的输入输出设备一致)
    //1.创建认证上下文
    LAContext *context = [[LAContext alloc] init];
    //2.判断设备能够识别
    
    /**
     
     Policy(政策)Device(设备)Owner(拥有者):设备拥有者
     
     Authentication:认证
     
     Biometics:生物识别及时(指纹解锁, 刷脸识别, 虹膜识别)
     
     */
    
    //LAPolicyDeviceOwnerAuthenticationWithBiometrics
    
    //LAPolicyDeviceOwnerAuthentication //iOS9类型(与iOS8的区别就是多次点击错误之后,点击输入密码会弹出密码页面,iOS8不会)
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil]) {
        
        
        
        //开始验证  LAPolicyDeviceOwnerAuthentication这个枚举值,需要和上面验证设备是否可以用的写一致.
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"弹出指纹验证的描述" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                
                //code 返回0代表认证成功
                
                NSLog(@"认证成功 -->%zd",error.code);
                
                
            } else {
                
                //实际开发中需要用户对code类型做不同业务逻辑处理
                
                /**
                 
                 -2:用户主动点击取消
                 
                 -1:三次识别错误
                 
                 -8:三次识别错误之后继续识别错误两次(这时候会弹出密码框)
                 
                 0:认证成功
                 
                 */
                
                NSLog(@"%zd",error.code);
                
                
                
                //特别需要注意的是:指纹识别也是在子线程中的,刷新UI需要回到子线程
                
                //否则要么等待很长时间,要么会报一些奇怪的错误, 我就是栽倒在这里了😂
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                });
            }
            
            //回调结果
            result(success, error);
            
        }];
        
    } else {
        
        NSLog(@"设备不支持");
        
    }
    

}



@end
