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
# Swift版plist缓存
```objc
class PersistServiceSwift {
    static let subpath = "/doc"
    
    static func set(_ obj: Any, key: String, classKey: String) {
        if let currentSetting = get(fromKey: classKey) as? Dictionary<String, Any> {
            let newSetting = NSMutableDictionary(dictionary: currentSetting)
            newSetting.setObject(obj, forKey: NSString(string: key))
            set(newSetting, key: classKey)
        }else {
            let newSetting = NSMutableDictionary(object: obj, forKey: NSString(string: key))
            set(newSetting, key: classKey)
        }
    }
    
    static func get(key: String, from classkey: String) -> Any? {
        if let currentSetting = get(fromKey: classkey) as? Dictionary<String, Any> {
            return currentSetting[key]
        }
        return nil
    }
    
    private static func set(_ obj : Any?, key : String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + subpath
        var file = NSMutableDictionary(contentsOfFile: path)
        if file == nil {
            file = NSMutableDictionary()
        }
        if obj == nil {
            file?.removeObject(forKey: key)
        }else {
            file?.setObject(obj!, forKey: NSString(string: key))
        }
        guard (file?.write(toFile: path, atomically: true))! else {
            print("persist fail!!")
            return
        }
    }
    
    private static func get(fromKey key : String) -> Any? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + subpath
        return NSDictionary(contentsOfFile: path)?.object(forKey: key)
    }
}
```
swift版的使用方式跟OC的差不多就不新增Demo了