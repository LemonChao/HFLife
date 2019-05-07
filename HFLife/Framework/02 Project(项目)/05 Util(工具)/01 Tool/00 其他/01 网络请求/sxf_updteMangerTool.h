//
//  sxf_updteMangerTool.h
//  HRFramework
//
//  Created by sxf_pro on 2018/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, alert_Type) {
    alert_Type_defaulte,
    alert_Type_custom
};

typedef enum : NSUInteger {
    imageType,
    movieType,
} selectImageOrMovieType;
@interface sxf_updteMangerTool : NSObject
+(sxf_updteMangerTool *)getInstance;
- (void) showAlertViewWithAlertType:(alert_Type)alertType selecteImageOrMovieType:(selectImageOrMovieType)ImageOrMovieType ForVC:(UIViewController *)vc;
@property (nonatomic, assign) selectImageOrMovieType ImageOrMovieType;
@end






