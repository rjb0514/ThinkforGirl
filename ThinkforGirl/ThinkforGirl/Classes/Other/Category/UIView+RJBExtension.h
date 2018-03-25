//
//  UIView+RJBExtension.h
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RJBExtension)


@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;


@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;


@property (nonatomic, assign) CGSize size;


+ (instancetype)viewFromXib;


@end
