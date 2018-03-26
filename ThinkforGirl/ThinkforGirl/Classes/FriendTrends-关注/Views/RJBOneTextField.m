//
//  RJBOneTextField.m
//  ThinkforGirl
//
//  Created by 茹 on 2017/12/17.
//  Copyright © 2017年 bin. All rights reserved.
//

#import "RJBOneTextField.h"
#import <objc/runtime.h>

@implementation RJBOneTextField

- (void)awakeFromNib {
    
    [super awakeFromNib];
    

        self.tintColor = self.textColor;
     
}

-  (BOOL)becomeFirstResponder {
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return  [super resignFirstResponder];
}




- (void)test {
    unsigned num = 0;
    
    unsigned num1 = 0;
    
    Ivar *varList =  class_copyIvarList([UITextField class], &num1);
    objc_property_t *proLitst =  class_copyPropertyList([UITextField class], &num);
    
    for (NSInteger i = 0; i < num1; i++) {
        Ivar var = varList[i];
        
        NSLog(@"-----%s",ivar_getName(var));
    }
    
    NSLog(@"0-0-0-0-0-0-0-0-0-0--0-0-0-00-0-");
    
    for (NSInteger i = 0; i < num; i++) {
        objc_property_t proper = proLitst[i];
        
        NSLog(@"%s",property_getName(proper));
    }
    
}

//- (void)drawPlaceholderInRect:(CGRect)rect {
//
//    [self.placeholder drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor],NSFontAttributeName:self.font}];
//
//
//}

@end
