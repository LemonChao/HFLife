//
//  uploadModel.h
//  HRFramework
//
//  Created by sxf_pro on 2018/4/25.
//

#import <Foundation/Foundation.h>

@interface uploadModel : NSObject
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL      isUploaded;
@end
