//
//  UIBarButtonItem+RJBExtension.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "UIBarButtonItem+RJBExtension.h"

@implementation UIBarButtonItem (RJBExtension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage block:(void(^)(UIButton *btn))actionBlock {
    
    
    UIButton *tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tabBtn setBackgroundImage: [UIImage imageNamed:image] forState:UIControlStateNormal];
    [tabBtn setBackgroundImage: [UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];
    //设置Btn尺寸
    tabBtn.size = tabBtn.currentBackgroundImage.size;
    [tabBtn buttonAddBlock:actionBlock];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:tabBtn];
    
    return item;
     
}

@end
