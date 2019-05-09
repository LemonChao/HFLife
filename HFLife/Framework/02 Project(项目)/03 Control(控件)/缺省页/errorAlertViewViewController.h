//
//  errorAlertViewViewController.h
//  DoLifeApp
//
//  Created by sxf_pro on 2018/7/13.
//  Copyright © 2018年 张志超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ALERTTYPE{
    TYPE_EMPTY,
    TYPE_ADRESS,
    TYPE_NONETWORK,
    TYPE_NOLIST,
    TYPE_NOSEARCH,
    TYPE_NOCOMMENT
}alert_type;
typedef enum VIEWTYPE{
    TYPE_WINDOW,//添加到window
    TYPE_VIEW//添加到view
}view_type;


@interface errorAlertViewViewController : UIViewController
@property (nonatomic ,strong) NSString *msg;
@property (nonatomic ,assign) alert_type imageType;
@property (nonatomic ,strong) void(^callBack)(void);

@end
