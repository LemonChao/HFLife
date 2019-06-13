
#import "baseTableView.h"
#import <ImageIO/ImageIO.h>     // 图像的输入输出文件
#import <MobileCoreServices/MobileCoreServices.h>
@interface baseTableView()
@property (nonatomic, strong) MJRefreshGifHeader *header;

@property (nonatomic ,strong) NSString *gifPathSource;//图片地址
@end


@implementation baseTableView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.tableFooterView = [UIView new];
        [self addLodingView];
        self.page = 1;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableFooterView = [UIView new];
        [self addLodingView];
        self.page = 1;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tableFooterView = [UIView new];
        [self addLodingView];
        self.page = 1;
    }
    
    return self;
}

//xibtable继承自basetable 需要
- (void)awakeFromNib{
    [super awakeFromNib];
    self.tableFooterView = [UIView new];
    [self addLodingView];
    self.page = 1;
}


- (void)addLodingView{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    self.mj_header = header;
    self.header = header;
    
    //    header.mj_h = 30;//修改刷新头的高度
    
    /**下拉刷新 停留样式*/
    //     MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    //    footer.refreshingTitleHidden = YES;//刷新时隐藏标题
    
    /**下拉刷新 底部样式*/
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [footer setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1.0];
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    self.mj_footer = footer;
    
    //默认开启jif动画
    self.activityGifHeader = YES;
    self.gifSourceName = @"refresh";
}


- (void)setActivityGifHeader:(BOOL)activityGifHeader{
    _activityGifHeader = activityGifHeader;
    
    if (_activityGifHeader) {
        //必须隐藏 动画才能正常显示
        _header.stateLabel.hidden = YES;
        _header.lastUpdatedTimeLabel.hidden = YES;
        
        NSArray *imagesArr = [self didCompositionGif];
        if (imagesArr.count == 0) {
            return;
        }
        //激活gif 动画刷新
        NSMutableArray *images = [NSMutableArray array];
//        for (int i = 0 ; i < 10; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
//            [images addObject:image];
//        }
        images = [NSMutableArray arrayWithArray:imagesArr];
        
        NSMutableArray *firstArr = [NSMutableArray array];
        [firstArr addObject:images[0]];
        //        0.1s一针
        float time = images.count * 0.02;
        
        [_header setImages:images duration:time forState:MJRefreshStateRefreshing];
        
        [_header setImages:images duration:time forState:MJRefreshStatePulling];
        
        [_header setImages:firstArr duration:time forState:MJRefreshStateWillRefresh];
        
        [_header setImages:firstArr forState:MJRefreshStateIdle];
        
    }
}



//下拉
- (void)setRefreshHeaderBlock:(void (^)(void))refreshHeaderBlock{
    _refreshHeaderBlock = refreshHeaderBlock;
}


//上啦
- (void)setRefreshFooterBlock:(void (^)(void))refreshFooterBlock{
    _refreshFooterBlock =  refreshFooterBlock;
}

- (void) refreshHeader{
    self.page = 1;
    
    NSLog(@"下拉--第----%ld----页" , self.page);
    if ([self.mj_footer isRefreshing]) {
        
        [self.mj_footer endRefreshing];
    }
    if (_refreshHeaderBlock) {
        _refreshHeaderBlock();
    }
}
- (void) refreshFooter{
    self.page += 1;
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if (_refreshFooterBlock) {
        _refreshFooterBlock();
    }
    NSLog(@"上拉--第----%ld----页" , self.page);
}
- (void) endRefreshData{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}


//关闭加载数据 开始新的数据加载
- (void) closeRequest{
    
}


- (void)setGifSourceName:(NSString *)gifSourceName{
    _gifSourceName = gifSourceName;
    self.gifPathSource = [[NSBundle mainBundle] pathForResource:gifSourceName ofType:@"gif"];
    //重新设置 动画
    self.activityGifHeader = YES;
}

//解析gif图片
- (NSArray *)didCompositionGif {
    
    
    //1. 拿到gif数据
    NSString * gifPathSource = [[NSBundle mainBundle] pathForResource:self.gifSourceName ofType:@"gif"];//默认的加载动画
    
    //拿不到资源就不设置
    if (!gifPathSource) {
        return [NSArray array];
    }
    
    
    
    if (self.gifPathSource) {
        gifPathSource = self.gifPathSource;
    }
    NSData * data = [NSData dataWithContentsOfFile:gifPathSource];
#warning 桥接的意义 (__bridge CFDataRef)
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    //2. 将gif分解为一帧帧
    size_t count = CGImageSourceGetCount(source);
    NSLog(@"%zu",count);
    
    NSMutableArray * tmpArray = [NSMutableArray arrayWithCapacity:0];
    for (size_t i = 0; i < count; i ++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        
        //3. 将单帧数据转为UIImage
        UIImage * image = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        [tmpArray addObject:image];
#warning CG类型的对象 不能用ARC自动释放内存.需要手动释放
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    
    // 单帧图片保存
    //    int i = 0;
    //    for (UIImage * image  in tmpArray) {
    //
    //        i ++;
    //        NSData * data = UIImagePNGRepresentation(image);
    //        NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //
    //        NSString * gifPath = path[0];
    //        NSLog(@"gifPath: %@",gifPath);
    //        NSString * pathNum = [gifPath stringByAppendingString:[NSString stringWithFormat:@"%d.png",i]];
    //        [data writeToFile:pathNum atomically:NO];
    //    }
    //解析帧数
    NSLog(@"%ld", tmpArray.count);
    
    
    //    //只需要36针  那么就取出来36帧作为使用
    //    NSMutableArray *imagesArr = [NSMutableArray array];
    //    int speed = (int)tmpArray.count / 36;
    //    if (speed == 0) {
    //        speed = 1;
    //    }
    //
    //
    //    for (int i = 0; i < tmpArray.count; i += speed) {
    //        [imagesArr addObject:tmpArray[i]];
    //    }
    //    //添加最后一帧
    //    [imagesArr addObject:tmpArray.lastObject];
    
    
    
    
    //ui给图不对 自定义修改图片尺寸
    NSMutableArray *newImgArrM = [NSMutableArray array];
    for (UIImage *img in tmpArray) {
        [newImgArrM addObject:[self imageResize:img andResizeTo:CGSizeMake(30, 32)]];
    }
    
    
    return newImgArrM;
    
}


//修改图片的尺寸
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
