//
//  RJBFriendTrendsViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/6.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBFriendTrendsViewController.h"
#import "RJBRecommendController.h"
#import "RJBLoginViewController.h"

@interface RJBFriendTrendsViewController ()

@end

@implementation RJBFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    
    __weak typeof(self) weakSelf = self;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" hightImage:@"friendsRecommentIcon-click" block:^(UIButton *btn) {
//         NSLog(@"我的关注");
        RJBRecommendController *VC = [RJBRecommendController new];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    }];
    
    
}
- (IBAction)loginButtonClick:(id)sender {
    
    RJBLoginViewController *VC = [RJBLoginViewController new];
    [self presentViewController:VC animated:YES completion:nil];
}



@end
