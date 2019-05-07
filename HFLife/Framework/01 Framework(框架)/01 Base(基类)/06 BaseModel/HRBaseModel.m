
#import "HRBaseModel.h"
#import <objc/runtime.h>
#import "NSString+PinYin.h"
@implementation HRBaseModel

#pragma mark -prototal method(协议方法)
// 解档
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        // 获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            // 进行解档取值
            id value = [decoder decodeObjectForKey:strName];
            // 利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}
// 归档
- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        // 利用KVC取值
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

#pragma mark -pulic method(公有方法)
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


#pragma mark - overide (重写父类)
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forUndefinedKey:key];
}

//log模型
-(NSString *)description
{
    NSMutableDictionary *jsonDic = [NSMutableDictionary dictionary];
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i <count; i ++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";
        [jsonDic setObject:value forKey:name];
    }
    free(properties);
    return [NSString stringWithFormat:@"<%@:%p> -- %@",[self mj_keyValues],self,jsonDic];
}

-(NSString *)debugDescription
{
    return [NSString stringWithFormat:@"%@ -- %p",[self mj_keyValues],self];
}



//MJ过滤null
-(id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([NSString isEmpty:oldValue]) {
        return @"";
    }
    return oldValue;
}

@end
