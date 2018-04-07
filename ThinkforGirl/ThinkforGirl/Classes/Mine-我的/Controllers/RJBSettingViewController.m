//
//  RJBSettingViewController.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/4/1.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBSettingViewController.h"
#import <SDImageCache.h>


@interface RJBSettingViewController ()

@end

@implementation RJBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat size = [[SDImageCache sharedImageCache] getSize] / 1000.0 / 1000.0;
    
    
    [btn setTitle:[NSString stringWithFormat:@"清楚缓存%.fMB",size] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    

}

- (void)getfileSize {
    //图片缓存
    NSUInteger size =  [[SDImageCache sharedImageCache] getSize];
    NSLog(@"%lu--%@",(unsigned long)size,NSHomeDirectory());
    
    
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    str = [str stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    //      NSString *str1 = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, NO) firstObject];
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSDictionary *dic = [fileManage attributesOfItemAtPath:str error:nil];
    //获取的属性 NSFileSize  针对文件大小是正确的  针对于文件夹是不正确的
    
    
    //    NSDirectoryEnumerator
    NSUInteger size2 = 0;
    NSDirectoryEnumerator *enumarator = [fileManage enumeratorAtPath:str];
    for (NSString *name in enumarator) {
        NSString *temp = [str stringByAppendingPathComponent:name];
        NSDictionary *tempDic = [fileManage attributesOfItemAtPath:temp error:nil];
        if ([tempDic.fileType isEqualToString:NSFileTypeDirectory]) {
            continue;
        }
        size2 += tempDic.fileSize;
    }
    
    
    NSLog(@"%@",dic);
    
    
    //获取文件夹内的所有内容
    NSArray *contents = [fileManage contentsOfDirectoryAtPath:str error:nil];
    
}


- (void)btnClick:(UIButton *)btn {
    
    NSLog(@"清楚缓存按钮的点击");
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSLog(@"清楚成功");
    }];
    
}


@end
