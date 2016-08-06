//
//  ZCAutoScrollView.h
//  ZCAutoScrollView
//
//  鲁志超 github:https://github.com/zcLu qq:1185907688
//
//  Created by LuzhiChao on 16/8/5.
//  Copyright © 2016年 LuzhiChao. All rights reserved.
//

#import <UIKit/UIKit.h>

// 设置小圆点位置
typedef NS_ENUM(NSInteger, NSPageControlAliment) {
    NSPageControlAlimentCenter, //小圆点居中
    NSPageControlAlimentRight, //小圆点居右
    NSPageControlAlimentNone //小圆点隐藏
};

typedef void(^ClickImageViewBlock)(NSInteger index);

@interface ZCAutoScrollView : UIView

@property (nonatomic, assign) CGFloat scrollInterval;     //切换图片的时间间隔,默认3s
@property (nonatomic, assign) CGFloat animationInterVale; //切换图片过程间隔默认0.7s
@property (nonatomic, strong) NSArray *imageArray; //图片数组
@property (nonatomic, strong) UIImage *placeholderImage; //缺省图片
@property (nonatomic, assign) NSPageControlAliment pageControlAliment; //小圆点对齐方式，默认没有

@property (nonatomic, copy) ClickImageViewBlock block;

// 给图片添加点击事件
- (void)addTapClick:(ClickImageViewBlock) block;

@end
