//
//  NetworkingDemo.m
//  GskUtilityDemo
//
//  Created by gsk on 2018/7/26.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import "NetworkingDemo.h"
#import "NetworkManager.h"
@implementation NetworkingDemo

+ (void)getUserInfoWithParameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure{
    NSString *url = @"http:www.baidu.com";
    //get请求
    [NetworkingDemo requestWithURL:url type:GET parameters:parameters success:success failure:failure];
    //post请求
    [NetworkingDemo requestWithURL:url type:POST parameters:parameters success:success failure:failure];
}

/**
 请求的公共方法

 @param URL url
 @param type get/post
 @param parameter 参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+(NSURLSessionTask *)requestWithURL:(NSString *)URL type:(RequestType)type parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure{
    //设置请求头参数
    [NetworkManager setValue:@"ios" forHTTPHeaderField:@"PLATFORM"];
    [NetworkManager setValue:@"1.0.0" forHTTPHeaderField:@"VERSION"];
    if (type == GET){
        return  [NetworkManager GET:URL parameters:parameter success:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }else{
        return [NetworkManager POST:URL parameters:parameter success:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}
@end
