//
//  RJBEssenceViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/6.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBEssenceViewController.h"
#import "UIView+RJBExtension.h"
#import "RJBRecommendTagsTableViewController.h"
//#import "RJBAllTableViewController.h"
//#import "RJBVideoTableViewController.h"
//#import "RJBPictureTableViewController.h"
//#import "RJBSoundTableViewController.h"
//#import "RJBCrossTalkTableViewController.h"
#import "NSDate+RJBExtension.h"
#import "RJBBaseTopicController.h"


@interface RJBEssenceViewController ()<UIScrollViewDelegate>


/**
 标签栏底部的红色view
 */
@property (nonatomic, strong) UIView *indicator;

/**
 当前选中的Button
 */
@property (nonatomic, weak) UIButton *currentBtn;

/** 内容 */
@property (nonatomic, weak) UIScrollView *contentScrollView;

@property (nonatomic, weak) UIView *titlsView;



@end

@implementation RJBEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子控制器
    [self setupChildControllers];
    //设置导航
    [self setupNav];
    //设置顶部标题栏
    [self setupTitleView];
    //设置ScrollView
    [self setupScrollView];
 
    
    //测试判断是否是今天
//    NSDateFormatter *fmt = [NSDateFormatter new];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *creatDate = [fmt dateFromString:@"2017-12-24 18:15:30"];
//
//    NSLog(@"是否是今年：%d --- 是否是昨天：%d --- 是否是今天:%d",creatDate.isYear,creatDate.isYesterday,creatDate.isToday);
    
   
}

//初始化子控制器
- (void)setupChildControllers {
    
    //图片
    RJBBaseTopicController *pictureVC = [RJBBaseTopicController new];
    pictureVC.type = RJBTopictypePicture;
    pictureVC.title = @"图片";
    [self addChildViewController:pictureVC];
    
    //全部
    RJBBaseTopicController *allV = [RJBBaseTopicController new];
    allV.type = RJBTopictypeAll;
    allV.title = @"全部";
    [self addChildViewController:allV];
    
    //视频
    RJBBaseTopicController *videoVC = [RJBBaseTopicController new];
    videoVC.type = RJBTopictypeVideo;
    videoVC.title = @"视频";
    [self addChildViewController:videoVC];
    
    //声音
    RJBBaseTopicController *soundVC = [RJBBaseTopicController new];
    soundVC.type = RJBTopictypeSound;
    soundVC.title = @"声音";
    [self addChildViewController:soundVC];
    
  
    
    //段子
    RJBBaseTopicController *crossTalkVC = [RJBBaseTopicController new];
    crossTalkVC.type = RJBTopictypeCrossTalk;
    crossTalkVC.title = @"段子";
    [self addChildViewController:crossTalkVC];
    
    
}

//设置ScrollView
- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    scrollView.frame = self.view.bounds;
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
    scrollView.delegate = self;
    self.contentScrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    
    
    //添加第一个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//设置顶部标题栏
- (void)setupTitleView {
    
    UIView *titlesView = [[UIView alloc] init];
    titlesView.userInteractionEnabled = YES;
    [self.view addSubview:titlesView];
    
    self.titlsView = titlesView;
    
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titlesView.width = self.view.width;
    titlesView.height = RJBTitleViewH;
    titlesView.y = RJBTitleViewY;
    
    UIView *indicator = [UIView new];
    indicator.backgroundColor = [UIColor redColor];
    
    indicator.height = 2;
    indicator.y = titlesView.height - indicator.height;
    self.indicator = indicator;
    
    NSInteger count = 5;
//    NSArray *titls= @[@"图片",@"视频",@"声音",@"全部全部",@"段子"];
    CGFloat btnH = titlesView.height;
    CGFloat btnW = titlesView.width /count;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.height = btnH;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.tag = i;
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        
        if (i == 0) {
//            [btn layoutIfNeeded];
            [btn.titleLabel sizeToFit];
            btn.enabled = NO;
            self.currentBtn = btn;
            self.indicator.width = btn.titleLabel.width;
            self.indicator.centerX = btn.centerX;
        }
    }
    
[titlesView addSubview:indicator];
    
  
}

- (void)titleBtnClick:(UIButton *)btn {
    self.currentBtn.enabled = YES;
    btn.enabled = NO;
    self.currentBtn = btn;
    NSLog(@"rujianbin");
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = btn.titleLabel.width;
        self.indicator.centerX = btn.centerX;
    }];
    
    //滚动
    CGPoint tempOffSet = self.contentScrollView.contentOffset;
    tempOffSet.x = btn.tag * self.view.width;
    [self.contentScrollView setContentOffset:tempOffSet animated:YES];
}

-(void)setupNav {
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" hightImage:@"MainTagSubIconClick" block:^(UIButton *btn) {
        NSLog(@"精华");
        RJBRecommendTagsTableViewController *VC = [RJBRecommendTagsTableViewController new];
        [self.navigationController pushViewController:VC animated:YES];
    }];
}


#pragma mark - scrollViwe代理
//结束动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //获取当前索引
    NSInteger temp = scrollView.contentOffset.x / scrollView.width;
    NSLog(@"当前的角标----%zd",temp);
    UITableViewController *VC = self.childViewControllers[temp];
    VC.view.x = scrollView.contentOffset.x;
    VC.view.y = 0;      //默认是20
    VC.view.height = scrollView.height;
    [self.contentScrollView addSubview:VC.view];
    
}

//拖拽减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleBtnClick:self.titlsView.subviews[index]];
}


@end
