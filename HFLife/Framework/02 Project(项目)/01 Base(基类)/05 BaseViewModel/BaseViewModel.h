
#import "HRBaseViewModel.h"

@interface BaseViewModel : HRBaseViewModel

/** 第几页 */
@property(nonatomic, assign) NSUInteger page;

/**
 总共的页数
 */
@property(nonatomic, assign) NSUInteger totalPage;

@end
