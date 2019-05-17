

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
    }
    return self;
}


@end
