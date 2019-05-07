//
//  sxf_updteMangerTool.m
//  HRFramework
//
//  Created by sxf_pro on 2018/4/8.
//

#import "sxf_updteMangerTool.h"
#import "appStatusManager.h"
#import "uploadModel.h"
#import <AFNetworking/AFNetworking.h>
#import <AVFoundation/AVFoundation.h>
#define PHOTOCACHEPATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"photoCache"]
#define VIDEOCACHEPATH [NSTemporaryDirectory() stringByAppendingPathComponent:@"videoCache"]


typedef enum : NSUInteger {
    PHOTO_TYPE,//相册中的照片
    MOVIE_TYPE,//相册中的视频
    TACKPHOTO_TYPE,//拍照
    TACKMOVIE_TYPE//摄像
} selectType;


@interface sxf_updteMangerTool()<UINavigationControllerDelegate, UIImagePickerControllerDelegate , UIAlertViewDelegate>
@property (nonatomic ,strong) UIView *alertTableView;
@property (nonatomic ,strong) UIView *alertBgView;
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic ,assign) BOOL isCamara;
@property (nonatomic, strong) UIImagePickerController *PickerImage;
//存储上传的model
@property (nonatomic, strong) NSMutableArray *uploadedArray;
@property (nonatomic, assign) selectType get_Type;
@end
@implementation sxf_updteMangerTool
{
    CGFloat tableViewHeight;
    CGFloat tableViewCellHeight;
}

- (NSMutableArray *)uploadedArray{
    if (!_uploadedArray) {
        _uploadedArray = [[NSMutableArray alloc] init];
    }
    return _uploadedArray;
}
//单利模式
static sxf_updteMangerTool *instance;
+(sxf_updteMangerTool *)getInstance{
    static dispatch_once_t onceToken;
    if (!instance) {
        dispatch_once(&onceToken, ^{
            instance = [[sxf_updteMangerTool alloc] init];
        });
    }
    return instance;
}
- (UIImagePickerController *)PickerImage{
    if (!_PickerImage) {
        _PickerImage = [[UIImagePickerController alloc] init];
    }
    return _PickerImage;
}
- (void) showAlertViewWithAlertType:(alert_Type)alertType selecteImageOrMovieType:(selectImageOrMovieType)ImageOrMovieType ForVC:(UIViewController *)vc{
    
    //默认使用上传图片模式
    self.ImageOrMovieType = ImageOrMovieType;
    
    self.vc = vc;
    if (alertType == alert_Type_defaulte) {
        [self addDefaulteAlertforVC:vc];
    }
    if (alertType == alert_Type_custom) {
        [self addCustomAlertforVC:vc];
    }
}

- (void)setImageOrMovieType:(selectImageOrMovieType)ImageOrMovieType{
    _ImageOrMovieType = ImageOrMovieType;
}


#pragma mark - //配置imagePickViewController
//赋值选择的类型  照片， 视频， 拍照， 摄像
- (void)setGet_Type:(selectType)get_Type{
    _get_Type = get_Type;
    //设置代理
    self.PickerImage.delegate = self;
    //在里面配置 self.PickerImage
    switch (get_Type) {
        case PHOTO_TYPE://照片
        {
            self.PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.PickerImage.mediaTypes = @[(NSString *)kUTTypeImage];
            //允许编辑，即放大裁剪
            self.PickerImage.allowsEditing = YES;
        }
            break;
        case TACKPHOTO_TYPE://拍照
        {
            self.PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.PickerImage.allowsEditing = YES;
            self.PickerImage.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            self.PickerImage.cameraDevice      = UIImagePickerControllerCameraDeviceRear;            
        }
            break;
        case MOVIE_TYPE://视频
        {
            self.PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //下面方法需要导入 #import <AVFoundation/AVFoundation.h>
            self.PickerImage.mediaTypes = @[(NSString *)kUTTypeMovie];
            self.PickerImage.allowsEditing = NO;
        }
            break;
        case TACKMOVIE_TYPE://摄像
        {
            self.PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.PickerImage.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            self.PickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
            self.PickerImage.videoQuality = UIImagePickerControllerQualityType640x480;
            self.PickerImage.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
            self.PickerImage.allowsEditing = YES;
        }
            break;
        default:
            break;
    }
    
    
    
}


