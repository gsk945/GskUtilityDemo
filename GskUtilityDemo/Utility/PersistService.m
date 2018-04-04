//
//  PersistService.m
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import "PersistService.h"

@implementation PersistService
+ (void)saveObject:(id<NSCoding>)obj withKey:(NSString *)key AndClassKey:(NSString*)classKey{
    if([PersistService getPatchWithPath:classKey]){
        NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:[PersistService getPatchWithPath:classKey]];
        [newDic setObject:obj forKey:key];
        [PersistService save:newDic withKey:classKey];
    }else{
        NSMutableDictionary *newDic =[[NSMutableDictionary alloc]init];
        [newDic setObject:obj forKey:key];
        [PersistService save:newDic withKey:classKey];
    }
}
+ (void)save:(id)obj withKey:(NSString *)key{
    NSString *patch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/doc"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:patch];
    if (dic == nil){
        dic = [[NSMutableDictionary alloc]init];
    }
    if (obj == nil){
        [dic removeObjectForKey:key];
    }else{
        [dic setObject:obj forKey:key];
    }
    if ( [dic writeToFile:patch atomically:YES]){
        NSLog(@"数据写入成功");
    }else{
        NSLog(@"数据写入失败");
    }
}
+ (id)getDataWithKey:(NSString *)key AndClassKey:(NSString *)classKey{
    if([PersistService getPatchWithPath:classKey] != nil){
        NSMutableDictionary *newDic = [[NSMutableDictionary alloc]initWithDictionary:[PersistService getPatchWithPath:classKey]];
        return newDic[key];
    }else{
        return nil;
    }
}
+ (id)getPatchWithPath:(NSString *)key{
    NSString *patch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/doc"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:patch];
    return [dic objectForKey:key];
}
@end
