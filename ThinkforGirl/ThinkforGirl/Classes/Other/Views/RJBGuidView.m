//
//  RJBGuidView.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/18.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBGuidView.h"

@implementation RJBGuidView

+ (instancetype)getGuidView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
  
    
    [self removeFromSuperview];
}


@end