//自定义alert
- (void) addCustomAlertforVC:(UIViewController *)vc{
    
    UIWindow *keyWin = [UIApplication sharedApplication].keyWindow;
    NSArray *titArr = @[(self.ImageOrMovieType == movieType) ? @"录像":@"拍照" , @"从相册选择" , @"取消"];

    self.alertBgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.alertBgView.backgroundColor = [UIColor blackColor];
    self.alertBgView.alpha = 0.0;
    self.alertBgView = self.alertBgView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeWindow:)];
    [self.alertBgView addGestureRecognizer:tap];
    [keyWin addSubview:self.alertBgView];
    
    //适配iphonex
    if ([UIScreen mainScreen].bounds.size.height == 812) {
        tableViewHeight = 146 + 34;
    }else{
        tableViewHeight = 146;
    }
    tableViewCellHeight = 45;
    UIView *alertTableView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT + 1,SCREEN_WIDTH, tableViewHeight)];
    alertTableView.backgroundColor = [UIColor whiteColor];

    CGFloat space = 0;
    for (int i = 0; i < 3; i++) {
        if (i == 1) {
            space = 1;
        }else if (i == 2){
            space = 11;
        }else{
            space = 0;
        }
        UIButton *cellBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, i * tableViewCellHeight +  space, SCREEN_WIDTH, tableViewCellHeight)];
        [cellBtn addTarget:self action:@selector(clickAlertCell:) forControlEvents:UIControlEventTouchUpInside];
        cellBtn.tag = i + 666;
        [cellBtn setTitle:titArr[i] forState:UIControlStateNormal];
        cellBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        cellBtn.backgroundColor = [UIColor whiteColor];
        UIColor *ccc = [UIColor blackColor];
        [cellBtn setTitleColor:ccc forState:UIControlStateNormal];
        [alertTableView addSubview:cellBtn];
    }
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, tableViewCellHeight, SCREEN_WIDTH, 1)];
    lineView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, tableViewCellHeight * 2 + 1, SCREEN_WIDTH, 10)];
    lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, tableViewCellHeight * 3 + 11, SCREEN_WIDTH, 1)];
    lineView3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [alertTableView addSubview:lineView1];
    [alertTableView addSubview:lineView2];
    [alertTableView addSubview:lineView3];
    self.alertTableView = alertTableView;
    [keyWin addSubview:self.alertTableView];
    [self showAlertWith:self.alertTableView];
    
}
- (void) showAlertWith:(UIView *)alertView{
    [UIView animateWithDuration:0.3 animations:^{
        self.alertBgView.alpha = 0.5;
        alertView.frame = CGRectMake(0, SCREEN_HEIGHT - tableViewHeight, SCREEN_WIDTH, tableViewHeight);
    } completion:^(BOOL finished) {
        
    }];
}


- (void) closeWindow:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.3 animations:^{
        self.alertBgView.alpha = 0.0;
        self.alertTableView.frame = CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, tableViewHeight + 1);
    } completion:^(BOOL finished) {
        [self.alertBgView removeFromSuperview];
        [self.alertTableView removeFromSuperview];
    }];
    
}
- (void) clickAlertCell:(UIButton *)sender{
    NSInteger index = sender.tag  - 666;
    NSLog(@"点击的是--%ld" , index);
    
    switch (sender.tag - 666) {
        case 0:
            [self paizhao];
            break;
        case 1:
            [self xiangce];
            break;
        case 3:
            //            [self closeWindow:nil];
            break;
        default:
            break;
    }
    [self closeWindow:nil];
}


