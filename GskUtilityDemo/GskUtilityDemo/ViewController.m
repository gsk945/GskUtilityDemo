//
//  ViewController.m
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str = @"hello";
    GSKLog(@"%@ world",str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
