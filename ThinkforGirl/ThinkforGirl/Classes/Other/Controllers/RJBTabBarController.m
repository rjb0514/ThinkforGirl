//
//  RJBTabBarController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/6.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBTabBarController.h"
#import "RJBMeViewController.h"
#import "RJBNewViewController.h"
#import "RJBEssenceViewController.h"
#import "RJBFriendTrendsViewController.h"
#import "RJBTabBar.h"

#import "RJBNavigationController.h"

@interface RJBTabBarController ()

@end

@implementation RJBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
 
    
    
    //精华控制器
    [self setChildViewConroller:@"RJBEssenceViewController" title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    //新帖控制器
    [self setChildViewConroller:@"RJBNewViewController" title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    //关注控制器
    [self setChildViewConroller:@"RJBFriendTrendsViewController" title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    //我控制器
    [self setChildViewConroller:@"RJBMeViewController" title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];

    
//    self.tabBar  = [[RJBTabBar alloc] init];
    [self setValue:[[RJBTabBar alloc] init]forKey:@"tabBar"];

}


- (void)setChildViewConroller:(NSString *)VCString title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selecImage {
    
    Class cla = NSClassFromString(VCString);
    
    UIViewController *VC = [[cla alloc] init];
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:image];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selecImage];
    
    VC.navigationItem.title = title;
    
    RJBNavigationController *nav = [[RJBNavigationController alloc] initWithRootViewController:VC];

    [self addChildViewController:nav];
}


@end
