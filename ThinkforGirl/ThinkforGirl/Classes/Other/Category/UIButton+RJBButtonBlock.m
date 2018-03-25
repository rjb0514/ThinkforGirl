//
//  UIButton+RJBButtonBlock.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/10.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "UIButton+RJBButtonBlock.h"
#import <objc/runtime.h>

static const  char btnBlockString;

@implementation UIButton (RJBButtonBlock)


- (void)setBtnClickBlock:(void (^)(UIButton *))btnClickBlock {
    
    
    objc_setAssociatedObject(self, &btnBlockString, btnClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}


- (void (^)(UIButton *))btnClickBlock {
   return  objc_getAssociatedObject(self, &btnBlockString);
}

- (void)buttonAddBlock:(ButtonBlock)block {
    
    self.btnClickBlock = block;
    
    [self addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClick:(UIButton *)btn {
    if (self.btnClickBlock) {
        self.btnClickBlock(btn);
    }
}





@end
