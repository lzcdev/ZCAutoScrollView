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

typedef void(^ClickImageViewBlock)(NSInteger index);

@interface ZCAutoScrollView : UIView

@property (nonatomic, assign) CGFloat scrollInterval;     //切换图片的时间间隔,默认3s
@property (nonatomic, assign) CGFloat animationInterVale; //切换图片过程间隔默认0.7s
@property (nonatomic, strong) NSArray *imageArray; //图片数组

@property (nonatomic, assign) BOOL *isAutoScroll; //是否自动切换

@property (nonatomic, copy) ClickImageViewBlock block;

// 给图片添加点击事件
- (void)addTapClick:(ClickImageViewBlock) block;

@end
