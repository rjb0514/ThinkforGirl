//
//  RJBPublishViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/1/4.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBPublishViewController.h"
#import "UIButton+RJBButtonBlock.h"
#import <POP.h>
#import "RJBPushWordViewController.h"
#import "RJBNavigationController.h"

@interface RJBPublishViewController ()

@end

@implementation RJBPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *tipLabel = [UILabel new];
    tipLabel.text = @"哈哈我要开始动画了";
    tipLabel.y = 150;
    [tipLabel sizeToFit];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.centerX = RJBScreenW *0.5;
    [self.view addSubview:tipLabel];
    
    
    CGFloat btnW = 72;
    CGFloat btnH = btnW +30;
    CGFloat btnStartY = (RJBScreenH - 2 *btnH) *0.5;
    int maxCols = 3;
    CGFloat margin = (RJBScreenW - 3 *btnW) /4;
    NSArray *titleArr = @[@"发音屏",@"发段子",@"发图片",@"发帖子",@"发文字",@"发视屏"];
    NSArray *imageArr = @[@"publish-audio",@"publish-offline",@"publish-picture",@"publish-review",@"publish-text",@"publish-video"];
    
    //创建6个Btn
    for (int i = 0; i < 6; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //行列 计算
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat btnX = col * (btnW + margin) + margin;
        CGFloat btnEndY = btnStartY + row *btnH;
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY - RJBScreenH, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
        anim.springSpeed = 15;
        anim.springBounciness = 15;
        anim.beginTime = CACurrentMediaTime() + 0.15 *i;
        [btn pop_addAnimation:anim forKey:nil];
        
    }
    
}

- (IBAction)cancelClick:(id)sender {
    
    
    [self cancelWithFinishBlcok:nil];
    
}



- (void)cancelWithFinishBlcok:(void (^)(void))finishBlcok {
    
    self.view.userInteractionEnabled = NO;
    NSInteger num = 3;
    for (NSInteger i = num; i < self.view.subviews.count ; i++) {
        UIView *subView = self.view.subviews[i];
        CGFloat tempCenterX = subView.centerX;
        CGFloat tempCentery = subView.centerY + RJBScreenH;
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(tempCenterX, tempCentery)];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.beginTime = CACurrentMediaTime() + (i - 1)*0.15;
        //如果是最后一个
        if (i == self.view.subviews.count - 1) {
            
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                self.view.userInteractionEnabled = YES;
                [self dismissViewControllerAnimated:YES completion:nil];
                if (finishBlcok) {
                    finishBlcok();
                }
            }];
        }
        
        [subView pop_addAnimation:anim forKey:nil];
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithFinishBlcok:nil];
}

//按钮的额点击事件
- (void)btnClick:(UIButton *)btn {
    
    [self cancelWithFinishBlcok:^{
        if (btn.tag == 0) {
            NSLog(@"发送音频");
        }else if (btn.tag == 1){
            NSLog(@"发段子");
//            
//            RJBPushWordViewController *VC = [RJBPushWordViewController new];
//            
//            RJBNavigationController *nav = [[RJBNavigationController alloc] initWithRootViewController:VC];
//            UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//            
//            //这里不能用self  会有问题
//            [rootVC presentViewController:nav animated:YES completion:nil];
            
        }else if (btn.tag == 2) {
            NSLog(@"");
        }
    }];
}


@end
