# ZCAutoScrollView
简单易用的广告轮播页面，可轮播本地和网络图片（依赖SDWebImage），支持手动和自动滚动，可设置小圆点位置和网络缺省图片。支持图片的点击事件。
# 效果
动态图片展示不出来的这里我直接附上图片地址
`http://7xt7mf.com1.z0.glb.clouddn.com/%E6%8F%90%E7%A4%BA%E6%A1%86.gif`
![演示效果](http://7xt7mf.com1.z0.glb.clouddn.com/%E6%8F%90%E7%A4%BA%E6%A1%86.gif)
# 原理
采用UIScrollView完成，假如要循环3张图片，则放4张，也就是最后一张图片放2次。顺序为3123，默认scrollView在第一张图片上，当切换到第三张时把scrollView的偏移量移到第一张图片上，这样就完成了循环。
# 用法
1.支持CocoaPods,

```
platform :ios, '7.0'
use_frameworks!
pod 'ZCAutoScrollView', '~> 0.0.2'
```

2.把ZCAutoScrollView这个文件夹拖入工程，文件夹里面包含SDWebImage和ZCAutoScrollView.h,ZCAutoScrollView.m两个文件，若项目中已有SDWebImage，只需把其余两个文件拖入工程。
导入头文件`#import "ZCAutoScrollView.h"`

```
 ZCAutoScrollView *scrollView = [[ZCAutoScrollView alloc]initWithFrame:CGRectMake(0, 100, KWIDTH, 400)];
    scrollView.imageArray = @[@"001.jpg",@"002.jpg",@"003.jpg",@"http://pic1.nipic.com/2008-12-25/2008122510134038_2.jpg"];
    scrollView.placeholderImage = [UIImage imageNamed:@"dog_1"]; //设置缺省图片
    scrollView.pageControlAliment = NSPageControlAlimentCenter; //设置小圆点居中，默认不显示
    // 图片的点击方法
    [scrollView addTapClick:^(NSInteger index) {
        NSLog(@"我是第%ld张图片",index);
    }];
    [self.view addSubview:scrollView];

```
# 说明
本demo用时较短，借鉴了前辈的轮子。疏漏之处在所难免，觉得有那么一点点用的请star一下，觉得不好的请直接请批评指正。

**邮箱：zhichao.lu@trustway.cn**

