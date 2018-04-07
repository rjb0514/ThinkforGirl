//
//  RJBNavigationController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBNavigationController.h"

@interface RJBNavigationController ()

@end

@implementation RJBNavigationController




/**
 当导航用在NAV 中中CIA生效
 */
+ (void)initialize
{
    if (self == [RJBNavigationController class]) {
//        UINavigationBar *naBar = [UINavigationBar appearanceWhenContainedIn:[self class],nil];
        UINavigationBar *naBar = [UINavigationBar appearance];
        [naBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
        [naBar setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]}];
        
        
        UITabBarItem *barItem = [UITabBarItem appearance];
        NSDictionary *dicA = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]};
        NSDictionary *diB = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
        [barItem setTitleTextAttributes:dicA forState:UIControlStateNormal];
        [barItem setTitleTextAttributes:diB forState:UIControlStateSelected];;
        
        
        
        UIBarButtonItem *buttonItem = [UIBarButtonItem appearance];
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName : [UIColor blackColor]};
        NSDictionary *dic1 = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName : [UIColor lightGrayColor]};

        [buttonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
        [buttonItem setTitleTextAttributes:dic1 forState:UIControlStateDisabled];
        
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //navigationbarBackgroundWhite
    
    //重写了leftBarButtonItem 侧滑手势失灵 就写中一句代码就可以
    self.interactivePopGestureRecognizer.delegate = nil;
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if (self.childViewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        btn.size = CGSizeMake(70, 30);
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        __weak typeof(UIViewController *) weakVC = viewController;
        [btn buttonAddBlock:^(UIButton *btn) {
            [weakVC.navigationController popViewControllerAnimated:YES];
        }];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:animated];
}


@end
