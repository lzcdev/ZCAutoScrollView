//
//  ZCAutoScrollView.m
//  ZCAutoScrollView
//
//  鲁志超 github:https://github.com/zcLu qq:1185907688
//
//  Created by LuzhiChao on 16/8/5.
//  Copyright © 2016年 LuzhiChao. All rights reserved.
//

#import "ZCAutoScrollView.h"
#import "UIImageView+WebCache.h"

#define KWIDTH [UIScreen mainScreen].bounds.size.width
#define KHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZCAutoScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView; //滚动视图
@property (nonatomic, assign) CGFloat scrollViewWidth; //滚动视图的宽度
@property (nonatomic, assign) CGFloat scrollViewHeight; //滚动视图的高度
@property (nonatomic, strong) UIImageView *imageView; //滚动视图上的图片
@property (nonatomic, copy) NSString *imageName; //图片名字
@property (nonatomic, strong) UIButton *clickImageBtn; //图片名字
@property (nonatomic, strong) UIPageControl *pageControl; //小圆点
@property (nonatomic, strong) NSTimer *timer; //定时器
@property (nonatomic, assign) NSInteger currentPage; //当前页码
@end

@implementation ZCAutoScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        [self setValueWithFrame:frame];
    }
    return self;
}

/**
 *  设置默认值
 */
- (void)setValueWithFrame:(CGRect)frame
{
    _scrollInterval = 3;
    _animationInterVale = 0.7;
    _scrollViewWidth = frame.size.width;
    _scrollViewHeight = frame.size.height;
    _currentPage = 1;
}

- (void)layoutSubviews
{
    [self initScrollView];
    [self addImageArray];
    [self addPageControl];
    
    if (!_isAutoScroll) {
        [self addTimer];
    }
}

/**
 *  初始化滚动视图
 */
- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _scrollViewWidth, _scrollViewHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
}

/**
 *  往滚动视图上添加图片
 */
- (void)addImageArray
{
    // 多放一张图片
    _scrollView.contentSize = CGSizeMake(_scrollViewWidth * (_imageArray.count + 1), _scrollViewHeight);
    
    for (int i = 0; i < (_imageArray.count + 1); i++) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_scrollViewWidth * i, 0, _scrollViewWidth, _scrollViewHeight)];
        _imageView.clipsToBounds = YES;
        
        if (i == 0) {
            //
            _imageName = [_imageArray lastObject];
        }else
        {
            _imageName = _imageArray[i - 1];
        }
        // 是网络图片
        if ([self checkURL:_imageName]) {
            NSURL *imageUrl = [NSURL URLWithString:_imageName];
            [_imageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"dog_1"]];
        }else
        {
            // 是本地图片
            _imageView.image = [UIImage imageNamed:_imageName];
            
        }
        
        [_scrollView addSubview:_imageView];
        
        //给imageView添加button点击事件
        _clickImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(_scrollViewWidth * i, 0, _scrollViewWidth, _scrollViewHeight)];
        [_clickImageBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            _clickImageBtn.tag = _imageArray.count;
        }else
        {
            _clickImageBtn.tag = i;
        }
        [_scrollView addSubview:_clickImageBtn];
    }
    // 默认图片从第二张开始，因为第一张和最后一张相同
    _scrollView.contentOffset = CGPointMake(_scrollViewWidth, 0);
}

/**
 *  button的点击事件
 *
 *  @param sender tag
 */
- (void)clickBtn:(UIButton *)sender
{
    _block(sender.tag);
}

/**
 *  添加小圆点
 */
- (void)addPageControl
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _scrollViewHeight-20, _scrollViewWidth, 20)];
    _pageControl.currentPage = _currentPage - 1;
    _pageControl.numberOfPages = _imageArray.count;
    _pageControl.tintColor = [UIColor blackColor];
    [self addSubview:_pageControl];
}

/**
 *  验证是不是网址
 *
 *  @param url 网址
 *
 *  @return 是
 */
- (BOOL)checkURL:(NSString *)url
{
    NSString *pattern = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [predicate evaluateWithObject:url];
    return isMatch;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x / _scrollViewWidth;
    if (currentPage == 0) {
        _scrollView.contentOffset = CGPointMake(_scrollViewWidth * _imageArray.count, 0);
        _pageControl.currentPage = _imageArray.count;
        [self resumeTimer];
        return;
    }else
    {
        if (currentPage == _imageArray.count) {
            _scrollView.contentOffset = CGPointMake(0, 0);
        }
        
        _pageControl.currentPage = currentPage-1;
        [self resumeTimer];
        
    }
    
}
/**
 *  添加定时器
 */
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_scrollInterval target:self selector:@selector(changeOffset) userInfo:nil repeats:YES];

}
/**
 *  自动切换
 */
- (void)changeOffset
{
    _currentPage ++;
    
    if (_currentPage == _imageArray.count + 1) {
        _currentPage = 1;
    }
    
    [UIView animateWithDuration:_animationInterVale animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollViewWidth * _currentPage, 0);
    } completion:^(BOOL finished) {
        if (_currentPage == _imageArray.count) {
            _scrollView.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    _pageControl.currentPage = _currentPage - 1;

}
/**
 *  暂停定时器
 */
-(void)resumeTimer{
    
    if (![_timer isValid]) {
        return ;
    }
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_scrollInterval-_animationInterVale]];
}
- (void)addTapClick:(ClickImageViewBlock)block
{
    _block = block;
}
@end