- (void)addDefaulteAlertforVC:(UIViewController *)vc
{
    NSString *title = @"标题";
    NSString *message = @"内容";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    //改变title的大小和颜色
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAtt addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],NSForegroundColorAttributeName : [UIColor orangeColor]} range:NSMakeRange(0, title.length)];
    [alertController setValue:titleAtt forKey:@"attributedTitle"];
    
    //改变message的大小和颜色
    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, message.length)];
    [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, message.length)];
    [alertController setValue:messageAtt forKey:@"attributedMessage"];
    
    
    //添加
    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:(self.ImageOrMovieType == movieType) ? @"录像":@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //拍照
        [self paizhao];
    }];
    
    
    
    UIAlertAction *neverAction = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 相册
        [self xiangce];
    }];
    //自定义弹窗的action的字体颜色
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"从相册获取"];
     [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName : [UIColor orangeColor]} range:NSMakeRange(0, str.length)];
    
    [laterAction setValue:[UIColor greenColor] forKey:@"titleTextColor"];
    
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s------%s", ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    
    
    
    
    
    
    
    
    //查看个人资料
    UIAlertAction *lookUserInfoAction = [UIAlertAction actionWithTitle:@"查看大图" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 查看个人资料
//        [self lookBageImage];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // 取消按键
    }];
    // 添加操作（顺序就是呈现的上下顺序）
    //拍照在这里
    //    [alertDialog addAction:lookUserInfoAction];
    [alertController addAction:laterAction];
    [alertController addAction:neverAction];
    
    [alertController addAction:okAction];
    
    // 呈现警告视图
    [self.vc presentViewController:alertController animated:YES completion:nil];
}



//alertViewDelegate
//alertView与alertViewController的区别
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"点击的按钮下标%ld" , buttonIndex);
    if (buttonIndex == 0) {
        //取消按钮
    }else{
        //确定按钮 去开启定位 , 拍照 ， 相册
        [appStatusManager goSettingOpenPhoto];
    }
}
//拍照/摄像
- (void) paizhao {
    if (self.ImageOrMovieType == imageType) {//去拍照
        self.get_Type = TACKPHOTO_TYPE;
    }else{//去摄像
        self.get_Type = TACKMOVIE_TYPE;
    }
    //首先判断是否是否开启了拍照权限  没有就提示跳转打开
    if (![appStatusManager isCanUseCamare]) {
        //未打开提示去开启
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"允许使用相机" message:@"定位服务未开启，请进入系统［设置］> [隐私] > [相机服务]中允许使用相机服务" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"立即开启", nil];
        [alertView show];
        return;
    }
    self.isCamara = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self.vc presentViewController:self.PickerImage animated:YES completion:nil];
    }else {
        NSLog(@"未检测到照相设备");
        [CustomPromptBox showTextHud:@"未检测到照相设备"];
    }
}
//相册----照片/视频
- (void)xiangce {
    if (self.ImageOrMovieType == imageType) {//选相册中的照片
        self.get_Type = PHOTO_TYPE;
    }else{//选择相册中的视频
        self.get_Type = MOVIE_TYPE;
    }
    //首先判断是否是否开启了拍照权限  没有就提示跳转打开
    //    if (![appStatusManager isCanUsePhotos]) {
    //        //未打开提示去开启
    //
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"允许使用相册" message:@"定位服务未开启，请进入系统［设置］> [隐私] > [相册服务]中允许使用相册服务" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消",@"立即开启", nil];
    //        [alertView show];
    //        return;
    //    }
    self.isCamara = NO;

    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 此应用程序没有被授权访问的照片数据。可能是家长控制权限。
        NSLog(@"因为系统原因, 无法访问相册");
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝访问相册
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"允许使用相册" message:@"定位服务未开启，请进入系统［设置］> [隐私] > [相册服务]中允许使用相册服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        [alertView show];
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许访问相册
        // 放一些使用相册的代码
        //页面跳转
        [self.vc presentViewController:self.PickerImage animated:YES completion:nil];
        NSLog(@" 用户允许访问相册");
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        NSLog(@" 用户还没有做出选择");
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                // 放一些使用相册的代码
                //页面跳转
                [self.vc presentViewController:self.PickerImage animated:YES completion:nil];
            }
        }];
    }
}




