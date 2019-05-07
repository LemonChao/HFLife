

#import "HRSandbox.h"

@implementation HRSandbox

+ (NSString *)docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrePath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [self createPathWithParentPath:[paths objectAtIndex:0] pathName:@"Preference"];
}

+ (NSString *)libCachePath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [self createPathWithParentPath:[paths objectAtIndex:0] pathName:@"Caches"];
}

+ (NSString *)tmpPath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [self createPathWithParentPath:[paths objectAtIndex:0] pathName:@"tmp"];
}

+ (NSString *)createPathWithParentPath:(NSString *)aParentPath pathName:(NSString *)aPathName {
    if (!aParentPath || aParentPath.length <= 0) {
        return nil;
    }
    NSString *path = [aParentPath stringByAppendingPathComponent:aPathName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:NULL]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return path;
}

@end
