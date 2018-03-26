//
//  RJBTagTextField.m
//  ThinkforGirl
//
//  Created by 茹 on 2018/3/26.
//  Copyright © 2018年 bin. All rights reserved.
//

#import "RJBTagTextField.h"

@implementation RJBTagTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)deleteBackward {
    
    //先看删除之前的情况 要不会出现 文字删除跟按钮删除一起调用
    !self.deleteBlock ? :self.deleteBlock();
    [super deleteBackward];

}

@end
