//
//  RJBTabBar.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/6.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBTabBar.h"
#import "RJBPublishViewController.h"
#import "RJBPushWordViewController.h"
#import "RJBNavigationController.h"


@interface RJBTabBar ()

@property (nonatomic, weak) UIButton *publishBtn;

@end

@implementation RJBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *publishBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
        [publishBtn addTarget:self action:@selector(publishCLick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)publishCLick:(UIButton *)btn {
    RJBPublishViewController *VC = [RJBPublishViewController new];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:VC animated:NO completion:nil];
//    RJBPushWordViewController *VC = [RJBPushWordViewController new];
    
//    RJBNavigationController *nav = [[RJBNavigationController alloc] initWithRootViewController:VC];
//    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
//    这里不能用self  会有问题
//    [rootVC presentViewController:nav animated:YES completion:nil];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    //设置发布按钮的frame 还可以设置其他的
    
    CGFloat btnY = 0;
    CGFloat btnW = self.frame.size.width / 5;
    CGFloat btnH = self.frame.size.height;
    NSInteger num = 0;
    
 
    
    for (UIView *btn in self.subviews) {
        
        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        
        CGFloat btnX = btnW * (num > 1 ? num + 1 : num);
        num ++ ;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }

    self.publishBtn.frame  = CGRectMake(0, 0, btnW, btnH);
    
    self.publishBtn.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
 
    
}

@end