//PickerImage完成后的代理方法  相机
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSLog(@"获取相册回调的信息：-- %@", info);
    
    
    
    
    
    UIImage *newPhoto;//创建照片对象
    if (self.get_Type == PHOTO_TYPE) {
        //定义一个newPhoto，用来存放我们选择的图片。
        //获取的是编辑后的照片  需要把编辑状态设置为yes
        newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        //获取的是原图
        //    newPhoto = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //压缩照片
        //处理图片（缩略图）newimage lenth = 29378byt
        /**
         生成缩略图
         */
        UIImage *newImage = [self thumnaiWithImage:newPhoto size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        NSLog(@"newimage lenth = %lu",UIImagePNGRepresentation(newImage).length);
        // 真正发送的数据(进一步压缩) sendData lenth = 1505byt
        NSData *sendData = UIImageJPEGRepresentation(newImage, 0.5);
        NSLog(@"sendData lenth = %lu",sendData.length);
    }else if (self.get_Type == TACKPHOTO_TYPE){
        
    }else if (self.get_Type == MOVIE_TYPE){
        
    }else if(self.get_Type == TACKMOVIE_TYPE){
        
    }else{
        NSLog(@"未知-----");
    }
    
    


    //相机相册代理回调
    [self.vc dismissViewControllerAnimated:YES completion:^{
        NSLog(@"开始上传！！！！！！！！");
        return;
        //下面是上传方法
        //调用上传图片的方法
        //        [networkingManagerTool postRequestWithURL:[NSString stringWithFormat:@"%@upload/index/token/%@" , BASEURL , [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] image:newPhoto picFileName:[dataMenagerTool generateUuidString] block:^(NSDictionary *dic) {
        //
        //            //上传成功更新头像 post
        //            NSString *codeStr = [NSString stringWithFormat:@"icon=%@" ,[NSString stringWithFormat:@"%@" ,dic[@"data"][@"path"]]];
        //            //用参数签名
        ////            NSString *sign = [[RSACheckTool sharedRSACheckTool] checkInfoWithPerametersStr:codeStr withType:SHA256Type];
        //            //            @"http://www.chenchen521.cn/index.php/api/user/contacts/token/{token}"
        //
        //
        //            NSDictionary *parameters = @{};
        //            [networkingManagerTool requestToServerWithType:REQUEST_TYPE_POST withSubUrl:[NSString stringWithFormat:@"user/icon/token/%@" , [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]] withParameters:parameters withResultBlock:^(BOOL result, id value) {
        //                if (result == YES)
        //                {
        //                    [self.headerimageBtn setImage:newPhoto forState:UIControlStateNormal];
        //                }
        //            } witnVC:self];
        //        }];
        
        
        
        //base64上传
        [MBProgressHUD showHUDAddedTo:self.vc.view animated:YES];
        [networkingManagerTool upLoadImageWithBase64WithImage:newPhoto withSubUrl:@"update_api" progress:^(NSProgress *progress) {
            NSLog(@"%lld----%lld" , progress.totalUnitCount , progress.completedUnitCount);
        } withResultBlock:^(BOOL result, id value) {
            if (result) {
                //保存到相册  在拍照状态下存到相册  选取的是相册的 就不用
                if (_isCamara) {
                    UIImageWriteToSavedPhotosAlbum(newPhoto, nil, nil, nil);
                }
                [self savePhoto:newPhoto];
                //提交图片接口
                //上传成功显示头像
                NSString *urlStr = value[@"data"][@"url"];
                //提交返回的url
                [networkingManagerTool requestToServerWithType:POST withSubUrl:@"upLoadImage_Url" withParameters:@{@"avatar_url" : urlStr} withResultBlock:^(BOOL result, id value) {
                    if (result) {
                        NSLog(@"提交数据成功！");
                    }
                } witnVC:self.vc];
            }
        } witnVC:self.vc];
        
        
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        
        
        //data数据流上传
        [networkingManagerTool requestToServerWithType:UPDATE withSubUrl:@"subUrl" withParameters:parameters progress:^(NSProgress *progress) {
            
        } withResultBlock:^(BOOL result, id value) {
            
        } witnVC:self.vc];
        
        
        
        
        
    }];
}

//获取头像存储路径
- (NSString *) getHeaderImagePath{
    NSString *catchPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *pathStr = [catchPath stringByAppendingPathComponent:@"headerImageName"];
    
    return pathStr;
}


/** 生成缩略图的方法 */
- (UIImage *) thumnaiWithImage:(UIImage *) image size:(CGSize) size
{
    //    image lenth = 11314085byt
    //    newimage lenth = 29378byt
    //    sendData lenth = 1505
    //    压缩了400倍
    UIImage *newImage = nil;
    if (!newImage)
    {
        UIGraphicsBeginImageContext(size);//获取绘制开始的上下文
        [image drawInRect:CGRectMake(0, 0, size.width, size.width)];//重新绘制一个图片
        newImage = UIGraphicsGetImageFromCurrentImageContext();//获取绘制过得图片上下文
        UIGraphicsEndImageContext();//结束绘制
    }
    return newImage;
}


