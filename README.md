#plist文件缓存封装&&基于AFNetworking的网络请求封装
## Object-C版plist文件缓存
### 核心代码为PersistService
#### PersistService.h文件
```
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

###使用方法示例

1. 继承于PersistService再封装一层属于本项目的缓存层（例如：UserPersistService），缓存路径可自行设置，例如：
```
#define UserData @"userData"
```

2.在需要使用的地方直接可以使用，例如：

```
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
### Swift版plist缓存
```
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
## 基于AFNetworking的网络请求封装
###核心代码：NetworkManager
```
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, RequestSerializer) {
    /// 设置请求数据为JSON格式
    RequestSerializerJSON,
    /// 设置请求数据为二进制格式
    RequestSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, ResponseSerializer) {
    /// 设置响应数据为JSON格式
    ResponseSerializerJSON,
    /// 设置响应数据为二进制格式
    ResponseSerializerHTTP,
};

typedef NS_ENUM(NSUInteger, NetworkStatusType) {
    /// 未知网络
    NetworkStatusUnknown,
    /// 无网络
    NetworkStatusNotReachable,
    /// 手机网络
    NetworkStatusReachableViaWWAN,
    /// WIFI网络
    NetworkStatusReachableViaWiFi
};

/// 请求成功的Block
typedef void(^HttpRequestSuccess)(id responseObject);

/// 请求失败的Block
typedef void(^HttpRequestFailed)(NSError *error);

/// 上传或者下载的进度, Progress.completedUnitCount:当前大小 - Progress.totalUnitCount:总大小
typedef void (^HttpProgress)(NSProgress *progress);

/// 网络状态的Block
typedef void(^NetworkStatus)(NetworkStatusType status);

@interface NetworkManager : NSObject
/// 实时获取网络状态,通过Block回调实时获取
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus;

/// 有网YES, 无网:NO
+ (BOOL)isNetwork;

/// 手机网络:YES, 反之:NO
+ (BOOL)isWWANNetwork;

/// WiFi网络:YES, 反之:NO
+ (BOOL)isWiFiNetwork;

/**
 *  GET请求
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)GET:(NSString *)URL
                        parameters:(id)parameters
                           success:(HttpRequestSuccess)success
                           failure:(HttpRequestFailed)failure;

/**
 POST请求

 @param url 请求地址
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+(NSURLSessionTask *)POST:(NSString *)url parameters:(id)parameters success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailed)failure;

/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                                 progress:(HttpProgress)progress
                                  success:(HttpRequestSuccess)success
                                  failure:(HttpRequestFailed)failure;

/**
 *  设置请求超时时间:默认为30S
 *
 *  @param time 时长
 */
+ (void)setRequestTimeoutInterval:(NSTimeInterval)time;

/// 设置请求头
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 *  设置网络请求参数的格式:默认为二进制格式
 *
 *  @param requestSerializer RequestSerializerJSON(JSON格式),RequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(RequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer ResponseSerializerJSON(JSON格式),ResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(ResponseSerializer)responseSerializer;
/**
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103
 
 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
 的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
 一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 */
+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName;
@end
```
####使用方法示例
1. 基于NetworkManager再封装一层属于本项目的网络层（例如：NetworkingDemo），可将项目中的网络接口集中在一起便于管理
2. 在需要使用的地方直接使用,例如：
```
   [NetworkingDemo getUserInfoWithParameters:@{@"token":@"abcdefg"} success:^(id response) {
        NSString * str = [self jsonToString:response];
        NSLog(@"数据==%@", str);
    } failure:^(NSError *error) {
        
    }];
```
3. NetworkManager封装了网络状态的判断，需要的可自行使用

