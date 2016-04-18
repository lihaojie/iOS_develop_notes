//
//  ViewController.m
//  ScrollView 二图
//
//  Created by 李豪杰 on 16/4/15.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "SegmentControlView.h"
#import "MyChildViewController.h"
//屏幕宽高
#define screen_width [[UIScreen mainScreen] bounds].size.width
#define screen_height [[UIScreen mainScreen] bounds].size.height
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define RGBColorAlpha(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RandomColor RGBColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

@interface ViewController ()<UIScrollViewDelegate>

/** segmentedControl*/
@property (nonatomic, strong)  SegmentControlView *segmentedControl;
/** scrollview */
@property (nonatomic, strong) UIScrollView *mainScrollview;
/**
 *  保存可见的视图
 */
@property (nonatomic, strong) NSMutableSet *visibleViewControllers;

/**
 *  保存可重用的
 */
@property (nonatomic, strong) NSMutableSet *reusedViewControllers;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @" ScrollView 两个优化";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSegmented];
    
    [self setupScrollview];
}
#pragma mark - 添加导航栏下面的segmentedControl
- (void)setupSegmented
{
    self.segmentedControl = [[SegmentControlView alloc] initWithFrame:CGRectMake(0, 64, screen_width, 55)];
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.titleArray = @[@"推荐",@"视频",@"图片",@"段子",@"精华",@"精华",@"同城",@"推荐",@"视频",@"图片",@"段子",@"精华",@"精华",@"同城"];
    [self.segmentedControl setSelectedSegmentIndex:0 animated:YES]; // 默认选中第0个
    __weak typeof(self) weakSelf = self;
    // 点击
    self.segmentedControl.IndexChangeBlock = ^(NSInteger index){
        CGPoint offset = weakSelf.mainScrollview.contentOffset;
        offset.x = index * weakSelf.mainScrollview.bounds.size.width;
        [weakSelf.mainScrollview setContentOffset:offset animated:YES];
    };
}


#pragma mark - creatScrollview
- (void)setupScrollview
{
    _mainScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), screen_width, screen_height - CGRectGetMaxY(self.segmentedControl.frame))];
    self.mainScrollview.pagingEnabled = YES;
    self.mainScrollview.showsHorizontalScrollIndicator = NO;
    self.mainScrollview.showsVerticalScrollIndicator = NO;
    self.mainScrollview.contentSize = CGSizeMake(screen_width * self.segmentedControl.titleArray.count, 0);
    self.mainScrollview.delegate = self;
    self.mainScrollview.bounces = NO;
    [self.view addSubview:_mainScrollview];
    // 默认显示第0个控制器
    self.mainScrollview.backgroundColor = [UIColor redColor];
    
    [self showImageViewAtIndex:0];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self showImages];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    [self test];
}
- (void)test {
    NSMutableString *rs = [NSMutableString string];
    NSInteger count = [self.mainScrollview.subviews count];
    for (UIImageView *imageView in self.mainScrollview.subviews) {
        [rs appendFormat:@"%p - ", imageView];
    }
    [rs appendFormat:@"%ld", (long)count];
    NSLog(@"%@", rs);
}

- (void)showImages{
    // 获取当前处于显示范围的 控制器 索引
    CGRect visibleBounds = self.mainScrollview.bounds;
    CGFloat minX  = CGRectGetMinX(visibleBounds);
    CGFloat maxX  = CGRectGetMaxX(visibleBounds);
    CGFloat width = CGRectGetWidth(visibleBounds);
    NSInteger firstIndex = (NSInteger)floorf(minX / width);
    NSInteger lastIndex  = (NSInteger)floorf(maxX / width);
    
    // 处理越界
    if (firstIndex < 0) {
        firstIndex = 0;
    }
    if (lastIndex >= [self.segmentedControl.titleArray count]) {
        lastIndex = [self.segmentedControl.titleArray count] - 1;
    }
    // 回收不在显示 的
    NSInteger viewIndex = 0;
    for (MyChildViewController * vc in self.visibleViewControllers) {
        viewIndex = vc.tag;
        // 不在显示范围内
        if ( viewIndex < firstIndex || viewIndex > lastIndex) {
            [self.reusedViewControllers addObject:vc];
            [vc removeFromParentViewController];
            [vc.view removeFromSuperview];
        }
    }
    [self.visibleViewControllers minusSet:self.reusedViewControllers];
    // 是否需要显示新的视图
    for (NSInteger index = firstIndex; index <= lastIndex; index ++) {
        BOOL isShow = NO;
        for (MyChildViewController * childVc in self.visibleViewControllers) {
            
            if (childVc.tag == index) {
                isShow = YES;
            }
        }
        if (!isShow ) {
            [self showImageViewAtIndex:index];
        }
    }
}

// 显示一个 view
- (void)showImageViewAtIndex:(NSInteger)index{
    MyChildViewController *vc = [self.reusedViewControllers anyObject];
    if (vc) {
        [self.reusedViewControllers removeObject:vc];
        
    }else{
        MyChildViewController *childVc = [[MyChildViewController alloc] init];
        [self addChildViewController:childVc];
        vc = childVc;
    }
    CGRect bounds  = self.mainScrollview.bounds;
    CGRect vcFrame = bounds;
    vcFrame.origin.x = CGRectGetWidth(bounds) * index;
    vc.tag = index;
    vc.view.frame = vcFrame;
    [self.visibleViewControllers addObject:vc];
    [self.mainScrollview  addSubview:vc.view];
}

#pragma mark - lazy 

-(NSMutableSet *)visibleViewControllers
{
    if (!_visibleViewControllers) {
        self.visibleViewControllers = [[NSMutableSet  alloc] init];
        
    }
    return _visibleViewControllers;
}

-(NSMutableSet *)reusedViewControllers
{
    if (!_reusedViewControllers) {
        self.reusedViewControllers = [[NSMutableSet  alloc] init];
        
    }
    return _reusedViewControllers;
}




@end