//储存photo
- (void) savePhoto:(UIImage *)newPhoto{
    //存 到本地
    NSString *imagePath = [self getHeaderImagePath];
    //转成data
    NSData *imageData;
    if(newPhoto){
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(newPhoto)) {
            //返回为png图像。
            imageData = UIImagePNGRepresentation(newPhoto);
        }else {
            //返回为JPEG图像。
            imageData = UIImageJPEGRepresentation(newPhoto, 1.f);
        }
    }
    [imageData writeToFile:imagePath atomically:YES];//存入路径
}




//将Image保存到缓存路径中
- (void)saveImage:(UIImage *)image toCachePath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:PHOTOCACHEPATH]) {
        
        NSLog(@"路径不存在, 创建路径");
        [fileManager createDirectoryAtPath:PHOTOCACHEPATH
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    } else {
        
        NSLog(@"路径存在");
    }
    
    //[UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
    [UIImageJPEGRepresentation(image, 1) writeToFile:path atomically:YES];
}

//将视频保存到缓存路径中
- (void)saveVideoFromPath:(NSString *)videoPath toCachePath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:VIDEOCACHEPATH]) {
        
        NSLog(@"路径不存在, 创建路径");
        [fileManager createDirectoryAtPath:VIDEOCACHEPATH
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    } else {
        
        NSLog(@"路径存在");
    }
    
    NSError *error;
    [fileManager copyItemAtPath:videoPath toPath:path error:&error];
    if (error) {
        
        NSLog(@"文件保存到缓存失败");
    }
}


//以当前时间合成图片名称
- (NSString *)getImageNameBaseCurrentTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".JPG"];
}

//以当前时间合成视频名称
- (NSString *)getVideoNameBaseCurrentTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".MOV"];
}
//获取视频的第一帧截图, 返回UIImage
//需要导入AVFoundation.h
- (UIImage*) getVideoPreViewImageWithPath:(NSURL *)videoPath
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    
    AVAssetImageGenerator *gen         = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time      = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error   = nil;
    
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img     = [[UIImage alloc] initWithCGImage:image];
    
    return img;
}

/*
 5. 如何上传?
 下面就是上传方法:
 我把服务器地址xx掉了, 大家可以改为自己的
 */

//上传图片和视频
- (void)uploadImageAndMovieBaseModel:(uploadModel *)model {
    
    //获取文件的后缀名
    NSString *extension = [model.name componentsSeparatedByString:@"."].lastObject;
    
    //设置mimeType
    NSString *mimeType;
    if ([model.type isEqualToString:@"image"]) {
        
        mimeType = [NSString stringWithFormat:@"image/%@", extension];
    } else {
        
        mimeType = [NSString stringWithFormat:@"video/%@", extension];
    }
    
    //创建AFHTTPSessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置响应文件类型为JSON类型
    manager.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    //初始化requestSerializer
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = nil;
    
    //设置timeout
    [manager.requestSerializer setTimeoutInterval:20.0];
    
    //设置请求头类型
    [manager.requestSerializer setValue:@"form/data" forHTTPHeaderField:@"Content-Type"];
    
    //设置请求头, 授权码
    [manager.requestSerializer setValue:@"YgAhCMxEehT4N/DmhKkA/M0npN3KO0X8PMrNl17+hogw944GDGpzvypteMemdWb9nlzz7mk1jBa/0fpOtxeZUA==" forHTTPHeaderField:@"Authentication"];
    
    //上传服务器接口
    NSString *url = [NSString stringWithFormat:@"http://xxxxx.xxxx.xxx.xx.x"];
    
    //开始上传
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSError *error;
        BOOL success = [formData appendPartWithFileURL:[NSURL fileURLWithPath:model.path] name:model.name fileName:model.name mimeType:mimeType error:&error];
        if (!success) {
            
            NSLog(@"appendPartWithFileURL error: %@", error);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传进度: %f", uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"成功返回: %@", responseObject);
        model.isUploaded = YES;
        [self.uploadedArray addObject:model];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败: %@", error);
        model.isUploaded = NO;
    }];
}





@end
