//
//  UIBarButtonItem+RJBExtension.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RJBExtension)

+ (instancetype)itemWithImage:(NSString *)image hightImage:(NSString *)hightImage block:(void(^)(UIButton *btn))actionBlock;

@end
