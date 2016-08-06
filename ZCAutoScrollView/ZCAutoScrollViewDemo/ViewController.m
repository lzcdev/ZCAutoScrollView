//
//  ViewController.m
//  ZCAutoScrollView
//
//  Created by LuzhiChao on 16/8/5.
//  Copyright © 2016年 LuzhiChao. All rights reserved.
//

#import "ViewController.h"
#import "ZCAutoScrollView.h"
#define KWIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZCAutoScrollView *scrollView = [[ZCAutoScrollView alloc]initWithFrame:CGRectMake(0, 100, KWIDTH, 400)];
    scrollView.imageArray = @[@"001.jpg",@"002.jpg",@"003.jpg",@"http://pic1.nipic.com/2008-12-25/2008122510134038_2.jpg"];
    scrollView.placeholderImage = [UIImage imageNamed:@"dog_1"]; //设置缺省图片
    scrollView.pageControlAliment = NSPageControlAlimentCenter; //设置小圆点居中，默认不显示
    // 图片的点击方法
    [scrollView addTapClick:^(NSInteger index) {
        NSLog(@"我是第%ld张图片",index);
    }];
    [self.view addSubview:scrollView];
    
}

@end
