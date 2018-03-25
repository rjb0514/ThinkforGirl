//
//  RJBAddTagToolBar.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/25.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBAddTagToolBar.h"
#import "RJBAddTageViewController.h"

@interface RJBAddTagToolBar ()


@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation RJBAddTagToolBar

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addBtn.size = addBtn.currentImage.size;
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addBtn];
    
    
}

- (void)addBtnClick:(UIButton *)btn {
    RJBFunc;
    
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.presentedViewController;
    RJBAddTageViewController *addVC = [RJBAddTageViewController new];
    [nav pushViewController:addVC animated:YES];
}


@end
