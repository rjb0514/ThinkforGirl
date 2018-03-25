//
//  UIImage+RJBExtension.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/11.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "UIImage+RJBExtension.h"

@implementation UIImage (RJBExtension)

- (UIImage *)circleImage {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获取图形上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    //添加一个圆
    CGContextAddEllipseInRect(contextRef, rect);
    //裁剪
    CGContextClip(contextRef);
    //将图片画上去
    [self drawInRect:rect];
    
    
    
    UIImage *iamge = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    return iamge;
}

@end
