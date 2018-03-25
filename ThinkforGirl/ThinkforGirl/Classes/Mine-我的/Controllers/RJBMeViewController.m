//
//  RJBMeViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/6.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBMeViewController.h"

@interface RJBMeViewController ()

@end

@implementation RJBMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     UIBarButtonItem *setItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" hightImage:@"mine-setting-icon-click" block:^(UIButton *btn) {
           NSLog(@"设置");
    }];
    

    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" hightImage:@"mine-moon-icon-click" block:^(UIButton *btn) {
        NSLog(@"夜间模式");
    }];
    
    self.navigationItem.rightBarButtonItems = @[setItem,moonItem];
}



@end
