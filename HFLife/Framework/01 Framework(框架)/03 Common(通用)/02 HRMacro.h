
/**
 
 1.项目宏定义
 
 */


#ifndef HRMacro_h
#define HRMacro_h

#pragma mark - -------------  System Singleton ----------------
#define USERDEFAULT     [NSUserDefaults standardUserDefaults]
#define NOTIFICATION    [NSNotificationCenter defaultCenter]
#define APPLICATION     [UIApplication sharedApplication]
#define APP_DELEGATE    [[UIApplication sharedApplication] delegate]

#pragma mark - ------------------- XIB --------------------
#define XIB(Class) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:nil options:nil] firstObject]

#pragma mark - ---------------- Storyboard ----------------
#define SB(name) [[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController]
#define SB_ID(name, identifier)   [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:identifier]

#pragma mark - ---------------- Memory ----------------
#define WEAK(weakSelf) __weak typeof(self) weakSelf = self;
#define STRONG(strongSelf,weakSelf) __strong typeof(weakSelf) strongSelf = weakSelf;

#pragma mark - ------------------ NSBundle -------------------
#define BUNDLE      [NSBundle mainBundle]
#define APP_NAME    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_VERSION [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD   [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"]

#define BUNDLE_PATH(name, type) [[NSBundle mainBundle] pathForResource:name ofType:type]
#define IMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:nil]]

#pragma mark - -------------------- Screen ------------------
#define SCREEN_BOUNDS    [UIScreen mainScreen].bounds
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height


#define NaviBarHeight          self.navigationController.navigationBar.frame.size.height
#define TableBarHeight         self.tabBarController.tabBar.frame.size.height
#define statusBarHeight        [UIApplication sharedApplication].statusBarFrame.size.height

#pragma mark - ------------------- Color -------------------
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define RGBColor(r,g,b,a)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB0X(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR_RAND          [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
#define COLOR_CLEAR         [UIColor clearColor]

#define MyFont(font) [UIFont systemFontOfSize:font]
#define image(name) [UIImage imageNamed:name]


#pragma mark - -------------------- Log --------------------
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"-------------------------- [HRLog] -------------------------- \n[D]:%s\n[T]:%s\n[F]:%s\n[M]:%s\n[L]:%d\n[C]:%s\n", __DATE__, __TIME__, __FILE__,__FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#if DEBUG
#define HRLog(FORMAT, ...) fprintf(stderr,"-------------------------- [HRLog] -------------------------- \n%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define HRLog(FORMAT, ...) nil
#endif


#pragma mark - ------------------- String -------------------
#define SF(...) [NSString stringWithFormat:__VA_ARGS__]
#define NIL(string) (string == nil || (NSNull *)string == [NSNull null] || [string isEqualToString:@""])
#define LOCAL_STRING(x, ...) NSLocalizedString(x, nil)


#pragma mark - ------------------- Font -------------------
#define FONT(size) [UIFont systemFontOfSize:size]
#define HF_xyRatio [UIScreen mainScreen].bounds.size.height / 568
#define HF_Ratio [UIScreen mainScreen].bounds.size.width / 667

#define ScreenScale(x) ([UIScreen mainScreen].bounds.size.width / 375.0) * x

#pragma mark - ------------------- G_C_D -------------------

#define GCD_G_Q dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define GCD_M_Q dispatch_get_main_queue()
#define GCD_AS_G_Q(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block); // 异步执行全局队列
#define GCD_AS_M_Q(block) dispatch_async(dispatch_get_main_queue(),block);  // 异步执行主队列
#define GCD_DELAY(time, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_queue_create("custom", DISPATCH_QUEUE_CONCURRENT), block); // 延时执行
#define GCD_ONCE(block) static dispatch_once_t onceToken; dispatch_once(&onceToken, block); // 只执行一次

#pragma mark - ------------------- Language -------------------

#define LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0]) // 本地语言

#pragma mark - ------------------- Radian && Degrees -------------------

#define RADIAN(degrees) (M_PI * (degrees) / 180.0) // 角度转弧度
#define DEGREES(radian) (radian*180.0)/(M_PI) // 弧度转角度


#pragma mark - ------------------- IPHONE && SIMULATOR -------------------

#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif



#pragma mark ================= 系统宏 ==================
// __FILE__     当前文件所在目录
// __DATE__     “替代文字”是一个含有编译日期的字符串字面值，日期格式为“mm dd yyyy”（例如：“Mar 19 2006”）。如果日期小于10日，就在日的前面放一个空格符。NSLog(@"_DATE_=%s",__DATE__);
// __FUNCTION__ 当前函数名称

// __LINE__     当前语句在源文件中的行数
// __TIME__     此字符串字面值包含编译时间，格式为“hh:mm:ss”（范例：“08:00:59”）。



#endif /* HRMacro_h */
