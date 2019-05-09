//
//  alertView.h
//  缺省页test
//
//  Created by sxf_pro on 2018/7/13.
//  Copyright © 2018年 sxf_pro. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum ALERVIEW_TTYPE{
    IMAGETYPE_EMPTY,
    IMAGETYPE_ADRESS,
    IMAGETYPE_NONETWORK,
    IMAGETYPE_NOLIST,
    IMAGETYPE_NOSEARCH,
    IMAGETYPE_NOCOMMENT,
    IMAGETYPE_NOCOLLECTION,
    IMAGETYPE_HOMEPAGELIST,
    IMAGETYPE_NOIMAGE
}alertView_type;
@interface alertView : UIView
@property (nonatomic ,strong) NSString *msg;
@property (nonatomic ,assign) alertView_type viewImageType;
@property (nonatomic ,strong) void(^callBack)(void);

@property (nonatomic ,assign) CGFloat imageCenterY;
@end
