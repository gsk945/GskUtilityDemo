# Object-C版plist文件缓存
## 核心代码为PersistService
### PersistService.h文件
```objc
#import <Foundation/Foundation.h>

@interface PersistService : NSObject//demo: UserPersistService
/**
 保存数据
 
 @param obj 数据
 @param key 键值名
 @param classKey 类名
 */
+ (void)saveObject:(id<NSCoding>)obj withKey:(NSString *)key AndClassKey:(NSString*)classKey;

/**
 获取数据
 
 @param key 键值名
 @param classKey 类名
 @return 数据
 */
+ (id)getDataWithKey:(NSString *)key AndClassKey:(NSString *)classKey;
@end
```
### PersistService.m文件
```objc
#import "PersistService.h"

@implementation PersistService
+ (void)saveObject:(id<NSCoding>)obj withKey:(NSString *)key AndClassKey:(NSString*)classKey{
    if([PersistService getPathWithKey:classKey]){
        NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:[PersistService getPathWithKey:classKey]];
        [newDic setObject:obj forKey:key];
        [PersistService save:newDic withKey:classKey];
    }else{
        NSMutableDictionary *newDic =[[NSMutableDictionary alloc]init];
        [newDic setObject:obj forKey:key];
        [PersistService save:newDic withKey:classKey];
    }
}
+ (void)save:(id)obj withKey:(NSString *)key{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/doc"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    if (dic == nil){
        dic = [[NSMutableDictionary alloc]init];
    }
    if (obj == nil){
        [dic removeObjectForKey:key];
    }else{
        [dic setObject:obj forKey:key];
    }
    if ( [dic writeToFile:path atomically:YES]){
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
}
+ (id)getDataWithKey:(NSString *)key AndClassKey:(NSString *)classKey{
    if([PersistService getPathWithKey:classKey] != nil){
        NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:[PersistService getPathWithKey:classKey]];
        return newDic[key];
    }else{
        return nil;
    }
}
+ (id)getPathWithKey:(NSString *)key{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/doc"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    return [dic objectForKey:key];
}
@end
```
##使用方法示例
1.UserPersistService继承自PersistService在UserPersistService封装常用的方法

```objc
/**
 缓存数据

 @param obj 缓存数据
 @param key 对应键值
 */
+(void)saveData:(id<NSCoding>)obj withKey:(NSString *)key;

/**
 取出字典型数据

 @param key 对应键值
 @return 取出的数据
 */
+(NSDictionary *)getUserDataWithKey:(NSString *)key;

/**
 缓存数组型数据（其实上面那个缓存方式就可以了，故意区分开）

 @param obj 缓存数据型数据
 @param key 对应键值
 */
+(void)saveArray:(id<NSCoding>)obj withKey:(NSString *)key;

/**
 取出数组型数据

 @param key 对应的键值
 @return 数组型数据
 */
+(NSArray *)getUserDataArrayWithKey:(NSString *)key;

/**
 清空缓存数据

 @param key 对应键值
 */
+(void)clearDatawithKey:(NSString *)key;
```

2.在需要使用的地方直接可以使用，例如：

```objc
//数据写入
    NSDictionary *dic = @{@"name":@"gsk",@"age":@26};
    [UserPersistService saveData:dic withKey:@"me"];
    //数据读取
    NSDictionary *meDic = [UserPersistService getUserDataWithKey:@"me"];
        //数据清除
    [UserPersistService clearDatawithKey:@"me"];
    NSDictionary *newmeDic = [UserPersistService getUserDataWithKey:@"me"];
    GSKLog(@"me==%lu", (unsigned long)[newmeDic count]);

```
