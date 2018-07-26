//
//  ViewController.m
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import "ViewController.h"
#import "UserPersistService.h"
#import "NetworkingDemo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //数据写入
    NSDictionary *dic = @{@"name":@"gsk",@"age":@26};
    [UserPersistService saveData:dic withKey:@"me"];
    //数据读取
    NSDictionary *meDic = [UserPersistService getUserDataWithKey:@"me"];
    GSKLog(@"me==%@",meDic);
    //数据清除
    [UserPersistService clearDatawithKey:@"me"];
    NSDictionary *newmeDic = [UserPersistService getUserDataWithKey:@"me"];
    GSKLog(@"me==%lu", (unsigned long)[newmeDic count]);
    
    //网络请求Demo
    [NetworkingDemo getUserInfoWithParameters:@{@"token":@"abcdefg"} success:^(id response) {
        NSString * str = [self jsonToString:response];
        NSLog(@"数据==%@", str);
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  json转字符串
 */
- (NSString *)jsonToString:(NSDictionary *)dic
{
    if(!dic){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
