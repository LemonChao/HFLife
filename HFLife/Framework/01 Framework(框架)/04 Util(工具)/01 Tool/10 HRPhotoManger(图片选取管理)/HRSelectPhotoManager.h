
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    PhotoCamera = 0,
    PhotoAlbum,
}SelectPhotoType;

@protocol HRSelectPhotoDelegate <NSObject>
//照片选取成功
- (void)selectPhotoManagerDidFinishImage:(UIImage *)image;
//照片选取失败
- (void)selectPhotoManagerDidError:(NSError *)error;

@end

@interface HRSelectPhotoManager : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

//代理对象
@property(nonatomic, weak)__weak id<HRSelectPhotoDelegate>delegate;
//是否开启照片编辑功能
@property(nonatomic, assign)BOOL canEditPhoto;
//跳转的控制器 可选参数
@property(nonatomic, weak)__weak UIViewController *superVC;

//照片选取成功回调
@property(nonatomic, strong)void (^successHandle)(HRSelectPhotoManager *manager, UIImage *image);
//照片选取失败回调
@property(nonatomic, strong)void (^errorHandle)(NSString *error);

//开始选取照片
- (void)startSelectPhotoWithImageName:(NSString *)imageName;
- (void)startSelectPhotoWithType:(SelectPhotoType )type andImageName:(NSString *)imageName;

@end
