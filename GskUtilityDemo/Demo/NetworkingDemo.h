//
//  NetworkingDemo.h
//  GskUtilityDemo
//
//  Created by gsk on 2018/7/26.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, RequestType) {
    /// get请求
    GET,
    /// post请求
    POST,
};
/// 请求成功的Block
typedef void(^RequestSuccess)(id response);

/// 请求失败的Block
typedef void(^RequestFailure)(NSError *error);

@interface NetworkingDemo : NSObject

/**
 demo:请求用户信息

 @param parameters 参数(字典型)
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)getUserInfoWithParameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;
@end
