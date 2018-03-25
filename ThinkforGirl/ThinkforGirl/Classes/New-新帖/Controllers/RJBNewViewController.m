//
//  RJBNewViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/6.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBNewViewController.h"

@interface RJBNewViewController ()

@end

@implementation RJBNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    UIButton *tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tabBtn setBackgroundImage: [UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tabBtn setBackgroundImage: [UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    //设置Btn尺寸
    tabBtn.size = tabBtn.currentBackgroundImage.size;
    [tabBtn buttonAddBlock:^(UIButton *btn) {
        NSLog(@"热点 新闻");
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tabBtn];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIViewController *VC = [[UIViewController alloc] init];
    VC.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:VC animated:YES];
}



@end
